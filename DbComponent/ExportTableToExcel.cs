using Microsoft.Office.Interop.Excel;
using System;
using System.Data;
using System.IO;
using System.Web;

namespace DbComponent
{
    /// <summary> 
    /// OutPutExcel 的摘要说明 
    /// </summary> 
    public class ExportTableToExcel
    {
        public ExportTableToExcel()
        {
            // 
            // TODO: 在此处添加构造函数逻辑 
            // 
        }

        public static String DataTable_OutputExcel(System.Data.DataTable dt, string titleStr, string xFileName, string sheetName)
        {
            ClearTempFileDir();
            GC.Collect();
            Microsoft.Office.Interop.Excel._Application excel;//  =  new  Application();  
            int rowIndex = 4;
            int colIndex = 0;

            Microsoft.Office.Interop.Excel._Workbook xBk;
            Microsoft.Office.Interop.Excel._Worksheet xSt;

            excel = new ApplicationClass();

            xBk = excel.Workbooks.Add(true);

            xSt = (Microsoft.Office.Interop.Excel._Worksheet)xBk.ActiveSheet;
            xSt.Name = sheetName;
            //  
            //取得表格中各列的标题  
            //  
            foreach (DataColumn col in dt.Columns)
            {
                colIndex++;
                string colNameTmp = WrapWithName(col.Caption, 10);
                excel.Cells[4, colIndex] = colNameTmp;
                xSt.get_Range(excel.Cells[4, colIndex], excel.Cells[4, colIndex]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;//设置标题格式为居中对齐  
            }

            //  
            //取得表格中的数据  
            //  
            foreach (DataRow row in dt.Rows)
            {
                rowIndex++;
                colIndex = 0;
                foreach (DataColumn col in dt.Columns)
                {
                    colIndex++;
                    excel.Cells[rowIndex, colIndex] = row[col.ColumnName].ToString();
                }
            }
            //  
            //加载一个合计行  
            //  
            int rowSum = rowIndex;
            excel.Cells[2, 2] = titleStr;
            //  
            //设置整个报表的标题格式  
            //  
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, 2]).Font.Bold = true;
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, 2]).Font.Size = 12;
            //  
            //设置报表表格为最适应宽度  
            //  
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Select();
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Columns.AutoFit();
            //  
            //设置整个报表的标题为跨列居中  
            //  
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, colIndex]).Select();
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, colIndex]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenterAcrossSelection;

            // 
            //设置报表表格里的字体大小. 
            // 
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Font.Size = 9;
            //  
            //绘制边框  
            //  
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Borders.LineStyle = 1;
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, 1]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置左边线加粗  
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[4, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置上边线加粗  
            xSt.get_Range(excel.Cells[4, colIndex], excel.Cells[rowSum, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeRight].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置右边线加粗  
            xSt.get_Range(excel.Cells[rowSum, 1], excel.Cells[rowSum, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置下边线加粗  
            //  
            //显示效果  
            //  
            excel.Visible = false;
            int n = DateTime.Now.Millisecond;
            string path = HttpContext.Current.Server.MapPath(@"~/TempFiles/" + xFileName + ".xlsx");
            xBk.SaveCopyAs(path);
            dt.Dispose();
            xBk.Close(false, null, null);

            excel.Quit();
            System.Runtime.InteropServices.Marshal.ReleaseComObject(xBk);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(excel);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(xSt);
            xBk = null;
            excel = null;
            xSt = null;
            GC.Collect();

            return "../TempFiles/" + xFileName + ".xlsx";
        }

        public static String OutputExcel(DataView dv, string titleStr, string xFileName, string sheetName)
        {
            ClearTempFileDir();
            GC.Collect();
            Microsoft.Office.Interop.Excel._Application excel;//  =  new  Application();  
            int rowIndex = 4;
            int colIndex = 0;

            Microsoft.Office.Interop.Excel._Workbook xBk;
            Microsoft.Office.Interop.Excel._Worksheet xSt;

            excel = new ApplicationClass();

            xBk = excel.Workbooks.Add(true);

            xSt = (Microsoft.Office.Interop.Excel._Worksheet)xBk.ActiveSheet;
            xSt.Name = sheetName;
            //  
            //取得表格中各列的标题  
            //  
            foreach (DataColumn col in dv.Table.Columns)
            {
                colIndex++;
                string colNameTmp = WrapWithName(col.Caption, 10);
                excel.Cells[4, colIndex] = colNameTmp;
                xSt.get_Range(excel.Cells[4, colIndex], excel.Cells[4, colIndex]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;//设置标题格式为居中对齐  
            }

            //  
            //取得表格中的数据  
            //  
            foreach (DataRowView row in dv)
            {
                rowIndex++;
                colIndex = 0;
                foreach (DataColumn col in dv.Table.Columns)
                {
                    colIndex++;
                    excel.Cells[rowIndex, colIndex] = row[col.ColumnName].ToString();
                }
            }
            //  
            //加载一个合计行  
            //  
            int rowSum = rowIndex;
            excel.Cells[2, 2] = titleStr;
            //  
            //设置整个报表的标题格式  
            //  
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, 2]).Font.Bold = true;
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, 2]).Font.Size = 12;
            //  
            //设置报表表格为最适应宽度  
            //  
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Select();
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Columns.AutoFit();
            //  
            //设置整个报表的标题为跨列居中  
            //  
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, colIndex]).Select();
            xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, colIndex]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenterAcrossSelection;

            // 
            //设置报表表格里的字体大小. 
            // 
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Font.Size = 9;
            //  
            //绘制边框  
            //  
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Borders.LineStyle = 1;
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, 1]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置左边线加粗  
            xSt.get_Range(excel.Cells[4, 1], excel.Cells[4, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置上边线加粗  
            xSt.get_Range(excel.Cells[4, colIndex], excel.Cells[rowSum, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeRight].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置右边线加粗  
            xSt.get_Range(excel.Cells[rowSum, 1], excel.Cells[rowSum, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置下边线加粗  
            //  
            //显示效果  
            //  
            excel.Visible = false;
            int n = DateTime.Now.Millisecond;
            string path = HttpContext.Current.Server.MapPath(@"~/TempFiles/" + xFileName + n + ".xlsx");
            xBk.SaveCopyAs(path);
            dv.Dispose();
            xBk.Close(false, null, null);

            excel.Quit();
            System.Runtime.InteropServices.Marshal.ReleaseComObject(xBk);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(excel);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(xSt);
            xBk = null;
            excel = null;
            xSt = null;
            GC.Collect();

            return "TempFiles/" + xFileName + n + ".xlsx";
        }

        public static string OutputExcelWithMulSheet(DataView[] dvs, string xFileName, string[] titleStrs, string[] sheetNames)
        {
            ClearTempFileDir();
            GC.Collect();
            Microsoft.Office.Interop.Excel._Application excel;
            Microsoft.Office.Interop.Excel._Workbook xBk;
            Microsoft.Office.Interop.Excel._Worksheet xSt = null;

            excel = new ApplicationClass();
            xBk = excel.Workbooks.Add(true);
            if (dvs.Length == titleStrs.Length && titleStrs.Length == sheetNames.Length)
            {
                for (int i = 0; i < dvs.Length; i++)
                {
                    int rowIndex = 4;
                    int colIndex = 0;
                    DataView dv = dvs[i];
                    string titleStr = titleStrs[i];
                    string sheetName = sheetNames[i];
                    if (xSt == null)
                    {
                        xSt = (_Worksheet)xBk.Worksheets.Add(Type.Missing, Type.Missing, 1, Type.Missing);
                    }
                    else
                    {
                        xSt = (_Worksheet)xBk.Worksheets.Add(Type.Missing, xSt, 1, Type.Missing);
                    }

                    xSt.Name = sheetName;
                    //  
                    //取得表格中各列的标题  
                    //  
                    foreach (DataColumn col in dv.Table.Columns)
                    {
                        colIndex++;
                        string colNameTmp = WrapWithName(col.ColumnName, 10);
                        excel.Cells[4, colIndex] = colNameTmp;
                        //设置标题格式为居中对齐  
                        xSt.get_Range(excel.Cells[4, colIndex], excel.Cells[4, colIndex]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;
                    }
                    //  
                    //取得表格中的数据  
                    //  
                    foreach (DataRowView row in dv)
                    {
                        rowIndex++;
                        colIndex = 0;
                        foreach (DataColumn col in dv.Table.Columns)
                        {
                            colIndex++;

                            if (col.ColumnName == "客服流水号")
                            {
                                excel.Cells[rowIndex, colIndex] = "'" + row[col.ColumnName].ToString();
                            }
                            else
                            {
                                excel.Cells[rowIndex, colIndex] = row[col.ColumnName].ToString();
                            }
                        }
                    }
                    //  
                    //加载一个合计行  
                    //  
                    int rowSum = rowIndex;

                    //  
                    //取得整个报表的标题  
                    // 
                    excel.Cells[2, 2] = titleStr;
                    //  
                    //设置整个报表的标题格式  
                    //  
                    xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, 2]).Font.Bold = true;
                    xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, 2]).Font.Size = 12;
                    //  
                    //设置报表表格为最适应宽度  
                    //  
                    xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Select();
                    xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Columns.AutoFit();
                    //  
                    //设置整个报表的标题为跨列居中  
                    //  
                    xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, colIndex]).Select();
                    xSt.get_Range(excel.Cells[2, 1], excel.Cells[2, colIndex]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenterAcrossSelection;
                    // 
                    //设置报表表格里的字体大小. 
                    // 
                    xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Font.Size = 9;
                    //  
                    //绘制边框  
                    //  
                    xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, colIndex]).Borders.LineStyle = 1;
                    xSt.get_Range(excel.Cells[4, 1], excel.Cells[rowSum, 1]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置左边线加粗  
                    xSt.get_Range(excel.Cells[4, 1], excel.Cells[4, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置上边线加粗  
                    xSt.get_Range(excel.Cells[4, colIndex], excel.Cells[rowSum, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeRight].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置右边线加粗  
                    xSt.get_Range(excel.Cells[rowSum, 1], excel.Cells[rowSum, colIndex]).Borders[Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom].Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlMedium;//设置下边线加粗  
                    //  
                    //显示效果  
                    //  
                    excel.Visible = false;

                    dv.Dispose();
                }
                int n = new Random().Next(0, 10000);
                xBk.SaveCopyAs(HttpContext.Current.Server.MapPath(@"~/TempFiles/" + xFileName + n + ".xlsx"));

                xBk.Close(false, null, null);

                excel.Quit();
                System.Runtime.InteropServices.Marshal.ReleaseComObject(xBk);
                System.Runtime.InteropServices.Marshal.ReleaseComObject(excel);
                System.Runtime.InteropServices.Marshal.ReleaseComObject(xSt);
                xBk = null;
                excel = null;
                xSt = null;
                GC.Collect();
                return "TempFiles/" + xFileName + n + ".xlsx";
            }
            return "";
        }

        //
        //在调用此函数时间前2个小时生成的文件全部删除
        //
        public static void ClearTempFileDir()
        {
            double delFlagHours = 2;

            string tempfileDir = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + "/TempFiles";
            if (Directory.Exists(tempfileDir))
            {
                string[] filepaths = Directory.GetFiles(tempfileDir);//路径 
                foreach (string fileFullName in filepaths)
                {
                    FileInfo fileInfo = new FileInfo(fileFullName);
                    DateTime fileCreateTime = fileInfo.CreationTime;
                    TimeSpan timespan = DateTime.Now - fileCreateTime;
                    double hours = timespan.TotalHours;
                    if (hours >= delFlagHours)
                    {
                        File.Delete(fileFullName);
                    }
                }
            }
        }

        //
        //让字符串在规定字符个数位置换行


        //
        public static string WrapWithName(string str, int warpNum)
        {
            int flagNum = warpNum;
            string result = "";
            if (str.Length > flagNum)
            {
                for (int i = 0; i < str.Length; i++)
                {
                    result = result.Insert(result.Length, str[i].ToString());
                    if ((i + 1) % flagNum == 0 && (i + 1) != str.Length)
                    {
                        result = result.Insert(result.Length, "\n");
                    }
                }
            }
            else
            {
                result = str;
            }
            return result;
        }
    }
}
