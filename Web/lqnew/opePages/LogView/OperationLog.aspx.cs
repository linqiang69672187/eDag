using DbComponent;
using MyModel.Enum;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.LogView
{
    public partial class OperationLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                //GetEnumJson<OperateLogOperType>();
                IdentityDeviceUnitBind();
                IdentityUnitBind();
            }
        }

        /// <summary>
        /// OperateLogIdentityDeviceType设备类型
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="typename">OperateLogOperType/OperateLogIdentityDeviceType</typeparam>
        /// <returns></returns>
        protected String GetEnumJson<T>()
        {
            var type = typeof(T);
            Int32[] values = Enum.GetValues(type) as Int32[];
            int count = values.Length;
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            for (int i = count-1; i >=0 ; i--)
            {
                sb.AppendFormat("{0}:{1},", type.Name + values[i].ToString(), values[i]);
            }
            sb.Remove(sb.Length-1,1);
            sb.Append("}");
            return sb.ToString();
        }

        private void IdentityUnitBind()
        {
            DataTable dt = new System.Data.DataTable();
           
            string  sql = "select ID,Name from Entity where ID>1 ";

            SQLHelper.ExecuteDataReader(ref dt, sql);
            selIdentityUnit.DataSource = dt;
            selIdentityUnit.DataTextField = "name";
            selIdentityUnit.DataValueField = "id";
            selIdentityUnit.DataBind();
            selIdentityUnit.Items.Insert(0, new ListItem(ResourceManager.GetString("SelectEntity"), "0"));

        }

        private void IdentityDeviceUnitBind()
        {
            DataTable dt = new System.Data.DataTable();

            string sql = "select ID,Name from Entity where ID>1 ";

            SQLHelper.ExecuteDataReader(ref dt, sql);
            selIdentityDeviceUnit.DataSource = dt;
            selIdentityDeviceUnit.DataTextField = "name";
            selIdentityDeviceUnit.DataValueField = "id";
            selIdentityDeviceUnit.DataBind();
            selIdentityDeviceUnit.Items.Insert(0, new ListItem(ResourceManager.GetString("SelectEntity"), "0"));

        }
    }
}