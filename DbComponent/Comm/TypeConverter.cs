#region
/*
 * yangdj
 * **/
#endregion
using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using System.Text;

namespace DbComponent.Comm
{
    /// <summary>
    /// Type Conversion's Class
    /// </summary>
    /// <typeparam name="T">Type</typeparam>
    public class TypeConverter
    {
        /// <summary>
        /// Convert DataTable To ModelList
        /// </summary>
        /// <param name="dt">DataTable</param>
        /// <returns>ModelList</returns>
        public static IList<T> DataTable2ModelList<T>(DataTable dt)
        {
            List<T>                         list      = new List<T>();
            T                               model     = default(T);
            foreach (DataRow dr in dt.Rows)
            {
                model                                 = Activator.CreateInstance<T>();
                foreach (DataColumn dc in dt.Columns)
                {
                    PropertyInfo            pi        = model.GetType().GetProperty(dc.ColumnName);
                    if (dr[dc.ColumnName] != DBNull.Value)
                    {
                        pi.SetValue(model, dr[dc.ColumnName], null);
                    }
                    else
                    {
                        pi.SetValue(model, null, null);
                    }

                }
                list.Add(model);
            }
            return list;
        }
        
        /// <summary>
        /// Convert List To Json,formate is {jsonname:[{},{}…]}
        /// </summary>
        /// <param name="jsonName">jsonname</param>
        /// <param name="IL">ModelList</param>
        /// <returns>json</returns>
        public static string   List2Json<T>(string jsonName, IList<T> list)
        {
            StringBuilder                   Json    = new StringBuilder();
            Json.Append("{\"" + jsonName + "\":[");
            if (list.Count > 0)
            {
                for (int i = 0; i < list.Count; i++)
                {
                    T                       obj     = Activator.CreateInstance<T>();
                    Type                    type    = obj.GetType();
                    PropertyInfo[]          pis     = type.GetProperties();
                    Json.Append("{");
                    for (int j = 0; j < pis.Length; j++)
                    {
                        Json.Append("\"" + pis[j].Name.ToString() + "\":\"" + pis[j].GetValue(list[i], null) + "\"");
                        if (j < pis.Length - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < list.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]}");
            return Json.ToString();
        }
       
        /// <summary>
        /// Covert List To ArrayJson,Formate is [{},{}...]
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public static string List2ArrayJson(IList<string> list)
        {
            StringBuilder                   Json    = new StringBuilder();
            Json.Append("[");
            if (list.Count > 0)
            {
                for (int i = 0; i < list.Count; i++)
                {
                    Json.Append("{");
                    Json.Append("\"str\":\"" + list[i].ToString() + "\"");
                    Json.Append("}");
                    if (i < list.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]");
            return Json.ToString();
        }
       
        /// <summary>
        /// Covert List To javasrcipt's array,formate is [{},{}…]
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public static string   List2ArrayJson<T>(IList<T> list)
        {
            StringBuilder                   Json    = new StringBuilder();
            Json.Append("[");
            if (list.Count > 0)
            {
                for (int i = 0; i < list.Count; i++)
                {
                    T                       obj     = Activator.CreateInstance<T>();
                    Type                    type    = obj.GetType();
                    PropertyInfo[]          pis     = type.GetProperties();
                    Json.Append("{");
                    for (int j = 0; j < pis.Length; j++)
                    {
                        Json.Append("\"" + pis[j].Name.ToString() + "\":\"" + pis[j].GetValue(list[i], null) + "\"");
                        if (j < pis.Length - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < list.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]");
            return Json.ToString();
        }
        
        /// <summary>
        /// Covert Model To javascript's arrary,formate is [{}]
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="model">Model</param>
        /// <returns></returns>
        public static string   Model2ArrayJson<T>(T model)
        {
            StringBuilder                   Json    = new StringBuilder();
            Json.Append("[");

            T                               obj     = Activator.CreateInstance<T>();
            Type                            type    = obj.GetType();
            PropertyInfo[]                  pis     = type.GetProperties();
            Json.Append("{");
            for (int j = 0; j < pis.Length; j++)
            {
                Json.Append("\"" + pis[j].Name.ToString() + "\":\"" + pis[j].GetValue(model, null) + "\"");
                if (j < pis.Length - 1)
                {
                    Json.Append(",");
                }
            }
            Json.Append("}");

            Json.Append("]");
            return Json.ToString();
        }
       
        /// <summary>
        /// Covert Model To Json,Formate is {}
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="model">Model</param>
        /// <returns></returns>
        public static string   Model2Json<T>(T model)
        {
            StringBuilder                   Json    = new StringBuilder();
            T                               obj     = Activator.CreateInstance<T>();
            Type                            type    = obj.GetType();
            PropertyInfo[]                  pis     = type.GetProperties();
            Json.Append("{");
            for (int j = 0; j < pis.Length; j++)
            {
                Json.Append("\"" + pis[j].Name.ToString() + "\":\"" + pis[j].GetValue(model, null) + "\"");
                if (j < pis.Length - 1)
                {
                    Json.Append(",");
                }
            }
            Json.Append("}");

            return Json.ToString();
        }
        
        /// <summary>
        /// Covert Datatable To Json, Formate is {jsonname:[{},{}…]}
        /// </summary>
        /// <param name="jsonName"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string   DataTable2Json(string jsonName, DataTable dt)
        {
            StringBuilder                   Json    = new StringBuilder();
            Json.Append("{\"" + jsonName + "\":[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Json.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":\"" + dt.Rows[i][j].ToString() + "\"");
                        if (j < dt.Columns.Count - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]}");
            return Json.ToString();
        }
        
        /// <summary>
        /// Covert Datatable To Javacript's array, Formate is [{},{}…]
        /// </summary>
        /// <param name="jsonName"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string   DataTable2ArrayJson(DataTable dt)
        {
            StringBuilder                   Json    = new StringBuilder();
            Json.Append("[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Json.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":\"" + dt.Rows[i][j].ToString().Replace("\r", "").Replace("\n", "") + "\"");
                        if (j < dt.Columns.Count - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]");
            return Json.ToString();
        }
    }
}
