using Ryu666.Components;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
namespace Web.lqnew.opePages.SMS
{
    public partial class SMSDetail : System.Web.UI.Page
    {
        public string toissi = "";
        public string myissi = "";
        public string toname = "";
        public string myname = "";
        public int smsType = 0;
        public int isGroup = 0;

        protected void Page_Load(object sender, EventArgs e)
        {


            if (!Page.IsPostBack && Request.QueryString["ISSI"] != null)
            {
                string strSmsType = "";
                toissi = Request.QueryString["ISSI"].ToString();
                toname = Request.QueryString["name"].ToString();
                myname = Request.Cookies["username"].Value;
                smsType = Int32.Parse(Request.QueryString["type"].ToString());
                isGroup = Int32.Parse(Request.QueryString["isGroup"].ToString());

                myissi = "8008";
                if (Request.Cookies["dispatchissi"] != null && Request.Cookies["dispatchissi"].Value != null)
                {
                    myissi = Request.Cookies["dispatchissi"].Value;
                }
                String None = ResourceManager.GetString("Lang-None");
                String strql = "select top 100 SMSType,SendISSI,SMSContent,SendTime,ReturnID from SMS_Info where (SendISSI='" + toissi + "' and RevISSI='" + myissi + "')  or (SendISSI='" + myissi + "' and RevISSI='" + toissi + "') order by SendTime desc";
                DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strql, "adfafda");
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    if (dr["SMSType"].ToString() == "2")
                    {
                        strSmsType = Ryu666.Components.ResourceManager.GetString("Statusmessage");
                    }
                    else if (dr["SMSType"].ToString() == "0")
                    {
                        strSmsType = Ryu666.Components.ResourceManager.GetString("SMS");
                    }
                    if (dr["ReturnID"].ToString() != "-1")
                    {
                        strSmsType = Ryu666.Components.ResourceManager.GetString("Receipt");
                        string strQL = "select SMSContent,SendTime from SMS_Info where ID='" + dr["ReturnID"].ToString() + "'";
                        DataTable mydt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strQL, "adfafddfda");
                        if (mydt.Rows.Count > 0)
                        {
                            dr["SMSContent"] += "[<span style='color:yellow'>" + mydt.Rows[0]["SMSContent"] + " " + mydt.Rows[0]["SendTime"] + "</span>]";
                        }
                        else {
                            dr["SMSContent"] += "<none>";
                        }
                    }
                    if (dr["SendISSI"].ToString() == myissi)
                    { //我发送的
                        HtmlTableRow htr = new HtmlTableRow();
                        HtmlTableCell htc = new HtmlTableCell();
                        htc.Style.Add("width", "200px");
                        htc.Align = "right";
                        htc.InnerHtml = "<div id='sash_left'><b class='b1'></b><b class='b2'></b><b class='b3'></b><b class='b4'></b><div align='left' class='contentb'><span style='font-size: 14px; color: red;text-decoration-line:underline'><b>" + myname + "(" + myissi + ")[" + strSmsType + "]</b></span>:" + dr["SMSContent"].ToString() + "</div><div align='left' class='timeclass'>" + dr["SendTime"].ToString() + "</div><b class='b4'></b><b class='b3'></b><b class='b2'></b><b class='b1'></b></div><br>";
                        htr.Cells.Add(htc);
                        tb1.Rows.Add(htr);
                    }
                    else
                    { //对方发送的
                        HtmlTableRow htr2 = new HtmlTableRow();
                        HtmlTableCell htc2 = new HtmlTableCell();
                        htc2.InnerHtml = "<div id='sash_left'><b class='b11'></b><b class='b22'></b><b class='b33'></b><b class='b44'></b><div class='contentb2'><span style='font-size: 14px; color: red;text-decoration-line:underline'><b>" + toname + "(" + toissi + ")[" + strSmsType + "]</b></span>:" + dr["SMSContent"].ToString() + "</div><div class='timeclass2'>" + dr["SendTime"].ToString() + "</div><b class='b44'></b><b class='b33'></b><b class='b22'></b><b class='b11'></b></div><br>";
                        htr2.Cells.Add(htc2);
                        tb1.Rows.Add(htr2);
                    }

                }





            }

        }
    }
}