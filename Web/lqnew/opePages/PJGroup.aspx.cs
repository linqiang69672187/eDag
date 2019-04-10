using System;

namespace Web.lqnew.opePages
{
    public partial class PJGroup : System.Web.UI.Page
    {
        protected DbComponent.userinfo UserInfoService {
            get {
                return new DbComponent.userinfo();
            }
        }
        protected DbComponent.ISSI ISSIService {
            get {
                return new DbComponent.ISSI();
            }
        }
        protected DbComponent.group GroupInfoService {
            get {
                return new DbComponent.group();
            }
        }
        protected DbComponent.IDAO.IDispatchUserViewDao DispatchUserViewService
        {
            get { return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchUserViewDao(); }
        }
        protected DbComponent.IDAO.IUserISSIViewDao UserISSIViewService
        {
            get { return DbComponent.FactoryMethod.DispatchInfoFactory.CreateUserISSIViewDao(); }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
           
        }

        



    }
}