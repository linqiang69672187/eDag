using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class SendDTCZ : System.Web.UI.Page
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
                ddrDCZ.Items.Clear();
                DbComponent.DTGroupDao dtDao = new DTGroupDao();
                DataTable dt= dtDao.GetAllDTGroup();
                foreach (DataRow dr in dt.Rows) { 
                    ddrDCZ.Items.Add(new ListItem(dr["Group_name"].ToString(),dr["GSSI"].ToString()));
                }

                if (Request["senddtczhidsids"] != null && !String.IsNullOrEmpty(Request["senddtczhidsids"].ToString()))
                {
                    StringBuilder sbInfo = new StringBuilder();
                    hiduserinfo.Value = "";
                    string[] arrSid = Request["senddtczhidsids"].ToString().Split(new char[] { ';' });
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