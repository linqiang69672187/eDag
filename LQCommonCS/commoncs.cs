using System;
using System.Data;

namespace LQCommonCS
{
  public  class commoncs
    {
        public static string[] dtToArr1(DataTable dt)
        {
            if (dt == null || dt.Rows.Count == 0) return new string[0];
            string[] sr = new string[dt.Rows.Count];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (Convert.IsDBNull(dt.Rows[i][0])) sr[i] = "";
                else sr[i] = dt.Rows[i][0] + "";
            }
            return sr;
        }
    }
}
