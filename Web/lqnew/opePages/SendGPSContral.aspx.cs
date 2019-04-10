using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Ryu666.Components;

namespace Web.lqnew.opePages
{
    public partial class SendGPSContral : System.Web.UI.Page
    {
        protected DbComponent.userinfo UserInfoService
        {
            get
            {
                return new DbComponent.userinfo();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Beidou_model.Text = ResourceManager.GetString("BEIDOU");
            GPS_model.Text = ResourceManager.GetString("GPS");
            if (!IsPostBack)
            {
                if (Request["sendgpscontralhidsids"] != null && !String.IsNullOrEmpty(Request["sendgpscontralhidsids"].ToString()))
                {
                    StringBuilder sbInfo = new StringBuilder();
                    hiduserinfo.Value = "";
                    string[] arrSid = Request["sendgpscontralhidsids"].ToString().Split(new char[] { ';' });
                    DataTable myUserList = UserInfoService.GetUserInfoByIds(arrSid);
                    foreach (DataRow myUser in myUserList.Rows)
                    {
                        sbInfo.Append(myUser["Nam"]);
                        sbInfo.Append(",");
                        sbInfo.Append(myUser["ISSI"]);
                        sbInfo.Append(",");
                        sbInfo.Append(myUser["type"]);
                        sbInfo.Append(",");
                        sbInfo.Append(myUser["typeName"]);
                        sbInfo.Append(";");
                        //hiduserinfo.Value += myUser.Nam + "," + myUser.ISSI + "," + myUser.type + ";";
                    }
                    hiduserinfo.Value = sbInfo.ToString();
                    if (hiduserinfo.Value.Length > 0)
                    {
                        hiduserinfo.Value = hiduserinfo.Value.Substring(0, hiduserinfo.Value.Length - 1);
                    }
                    
                }
            }
        }
       
    }
}