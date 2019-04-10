using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
namespace Web.OpePages
{
    public partial class CIInfoGet : System.Web.UI.Page
    {
        WebSQLDb webSQLDb = new WebSQLDb(Config.m_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ci"] != null)
            {
                DataSet ds = webSQLDb.CIInfoGet(Request.QueryString["ci"].ToString());
                if (ds != null && ds.Tables[0].Rows.Count == 1)
                {
                    string body = "";
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count >= 1)
                    {
                        for (int cols = 0; cols < dt.Columns.Count; cols++)
                        {
                            //if (dt.Rows[0][cols].ToString().IndexOf('T') <= 0 && dt.Rows[0][cols].ToString().IndexOf('P') <= 0)
                            //{
                            //    body += "<tr><td>" + dt.Columns[cols].ColumnName + "</td><td>：" + dt.Rows[0][cols].ToString().Replace("(", "").Replace(")","") + "</td></tr>";
                            //}
                            //else
                            if (dt.Columns[cols].ColumnName == "Identification")//标识
                            {

                            }
                            else if (dt.Columns[cols].ColumnName == "Lang_interval")//上报间隔
                            {
                                body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td style='width:150px'>" + dt.Rows[0][cols].ToString() + Ryu666.Components.ResourceManager.GetString("minute") + "</td></tr>";
                            }
                            else if (dt.Columns[cols].ColumnName == "Lang_terminal_identification")//终端号码
                            {
                                if (dt.Rows[0][cols].ToString().IndexOf('T') >= 0)
                                {
                                    body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td><div  style='word-break: break-all;overflow-y:auto; width:150px ;height:20px'>" + dt.Rows[0][cols].ToString().Replace("T", "Tetra") + "</div></td></tr>";
                                }
                                else
                                    if (dt.Rows[0][cols].ToString().IndexOf('P') >= 0)
                                    {
                                        body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td><div  style='word-break: break-all;overflow-y:auto; width:150px ;height:20px'>" + dt.Rows[0][cols].ToString().Replace("P", "PDT") + "</div></td></tr>";
                                    }
                                    else
                                    {
                                        body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td><div  style='word-break: break-all;overflow-y:auto; width:150px ;height:20px'>" + dt.Rows[0][cols].ToString() + "</div></td></tr>";
                                    }
                            }
                            else if (dt.Columns[cols].ColumnName == "Remark")
                            {//备注信息
                                body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td><div  style='word-break: break-all;overflow-y:auto; width:150px ;height:20px'>" + dt.Rows[0][cols].ToString() + "</div></td></tr>";
                            }
                            else if (dt.Columns[cols].ColumnName == "Lang_Status")
                            {
                                body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td style='width:150px'>" + ResourceManager.GetString( dt.Rows[0][cols].ToString()) + "</td></tr>";
                            }
                            else
                            {
                                body += "<tr><td style='width:60px'>" + ResourceManager.GetString(dt.Columns[cols].ColumnName) + "</td><td style='width:5px'>:</td><td style='width:150px'>" + dt.Rows[0][cols].ToString() + "</td></tr>";
                            }
                        }
                    }
                    string HTML = @"<div><table style='font-size:12px;color:black;'>" + body
                                    + "</table></div>";
                    lblCIInfo.Text = HTML;
                }
            }
        }
    }
}