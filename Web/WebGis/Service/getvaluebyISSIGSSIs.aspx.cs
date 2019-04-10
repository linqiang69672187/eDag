using DbComponent;
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
using System;
using System.Data;
using System.Text;
namespace Web.WebGis.Service
{
    public partial class getvaluebyISSIGSSIs : System.Web.UI.Page
    {
        private IDispatchUserViewDao DispatchUserViewService
        {
            get
            {
                return DispatchInfoFactory.CreateDispatchUserViewDao();
            }
        }
        int intvalue = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            string issis = "";
            sb.Append("[");
            if (Request.QueryString["ISSI"].Trim() != "")  /**民警1(1000);民警2(1000);**/
            {
                string[] ISSI = Request.QueryString["issi"].Trim().Split(';');
                int intdb = 0;
                for (int i = 0; i < ISSI.Length; i++)
                {
                    if (ISSI[i].IndexOf(Ryu666.Components.ResourceManager.GetString("Unkown")) > -1)
                    {
                        if (intvalue > 0) { sb.Append(","); }
                        sb.Append(insertweizhi(ISSI[i].Substring(ISSI[i].IndexOf('(')+1).Replace(')',' ').Trim()));
                        intvalue += 1;
                    }
                    else
                    {
                        if (intdb > 0)
                        {
                            issis += ",";
                        }
                        issis += "'" + ISSI[i].Substring(ISSI[i].IndexOf('(') + 1).Replace(')', ' ').Trim() + "'";
                        intdb += 1;
                    }

                }
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT (select   [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID]  FROM [Group_info] a where [GSSI] in (" + issis + ")  UNION ALL SELECT (select   [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Lang_Terminal") + "',a.[ISSI],(SELECT   [Nam] FROM [User_info] where ISSI = a.[ISSI]),a.[ID] FROM [ISSI_info] a where [ISSI] in (" + issis + ") UNION ALL SELECT (select   [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ISSI],'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ID] FROM [Dispatch_Info] a where [ISSI] in (" + issis + ")", "group");
                for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                {

                    if (intvalue > 0) { sb.Append(","); }
                    if (dt.Rows[countdt][1].ToString() == Ryu666.Components.ResourceManager.GetString("Dispatch"))
                    {
                        Model_DispatchUser_View DispatchUserView = DispatchUserViewService.GetDispatchUserByISSI(dt.Rows[countdt][2].ToString());
                        sb.Append("{ \"entity\":\"" + dt.Rows[countdt][0] + "\", \"type\":\"" + dt.Rows[countdt][1] + "\", \"ISSI\":\"" + dt.Rows[countdt][2] + "\", \"name\":\"" + dt.Rows[countdt][3] + "[" + DispatchUserView.Usename + "]\", \"id\":\"" + dt.Rows[countdt][4] + "\", \"SQLType\":\"ISSI_info\"}");
                    }
                    else
                    {
                        sb.Append("{ \"entity\":\"" + dt.Rows[countdt][0] + "\", \"type\":\"" + dt.Rows[countdt][1] + "\", \"ISSI\":\"" + dt.Rows[countdt][2] + "\", \"name\":\"" + dt.Rows[countdt][3] + "\", \"id\":\"" + dt.Rows[countdt][4] + "\", \"SQLType\":\"ISSI_info\"}");
                    }
                    intvalue += 1;
                }
            }
            sb.Append("]");
            Response.Write(sb);
            Response.End();
        }

        private string insertweizhi(string issi)
        {
            return "{ \"entity\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"type\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"ISSI\":\"" + issi + "\", \"name\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"id\":\"0\", \"SQLType\":\"ISSI_info\"}";
        }
    }
}