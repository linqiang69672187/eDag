using DbComponent;
using System;
using System.Data;

namespace Web.WebGis.Service
{
    public partial class ISSIsAllreadyin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            double num1 = double.Parse(Request.QueryString["num1"]);
            double num2 = double.Parse(Request.QueryString["num2"]);
            string tempISSI = "";
            for (double i = num1; i <= num2;i++ )
            {
                tempISSI += (i == num1) ? "'" + i + "'" : ",'" + i + "'";
            }
            int countpc = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from [ISSI_info] where ISSI in ("+tempISSI+")").ToString());
            Response.Write(countpc.ToString());
            Response.End();
        }
    }
}