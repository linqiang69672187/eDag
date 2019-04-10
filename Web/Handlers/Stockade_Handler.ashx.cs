using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.SessionState; 

namespace Web.Handlers
{
    /// <summary>
    /// Stockade_Handler 的摘要说明
    /// </summary>
    public class Stockade_Handler : IHttpHandler, IReadOnlySessionState 
    {
        private IStockadeDao StockadeDaoService
        {
            get
            {
                return DispatchInfoFactory.CreateStockadeDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            StringBuilder sbResult = new StringBuilder();
            string CMD = context.Request["cmd"].ToString();
            if (CMD.ToLower() == "del")/***@删除电子栅栏*/
            {
                string stockadeID = context.Request["id"].ToString();
                if (StockadeDaoService.DeleteStockade(int.Parse(stockadeID)))
                {
                    sbResult.Append(Ryu666.Components.ResourceManager.GetString("StockDeleteSuccess"));//多语言:电子栅栏删除成功
                }
                else
                {
                    sbResult.Append(Ryu666.Components.ResourceManager.GetString("StockDeleteFailed"));//多语言:电子栅栏删除失败
                }
            }
            if (CMD.ToLower() == "delbydivid")/***@删除电子栅栏*/
            {
                string stockadeID = context.Request["id"].ToString();
                if (StockadeDaoService.DeleteStockadeByDivID(stockadeID))
                {
                    sbResult.Append(Ryu666.Components.ResourceManager.GetString("StockDeleteSuccess"));//多语言:电子栅栏删除成功
                }
                else
                {
                    sbResult.Append(Ryu666.Components.ResourceManager.GetString("StockDeleteFailed"));//多语言:电子栅栏删除失败
                }
            }
            if (CMD.ToLower() == "add")/***@添加电子栅栏*/
            {
                string UserID = "";
                string LoginName = context.Request.Cookies["username"].Value.ToString();
                string PointArray = context.Request["pointarray"].ToString();
                string strType = context.Request["type"].ToString();
                string divid = context.Request["divid"].ToString();
                string divstyle = context.Request["divstyle"].ToString();
                string title = context.Request["title"].ToString();
                Model_Stockade Stockade = new Model_Stockade() { LoginName = LoginName, PointArray = PointArray, Type = int.Parse(strType), DivID = divid, DivStyle = divstyle, Title = title };
                if (context.Request["userid"] != null)
                {
                    UserID = context.Request["userid"].ToString();
                    if (!string.IsNullOrEmpty(UserID))
                    {
                        IList<int> userIDlist = new List<int>();/*对UserID要进行分割，有多个用户的时候*/
                        string[] myUserid = UserID.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string uid in myUserid)
                        {
                            userIDlist.Add(int.Parse(uid));
                        }
                        Stockade.UID = userIDlist;
                    }
                }
                if (StockadeDaoService.AddStockade(Stockade))
                {
                    sbResult.Append(Ryu666.Components.ResourceManager.GetString("AddStackSuccess"));//多语言:电子栅栏添加成功
                }
                else
                {
                    sbResult.Append(Ryu666.Components.ResourceManager.GetString("AddStackFailed"));//多语言:电子栅栏添加失败
                }
            }
            context.Response.Write("{\"result\":\"" + sbResult.ToString() + "\"}");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}