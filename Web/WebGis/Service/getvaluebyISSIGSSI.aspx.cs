using DbComponent;
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
namespace Web.WebGis.Service
{
    public partial class getvaluebyISSIGSSI : System.Web.UI.Page
    {
        private IDispatchUserViewDao DispatchUserViewService
        {
            get
            {
                return DispatchInfoFactory.CreateDispatchUserViewDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            string id = Request.QueryString["id"].Replace("GSSI(", "").Replace("ISSI(", "").Replace(")", "").Replace(Ryu666.Components.ResourceManager.GetString("Dispatch") + "(", "");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID]  FROM [Group_info] a where [GSSI] = @id  UNION ALL SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Lang_Terminal") + "',a.[ISSI],(SELECT [Nam] FROM [User_info] where ISSI = a.[ISSI]),a.[ID] FROM [ISSI_info] a where [ISSI] =@id   UNION ALL SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ISSI],'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ID] FROM [Dispatch_Info] a where [ISSI] =@id ", "group", new SqlParameter("id", id));
            sb.Append("[");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                if (countdt > 0) { sb.Append(","); }
                if (dt.Rows[countdt][1].ToString() == Ryu666.Components.ResourceManager.GetString("Dispatch"))
                {
                    Model_DispatchUser_View DispatchUserView = DispatchUserViewService.GetDispatchUserByISSI(dt.Rows[countdt][2].ToString());
                    sb.Append("{ \"entity\":\"" + dt.Rows[countdt][0] + "\", \"type\":\"" + dt.Rows[countdt][1] + "\", \"ISSI\":\"" + dt.Rows[countdt][2] + "\", \"name\":\"" + dt.Rows[countdt][3] + "["+DispatchUserView.Usename+"]\", \"id\":\"" + dt.Rows[countdt][4] + "\", \"SQLType\":\"ISSI_info\"}");
                }
                else
                {
                    sb.Append("{ \"entity\":\"" + dt.Rows[countdt][0] + "\", \"type\":\"" + dt.Rows[countdt][1] + "\", \"ISSI\":\"" + dt.Rows[countdt][2] + "\", \"name\":\"" + dt.Rows[countdt][3] + "\", \"id\":\"" + dt.Rows[countdt][4] + "\", \"SQLType\":\"ISSI_info\"}");
                }
            
            }
            if (dt.Rows.Count < 1)
            {
                sb.Append("{ \"entity\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"type\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"ISSI\":\"" + id + "\", \"name\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"id\":\"0\", \"SQLType\":\"ISSI_info\"}");
            }
            sb.Append("]");
            Response.Write(sb);
            Response.End();
        }
    }
}