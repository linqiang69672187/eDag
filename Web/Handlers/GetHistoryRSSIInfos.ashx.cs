using DbComponent;
using DbComponent.Comm;
using DbComponent.IDAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetHistoryRSSIInfos 的摘要说明
    /// </summary>
    public class GetHistoryRSSIInfos : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        IHistoryRSSIInfoDao dao = new HistoryRSSIInfoDao();
        public void ProcessRequest(HttpContext context)
        {

            try
            {
                int count = 600;
                DateTime startTime = DateTime.Parse(context.Request["startTime"].ToString());
                DateTime endTime = DateTime.Parse(context.Request["endTime"].ToString());
                string type = context.Request["type"].ToString();
                int alpha = int.Parse(context.Request["alpha"]);
                int num = int.Parse(context.Request["num"]);
                string stringminX = context.Request["minX"];
                string stringminY = context.Request["minY"];
                string stringmaxX = context.Request["maxX"];
                string stringmaxY = context.Request["maxY"];
                double queryMinX, queryMinY, queryMaxX, queryMaxY;
                if (string.IsNullOrEmpty(stringminX))
                {
                    queryMinX = 0.1;
                    queryMinY = 0.1;
                    queryMaxX = Math.Pow(10, 10);
                    queryMaxY = Math.Pow(10, 10);
                }
                else
                {
                    queryMinX = double.Parse(stringminX);
                    queryMinY = double.Parse(stringminY);
                    queryMaxX = double.Parse(stringmaxX);
                    queryMaxY = double.Parse(stringmaxY);
                }

                DataTable dt = dao.getHistoryRSSIInfos(startTime, endTime, queryMinX, queryMinY, queryMaxX, queryMaxY);//先做过滤

                List<RSSIPoint> pointList = new List<RSSIPoint>();
                
                double minX = Math.Pow(10, 10);
                double minY = Math.Pow(10, 10);
                double maxX = 0.1;
                double maxY = 0.1;
                foreach (DataRow dr in dt.Rows)
                {
                    try
                    {
                        RSSIPoint point = new RSSIPoint();
                        point.ID = int.Parse(dr["ID"].ToString());
                        point.ISSI = dr["ISSI"].ToString();
                        point.Latitude = double.Parse(dr["Latitude"].ToString());
                        point.Longitude = double.Parse(dr["Longitude"].ToString());
                        point.MsRssi = dr["MsRssi"].ToString();
                        point.UlRssi = dr["UlRssi"].ToString();
                        point.Inserttb_time = DateTime.Parse(dr["Inserttb_time"].ToString());
                        pointList.Add(point);

                        if (point.Longitude < minX)
                        {
                            minX = point.Longitude;
                        }
                        if (point.Longitude > maxX)
                        {
                            maxX = point.Longitude;
                        }
                        if (point.Latitude < minY)
                        {
                            minY = point.Latitude;
                        }
                        if (point.Latitude > maxY)
                        {
                            maxY = point.Latitude;
                        }
                    }
                    catch 
                    {
                        continue;
                    }
                }

                string resultJson = string.Empty;
                
                List<RSSIPoint> resultList = new List<RSSIPoint>();

                if (pointList.Count < count)
                {
                    resultList = pointList;
                    //resultJson = TypeConverter.DataTable2Json("HistoryRSSIInfos", dt);
                }
                else
                {
                    double area = (maxY - minY) * (maxX - minX);
                    double scale = (maxY - minY) / (maxX - minX);
                    double partArea = area / (count * 1.0f);
                    double x_ = Math.Sqrt(partArea / scale);
                    double y_ = scale * x_;
                    int totalRowNum = (int)((maxY - minY)/y_+0.5);
                    int totalColumNum = (int)((maxX - minX)/x_+0.5);

                    AreaPoint[] areaPoint = new AreaPoint[count];
                    foreach (RSSIPoint p in pointList)
                    {
                        try
                        {
                            int row = (int)((p.Latitude - minY) / y_);
                            int colum = (int)((p.Longitude - minX) / x_);
                            if (row == totalRowNum)
                            {
                                row = totalRowNum - 1;
                            }
                            if (colum == totalColumNum)
                            {
                                colum = totalColumNum - 1;
                            }

                            int index = (row) * totalColumNum + colum;
                            AreaPoint ap = areaPoint[index];
                            if (ap != null)
                            {
                                ap.totalMsRssi = ap.totalMsRssi + double.Parse(p.MsRssi);
                                ap.totalUlRssi = ap.totalUlRssi + double.Parse(p.UlRssi);
                                ap.totalLongitude = ap.totalLongitude + p.Longitude;
                                ap.totalLatitude = ap.totalLatitude + p.Latitude;
                                ap.count = ap.count + 1;
                            }
                            else
                            {
                                AreaPoint ap_ = new AreaPoint(p, 1, double.Parse(p.MsRssi), double.Parse(p.UlRssi),p.Longitude,p.Latitude);
                                areaPoint[index] = ap_;
                            }
                        }
                        catch (Exception ex)
                        {
                            log.Error(ex);
                        }
                    }
                    
                    foreach (AreaPoint p in areaPoint)
                    {
                        if (p != null)
                        {
                            RSSIPoint rp=new RSSIPoint();
                            rp.ID = p.point.ID;
                            rp.ISSI = p.point.ISSI;
                            rp.Latitude = p.totalLatitude / p.count;
                            rp.Longitude = p.totalLongitude / p.count;
                            rp.MsRssi = (p.totalMsRssi/p.count).ToString();
                            rp.UlRssi = (p.totalUlRssi/p.count).ToString();
                            resultList.Add(rp);
                        }
                    }
                    //resultJson = TypeConverter.List2Json("HistoryRSSIInfos", resultList);
                }
                if (resultList.Count < 4)
                {
                    resultJson = Newtonsoft.Json.JsonConvert.SerializeObject(new {statue="error"});
                }
                else 
                {
                    double[] values = new double[resultList.Count];
                    if (type == "MsRssi")
                    {
                        values = resultList.Select(o => double.Parse(o.MsRssi)).ToArray();
                    }
                    else
                    {
                        values = resultList.Select(o => double.Parse(o.UlRssi)).ToArray();
                    }
                    double[] lngs = resultList.Select(o => o.Longitude).ToArray();
                    double[] lats = resultList.Select(o => o.Latitude).ToArray();

                    double minLng = lngs.Min();
                    double minLat = lats.Min();
                    double maxLng = lngs.Max();
                    double maxLat = lats.Max();

                    var obj = Kriging.train(values, lngs, lats, 0, alpha);
                    double[][][] polygons = new double[1][][] { new double[4][] { new double[] { minLng, minLat }, new double[] { minLng, maxLat }, new double[] { maxLng, maxLat }, new double[] { maxLng, minLat } } };
                    grid grid = Kriging.grid(polygons, obj, (maxLng - minLng) / num);
                    resultJson = Newtonsoft.Json.JsonConvert.SerializeObject(grid); 
                }
                context.Response.Write(resultJson);
            }
            catch (Exception ex) 
            {
                log.Error(ex);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        //private void CreateGrid(double[][][] polygons,)
        //{ 
            
        //}
    }

    public class RSSIPoint
    {
        public int ID { get; set; }
        public string ISSI { get; set; }
        public double Longitude { get; set; }
        public double Latitude { get; set; }
        public string MsRssi { get; set; }
        public string UlRssi { get; set; }
        public DateTime Inserttb_time { get; set; }
    }

    public class AreaPoint
    {
        public AreaPoint(RSSIPoint point, int count, double totalMsRssi, double totalUlRssi, double totalLongitude, double totalLatitude) 
        {
            this.point = point;
            this.count = count;
            this.totalMsRssi = totalMsRssi;
            this.totalUlRssi = totalUlRssi;
            this.totalLongitude = totalLongitude;
            this.totalLatitude = totalLatitude;
        }
        public RSSIPoint point { get; set; }
        public int count { get; set; }
        public double totalMsRssi { get; set; }
        public double totalUlRssi { get; set; }
        public double totalLongitude { get; set; }
        public double totalLatitude { get; set; }
    }

    public static class Kriging
    {
        private static bool pip(double[][] p, double x, double y)
        {
            int i, j;
            bool c = false;
            for (i = 0, j = p.Length - 1; i < p.Length; j = i++)
            {
                if (((p[i][1] > y) != (p[j][1] > y)) &&
                    (x < (p[j][0] - p[i][0]) * (y - p[i][1]) / (p[j][1] - p[i][1]) + p[i][0]))
                {
                    c = !c;
                }
            }
            return c;
        }

        public static double[] kriging_matrix_diag(double c, int n)
        {
            int i;
            var Z = new double[n * n];
            for (i = 0; i < n; i++)
            {
                Z[i * n + i] = c;
            }
            return Z;
        }

        public static double[] kriging_matrix_transpose(double[] X, int n, int m)
        {
            int i, j;
            double[] Z = new double[m * n];
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < m; j++)
                {
                    Z[j * n + i] = X[i * m + j];
                }
            }
            return Z;
        }

        public static double[] kriging_matrix_add(double[] X, double[] Y, int n, int m)
        {
            int i, j;
            double[] Z = new double[n * m];
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < m; j++)
                {
                    Z[i * m + j] = X[i * m + j] + Y[i * m + j];
                }
            }
            return Z;
        }

        public static double[] kriging_matrix_multiply(double[] X, double[] Y, int n, int m, int p)
        {
            int i, j, k;
            double[] Z = new double[n * p];
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < p; j++)
                {
                    Z[i * p + j] = 0;
                    for (k = 0; k < m; k++)
                    {
                        Z[i * p + j] += X[i * m + k] * Y[k * p + j];
                    }
                }
            }
            return Z;
        }

        public static bool kriging_matrix_chol(ref double[] X, int n)
        {
            int i, j, k, sum;
            double[] p = new double[n];
            for (i = 0; i < n; i++)
            {
                p[i] = X[i * n + i];
            }
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < i; j++)
                {
                    p[i] -= X[i * n + j] * X[i * n + j];

                }
                if (p[i] <= 0)
                {
                    return false;
                }
                p[i] = Math.Sqrt(p[i]);
                for (j = i + 1; j < n; j++)
                {
                    for (k = 0; k < i; k++)
                    {
                        X[j * n + i] -= X[j * n + k] * X[i * n + k];
                    }
                    X[j * n + i] /= p[i];
                }
            }
            for (i = 0; i < n; i++)
            {
                X[i * n + i] = p[i];
            }
            return true;
        }

        public static void kriging_matrix_chol2inv(ref double[] X, int n)
        {
            int i, j, k;
            double sum;
            for (i = 0; i < n; i++)
            {
                X[i * n + i] = 1 / X[i * n + i];
                for (j = i + 1; j < n; j++)
                {
                    sum = 0;
                    for (k = i; k < j; k++)
                    {
                        sum -= X[j * n + k] * X[k * n + i];
                    }
                    X[j * n + i] = sum / X[j * n + j];
                }
            }
            for (i = 0; i < n; i++)
            {
                for (j = i + 1; j < n; j++)
                {
                    X[i * n + j] = 0;
                }
            }
            for (i = 0; i < n; i++)
            {
                X[i * n + i] *= X[i * n + i];
                for (k = i + 1; k < n; k++)
                {
                    X[i * n + i] += X[k * n + i] * X[k * n + i];
                }
                for (j = i + 1; j < n; j++)
                {
                    for (k = j; k < n; k++)
                    {
                        X[i * n + j] += X[k * n + i] * X[k * n + j];
                    }
                }
            }
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < i; j++)
                {
                    X[i * n + j] = X[j * n + i];
                }

            }
        }

        public static bool kriging_matrix_solve(ref double[] X, int n)
        {
            var m = n;
            var b = new double[n * n];
            var indxc = new int[n];
            var indxr = new int[n];
            var ipiv = new int[n];
            int i, icol = 0, irow = 0, j, k, l, ll;
            double big, dum, pivinv, temp;

            for (i = 0; i < n; i++)
                for (j = 0; j < n; j++)
                {
                    if (i == j) b[i * n + j] = 1;
                    else b[i * n + j] = 0;
                }
            for (j = 0; j < n; j++) ipiv[j] = 0;
            for (i = 0; i < n; i++)
            {
                big = 0;
                for (j = 0; j < n; j++)
                {
                    if (ipiv[j] != 1)
                    {
                        for (k = 0; k < n; k++)
                        {
                            if (ipiv[k] == 0)
                            {
                                if (Math.Abs(X[j * n + k]) >= big)
                                {
                                    big = Math.Abs(X[j * n + k]);
                                    irow = j;
                                    icol = k;
                                }
                            }
                        }
                    }
                }
                ++(ipiv[icol]);

                if (irow != icol)
                {
                    for (l = 0; l < n; l++)
                    {
                        temp = X[irow * n + l];
                        X[irow * n + l] = X[icol * n + l];
                        X[icol * n + l] = temp;
                    }
                    for (l = 0; l < m; l++)
                    {
                        temp = b[irow * n + l];
                        b[irow * n + l] = b[icol * n + l];
                        b[icol * n + l] = temp;
                    }
                }
                indxr[i] = irow;
                indxc[i] = icol;

                if (X[icol * n + icol] == 0) return false; // Singular

                pivinv = 1 / X[icol * n + icol];
                X[icol * n + icol] = 1;
                for (l = 0; l < n; l++) X[icol * n + l] *= pivinv;
                for (l = 0; l < m; l++) b[icol * n + l] *= pivinv;

                for (ll = 0; ll < n; ll++)
                {
                    if (ll != icol)
                    {
                        dum = X[ll * n + icol];
                        X[ll * n + icol] = 0;
                        for (l = 0; l < n; l++) X[ll * n + l] -= X[icol * n + l] * dum;
                        for (l = 0; l < m; l++) b[ll * n + l] -= b[icol * n + l] * dum;
                    }
                }
            }
            for (l = (n - 1); l >= 0; l--)
                if (indxr[l] != indxc[l])
                {
                    for (k = 0; k < n; k++)
                    {
                        temp = X[k * n + indxr[l]];
                        X[k * n + indxr[l]] = X[k * n + indxc[l]];
                        X[k * n + indxc[l]] = temp;
                    }
                }

            return true;
        }

        public static double kriging_variogram_exponential(double h, double nugget, double range, double sill, double A)
        {
            return nugget + ((sill - nugget) / range) * (1.0 - Math.Exp(-(1.0 / A) * (h / range)));
        }

        public static variogram train(double[] t1, double[] x1, double[] y1, double sigma2, double alpha)
        {
            double[] t = t1;
            double[] x = x1;
            double[] y = y1;
            double nugget = 0.0;
            double range = 0.0;
            double sill = 0.0;
            double A = 1 / 3.0;
            int n = 0;
            //var variogram = new { t = t, x = x, y = y, nugget = 0.0, range = 0.0, sill = 0.0, A = 1 / 3, n = 0 };
            int i, j, k, l;
            n = t.Length;
            var distance = new double[(n * n - n) / 2][];
            for (i = 0, k = 0; i < n; i++)
                for (j = 0; j < i; j++, k++)
                {
                    distance[k] = new double[2];
                    distance[k][0] = Math.Pow(
                        Math.Pow(x[i] - x[j], 2) +
                        Math.Pow(y[i] - y[j], 2), 0.5);
                    distance[k][1] = Math.Abs(t[i] - t[j]);
                }
            distance = distance.OrderBy(o => o[0]).ToArray();
            range = distance[(n * n - n) / 2 - 1][0];

            // Bin lag distance
            var lags = ((n * n - n) / 2) > 30 ? 30 : (n * n - n) / 2;
            var tolerance = range / lags;
            var lag = new double[lags];
            var semi = new double[lags];
            if (lags < 30)
            {
                for (l = 0; l < lags; l++)
                {
                    lag[l] = distance[l][0];
                    semi[l] = distance[l][1];
                }
            }
            else
            {
                for (i = 0, j = 0, k = 0, l = 0; i < lags && j < ((n * n - n) / 2); i++, k = 0)
                {
                    while (distance[j][0] <= ((i + 1) * tolerance))
                    {
                        lag[l] += distance[j][0];
                        semi[l] += distance[j][1];
                        j++; k++;
                        if (j >= ((n * n - n) / 2)) break;
                    }
                    if (k > 0)
                    {
                        lag[l] /= k;
                        semi[l] /= k;
                        l++;
                    }
                }
                if (l < 2) return new variogram(t, x, y, nugget, range, sill, A, n, null, null); // Error: Not enough points
            }

            // Feature transformation
            n = l;
            range = lag[n - 1] - lag[0];
            var X = new double[2 * n];
            for (int qq = 0; qq < 2 * n; qq++)
            {
                X[qq] = 1;
            }
            double[] Y = new double[n];
            for (i = 0; i < n; i++)
            {

                X[i * 2 + 1] = 1.0 - Math.Exp(-(1.0 / A) * lag[i] / range);

                Y[i] = semi[i];
            }

            // Least squares
            var Xt = kriging_matrix_transpose(X, n, 2);
            var Z = kriging_matrix_multiply(Xt, X, 2, n, 2);
            Z = kriging_matrix_add(Z, kriging_matrix_diag(1 / alpha, 2), 2, 2);
            var cloneZ = new double[Z.Length];
            Z.CopyTo(cloneZ, 0);
            var a = Z;
            if (kriging_matrix_chol(ref Z, 2))
            {
                var b = Z;
                kriging_matrix_chol2inv(ref Z, 2);
            }
            else
            {
                kriging_matrix_solve(ref cloneZ, 2);
                Z = cloneZ;
            }
            var W = kriging_matrix_multiply(kriging_matrix_multiply(Z, Xt, 2, 2, n), Y, 2, n, 1);

            // Variogram parameters
            nugget = W[0];
            sill = W[1] * range + nugget;
            n = x.Length;

            // Gram matrix with prior
            n = x.Length;
            var K = new double[n * n];
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < i; j++)
                {
                    K[i * n + j] = kriging_variogram_exponential(Math.Pow(Math.Pow(x[i] - x[j], 2) +
                                        Math.Pow(y[i] - y[j], 2), 0.5),
                                   nugget,
                                   range,
                                   sill,
                                   A);
                    K[j * n + i] = K[i * n + j];
                }
                K[i * n + i] = kriging_variogram_exponential(0, nugget,
                               range,
                               sill,
                               A);
            }

            var C = kriging_matrix_add(K, kriging_matrix_diag(sigma2, n), n, n);
            double[] cloneC = new double[C.Length];
            C.CopyTo(cloneC, 0);
            if (kriging_matrix_chol(ref C, n))
                kriging_matrix_chol2inv(ref C, n);
            else
            {
                kriging_matrix_solve(ref cloneC, n);
                C = cloneC;
            }

            C.CopyTo(K, 0);
            var M = kriging_matrix_multiply(C, t, n, n, 1);

            return new variogram(t, x, y, nugget, range, sill, A, n, K, M);
        }

        public static grid grid(double[][][] polygons, variogram variogram, double width)
        {
            int i, j, k;
            int n = polygons.Length;

            var xlim = new double[2] { polygons[0][0][0], polygons[0][0][0] };
            var ylim = new double[2] { polygons[0][0][1], polygons[0][0][1] };
            for (i = 0; i < n; i++) // Polygons
                for (j = 0; j < polygons[i].Length; j++)
                { // Vertices
                    if (polygons[i][j][0] < xlim[0])
                        xlim[0] = polygons[i][j][0];
                    if (polygons[i][j][0] > xlim[1])
                        xlim[1] = polygons[i][j][0];
                    if (polygons[i][j][1] < ylim[0])
                        ylim[0] = polygons[i][j][1];
                    if (polygons[i][j][1] > ylim[1])
                        ylim[1] = polygons[i][j][1];
                }

            double xtarget, ytarget;
            int[] a = new int[2], b = new int[2];
            double[] lxlim = new double[2];
            double[] lylim = new double[2];
            var x = (int)Math.Ceiling((xlim[1] - xlim[0]) / width);
            var y = (int)Math.Ceiling((ylim[1] - ylim[0]) / width);

            var A = new double[x + 1][];
            for (i = 0; i <= x; i++) A[i] = new double[y + 1];
            for (i = 0; i < n; i++)
            {
                lxlim[0] = polygons[i][0][0];
                lxlim[1] = lxlim[0];
                lylim[0] = polygons[i][0][1];
                lylim[1] = lylim[0];
                for (j = 1; j < polygons[i].Length; j++)
                {
                    if (polygons[i][j][0] < lxlim[0])
                        lxlim[0] = polygons[i][j][0];
                    if (polygons[i][j][0] > lxlim[1])
                        lxlim[1] = polygons[i][j][0];
                    if (polygons[i][j][1] < lylim[0])
                        lylim[0] = polygons[i][j][1];
                    if (polygons[i][j][1] > lylim[1])
                        lylim[1] = polygons[i][j][1];
                }

                a[0] = (int)Math.Floor(((lxlim[0] - ((lxlim[0] - xlim[0]) % width)) - xlim[0]) / width);
                a[1] = (int)Math.Ceiling(((lxlim[1] - ((lxlim[1] - xlim[1]) % width)) - xlim[0]) / width);
                b[0] = (int)Math.Floor(((lylim[0] - ((lylim[0] - ylim[0]) % width)) - ylim[0]) / width);
                b[1] = (int)Math.Ceiling(((lylim[1] - ((lylim[1] - ylim[1]) % width)) - ylim[0]) / width);
                for (j = a[0]; j <= a[1]; j++)
                    for (k = b[0]; k <= b[1]; k++)
                    {
                        xtarget = xlim[0] + j * width;
                        ytarget = ylim[0] + k * width;
                        if (pip(polygons[i], xtarget, ytarget))
                            A[j][k] = predict(xtarget, ytarget, variogram);
                    }
            }
            double[] zlim = new double[2] { variogram.T.Min(), variogram.T.Max() };
            return new grid(A, xlim, ylim, zlim, width);
        }

        public static double predict(double x, double y, variogram variogram)
        {
            int i;
            double[] k = new double[variogram.n];
            for (i = 0; i < variogram.n; i++)
                k[i] = kriging_variogram_exponential(Math.Pow(Math.Pow(x - variogram.X[i], 2) + Math.Pow(y - variogram.Y[i], 2), 0.5), variogram.nugget, variogram.range, variogram.sill, variogram.A);
            return kriging_matrix_multiply(k, variogram.K, 1, variogram.n, 1)[0];
        }
    }

    public class variogram
    {
        public variogram(double[] T, double[] X, double[] Y, double nugget, double range, double sill, double A, int n, double[] M, double[] K)
        {
            this.T = T;
            this.X = X;
            this.Y = Y;
            this.nugget = nugget;
            this.range = range;
            this.sill = sill;
            this.A = A;
            this.n = n;
            this.M = M;
            this.K = K;
        }

        public double[] T { get; set; }
        public double[] X { get; set; }
        public double[] Y { get; set; }
        public double nugget { get; set; }
        public double range { get; set; }
        public double sill { get; set; }
        public double A { get; set; }
        public int n { get; set; }
        public double[] M { get; set; }
        public double[] K { get; set; }
    }

    public class grid
    {
        public grid()
        { 
        }

        public grid(double[][] A,double[] xlim,double[] ylim,double[] zlim,double width)
        {
            this.A = A;
            this.xlim = xlim;
            this.ylim = ylim;
            this.zlim = zlim;
            this.width = width;
        }
        public double[][] A { get; set; }
        public double[] xlim { get; set; }
        public double[] ylim { get; set; }
        public double[] zlim { get; set; }
        public double width { get; set; }
    }
}