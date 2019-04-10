using System;
using System.Text;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_BSgroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DbComponent.IDAO.IBSGroupInfoDao MYgroup = DbComponent.FactoryMethod.DispatchInfoFactory.CreateBSGroupInfoDao();
            DbComponent.IDAO.IBaseStationDao MyBSDao = DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
            MyModel.Model_BaseStation MBS = new MyModel.Model_BaseStation();
            MyModel.Model_BSGroupInfo group_detail = new MyModel.Model_BSGroupInfo();
            DbComponent.Entity MYEntity = new DbComponent.Entity();
            group_detail = MYgroup.GetBSGroupInfoByID(int.Parse(Request.QueryString["id"]));
            tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.BSGroupName;
            tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + MYEntity.GetEntityinfo_byid(int.Parse(group_detail.Entity_ID)).Name;
            //tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.GSSI;
            //tb1.Rows[3].Cells[1].InnerHtml = (group_detail.status == true) ? "&nbsp;&nbsp;是" : "&nbsp;&nbsp;否";
            string[] GSSIS = group_detail.MemberIds.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            StringBuilder cgvalue = new StringBuilder();
            
          for (int i = 0; i < GSSIS.Length; i++)//xzj--20181217--添加交换
            {
                string[] bsInfo = GSSIS[i].Split(new char[] { '{', ',','}' }, StringSplitOptions.RemoveEmptyEntries);
                MBS = MyBSDao.GetBaseStationByISSI(bsInfo[1].ToString(), string.IsNullOrEmpty(bsInfo[0].ToString())==true?0:int.Parse(bsInfo[0].ToString()));
                if (MBS != null)
                {
                    cgvalue.Append(MBS.StationName + "," + bsInfo[1] + "," + bsInfo[0] + "|");
                }
            }
            //foreach (var item in GSSIS)
            //{
            //    MBS = MyBSDao.GetBaseStationByISSI(item);
            //    if (MBS != null)
            //    {
            //        cgvalue.Append(MyBSDao.GetBaseStationByISSI(item).StationName + "," + item + "|");
            //    }
            //}
            tbtbz.InnerHtml = LQCommonCS.ISSI.CreateGroupBS(cgvalue.ToString().Split('|'));
        }
    }
}