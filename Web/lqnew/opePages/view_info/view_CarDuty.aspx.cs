using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_CarDuty : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string str_type = Request["type"].ToString();
            string pid = Request["id"].ToString();
            string begTime = Request["begtime"].ToString();
            string endTime = Request["endtime"].ToString();
            lb_Content.Text = toHtml(str_type, pid, begTime, endTime);
        }

        private string toHtml(string str_type, string pid, string begTime, string endTime)
        {
            string dis = "display:none";
            string fsrq = ResourceManager.GetString("Lang_HappenDate");    //发生日期
            string dqwt = ResourceManager.GetString("Lang_current_state");  //当前状态
            DataTable dt = new DataTable();
            if (str_type.ToString() == "0" || str_type.ToString() == "2")//代表汇总
            {
                dis = "display:";
                StringBuilder strSQL = new StringBuilder();
                strSQL.Append(" select begintime,endtime, e.Name as entityname,d.reserve1 as r1,d.reserve2 as r2,d.reserve3 as r3,d.reserve4 as r4,d.reserve5 as r5 ");
                strSQL.Append(" ,d.reserve6 as r6,d.reserve7 as r7,d.reserve8 as r8,d.reserve9 as r9,d.reserve10 as r10,b.reserve1 as rc1,b.reserve2 as rc2");
                strSQL.Append(" ,b.reserve3 as rc3,b.reserve4 as rc4,b.reserve5 as rc5 ");
                strSQL.Append(" ,b.reserve6 as rc6,b.reserve7 as rc7,b.reserve8 as rc8,b.reserve9 as rc9,b.reserve10 as rc10");
                strSQL.Append(" ,c.name as proname,issi,b.name as uname,num,stepName");
                strSQL.Append(" from duty_record a");
                strSQL.Append(" left join  user_duty b on (a.user_duty_id=b.id)");
                strSQL.Append(" left join _procedure c on(b.procedure_id=c.id)");
                strSQL.Append(" left join procedure_type d on(d.name=c.pType)");
                strSQL.Append(" left join Entity e on (b.entityID=e.ID) where a.id=@pid ");
                dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSQL.ToString(), "dfds", new SqlParameter("pid", pid));
            }
            else if (str_type.ToString() == "1") {
                dqwt = ResourceManager.GetString("Lang_StatueRW");  //状态
                fsrq = ResourceManager.GetString("Lang_DoTime");    //执行时间
                StringBuilder strSQL = new StringBuilder();
                strSQL.Append(" select begintime,endtime, e.Name as entityname,d.reserve1 as r1,d.reserve2 as r2,d.reserve3 as r3,d.reserve4 as r4,d.reserve5 as r5 ");
                strSQL.Append(" ,d.reserve6 as r6,d.reserve7 as r7,d.reserve8 as r8,d.reserve9 as r9,d.reserve10 as r10,b.reserve1 as rc1,b.reserve2 as rc2");
                strSQL.Append(" ,b.reserve3 as rc3,b.reserve4 as rc4,b.reserve5 as rc5 ");
                strSQL.Append(" ,b.reserve6 as rc6,b.reserve7 as rc7,b.reserve8 as rc8,b.reserve9 as rc9,b.reserve10 as rc10");
                strSQL.Append(" ,c.name as proname,issi,b.name as uname,num,f.stepName");
                strSQL.Append(" from duty_status f");
                strSQL.Append(" left join duty_record a on(f.duty_record_id=a.id)");
                strSQL.Append(" left join  user_duty b on (a.user_duty_id=b.id)");
                strSQL.Append(" left join _procedure c on(b.procedure_id=c.id)");
                strSQL.Append(" left join procedure_type d on(d.name=c.pType)");
                strSQL.Append(" left join Entity e on (b.entityID=e.ID) where f.id=@pid ");
                dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSQL.ToString(), "dfds", new SqlParameter("pid", pid));
            }
            else if (str_type.ToString().IndexOf("Emergency") >= 0) 
            {
                if (str_type.ToString().IndexOf("0") >= 0)  //汇总
                {
                    dis = "display:";
                    dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, pid.ToString(), "dfds");
                }
                else
                {
                    dqwt = ResourceManager.GetString("Lang_StatueRW");  //状态
                    fsrq = ResourceManager.GetString("Lang_DoTime");    //执行时间
                    dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, pid.ToString(), "dfds");
                }
            }
            string st_lc = "";
            string st_issi = "";
            string st_name = "";
            string st_no = "";
            string st_entity = "";
            string st_statues = "";
            string beg_time = "";
           
           

            StringBuilder sb2 = new StringBuilder();
            StringBuilder sbGXH = new StringBuilder();
            if (dt != null && dt.Rows.Count > 0) {
                if (dt.Rows[0]["r1"].ToString() != "")
                {
                    sbGXH.Append(" <tr> <td align=\"left\" class=\"td1td\">" + dt.Rows[0]["r1"].ToString() + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + dt.Rows[0]["rc1"].ToString() + "</td></tr>");
                }
                if (dt.Rows[0]["r2"].ToString() != "")
                {
                    sbGXH.Append(" <tr> <td align=\"left\" class=\"td1td\">" + dt.Rows[0]["r2"].ToString() + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + dt.Rows[0]["rc2"].ToString() + "</td></tr>");
                }

                st_lc = dt.Rows[0]["proname"].ToString();
                st_issi = dt.Rows[0]["issi"].ToString();
                st_name = dt.Rows[0]["uname"].ToString();
                st_no = dt.Rows[0]["num"].ToString();
                st_entity = dt.Rows[0]["entityname"].ToString();
                if (dt.Rows[0]["stepName"].ToString() == "") {
                    st_statues = ResourceManager.GetString("Lang_UnUP");
                    if (str_type.ToString() != "1")
                    {
                        beg_time = DateTime.Parse(dt.Rows[0]["begintime"].ToString()).ToShortDateString();
                    }
                }
                else
                {
                    if (str_type.ToString().IndexOf("Emergency") >= 0)
                    { st_statues = ResourceManager.GetString("Emergency"); }
                    else
                    {
                        st_statues = dt.Rows[0]["stepName"].ToString();
                    }
                    beg_time = DateTime.Parse(dt.Rows[0]["begintime"].ToString()).ToShortDateString();

                    if (str_type.ToString() == "1")
                    {
                        beg_time = DateTime.Parse(dt.Rows[0]["begintime"].ToString()).ToString();
                    }
                    else
                    {
                        if (str_type.ToString().IndexOf("Emergency") >= 0)
                        {
                            string strSql2 = "select RevISSI,SendTime as changeTime from SMS_Info where RevISSI = 'Emergency' and SendISSI=@id and SendTime>=@begtime and  SendTime<=@endtime";
                            DataTable dt2 = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSql2.ToString(), "dddfds", new SqlParameter("id", dt.Rows[0]["issi"].ToString()), new SqlParameter("endtime", endTime + " 23:59:59"), new SqlParameter("begtime", begTime + " 0:0:0"));
                            if (dt2 != null)
                            {
                                sb2.Append("<table width='99%' border='0' align='center' cellpadding='0' cellspacing='1' bgcolor='#c0de98' >");
                                sb2.Append("<tr style='height:25px;'><td  background='../images/tab_14.gif' align='center' >" + ResourceManager.GetString("Lang_StatueRW") + "</td><td width='160px' align='center' background='../images/tab_14.gif'>" + ResourceManager.GetString("Lang_DoSetup") + "</td></tr>");
                                foreach (DataRow dr in dt2.Rows)
                                {
                                    sb2.Append("<tr style='height:22px;'><td  bgcolor='#FFFFFF' align='left' >&nbsp;&nbsp;" + ResourceManager.GetString("Emergency") + "</td><td  align='center' bgcolor='#FFFFFF'>" + dr["changeTime"].ToString() + "</td></tr>");
                                }
                                sb2.Append("</table>");
                            }
                        }
                        else
                        {
                            //去检索 根据上报时间的日期来检索
                            string strSql2 = "select stepName,changeTime from duty_status where duty_record_id=@id and changeTime>=@begtime and  changeTime<=@endtime";
                            DataTable dt2 = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSql2.ToString(), "dddfds", new SqlParameter("id", pid), new SqlParameter("endtime", endTime + " 23:59:59"), new SqlParameter("begtime", begTime + " 0:0:0"));
                            if (dt2 != null)
                            {
                                sb2.Append("<table width='99%' border='0' align='center' cellpadding='0' cellspacing='1' bgcolor='#c0de98' >");
                                sb2.Append("<tr style='height:25px;'><td  background='../images/tab_14.gif' align='center' >" + ResourceManager.GetString("Lang_StatueRW") + "</td><td width='160px' align='center' background='../images/tab_14.gif'>" + ResourceManager.GetString("Lang_DoSetup") + "</td></tr>");
                                foreach (DataRow dr in dt2.Rows)
                                {
                                    sb2.Append("<tr style='height:22px;'><td  bgcolor='#FFFFFF' align='left' >&nbsp;&nbsp;" + dr["stepName"].ToString() + "</td><td  align='center' bgcolor='#FFFFFF'>" + dr["changeTime"].ToString() + "</td></tr>");
                                }
                                sb2.Append("</table>");
                            }
                        }
                    }
                }
               
            }
            
            StringBuilder sbHtml = new StringBuilder();
            sbHtml.Append("<table id=\"tb1\" align=\"center\" bgcolor=\"#c0de98\" runat=\"server\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" width=\"100%\">");
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + ResourceManager.GetString("Lang_SSLC") + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + st_lc + "</td></tr>");
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + ResourceManager.GetString("Lang_ZDID") + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + st_issi + "</td></tr>");
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + ResourceManager.GetString("Name") + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + st_name + "</td></tr>");
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + ResourceManager.GetString("Lang_CarONOrPoliceNo") + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + st_no + "</td></tr>");
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + ResourceManager.GetString("Subordinateunits") + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + st_entity + "</td></tr>");
            sbHtml.Append(sbGXH.ToString());
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + dqwt + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + st_statues + "</td></tr>");
            sbHtml.Append(" <tr> <td align=\"left\" class=\"td1td\">" + fsrq + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;&nbsp;" + beg_time + "</td></tr>");
            sbHtml.Append(" <tr style=\"" + dis + "\"> <td align=\"left\"  class=\"td1td\">" + ResourceManager.GetString("Lang_StatuesOrSBSJ") + "</td> <td align=\"left\" bgcolor=\"#FFFFFF\">");

            sbHtml.Append("<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
            sbHtml.Append(" <tr> <td height=\"30\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
            sbHtml.Append(" <tr> <td height=\"30\" width=\"15\"><img height=\"30\" src=\"../images/tab_03.gif\" width=\"15\" /></td>");
            sbHtml.Append("<td background=\"../images/tab_05.gif\">&nbsp;</td>");
            sbHtml.Append(" <td width=\"14\"><img height=\"30\" src=\"../images/tab_07.gif\" width=\"14\" /></td>");
            sbHtml.Append("  </tr></table></td></tr>");
            sbHtml.Append("  <tr> <td><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
            sbHtml.Append(" <tr> <td background=\"../images/tab_12.gif\" width=\"9\">&nbsp;</td> <td bgcolor=\"#f3ffe3\">");
            sbHtml.Append("<div class=\"divgrd\" runat=\"server\" id=\"tbtbz\" style=\"\">" + sb2.ToString() + " </div></td>");
            sbHtml.Append(" <td background=\"../images/tab_16.gif\" width=\"9\">&nbsp;</td> </tr> </table> </td></tr>");
            sbHtml.Append(" <tr> <td height=\"15\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
            sbHtml.Append("  <tr>  <td height=\"29\" width=\"15\"> <img height=\"29\" src=\"../images/tab_20.gif\" width=\"15\" /></td>");
            sbHtml.Append(" <td background=\"../images/tab_21.gif\">&nbsp;</td>");
            sbHtml.Append("<td width=\"14\"> <img height=\"29\" src=\"../images/tab_22.gif\" width=\"14\" /></td>");
            sbHtml.Append(" </tr></table> </td></tr> </table>");
            
            sbHtml.Append("  </td></tr>");

            
          
            


            sbHtml.Append("</table>");
            return sbHtml.ToString(); ;
        }
    }
}