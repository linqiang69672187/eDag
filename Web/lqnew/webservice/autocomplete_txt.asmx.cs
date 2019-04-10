using System.Web.Services;

namespace Web.lqnew.webservice
{
    /// <summary>
    /// autocomplete_txt 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
     [System.Web.Script.Services.ScriptService]
    public class autocomplete_txt : System.Web.Services.WebService
    {

        [WebMethod]
        public string[] GetData(string prefixText, int count)
        {
            DbComponent.ISSI issi = new DbComponent.ISSI();

            System.Data.DataTable dt = issi.searchISSI(prefixText, count);
      
            return LQCommonCS.commoncs.dtToArr1(dt);
          } 
    }
}
