using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using System.Data;
using DbComponent.resPermissions;
using Newtonsoft.Json.Linq;
using System.Text;
using Ryu666.Components;
namespace Web.lqnew.opePages
{
    public partial class select_user : System.Web.UI.Page
    {
        public string allpolices_json = "";

        public JArray unit = new JArray();
        public JArray zhishu = new JArray();
        public JArray usertype = new JArray();



        protected void Page_Load(object sender, EventArgs e)
        {
            string sids = "";
            string isHideOfflineUser = "True";
            int device_timeout = 5;
            int id = 0;
            string[] sidsArry;


            TabPanel1.HeaderText = ResourceManager.GetString("Terminal");
            TabPanel2.HeaderText = ResourceManager.GetString("Station");
            TabPanel3.HeaderText = ResourceManager.GetString("Unit");
            //基站
            this.ListBaseStation.Items[0].Text = ResourceManager.GetString("StationISSI");
            this.ListBaseStation.Items[1].Text = ResourceManager.GetString("StationName");

            //单位
            this.ListEntity.Items[0].Text = ResourceManager.GetString("EntityName");


            this.Button_Station.Text = ResourceManager.GetString("Lang_searchinresult");
            this.Button_Entity.Text = ResourceManager.GetString("Lang_searchinresult");

            if (Request.Form["hidsid"] != null)
            {
                sids = Request.Form["hidsid"];
                sidsArry = sids.Split(',');
                //框选基站
                ObjectDataSource1.SelectParameters.Add(new Parameter("minLo", TypeCode.String, sidsArry[0].ToString()));
                ObjectDataSource1.SelectParameters.Add(new Parameter("maxLo", TypeCode.String, sidsArry[1].ToString()));
                ObjectDataSource1.SelectParameters.Add(new Parameter("minLa", TypeCode.String, sidsArry[2].ToString()));
                ObjectDataSource1.SelectParameters.Add(new Parameter("maxLa", TypeCode.String, sidsArry[3].ToString()));
                //框选单位
                ObjectDataSource2.SelectParameters.Add(new Parameter("minLo", TypeCode.String, sidsArry[0].ToString()));
                ObjectDataSource2.SelectParameters.Add(new Parameter("maxLo", TypeCode.String, sidsArry[1].ToString()));
                ObjectDataSource2.SelectParameters.Add(new Parameter("minLa", TypeCode.String, sidsArry[2].ToString()));
                ObjectDataSource2.SelectParameters.Add(new Parameter("maxLa", TypeCode.String, sidsArry[3].ToString()));


                Session["sids"] = sids;
            }
            if (Request.Cookies["id"].Value != null)
            {
                id = int.Parse(Request.Cookies["id"].Value);
            }
            if (Request.Form["hidisHideOfflineUser"] != null)
            {
                isHideOfflineUser = Request.Form["hidisHideOfflineUser"];
                Session["hidisHideOfflineUser"] = isHideOfflineUser;
            }
            if (Request.Form["device_timeout"] != null)
            {
                device_timeout = int.Parse(Request.Form["device_timeout"].ToString());
                Session["device_timeout"] = device_timeout;
            }


            //基站信息配置

            GridView2.EmptyDataText = ResourceManager.GetString("NoData");
            GridView2.Columns[0].HeaderText = "ID";
            GridView2.Columns[1].HeaderText = ResourceManager.GetString("StationName");//基站名称
            GridView2.Columns[2].HeaderText = ResourceManager.GetString("Lang_Location");  //定位
            GridView2.Columns[3].HeaderText = ResourceManager.GetString("Lang_Operate");  //操作

            //单位信息配置

            GridView3.EmptyDataText = ResourceManager.GetString("NoData");
            GridView3.Columns[0].HeaderText = "ID";
            GridView3.Columns[1].HeaderText = ResourceManager.GetString("EntityName");//单位名称
            GridView3.Columns[2].HeaderText = ResourceManager.GetString("Lang_Location");  //定位

            //sids = "120.13569116592407,120.14354467391968,30.184976675142866,30.18775885907705";
            //id = 1;

            //获取权限
            String loginuserId = Request.Cookies["loginUserId"].Value;
            getResPermission(loginuserId);
            String respermissionString = getRespermissionString();
            userinfo getuserinfo = new userinfo();
            DataTable dtalluser = new DataTable();

            dtalluser = getuserinfo.getAllUSERInfoResPermission(Session["sids"].ToString(), respermissionString, Session["hidisHideOfflineUser"].ToString(), int.Parse(Session["device_timeout"].ToString()));


            string HDISSI = DbComponent.login.GETHDISSI(Request.Cookies["username"].Value.Trim());
            DataColumn dcdisplay = new DataColumn("IsDisplayByDispatch", typeof(bool));
            dtalluser.Columns.Add(dcdisplay);
            foreach (DataRow dr in dtalluser.Rows)
            {
                string issi = "<" + dr["ISSI"].ToString() + ">";
                dr["IsDisplayByDispatch"] = (HDISSI.Contains(issi)) ? false : true;
                dr["terminalType"] = dr["terminalType"].ToString().Trim();
            }
            allpolices_json = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dtalluser);

            //多语言
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
        }

        //定位和操作
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {


        }

        //获取权限
        public void getResPermission(String loginUserId)
        {
            try
            {
                LoginuserResourcePermissions LoginuserResourcePermissionsClass = new LoginuserResourcePermissions();
                JArray joRelust = new JArray();
                joRelust = LoginuserResourcePermissionsClass.getLoginuserResPermissionsByUserId_JObject(loginUserId);
                for (int i = 0; i < joRelust.Count(); i++)
                {
                    if (joRelust[i]["unit"] != null)
                    {
                        unit = JArray.Parse(joRelust[i]["unit"].ToString());
                    }
                    if (joRelust[i]["zhishu"] != null)
                    {
                        zhishu = JArray.Parse(joRelust[i]["zhishu"].ToString());
                    }
                    if (joRelust[i]["usertype"] != null)
                    {
                        usertype = JArray.Parse(joRelust[i]["usertype"].ToString());
                    }
                }
            }
            catch (Exception ex) { }
        }
        public String getRespermissionString()
        {
            StringBuilder respermissionString = new StringBuilder();
            int zhishuCount = 0;
            for (int i = 0; i < zhishu.Count(); i++)
            {
                ++zhishuCount;
                JObject jo = (JObject)zhishu[i];
                String entityId = jo["entityId"].ToString();
                if (zhishuCount == 1)
                {
                    respermissionString.Append(entityId);
                }
                else if (zhishuCount > 1)
                {
                    respermissionString.Append("," + entityId);
                }
            }
            respermissionString.Append("/");
            int unitCount = 0;
            for (int i = 0; i < unit.Count(); i++)
            {
                ++unitCount;
                JObject jo = (JObject)unit[i];
                String entityId = jo["entityId"].ToString();
                if (unitCount == 1)
                {
                    respermissionString.Append(entityId);
                }
                else if (unitCount > 1)
                {
                    respermissionString.Append("," + entityId);
                }
            }
            respermissionString.Append("/");
            int usertypeCount = 0;
            for (int i = 0; i < usertype.Count(); i++)
            {
                JObject jo = (JObject)usertype[i];
                String enId = jo["entityId"].ToString();

                JArray usertypeIds = (JArray)jo["usertypeIds"];
                for (int j = 0; j < usertypeIds.Count(); j++)
                {
                    ++usertypeCount;
                    String utId = usertypeIds[j].ToString();
                    if (usertypeCount == 1)
                    {
                        respermissionString.Append(enId + ":" + utId);
                    }
                    else if (usertypeCount > 1)
                    {
                        respermissionString.Append(";" + enId + ":" + utId);
                    }
                }
            }
            return respermissionString.ToString();
        }



        protected void Button_Station_Click(object sender, EventArgs e)
        {
            GridView2.PageIndex = 0;
        }


        protected void Button_Entity_Click(object sender, EventArgs e)
        {
            GridView3.PageIndex = 0;
        }


    }
}