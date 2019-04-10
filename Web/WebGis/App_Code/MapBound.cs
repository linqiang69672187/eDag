
/// <summary>
/// mapbound 类，一个包含四个边界顶点的地图边界
/// </summary>
    public class MapBound
    {
        /// <summary>
        /// 边界最小经度
        /// </summary>
        private double xmin = 0.0;

        /// <summary>
        /// 边界最小纬度
        /// </summary>
        private double ymin = 0.0;

        /// <summary>
        /// 边界最大经度
        /// </summary>
        private double xmax = 0.0;

        /// <summary>
        /// 边界最大纬度
        /// </summary>
        private double ymax = 0.0;

        /// <summary>
        /// Initializes a new instance of the MapBound class.构造函数
        /// </summary>
        public MapBound()
        {
        }

        /// <summary>
        ///  Initializes a new instance of the MapBound class.
        /// </summary>
        /// <param name="xmin">边界最小X</param>
        /// <param name="ymin">边界最小Y</param>
        /// <param name="xmax">边界最大X</param>
        /// <param name="ymax">边界最大Y</param>
        public MapBound(double xmin, double ymin, double xmax, double ymax)
        {
            this.xmin = xmin;
            this.ymin = ymin;
            this.xmax = xmax;
            this.ymax = ymax;
        }

        /// <summary>
        /// 把类转换为JSON字符串，和JS文件里的类对应
        /// </summary>
        /// <returns>边界的 JSON 字符串</returns>
        public override string ToString()
        {
            string str = string.Empty;
            str = "MapBound(xmin=" + this.xmin
                + ",ymin=" + this.ymin
                + ",xmax=" + this.xmax
                + ",ymax=" + this.ymax
                + ")";

            return str;
        }

        /// <summary>
        /// 获取边界最大经度
        /// </summary>
        /// <returns>经度</returns>
        public double GetXmax()
        {
            return this.xmax;
        }

        /// <summary>
        /// 设置边界最大经度
        /// </summary>
        /// <param name="xmax">经度</param>
        public void SetXmax(double xmax)
        {
            this.xmax = xmax;
        }

        /// <summary>
        /// 获取边界最小经度
        /// </summary>
        /// <returns>最小经度</returns>
        public double GetXmin()
        {
            return this.xmin;
        }

        /// <summary>
        /// 设置边界最小经度
        /// </summary>
        /// <param name="xmin">经度</param>
        public void SetXmin(double xmin)
        {
            this.xmin = xmin;
        }

        /// <summary>
        /// 获取边界最大纬度
        /// </summary>
        /// <returns>最大纬度</returns>
        public double GetYmax()
        {
            return this.ymax;
        }

        /// <summary>
        /// 设置边界最大纬度
        /// </summary>
        /// <param name="ymax">纬度</param>
        public void SetYmax(double ymax)
        {
            this.ymax = ymax;
        }

        /// <summary>
        /// 获取边界最下纬度
        /// </summary>
        /// <returns>最小纬度</returns>
        public double GetYmin()
        {
            return this.ymin;
        }

        /// <summary>
        /// 设置边界最小纬度
        /// </summary>
        /// <param name="ymin">纬度</param>
        public void SetYmin(double ymin)
        {
            this.ymin = ymin;
        }
    }
