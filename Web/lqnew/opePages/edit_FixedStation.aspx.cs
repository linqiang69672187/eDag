using DbComponent;
using DbComponent.FS_Info;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;


namespace Web.lqnew.opePages
{
    public partial class edit_FixedStation : FixedStation
    {
        private class checkISSI
        {
            public static bool RegexIssiValue(string value)
            {
                Regex regex = new Regex(@"^\d*$");
                return regex.IsMatch(value);
            }
        }
        private static Model_FixedStation FixedStation = new Model_FixedStation();
        private DbComponent.FS_Info.FixedStation FS = new DbComponent.FS_Info.FixedStation();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                FixedStation = FS.GetFixedStationByID(int.Parse(Request.QueryString["id"]));
                if (FixedStation != null)
                {

                    txtFSGSSIS.Text = FixedStation.GSSIS;
                    txtFSISSI.Text = FixedStation.StationISSI;
                    txtLa.Text = FixedStation.La.ToString();
                    txtLo.Text = FixedStation.Lo.ToString();
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("nxyxgdgdtxxybcz") + "');window.parent.mycallfunction('edit_FixedStation');</script>");
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            RVFSISSI.ErrorMessage = ResourceManager.GetString("gdtbzbxwzs");
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            rfvFSISSI.ErrorMessage = ResourceManager.GetString("rfvFSISSI");
            rfvFSGSSIS.ErrorMessage = ResourceManager.GetString("rfvFSGSSIS");
            rbtxtLo.ErrorMessage = "<b>" + ResourceManager.GetString("rbtxtLo") + "</b>";
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("qhqjd") + "</b>";
            RangeValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_RangeValidator1Err") + "</b>";
            RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("qhqwd") + "</b>";
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
        }

        public bool FindFSISSIForUpdate(int ID, string ISSI)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from FixedStation_info where StationISSI = @StationISSI and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationISSI", ISSI), new SqlParameter("ID", ID));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
            return isReturn;
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public bool UpdateFixedStation(Model_FixedStation newModel)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("update FixedStation_info set ");
            bool flag = false;
            if (newModel.StationISSI != null)
            {
                sbSQL.Append(" [StationISSI] = '" + newModel.StationISSI + "',");
                flag = true;
            }
            if (newModel.GSSIS != null)
            {
                sbSQL.Append(" [GSSIS] = '" + newModel.GSSIS + "',");
                flag = true;
            }

            if (newModel.Entity_ID != "")
            {
                sbSQL.Append(" [Entity_ID] = '" + newModel.Entity_ID + "',");
                flag = true;
            }
            if (newModel.Lo != null)
            {
                sbSQL.Append(" [Lo] = '" + newModel.Lo + "',");
                flag = true;
            }
            if (newModel.La != null)
            {
                sbSQL.Append(" [La] = '" + newModel.La + "',");
                flag = true;
            }

            if (newModel.IsDisplay != null)
            {
                sbSQL.Append(" [IsDisplay] = '" + newModel.IsDisplay + "',");
                flag = true;
            }
            string strSql = "";
            if (flag)
            {
                strSql = sbSQL.ToString().Substring(0, sbSQL.ToString().Length - 1);
            }
            strSql += " where ID=@ID";
            int i = 0;
            try
            {
                log.Info(strSql);
                i = SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("ID", newModel.ID));
                if (i > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {
                log.Info(strSql);
                log.Error(ex);
                return false;
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            if (FS.getAllFixedStationCount() == null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("gdteditfaile") + "');window.parent.mycallfunction('edit_FixedStation');</script>");
                return;
            }
            if (!checkISSI.RegexIssiValue(txtFSISSI.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("gdtbzbxwzs") + "');</script>");
                return;
            }
            if (FindFSISSIForUpdate(int.Parse(Request.QueryString["id"]), txtFSISSI.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("gdtbzycz") + "');</script>");
                return;
            }

            try
            {
                decimal Lo = 0.0M;
                decimal La = 0.0M;
                if (!string.IsNullOrEmpty(txtLo.Text.Trim()))
                {
                    Lo = decimal.Parse(txtLo.Text.Trim());
                }
                if (!string.IsNullOrEmpty(txtLa.Text.Trim()))
                {
                    La = decimal.Parse(txtLa.Text.Trim());
                }

                Model_FixedStation newModel = new Model_FixedStation { ID = int.Parse(Request.QueryString["id"]), GSSIS = txtFSGSSIS.Text.Trim(), StationISSI = txtFSISSI.Text.Trim(), Entity_ID = DropDownList1.SelectedIndex.ToString().Trim(), Lo = Lo, La = La, IsDisplay = false };
                if (UpdateFixedStation(newModel))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.CloseJWD();window.parent.lq_changeifr('FixedStation');window.parent.mycallfunction('edit_FixedStation');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }
    }
}
