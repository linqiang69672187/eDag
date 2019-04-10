using DbComponent.IDAO;
using MyModel;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
namespace DbComponent
{
    public class DTGroupInfoDao:IDTGroupInfoDao
    {
        #region IDTGroupInfoDao 成员

        public bool AddTDGroupInfo(Model_DTGroupInfo model)
        {
            throw new NotImplementedException();
        }

        public bool UpdateTDGroupInfo(Model_DTGroupInfo newModel)
        {
            throw new NotImplementedException();
        }

        public bool DeleteTDGroupInfoByID(int ID)
        {
            throw new NotImplementedException();
        }

        public Model_DTGroupInfo GetTDGroupInfoByGSSI(string gssi)
        {
            Model_DTGroupInfo newModel = new Model_DTGroupInfo();
            StringBuilder sbSQL = new StringBuilder(" select top 1 * from DTGroup_info left outer join Entity on (DTGroup_info.entity_id=Entity.id) WHERE GSSI = @GSSI ");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdfi", new SqlParameter("GSSI", gssi));
            if (dt != null && dt.Rows.Count > 0)
            {
                newModel.ID = int.Parse(dt.Rows[0]["ID"].ToString());
                newModel.GSSI = dt.Rows[0]["GSSI"].ToString();
                newModel.Group_name = dt.Rows[0]["Group_name"].ToString();
                newModel.Value = dt.Rows[0]["Value"].ToString();
                newModel.Entity_ID = dt.Rows[0]["Entity_ID"].ToString();
                newModel.EntityName = dt.Rows[0]["Name"].ToString();
                newModel.Status = bool.Parse(dt.Rows[0]["Status"].ToString());
            }
            return newModel;
        }

        #endregion
    }
}
