using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DbComponent.Comm
{
    public class CPjName
    {
        public string username;
        public string pjname;
    }
    public class CDxName
    {
        public string username;
        public string dxname;
    }
    public class SessionContent
    {
        private static IList<CPjName> tempPJNameList = new List<CPjName>();
        private static IList<CDxName> tempDXNameList = new List<CDxName>();
        
        /// <summary>
        /// Get My Temp DXGroup
        /// </summary>
        /// <returns></returns>
        public static IList<CDxName> GetTempDXNameList()
        {
            return tempDXNameList.Where(a => a.username == HttpContext.Current.Request.Cookies["username"].Value) as IList<CDxName>;
        }
      
        /// <summary>
        /// Judge DxName Is In Temp PjNameList
        /// </summary>
        /// <param name="PJName"></param>
        /// <returns></returns>
        public static bool JudgeDxNameIsInTempPjNameList(string DxName)
        {
            if (tempDXNameList == null || tempDXNameList.Count == 0)
            {
                return false;
            }
            if (tempDXNameList.Where(a => a.dxname == DxName && a.username == HttpContext.Current.Request.Cookies["username"].Value).Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Set Temp DXName To List
        /// </summary>
        /// <param name="DXName"></param>
        public static void SetTempDXNameToList(string DXName)
        {
            if (tempDXNameList == null)
            {
                tempDXNameList = new List<CDxName>();
            }
            if (!JudgeDxNameIsInTempPjNameList(DXName))
            {
                tempDXNameList.Add(new CDxName { username = HttpContext.Current.Request.Cookies["username"].Value, dxname = DXName });
            }
        }
        
        /// <summary>
        /// Clear DXName from List
        /// </summary>
        public static void ClearDXNameToList()
        {
            if (tempDXNameList == null) { return; }
            tempDXNameList = tempDXNameList.Where(a => a.username != HttpContext.Current.Request.Cookies["username"].Value) as IList<CDxName>;
        }

        /// <summary>
        /// Get My Temp PJName from PJNameList
        /// </summary>
        /// <returns></returns>
        public static IList<CPjName> GetTempPJNameList()
        {
            return tempPJNameList.Where(a => a.username == HttpContext.Current.Request.Cookies["username"].Value) as IList<CPjName>;
        }
       
        /// <summary>
        /// Judge PjName Is In Temp PjNameList 
        /// </summary>
        /// <param name="PJName"></param>
        /// <returns></returns>
        public static bool JudgePjNameIsInTempPjNameList(string PJName)
        {
            if (tempPJNameList==null || tempPJNameList.Count == 0)
            {
                return false;
            }
            if (tempPJNameList.Where(a => a.pjname == PJName && a.username == HttpContext.Current.Request.Cookies["username"].Value).Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
       
        /// <summary>
        /// Set Temp PjGroup
        /// </summary>
        /// <param name="PJName"></param>
        public static void SetTempPJNameToList(string PJName)
        {
            if (tempPJNameList == null) {
                tempPJNameList = new List<CPjName>();
            }
            if (!JudgePjNameIsInTempPjNameList(PJName))
            {
                tempPJNameList.Add(new CPjName { username = HttpContext.Current.Request.Cookies["username"].Value, pjname = PJName });
            }
        }
        
        /// <summary>
        /// Clear My Temp PjGroup
        /// </summary>
        public static void ClearPJNameToList()
        {
            if (tempPJNameList == null) { return; }
            tempPJNameList = tempPJNameList.Where(a => a.username != HttpContext.Current.Request.Cookies["username"].Value) as IList<CPjName>;
        }
    }
}
