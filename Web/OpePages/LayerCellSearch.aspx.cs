using DbComponent;
using System;
using System.Collections;
using System.Data;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class LayerCellSearch : System.Web.UI.Page
    {
        ThisGridViewInit _gv;
        WebSQLDb webSQLDb = new WebSQLDb(Config.m_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            //使用在此声明继承与GridViewInit类，实现GVDataGet功能
            _gv = new ThisGridViewInit(GVSearch, ddlCompany, txtName, txtNum, txtISSI);
            if (!IsPostBack)
            {
                Response.Write("<script type='text/javascript'></script>");
                MyCSharp.ControlsDataBind.GridViewBind(_gv.ThisGVDataGet("", "", "", ""), GVSearch);
                ddlBind();
            }
        }
        private void ddlBind()
        {
            DataSet ds = webSQLDb.CompanyGet();
            ddlCompany.DataSource = ds;
            ddlCompany.DataTextField = "Name";
            ddlCompany.DataValueField = "Name";
            ddlCompany.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            MyCSharp.ControlsDataBind.GridViewBind(_gv.ThisGVDataGet(ddlCompany.SelectedValue, txtName.Text, txtNum.Text, txtISSI.Text), GVSearch);
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "choose")
            {
                //这里加上了地图的经纬度偏移值，使得查询的结果与地图显示的图元位置先一致
                if (e.CommandArgument.ToString() != "")
                {
                    if (e.CommandArgument.ToString().Split(',')[0] != "" && e.CommandArgument.ToString().Split(',')[1] != "" && e.CommandArgument.ToString().Split(',')[2] != "")
                    {
                        string LayerID = e.CommandArgument.ToString().Split('|')[0];
                        string CI = e.CommandArgument.ToString().Split('|')[1];
                        //这里加上了地图的经纬度偏移值，使得查询的结果与地图显示的图元位置先一致
                        string longitude = e.CommandArgument.ToString().Split('|')[2];
                        string latitude = e.CommandArgument.ToString().Split('|')[3];
                        string pars = LayerID + "|" + CI + "|" + longitude + "|" + latitude;
                        Response.Write("<script type='text/javascript'>window.parent.thisLocation('" + pars + "');</script>");
                    }
                }
            }
        }
    }
    //继承分页、排序列表父类 包括获取数据等函数
    public class ThisGridViewInit : MyCSharp.GridViewInit
    {
        public delegate DataSet deGetGVData(string entityName, string pcNam, string pcNum, string ISSI);
        WebSQLDb db = new WebSQLDb(Config.m_connectionString);
        #region 固定参数 无需更改
        public deGetGVData _deGetGVData;
        #endregion
        public ThisGridViewInit(System.Web.UI.WebControls.GridView dv, DropDownList ddlCompany, TextBox txtName, TextBox txtNum, TextBox txtISSI)
            : base(dv)
        {
            ArrayList paraControl = new ArrayList();
            paraControl.Add(ddlCompany);
            paraControl.Add(txtName);
            paraControl.Add(txtNum);
            paraControl.Add(txtISSI);
            SetGetData(new deGetGVData(ThisGVDataGet), paraControl);
        }
        public DataSet ThisGVDataGet(string entityName, string pcNam, string pcNum, string ISSI)
        {
            return db.CellsInfoGet(entityName, pcNam, pcNum, ISSI);
        }
        public override DataSet GVDataGet()
        {
            return _deGetGVData(((DropDownList)_paraControls[0]).SelectedValue, ((TextBox)_paraControls[1]).Text, ((TextBox)_paraControls[2]).Text, ((TextBox)_paraControls[3]).Text);
        }
        #region 固定函数 无需更改
        //设置获取数据委托函数与参数数组
        public void SetGetData(deGetGVData getGVData, ArrayList paraControls)
        {
            _paraControls = (ArrayList)paraControls.Clone();
            _deGetGVData = getGVData;
        }
        #endregion
    }
}