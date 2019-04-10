using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Ryu666.Components;

namespace Web.WebGis.Service
{
    public partial class getISSSname : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            string ISSI = Request.QueryString["ISSI"];
            string GSSI = Request.QueryString["GSSI"];
            string hostISSI = Request.QueryString["hostISSI"];
            if (ISSI == hostISSI) 
            {
                sb.Append("\"PCname\":\"" + Request.Cookies["username"].Value + "\"");
                sb.Append(",\"lo\":\"0\"");
                sb.Append(",\"la\":\"0\"");
                sb.Append(",\"PCid\":\"0\",");
            } 
            else
            {
                switch (ISSI)
                {
                    case "1":
                        break;
                    default:
                        DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 a.[Nam],b.[Longitude],b.[Latitude],a.[ID]  FROM [User_info] a left outer join [GIS_info] b on a.[ISSI] =b.[ISSI] where a.[ISSI] = @ISSI ", "pc", new SqlParameter("ISSI", ISSI));//我将内部链接 改成了左链接 
                        if (dt.Rows.Count > 0)
                        {
                            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                            {
                                sb.Append("\"PCname\":\"" + dt.Rows[countdt][0].ToString() + "\"");
                                sb.Append(",\"lo\":\"" + dt.Rows[countdt][1].ToString() + "\"");
                                sb.Append(",\"la\":\"" + dt.Rows[countdt][2].ToString() + "\"");
                                sb.Append(",\"PCid\":\"" + dt.Rows[countdt][3].ToString() + "\",");
                            }
                        }
                        else
                        {
                            DataTable dtDispatch = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 * from Dispatch_Info where ISSI=@ISSI", "dsfdsdfs", new SqlParameter("ISSI", ISSI));

                            if (dtDispatch.Rows.Count > 0)
                            {
                                sb.Append("\"PCname\":\"" + Ryu666.Components.ResourceManager.GetString("Lang_Dispatch") + "\"");//调度台
                                sb.Append(",\"lo\":\"0\"");
                                sb.Append(",\"la\":\"0\"");
                                sb.Append(",\"PCid\":\"0\",");
                            }
                            else
                            {
                                sb.Append("\"PCname\":\"" + Ryu666.Components.ResourceManager.GetString("UnkownUser") + "\"");//未知用户
                                sb.Append(",\"lo\":\"0\"");
                                sb.Append(",\"la\":\"0\"");
                                sb.Append(",\"PCid\":\"0\",");
                            }
                        }
                        break;

                 }


            }

            switch (GSSI)
            {
                case "1":
                    sb.Append("\"GSSIName\":\"0\"");
                    break;
                default:
                    DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 [Group_name]  FROM [Group_info] where [GSSI] = @GSSI ", "group", new SqlParameter("GSSI", GSSI));
                    if (dt.Rows.Count > 0)
                    {
                        for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                        {
                            sb.Append("\"GSSIName\":\"" + dt.Rows[countdt][0].ToString() + "\"");
                        }
                    }
                    else
                    {
                        string weiPeiZhi = ResourceManager.GetString("Lang_noConfigure");
                        //sb.Append("\"GSSIName\":\"" +"未配置" + "\"");
                        sb.Append("\"GSSIName\":\"" + weiPeiZhi + "\"");
                    }
                    break;
            }
           

            sb.Append("}");
            Response.Write(sb);
            Response.End();

        }
    }
}