using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;
using System.Xml;
using System.Data;
using System.Collections;
using System.Web.Script.Serialization;
using System.Text;
using DbComponent;

namespace Web.WebGis.Service
{
    public partial class FlexLayerControl : System.Web.UI.Page
    {
        WebSQLDb db = new WebSQLDb(Web.Config.m_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            string function = Request.QueryString["func"];
            if (!string.IsNullOrEmpty(function))
            {
                switch (function)
                {
                    case "LoadDataToLayerControl": { LoadDataToLayerControlByBound(Request.QueryString["layers"], Request.QueryString["bss"]); break; }//bss == bound,select,storedProcedures
                    default: { break; }
                }
            }
        }
        public void LoadDataToLayerControlByBound(string layers, string bss)
        {
            string[] bssArr = bss.Split('|');
            string bound = bssArr[0];
            string select = bssArr[1];
            string storedProcedures = bssArr[2];
            LoadDataToLayerControl(bound, select, layers, storedProcedures);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="bound"></param>
        /// <param name="select"></param>
        /// <param name="layers">@layer1isTwoG,@layer1manufactoryId,@layer1site_type|@layer2isTwoG,@layer2manufactoryId,@layer2site_type</param>
        /// <param name="storedProcedures"></param>
        public void LoadDataToLayerControl(string bound, string select, string layers, string storedProcedures)
        {
            System.DateTime dt1 = System.DateTime.Now;
            //如果Session存在数据则从Session获取 否则需要重新获取
            string JSONLayerControl = "";
            JSONLayerControl = GetLayerDataJSONString(layers, bound, select, storedProcedures);
            System.DateTime dt2 = System.DateTime.Now;
            string cSharp = (dt2.Second - dt1.Second).ToString() + (dt2.Millisecond - dt1.Millisecond).ToString();
            Response.Write(Server.UrlEncode(JSONLayerControl));
            Response.End();
        }
        /// <summary>
        /// 获取图层数据到Session
        /// </summary>
        /// <param name="LayerID"></param>
        /// <returns></returns>
        private string GetLayerDataJSONString(string layers, string bound, string select, string storedProcedures)
        {
            DataSet layerDs = new DataSet();
            layerDs = db.GetLayerData(layers, bound, select, storedProcedures, 3, "admin","false","5");
            StringBuilder JSON = new StringBuilder();
            JSON.Append("{");
            if (layerDs != null && layerDs.Tables.Count != 0)
            {
                int layerSplitNum = 200;//how many cells compose a group
                int layerCellNum = 0;
                for (int layer = 0; layer < layerDs.Tables.Count; layer++)
                {
                    for (int cell = 0; cell < layerDs.Tables[layer].Rows.Count; cell++)
                    {
                        if (cell == 0)
                        {
                            string layerName = layerDs.Tables[layer].Rows[0]["layerId"].ToString();
                            JSON.Append('"');
                            JSON.Append(layerName);
                            JSON.Append('"');
                            JSON.Append(":[");
                        }
                        DataRow dr = layerDs.Tables[layer].Rows[cell];
                        //dr["Longitude"] = (Convert.ToDouble(dr["Longitude"]) + 0.00519276).ToString();
                        //dr["Latitude"] = (Convert.ToDouble(dr["Latitude"]) - 0.002502505).ToString();
                        //if (cell == 0 || dr["layerId"].ToString() != layerDs.Tables[0].Rows[cell - 1]["layerId"].ToString())
                        //{
                        //}
                        if (layerCellNum % layerSplitNum == 0)//layerSplit begin
                        {
                            JSON.Append("{");
                        }
                        JSON.Append('"');
                        JSON.Append(dr["ID"].ToString());
                        JSON.Append('"');
                        JSON.Append(":{");
                        foreach (DataColumn dc in layerDs.Tables[layer].Columns)//LayerCellKeys
                        {
                            if (dc.ColumnName != "layerId")//图层名称不需要
                            {
                                JSON.Append('"');
                                JSON.Append(dc.ColumnName);
                                JSON.Append('"');
                                JSON.Append(":");
                                JSON.Append('"');
                                JSON.Append(dr[dc].ToString());
                                JSON.Append('"');
                                JSON.Append(',');
                            }
                        }
                        JSON.Remove(JSON.Length - 1, 1);//cut Groupcells last ','
                        JSON.Append("},");
                        if (layerCellNum % layerSplitNum == layerSplitNum - 1 || cell == layerDs.Tables[layer].Rows.Count - 1)//|| dr["layerId"].ToString() != layerDs.Tables[layer].Rows[cell + 1]["layerId"].ToString())//layerSplit end or layer end
                        {
                            JSON.Remove(JSON.Length - 1, 1);//cut Groupcells last ','
                            JSON.Append("},");
                        }
                        layerCellNum++;
                        if (cell == layerDs.Tables[layer].Rows.Count - 1)// || dr["layerId"].ToString() != layerDs.Tables[0].Rows[cell + 1]["layerId"].ToString())//layer end
                        {
                            layerCellNum = 0;
                            JSON.Remove(JSON.Length - 1, 1);//cut cellsGroup last ','
                            JSON.Append("],");
                        }
                    }
                }
                if (JSON.ToString() != "{")
                    JSON.Remove(JSON.Length - 1, 1);//cut last ','
            }
            JSON.Append("}");
            return JSON.ToString();
        }
        private Hashtable ConvertJsonToHashtable(string JSONData)
        {
            Hashtable ht = new Hashtable();
            return ht;
        }
    }
}