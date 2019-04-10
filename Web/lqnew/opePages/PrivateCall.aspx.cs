using DbComponent;
using Ryu666.Components;
using System;
using System.Data;

namespace Web.lqnew.opePages
{
    public partial class PrivateCall : System.Web.UI.Page
    {
        private userinfo UserInfoService
        {
            get
            {
                return new userinfo();
            }
        }
        private Entity entityService
        {
            get {
                return new Entity();
            }
        }
        
        private DbComponent.IDAO.IDispatchUserViewDao DispatchUserViewDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchUserViewDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //btnnew.Text = ResourceManager.GetString("Add_New");
           
            

            if (!IsPostBack)
            {

                if (Request["type"] != null && Request["myid"] != null)
                {
                    if (Request["type"].ToString() == "ISSI")
                    {
                        DataTable mu = UserInfoService.GetInfoByISSI(Request["myid"].ToString());
                        if (mu != null && mu.Rows.Count > 0)
                        {
                            txtISSIText.Value = mu.Rows[0]["ISSI"].ToString();
                            txtPoliceNo.Value = mu.Rows[0]["Num"].ToString();

                            txtUserName.Value = mu.Rows[0]["Nam"].ToString();
                            txtUserEntity.Value = mu.Rows[0]["Name"].ToString();
                            
                        }
                    }

                    //传调度台ISSI号码
                    if (Request["type"].ToString() == "Dispatch")
                    {
                        MyModel.Model_DispatchUser_View mdv = DispatchUserViewDaoService.GetDispatchUserByISSI(Request["myid"].ToString());
                        if (mdv != null)
                        {
                            txtISSIText.Value = mdv.ISSI;
                            string disp_str = ResourceManager.GetString("Dispatch");//调度台
                            txtUserName.Value = disp_str + "(" + mdv.Usename + ")";

                            MyModel.Model_Entity me = entityService.GetEntityinfo_byid(int.Parse(mdv.Entity_ID));
                            if (me != null)
                            {
                                txtUserEntity.Value = me.Name;
                            }
                        }
                    }
                    //传用户ID过来
                    if (Request["type"].ToString() == "UID")
                    {
                        MyModel.Model_userinfo mu = UserInfoService.GetUserinfo_byid(int.Parse(Request["myid"].ToString()));
                        if (mu != null)
                        {
                            txtISSIText.Value = mu.ISSI;
                            txtPoliceNo.Value = mu.Num;
                            
                            txtUserName.Value = mu.Nam;
                            if (mu.Entity_ID == null) {
                                return;
                            }
                            MyModel.Model_Entity me = entityService.GetEntityinfo_byid(int.Parse(mu.Entity_ID));
                            if (me != null)
                            {
                                txtUserEntity.Value = me.Name;
                            }
                        }
                    }
                }
            }
        }
    }
}