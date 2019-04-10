using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Web.lqnew.opePages
{
    public partial class GroupCall : System.Web.UI.Page
    {
        protected DbComponent.group GroupInfoService
        {
            get
            {
                return new DbComponent.group();
            }
        }
        protected DbComponent.userinfo UserInfoService
        {
            get
            {
                return new DbComponent.userinfo();
            }
        }
        protected DbComponent.ISSI ISSIService
        {
            get
            {
                return new DbComponent.ISSI();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string putongzu = ResourceManager.GetString("putong_group");
            string zhuliuzu = ResourceManager.GetString("Lang_zhuliuzu");
            if (!IsPostBack)
            {
                if (Request["type"] != null && Request["myid"] != null)
                {
                    if (Request["type"].ToUpper() == "GSSI")
                    {
                        string myGssi = Request["myid"].ToString();
                        DataTable dt = GroupInfoService.GetGroupInfoByGIIS(myGssi);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            txtGIIS.Value = myGssi;
                            txtEntityName.Value = dt.Rows[0]["Name"].ToString();
                            txtGroupName.Value = dt.Rows[0]["Group_name"].ToString();
                            txtGType.Value = putongzu;// "普通组";

                        }
                    }

                    if (Request["type"].ToString() == "UID")
                    {
                        MyModel.Model_userinfo UserInfo = UserInfoService.GetUserinfo_byid(int.Parse(Request["myid"].ToString()));
                        string strISSI = UserInfo.ISSI;
                        if (!string.IsNullOrEmpty(strISSI))
                        {
                            MyModel.Model_ISSI MyISSI = ISSIService.GetISSIinfoByISSI(strISSI);
                            if (MyISSI != null)
                            {
                                string strGSSIs = MyISSI.GSSIS;
                                if (!string.IsNullOrEmpty(strGSSIs))
                                {
                                    string[] arrGSSI = strGSSIs.Split(new char[] { 's' });
                                    if (arrGSSI.Length > 0)
                                    {

                                        IList<string> tbz = (from c in arrGSSI.ToList<string>() where c.Contains("z") select c).ToList<string>();
                                        if (tbz != null)
                                        {
                                            string myGssi = tbz[0].ToString().Substring(2, tbz[0].ToString().Length - 3);

                                            DataTable dt = GroupInfoService.GetGroupInfoByGIIS(myGssi);
                                           if (dt != null && dt.Rows.Count > 0)
                                            {
                                                txtGIIS.Value = myGssi;
                                               txtEntityName.Value = dt.Rows[0]["Name"].ToString();
                                               txtGroupName.Value = dt.Rows[0]["Group_name"].ToString();
                                               txtGType.Value = putongzu;// "普通组";

                                            }
                                           else
                                            {
                                                if (myGssi != "0" && myGssi != "")//20171128 为0或空时不显示
                                                {
                                                    txtGIIS.Value = myGssi;
                                                    txtGroupName.Value = myGssi;
                                                    txtGType.Value = putongzu;

                                                }
                                            }
                                        }
                                    }

                                }
                            }

                        }

                    }
                }
            }
        }
    }
}