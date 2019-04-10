using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Web.lqnew.opePages
{
    public partial class SendGPSEnableOrDisable : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                if (Request["sendgpshidsids"] != null && !String.IsNullOrEmpty(Request["sendgpshidsids"].ToString()))
                {
                    StringBuilder sbInfo = new StringBuilder();
                    hiduserinfo.Value = "";
                    string[] arrSid = Request["sendgpshidsids"].ToString().Split(new char[] { ';' });
                    DataTable myUserList = UserInfoService.GetUserInfoByIds(arrSid);
                    foreach (DataRow myUser in myUserList.Rows)
                    {
                        sbInfo.Append(myUser["Nam"]);
                        sbInfo.Append(",");
                        sbInfo.Append(myUser["ISSI"]);
                        sbInfo.Append(",");
                        sbInfo.Append(myUser["type"]);
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