using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ryu666.Components;
using System.Text;
using System.Data;

namespace Web.lqnew.opePages
{
    public partial class circleLocation : System.Web.UI.Page
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
                if (Request["sendgpspullcontralhidsids"] != null && !String.IsNullOrEmpty(Request["sendgpspullcontralhidsids"].ToString()))
                {
                    StringBuilder sbInfo = new StringBuilder();
                    hiduserinfo.Value = "";
                    string[] arrSid = Request["sendgpspullcontralhidsids"].ToString().Split(new char[] { ';' });
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