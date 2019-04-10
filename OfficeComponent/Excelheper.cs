using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Data;
using System.Threading;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.Web;
using System.Data.SqlClient;
using NPOI.HSSF.Util;
using NPOI.SS.Util;
using DbComponent;
using System.Web.UI;
using Ryu666.Components;

namespace OfficeComponent
{
    public class Excelheper
    {
        private static readonly Object objlock = new Object();
        private int _type = 0;
        private Dictionary<string, string> _diclist = new Dictionary<string, string>();
        private static Excelheper instance;
        public static Excelheper Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (objlock)
                    {
                        if (instance == null)
                            instance = new Excelheper();
                    }
                }
                return instance;
            }
        }

        private IWorkbook workbook;

        private Excelheper()
        {
        }

        private IWorkbook CreateWorkBook()
        {
            return new HSSFWorkbook();
        }

        private ICellStyle CreateCellStyle(IFont font)
        {
            ICellStyle cellstyle = workbook.CreateCellStyle();
            cellstyle.Alignment = HorizontalAlignment.CENTER;
            if (font != null)
                cellstyle.SetFont(font);
            return cellstyle;
        }

        private IFont DefaultIFont()
        {
            IFont font = workbook.CreateFont();
            font.FontName = "宋体";
            font.FontHeightInPoints = 12;
            font.Boldweight = (short)FontBoldWeight.BOLD;
            font.Color = HSSFColor.RED.index;
            return font;
        }

        private IFont SetFont(String fontname, short fontsize, short fontcolor, FontBoldWeight fontboldweight)
        {
            IFont font = workbook.CreateFont();
            font.FontName = fontname;
            font.FontHeightInPoints = fontsize;
            font.Boldweight = (short)fontboldweight;
            font.Color = fontcolor;
            return font;
        }

        private String GetSheetName(string sheetname, int page)
        {
            int index = sheetname.LastIndexOf('_');
            return String.Format("{0}_{1}", sheetname.Substring(index + 1), page);
        }

        private void DoFillSheet(IDataReader dr, DataTable drEmergency, string sheetname, ref IWorkbook workbook)
        {
            ISheet sheet;
            int fieldcount;
            ICell cell;
            ICellStyle cellstyle2 = CreateCellStyle(null);
            cellstyle2.BorderBottom = BorderStyle.THIN;
            cellstyle2.BottomBorderColor = 8;
            cellstyle2.BorderRight = BorderStyle.THIN;
            cellstyle2.RightBorderColor = 8;
            cellstyle2.BorderTop = BorderStyle.THIN;
            cellstyle2.TopBorderColor = 8;
            cellstyle2.FillForegroundColor = 26;
            cellstyle2.Alignment = HorizontalAlignment.CENTER;
            int rowindex = 2;
            int pagerow = 1;
            CreateSheetAndTitle(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out fieldcount, out cell);
            while (dr.Read())
            {
                IRow datarow;
                try
                {
                    datarow = sheet.CreateRow(rowindex);
                }
                catch (Exception er)
                {
                    CreateSheetAndTitle(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out fieldcount, out cell);
                    rowindex = 2;
                    datarow = sheet.CreateRow(rowindex);
                }
                int column_index = 0;
                for (int j = 0; j < fieldcount; j++)
                {
                    string title = "";
                    try
                    {
                        title = ENCN.DicENCN[dr.GetName(j).ToLower()];
                    }
                    catch
                    {
                        title = "";
                    }
                    if (title != "")
                    {
                        cell = datarow.CreateCell(column_index);
                        cell.CellStyle = cellstyle2;
                        switch (j)
                        {
                            case 5:
                                if (string.IsNullOrEmpty(dr[j].ToString()))
                                    cell.SetCellValue(DYY._lists["Lang_UnUP"]);
                                else
                                    cell.SetCellValue(dr[j].ToString());
                                break;
                            case 0:
                                if (string.IsNullOrEmpty(dr[j].ToString()))
                                    cell.SetCellValue(dr[j].ToString());
                                else
                                    cell.SetCellValue(DateTime.Parse(dr[j].ToString()).ToShortDateString());
                                break;
                            default:
                                cell.SetCellValue(dr[j].ToString());
                                break;
                        }
                        column_index++;
                    }

                }
                rowindex++;
                pagerow++;
            }
            string tempISSI = "";
            if (drEmergency == null)
            { return; }
            for (int i = 0; i < drEmergency.Rows.Count; i++)
            {
                if (this._type == 0)
                {
                    if (drEmergency.Rows[i][2].ToString() == tempISSI)
                    { continue; }
                    else { tempISSI = drEmergency.Rows[i][2].ToString(); }
                }
                IRow datarow;
                try
                {
                    datarow = sheet.CreateRow(rowindex);
                }
                catch (Exception er)
                {
                    CreateSheetAndTitle(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out fieldcount, out cell);
                    rowindex = 2;
                    datarow = sheet.CreateRow(rowindex);
                }
                int column_index = 0;
                for (int j = 0; j < fieldcount; j++)
                {
                    string title = "";
                    try
                    {
                        title = ENCN.DicENCN[dr.GetName(j).ToLower()];
                    }
                    catch
                    {
                        title = "";
                    }
                    if (title != "")
                    {
                        cell = datarow.CreateCell(column_index);
                        cell.CellStyle = cellstyle2;
                        switch (j)
                        {
                            case 5:
                                cell.SetCellValue(Ryu666.Components.ResourceManager.GetString("Emergency"));
                                break;
                            case 0:
                                if (string.IsNullOrEmpty(drEmergency.Rows[i][j].ToString()))
                                    cell.SetCellValue(drEmergency.Rows[i][j].ToString());
                                else
                                    cell.SetCellValue(DateTime.Parse(drEmergency.Rows[i][j].ToString()).ToShortDateString());
                                break;
                            case 7:
                                if (this._type == 0)
                                {
                                    int count = 0;
                                    for (int m = 0; m < drEmergency.Rows.Count; m++)
                                    {
                                        if (drEmergency.Rows[m][2].ToString() == tempISSI)
                                        { count++; }
                                    }
                                    cell.SetCellValue(count.ToString());
                                }
                                break;
                            default:
                                cell.SetCellValue(drEmergency.Rows[i][j].ToString());
                                break;
                        }
                        column_index++;
                    }

                }
                rowindex++;
                pagerow++;
            }
        }



        /// <summary>
        /// 
        /// </summary>
        /// <param name="dr"></param>
        /// <param name="sheetname"></param>
        /// <param name="workbook"></param>
        /// <param name="sheet">sheet 名称长度有限制不能超过 </param>
        /// <param name="title">内容表格名称</param>
        /// <param name="fieldcount"></param>
        /// <param name="cell"></param>
        private void CreateSheetAndTitle(IDataReader dr, string sheetname, string title, IWorkbook workbook, out ISheet sheet, out int fieldcount, out ICell cell)
        {
            try
            {
                sheet = workbook.CreateSheet(sheetname);
            }
            catch (Exception er)
            {
                sheet = workbook.GetSheet(sheetname);
            }
            fieldcount = dr.FieldCount;
            sheet.AddMergedRegion(new CellRangeAddress(0, 0, 0, fieldcount - 1));//合并单元格

            ///设置内容标题
            IRow TitleRow = sheet.CreateRow(0);
            cell = TitleRow.CreateCell(0);
            cell.CellStyle = CreateCellStyle(SetFont("宋体", 20, HSSFColor.GREEN.index, FontBoldWeight.BOLD));
            cell.SetCellValue(title);

            ///标题
            IRow HeaderRow = sheet.CreateRow(1);
            ICellStyle cellstyle = CreateCellStyle(DefaultIFont());
            cellstyle.BorderBottom = BorderStyle.THIN;
            cellstyle.BottomBorderColor = 8;
            cellstyle.BorderRight = BorderStyle.THIN;
            cellstyle.RightBorderColor = 8;
            cellstyle.BorderTop = BorderStyle.THIN;
            cellstyle.TopBorderColor = 8;
            cellstyle.FillForegroundColor = 22;
            cellstyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            int column_index = 0;
            for (int i = 0; i < fieldcount; i++)
            {
                sheet.SetColumnWidth(i, 20 * 256); //设置列宽
                //sheet.AutoSizeColumn(i); //列自适应

                string title0 = "";
                try
                {
                    title0 = ENCN.DicENCN[dr.GetName(i).ToLower()];
                }
                catch
                {
                    title0 = "";
                }
                if (title0 != "")
                {
                    cell = HeaderRow.CreateCell(column_index);
                    cell.CellStyle = cellstyle;
                    cell.SetCellValue(title0);
                    column_index++;
                }


            }
        }


        private void Run(HttpContext context, List<string> sheetlist, int ProcId, String issi, String carno, String status, DateTime begtime, DateTime endtime, int entityID)
        {
            workbook = CreateWorkBook();

            //foreach (string sheetname in sheetlist)
            //{
            //    SqlDataReader dr = SQLHelper.GetReader(GetSQL(sheetname, ProcId, issi, carno, status, begtime, endtime, entityID));
            //    if (!dr.HasRows)
            //        return;
            //    DoFillSheet(dr, sheetname, ref workbook);
            //}
            foreach (string sheetname in sheetlist)
            {
                SqlDataReader dr;
                DataTable drEmergency;
                if (status == Ryu666.Components.ResourceManager.GetString("Emergency"))
                {
                    dr = SQLHelper.GetReader(GetSQL(sheetname, ProcId, issi, carno, status, begtime.AddYears(-50), endtime.AddYears(-50), entityID));
                    drEmergency = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, GetEmergencySQL(sheetname, ProcId, issi, carno, status, begtime, endtime, entityID), "sadfjasdfa");
                }
                else if (status == "")
                {
                    dr = SQLHelper.GetReader(GetSQL(sheetname, ProcId, issi, carno, status, begtime, endtime, entityID));
                    drEmergency = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, GetEmergencySQL(sheetname, ProcId, issi, carno, status, begtime, endtime, entityID), "sadfjasdfa");
                }
                else
                {
                    dr = SQLHelper.GetReader(GetSQL(sheetname, ProcId, issi, carno, status, begtime, endtime, entityID));
                    drEmergency = null;
                }
                if (dr != null && drEmergency != null && !dr.HasRows && drEmergency.Rows.Count <= 0)
                    return;
                DoFillSheet(dr, drEmergency, sheetname, ref workbook);
            }
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;
                ms.WriteTo(context.Response.OutputStream);
            }
            workbook = null;
        }

        private string GetEmergencySQL(string sheetname, int ProcId, string issi, string carno, string status, DateTime begtime, DateTime endtime, int entityID)
        {
            begtime = DateTime.Parse(begtime.ToShortDateString() + " 0:0:0");
            endtime = DateTime.Parse(endtime.ToShortDateString() + " 23:59:59");
            StringBuilder sqlcondition = new StringBuilder();
            sqlcondition.AppendFormat(" WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id={0} UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ", entityID);
            sqlcondition.AppendFormat(" select SendTime as beginTime,reserve1,b.issi,b.num,reserve2,a.RevISSI as nowstepName,a.SendTime, ROW_NUMBER() over(order by a.SendTime desc) cnt from SMS_Info a ");
            sqlcondition.AppendFormat(" left join user_duty b on a.SendISSI=b.issi");
            sqlcondition.AppendFormat(" left join _procedure c on b.procedure_id=c.id");
            sqlcondition.AppendFormat(" left join Entity e on (b.entityID=e.ID)");
            sqlcondition.AppendFormat(" where a.RevISSI='Emergency' and SendTime>='{0}' and SendTime<='{1}'", begtime, endtime);
            sqlcondition.Append(" and b.entityID in (select id from lmenu)");
            sqlcondition.Append(" and b.procedure_id=" + ProcId);
            if (!string.IsNullOrEmpty(carno))
            { sqlcondition.Append(" and b.num=" + carno); }
            if (!string.IsNullOrEmpty(issi))
            { sqlcondition.Append(" and b.issi=" + issi); }
            sqlcondition.Append(" order by SendISSI ");
            return sqlcondition.ToString();
        }

        public void SaveToClient(HttpContext context, String filename, List<string> list, int ProcId,
            String issi, String carno, String status, DateTime begtime, DateTime endtime, int entityID,
            int type, Dictionary<string, string> diclist)
        {
            this._type = type;
            //DYY._lists = diclist;
            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}.xls", context.Server.UrlEncode(filename)));
            context.Response.Clear();

            Run(context, list, ProcId, issi, carno, status, begtime, endtime, entityID);
        }

        private String GetSQL(String file, int ProcId, String issi, String carno, String status, DateTime begtime, DateTime endtime, int entityID)
        {
            if (this._type == 0)
            {
                return GetSQLCount(ProcId, issi, carno, status, begtime, endtime, entityID);
            }
            else
            {
                return GetSQLDetail(ProcId, issi, carno, status, begtime, endtime, entityID);
            }
        }

        /// <summary>
        /// 获得详细记录
        /// </summary>
        /// <param name="ProcId"></param>
        /// <param name="issi"></param>
        /// <param name="carno"></param>
        /// <param name="status"></param>
        /// <param name="begtime"></param>
        /// <param name="endtime"></param>
        /// <param name="entityID"></param>
        /// <returns></returns>
        private String GetSQLDetail(int ProcId, String issi, String carno, String status, DateTime begtime, DateTime endtime, int entityID)
        {
            begtime = DateTime.Parse(begtime.ToShortDateString() + " 0:0:0");
            endtime = DateTime.Parse(endtime.ToShortDateString() + " 23:59:59");
            //StringBuilder sqlcondition = new StringBuilder();

            //sqlcondition.AppendFormat(" WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id={0} UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ", entityID);
            //sqlcondition.Append(" select beginTime,reserve1,issi,num,reserve2,d.stepName,d.changeTime from user_duty a ");
            //sqlcondition.AppendFormat(" left join duty_record b on (b.user_duty_id=a.id and beginTime>='{0}' and beginTime<='{1}')", begtime, endtime);
            //sqlcondition.AppendFormat(" left join duty_status d on (b.id=d.duty_record_id and changeTime>='{0}' AND changeTime<='{1}')", begtime, endtime);
            //sqlcondition.AppendFormat(" where procedure_id={0}", ProcId);
            //sqlcondition.Append(" and a.entityID in (select  id from lmenu)");
            //if (!String.IsNullOrEmpty(issi))
            //    sqlcondition.AppendFormat(" and ISSI={0}", issi);
            //if (!String.IsNullOrEmpty(carno))
            //    sqlcondition.AppendFormat(" and num={0}", carno);
            //if (status != "-1" && !string.IsNullOrEmpty(status))
            //    sqlcondition.AppendFormat(" and d.stepName='{0}'", status);
            //else if (status == "-1")
            //    sqlcondition.AppendFormat(" and d.stepName is null", status);
            //sqlcondition.Append(" order by d.changeTime desc");

            StringBuilder sbWhere = new StringBuilder();
            if (!String.IsNullOrEmpty(issi))
            {
                sbWhere.AppendFormat(" and issi={0}", issi);
            }
            if (!String.IsNullOrEmpty(carno))
            {
                sbWhere.AppendFormat(" and num={0}", carno);
            }
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=" + entityID + " UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select beginTime,reserve1,issi,num,reserve2,d.stepName,d.changeTime from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append("");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id)  ");
            sbSQL.Append(" where procedure_id=" + ProcId + sbWhere.ToString() + " and a.entityID in (select  id from lmenu)");
            if (status == "")
            {
                sbSQL.Append(" and beginTime<='" + endtime + "' and beginTime >='" + begtime + "'");
            }
            else
            {
                if (status != "-1")
                {
                    sbSQL.Append(" and beginTime>='" + begtime + "' and beginTime<='" + endtime + "' and d.stepName='" + status + "'");
                }
                else
                {
                    sbSQL.Append(" and beginTime<='" + endtime + "' and beginTime >='" + begtime + "' and b.stepName is null ");
                }
            }
            return sbSQL.ToString();
        }

        /// <summary>
        /// 获得汇总信息
        /// </summary>
        /// <param name="ProcId"></param>
        /// <param name="issi"></param>
        /// <param name="carno"></param>
        /// <param name="status"></param>
        /// <param name="begtime"></param>
        /// <param name="endtime"></param>
        /// <param name="entityID"></param>
        /// <returns></returns>
        private String GetSQLCount(int ProcId, String issi, String carno, String status, DateTime begtime, DateTime endtime, int entityID)
        {

            begtime = DateTime.Parse(begtime.ToShortDateString() + " 0:0:0");
            endtime = DateTime.Parse(endtime.ToShortDateString() + " 23:59:59");
            //StringBuilder sqlcondition = new StringBuilder();
            //sqlcondition.AppendFormat(" WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id={0} UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ", entityID);
            //sqlcondition.Append(" select b.begintime,reserve1,issi,num,reserve2,b.stepName as nowstepName,b.stepChangeTime,b.cnt from user_duty a  ");
            //sqlcondition.AppendFormat(" left join duty_record b on (b.user_duty_id=a.id and beginTime>='{0}' and beginTime<='{1}')", begtime, endtime);
            //sqlcondition.AppendFormat(" where procedure_id={0}", ProcId);
            //sqlcondition.Append(" and a.entityID in (select  id from lmenu)");
            //if (!String.IsNullOrEmpty(issi))
            //    sqlcondition.AppendFormat(" and ISSI={0}", issi);
            //if (!String.IsNullOrEmpty(carno))
            //    sqlcondition.AppendFormat(" and num={0}", carno);
            //if (status != "-1" && !string.IsNullOrEmpty(status))
            //    sqlcondition.AppendFormat(" and b.stepName='{0}'", status);
            //else if (status == "-1")
            //    sqlcondition.AppendFormat(" and b.stepName is null", status);
            //sqlcondition.Append(" order by b.begintime desc,b.stepChangeTime desc");


            StringBuilder sbWhere = new StringBuilder();
            if (!String.IsNullOrEmpty(issi))
            {
                sbWhere.AppendFormat(" and ISSI={0}", issi);
            }
            if (!String.IsNullOrEmpty(carno))
            {
                sbWhere.AppendFormat(" and num={0}", carno);
            }
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=" + entityID + " UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";

            StringBuilder sbSQL = new StringBuilder(str + " select b.begintime,reserve1,issi,num,reserve2,b.stepName as nowstepName,b.stepChangeTime,b.cnt from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append(" ");
            sbSQL.Append(" where procedure_id=" + ProcId + " " + sbWhere.ToString() + " and a.entityID in (select  id from lmenu)");
            if (status == "")
            {
                //sbSQL.Append(" where stepChangeTime<='" + endtime + "' or stepChangeTime is null or nowstepName is null ");
                sbSQL.Append(" and b.begintime<='" + endtime + "' and b.begintime>='" + begtime + "'");
            }
            else
            {
                if (status != "-1")
                {
                    sbSQL.AppendFormat(" and b.begintime>='{0}' and b.begintime<='{1}' and b.stepName='{2}' ", begtime, endtime, status);
                }
                else
                {
                    sbSQL.Append(" and b.begintime<='" + endtime + "' and b.begintime>='" + begtime + "' and b.stepName is null ");
                }
            }
            return sbSQL.ToString();
        }
        //By wangnana GPS统计(汇总、详细)导出、单键报备历史汇总导出
        public void SaveToClient2(HttpContext context, String filename, List<string> list, String sql, Dictionary<string, string> diclist)
        {
            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}.xls", context.Server.UrlEncode(filename)));
            context.Response.Clear();
            workbook = CreateWorkBook();

            foreach (string sheetname in list)
            {
                SqlDataReader dr;

                dr = SQLHelper.GetReader(sql);

                //   DoFillSheet(dr, null, sheetname, ref workbook);

                ISheet sheet;
                int fieldcount;
                ICell cell;
                ICellStyle cellstyle2 = CreateCellStyle(null);
                cellstyle2.BorderBottom = BorderStyle.THIN;
                cellstyle2.BottomBorderColor = 8;
                cellstyle2.BorderRight = BorderStyle.THIN;
                cellstyle2.RightBorderColor = 8;
                cellstyle2.BorderTop = BorderStyle.THIN;
                cellstyle2.TopBorderColor = 8;
                cellstyle2.FillForegroundColor = 26;
                cellstyle2.Alignment = HorizontalAlignment.CENTER;
                int rowindex = 2;
                int pagerow = 1;
                CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                while (dr.Read())
                {
                    IRow datarow;
                    try
                    {
                        datarow = sheet.CreateRow(rowindex);
                    }
                    catch (Exception er)
                    {
                        CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                        rowindex = 2;
                        datarow = sheet.CreateRow(rowindex);
                    }
                    int column_index = 0;
                    for (int j = 0; j < dr.FieldCount; j++)
                    {
                        if (diclist[dr.GetName(j).ToLower()].ToString() != "")
                        {
                            cell = datarow.CreateCell(column_index);
                            cell.CellStyle = cellstyle2;
                            cell.SetCellValue(dr[j].ToString());
                            column_index++;
                        }
                    }
                    rowindex++;
                    pagerow++;
                }

            }
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;
                ms.WriteTo(context.Response.OutputStream);
            }
            workbook = null;
        }
        //By wangnana GPS统计(汇总、详细)导出、单键报备历史明细导出
        public void SaveToClient3(HttpContext context, String filename, List<string> list, String sql, String sqlEn, Dictionary<string, string> diclist, int type)
        {
            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}.xls", context.Server.UrlEncode(filename)));
            context.Response.Clear();
            workbook = CreateWorkBook();

            foreach (string sheetname in list)
            {
                SqlDataReader dr;
                DataTable drEmergency = null;
                dr = SQLHelper.GetReader(sql);
                if (sqlEn != "")
                {
                    drEmergency = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sqlEn, "sadfjasdfa");
                }

                ISheet sheet;
                int fieldcount;
                ICell cell;
                ICellStyle cellstyle2 = CreateCellStyle(null);
                cellstyle2.BorderBottom = BorderStyle.THIN;
                cellstyle2.BottomBorderColor = 8;
                cellstyle2.BorderRight = BorderStyle.THIN;
                cellstyle2.RightBorderColor = 8;
                cellstyle2.BorderTop = BorderStyle.THIN;
                cellstyle2.TopBorderColor = 8;
                cellstyle2.FillForegroundColor = 26;
                cellstyle2.Alignment = HorizontalAlignment.CENTER;
                int rowindex = 2;
                int pagerow = 1;
                CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                while (dr.Read())
                {
                    IRow datarow;
                    try
                    {
                        datarow = sheet.CreateRow(rowindex);
                    }
                    catch (Exception er)
                    {
                        CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                        rowindex = 2;
                        datarow = sheet.CreateRow(rowindex);
                    }
                    int column_index = 0;
                    for (int j = 0; j < dr.FieldCount; j++)
                    {
                        if (diclist[dr.GetName(j).ToLower()].ToString() != "")
                        {
                            cell = datarow.CreateCell(column_index);
                            cell.CellStyle = cellstyle2;
                            column_index++;
                            switch (j)
                            {
                                case 5:
                                    if (string.IsNullOrEmpty(dr[j].ToString().Trim()))
                                        cell.SetCellValue(ResourceManager.GetString("Lang_UnUP"));
                                    else
                                        cell.SetCellValue(dr[j].ToString());
                                    break;
                                case 0:
                                    if (string.IsNullOrEmpty(dr[j].ToString()))
                                        cell.SetCellValue(dr[j].ToString());
                                    else
                                        cell.SetCellValue(DateTime.Parse(dr[j].ToString()).ToShortDateString());
                                    break;
                                default:
                                    cell.SetCellValue(dr[j].ToString());
                                    break;
                            }
                        }
                    }
                    rowindex++;
                    pagerow++;
                }
                string tempISSI = "";
                if (drEmergency != null)
                {
                    for (int i = 0; i < drEmergency.Rows.Count; i++)
                    {
                        if (type == 0)
                        {
                            if (drEmergency.Rows[i][2].ToString() == tempISSI)
                            { continue; }
                            else { tempISSI = drEmergency.Rows[i][2].ToString(); }
                        }
                        IRow datarow;
                        try
                        {
                            datarow = sheet.CreateRow(rowindex);
                        }
                        catch (Exception er)
                        {
                            //CreateSheetAndTitle(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out fieldcount, out cell);
                            CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                            rowindex = 2;
                            datarow = sheet.CreateRow(rowindex);
                        }
                        int column_index = 0;
                        for (int j = 0; j < dr.FieldCount; j++)
                        {
                            if (diclist[dr.GetName(j).ToLower()].ToString() != "")
                            {
                                cell = datarow.CreateCell(column_index);
                                cell.CellStyle = cellstyle2;
                                switch (j)
                                {
                                    case 5:
                                        cell.SetCellValue(Ryu666.Components.ResourceManager.GetString("Emergency"));
                                        break;
                                    case 0:
                                        if (string.IsNullOrEmpty(drEmergency.Rows[i][j].ToString()))
                                            cell.SetCellValue(drEmergency.Rows[i][j].ToString());
                                        else
                                            cell.SetCellValue(DateTime.Parse(drEmergency.Rows[i][j].ToString()).ToShortDateString());
                                        break;

                                    default:
                                        cell.SetCellValue(drEmergency.Rows[i][j].ToString());
                                        break;
                                }
                                column_index++;
                            }
                        }
                        rowindex++;
                        pagerow++;
                    }
                }
            }
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;
                ms.WriteTo(context.Response.OutputStream);
            }
            workbook = null;
        }

        public void SaveToClient4(HttpContext context, String filename, List<string> list, String sql, Dictionary<string, string> diclist)
        {
            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}.xls", context.Server.UrlEncode(filename)));
            context.Response.Clear();
            workbook = CreateWorkBook();

            foreach (string sheetname in list)
            {
                SqlDataReader dr;

                dr = SQLHelper.GetReader(sql);

                //   DoFillSheet(dr, null, sheetname, ref workbook);

                ISheet sheet;
                int fieldcount;
                ICell cell;
                ICellStyle cellstyle2 = CreateCellStyle(null);
                cellstyle2.BorderBottom = BorderStyle.THIN;
                cellstyle2.BottomBorderColor = 8;
                cellstyle2.BorderRight = BorderStyle.THIN;
                cellstyle2.RightBorderColor = 8;
                cellstyle2.BorderTop = BorderStyle.THIN;
                cellstyle2.TopBorderColor = 8;
                cellstyle2.FillForegroundColor = 26;
                cellstyle2.Alignment = HorizontalAlignment.CENTER;
                int rowindex = 2;
                int pagerow = 1;
                string nodata = ResourceManager.GetString("Nodata");
                CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                while (dr.Read())
                {
                    IRow datarow;
                    try
                    {
                        datarow = sheet.CreateRow(rowindex);
                    }
                    catch (Exception er)
                    {
                        CreateSheetAndTitle2(dr, GetSheetName(sheetname, pagerow), sheetname, workbook, out sheet, out cell, diclist);
                        rowindex = 2;
                        datarow = sheet.CreateRow(rowindex);
                    }
                    int column_index = 0;
                    for (int j = 0; j < dr.FieldCount; j++)
                    {
                        cell = datarow.CreateCell(column_index);
                        cell.CellStyle = cellstyle2;
                        if (dr[j].ToString() == "Entity Lists")
                            cell.SetCellValue(nodata);
                        else
                            cell.SetCellValue(dr[j].ToString());
                        column_index++;
                    }
                    rowindex++;
                    pagerow++;
                }

            }
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;
                ms.WriteTo(context.Response.OutputStream);
            }
            workbook = null;
        }

        //重写CreateSheetAndTitle，新增参数diclist，用于传入列标题
        private void CreateSheetAndTitle2(IDataReader dr, string sheetname, string title, IWorkbook workbook,
            out ISheet sheet, out ICell cell, Dictionary<string, string> diclist)
        {
            try
            {
                sheet = workbook.CreateSheet(sheetname);
            }
            catch (Exception er)
            {
                sheet = workbook.GetSheet(sheetname);
            }
            int titlecount = 0;
            string[] titleArr = new string[100];//内容为excel表的列标题去除空白列后
            for (int i = 0; i < dr.FieldCount; i++)
            {
                if (diclist[dr.GetName(i).ToLower()].ToString() != "")
                {
                    titleArr.SetValue(diclist[dr.GetName(i).ToLower()].ToString(), titlecount);
                    titlecount++;
                }
            }
            sheet.AddMergedRegion(new CellRangeAddress(0, 0, 0, titlecount - 1));//合并单元格
            ///设置内容标题
            IRow TitleRow = sheet.CreateRow(0);
            cell = TitleRow.CreateCell(0);
            cell.CellStyle = CreateCellStyle(SetFont("宋体", 20, HSSFColor.GREEN.index, FontBoldWeight.BOLD));
            cell.SetCellValue(title);
            ///标题
            IRow HeaderRow = sheet.CreateRow(1);
            ICellStyle cellstyle = CreateCellStyle(DefaultIFont());
            cellstyle.BorderBottom = BorderStyle.THIN;
            cellstyle.BottomBorderColor = 8;
            cellstyle.BorderRight = BorderStyle.THIN;
            cellstyle.RightBorderColor = 8;
            cellstyle.BorderTop = BorderStyle.THIN;
            cellstyle.TopBorderColor = 8;
            cellstyle.FillForegroundColor = 22;
            cellstyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            for (int i = 0; i < titlecount; i++)
            {
                sheet.SetColumnWidth(i, 20 * 256); //设置列宽
                //sheet.AutoSizeColumn(i); //列自适应
                string title0 = "";
                try
                {
                    title0 = titleArr.GetValue(i).ToString();
                }
                catch
                {
                    title0 = "";
                }
                if (title0 != "")
                {
                    cell = HeaderRow.CreateCell(i);
                    cell.CellStyle = cellstyle;
                    cell.SetCellValue(title0);
                }
            }
        }

    }
    public class DYY
    {
        public static Dictionary<string, string> _lists = new Dictionary<string, string>();
    }

    public class ENCN
    {
        private static Dictionary<string, string> dicENCN = null;


        public static Dictionary<string, string> DicENCN
        {
            get { return ENCN.dicENCN; }
        }

        public static void SetENCN(string name)
        {
            dicENCN = GetENCN(name);
        }

        private static Dictionary<string, string> GetENCN(string name)
        {

            string Lang_CurrentInfo = "";//当前信息
            string Lang_DoSetup = "";//执行操作
            string Lang_ZDID = "";//终端ID
            string Lang_CarONOrPoliceNo = "";//号码(警号,车牌号等)
            string Lang_HappenDate = "";//发生日期
            string Lang_DoTime = "";//执行时间
            string Lang_DoDutyCount = "";//任务执行数量
            string Lang_UnUP = "";//未上报
            DYY._lists.TryGetValue("Lang_CurrentInfo", out Lang_CurrentInfo);
            DYY._lists.TryGetValue("Lang_DoSetup", out Lang_DoSetup);
            DYY._lists.TryGetValue("Lang_ZDID", out Lang_ZDID);
            DYY._lists.TryGetValue("Lang_CarONOrPoliceNo", out Lang_CarONOrPoliceNo);
            DYY._lists.TryGetValue("Lang_HappenDate", out Lang_HappenDate);
            DYY._lists.TryGetValue("Lang_DoTime", out Lang_DoTime);
            DYY._lists.TryGetValue("Lang_DoDutyCount", out Lang_DoDutyCount);
            DYY._lists.TryGetValue("Lang_UnUP", out Lang_UnUP);

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("nowstepname", Lang_CurrentInfo);//当前信息
            dic.Add("stepname", Lang_DoSetup);//执行操作
            dic.Add("issi", Lang_ZDID);//终端ID
            dic.Add("num", Lang_CarONOrPoliceNo);//号码(警号,车牌号等)
            dic.Add("begintime", Lang_HappenDate);//发生日期
            dic.Add("endtime", "全天结束时间");
            dic.Add("changetime", Lang_DoTime);//执行时间
            dic.Add("stepchangetime", Lang_DoTime);//执行时间
            dic.Add("cnt", Lang_DoDutyCount);//任务执行数量
            List<string> keylist = new List<string>();
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]))
            {
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = string.Format("select a.* from [procedure_type] a inner join _procedure b on a.name=b.pType where b.name='{0}'", name);
                    cmd.Connection = con;
                    cmd.Connection.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (!dr.HasRows)
                            return null;
                        int fieldcount = dr.FieldCount;
                        dr.Read();
                        for (int j = 0; j < fieldcount; j++)
                        {
                            if (String.IsNullOrEmpty(dr[j].ToString()))
                                continue;
                            dic.Add(dr.GetName(j), dr[j].ToString());
                        }
                    }
                }
            }
            return dic;
        }


        private static Dictionary<string, string> GetENCN()
        {

            string Lang_CurrentInfo = "";//当前信息
            string Lang_DoSetup = "";//执行操作
            string Lang_ZDID = "";//终端ID
            string Lang_CarONOrPoliceNo = "";//号码(警号,车牌号等)
            string Lang_HappenDate = "";//发生日期
            string Lang_DoTime = "";//执行时间
            string Lang_DoDutyCount = "";//任务执行数量
            string Lang_UnUP = "";//未上报
            DYY._lists.TryGetValue("Lang_CurrentInfo", out Lang_CurrentInfo);
            DYY._lists.TryGetValue("Lang_DoSetup", out Lang_DoSetup);
            DYY._lists.TryGetValue("Lang_ZDID", out Lang_ZDID);
            DYY._lists.TryGetValue("Lang_CarONOrPoliceNo", out Lang_CarONOrPoliceNo);
            DYY._lists.TryGetValue("Lang_HappenDate", out Lang_HappenDate);
            DYY._lists.TryGetValue("Lang_DoTime", out Lang_DoTime);
            DYY._lists.TryGetValue("Lang_DoDutyCount", out Lang_DoDutyCount);
            DYY._lists.TryGetValue("Lang_UnUP", out Lang_UnUP);

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("nowstepname", Lang_CurrentInfo);//当前信息
            dic.Add("stepname", Lang_DoSetup);//执行操作
            dic.Add("issi", Lang_ZDID);//终端ID
            dic.Add("num", Lang_CarONOrPoliceNo);//号码(警号,车牌号等)
            dic.Add("begintime", Lang_HappenDate);//发生日期
            dic.Add("endtime", "全天结束时间");
            dic.Add("changetime", Lang_DoTime);//执行时间
            dic.Add("stepchangetime", Lang_DoTime);//执行时间
            dic.Add("cnt", Lang_DoDutyCount);//任务执行数量
            List<string> keylist = new List<string>();
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]))
            {
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "select * from [procedure_type]";
                    cmd.Connection = con;
                    cmd.Connection.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (!dr.HasRows)
                            return null;
                        int fieldcount = dr.FieldCount;
                        dr.Read();
                        for (int j = 0; j < fieldcount; j++)
                        {
                            if (String.IsNullOrEmpty(dr[j].ToString()))
                                continue;
                            dic.Add(dr.GetName(j), dr[j].ToString());
                        }
                    }
                }
            }
            return dic;
        }
    }
}
