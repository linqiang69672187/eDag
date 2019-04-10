using OfficeComponent;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// OutputtoExcel 的摘要说明
    /// </summary>
    public class OutputtoExcel : IHttpHandler, IReadOnlySessionState
    {
        //int strProID,String issi,String carno,String statues,DateTime begtimes,DateTime endtimes,String protitle,int type
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int strProID = Convert.ToInt32(context.Request["strProID"]);
            String issi = context.Request["issi"].ToString();
            String carno = context.Request["carno"].ToString();
            String statues = context.Request["statues"].ToString();
            DateTime begtime = Convert.ToDateTime(context.Request["begtimes"]);
            DateTime endtime = Convert.ToDateTime(context.Request["endtimes"]);
            String filename = context.Request["protitle"].ToString();
            int type = Convert.ToInt32(context.Request["type"]);
            string Lang_HZRW = ResourceManager.GetString("Lang_HZRW");//汇总
            string Lang_XXRW = ResourceManager.GetString("Lang_XXRW");//详细
            string Lang_CurrentInfo = ResourceManager.GetString("Lang_CurrentInfo");//当前信息
            string Lang_DoSetup = ResourceManager.GetString("Lang_DoSetup");//执行操作
            string Lang_ZDID = ResourceManager.GetString("Lang_ZDID");//终端ID
            string Lang_CarONOrPoliceNo = ResourceManager.GetString("Lang_CarONOrPoliceNo");//号码(警号,车牌号等)
            string Lang_HappenDate = ResourceManager.GetString("Lang_HappenDate");//发生日期
            string Lang_DoTime = ResourceManager.GetString("Lang_DoTime");//执行时间
            string Lang_DoDutyCount = ResourceManager.GetString("Lang_DoDutyCount");//任务执行数量
            string Lang_UnUP = ResourceManager.GetString("Lang_UnUP");//未上报
            
            Dictionary<string, string> diclist = new Dictionary<string, string>();
            diclist.Add("Lang_HZRW", Lang_HZRW);
            diclist.Add("Lang_XXRW", Lang_XXRW);
            diclist.Add("Lang_CurrentInfo", Lang_CurrentInfo);
            diclist.Add("Lang_DoSetup", Lang_DoSetup);
            diclist.Add("Lang_ZDID", Lang_ZDID);
            diclist.Add("Lang_CarONOrPoliceNo", Lang_CarONOrPoliceNo);
            diclist.Add("Lang_HappenDate", Lang_HappenDate);
            diclist.Add("Lang_DoTime", Lang_DoTime);
            diclist.Add("Lang_DoDutyCount", Lang_DoDutyCount);
            diclist.Add("Lang_UnUP", Lang_UnUP);

            String filetype = type == 0 ? Lang_HZRW : Lang_XXRW;
            int entityid = Convert.ToInt32(context.Request.Cookies["id"].Value);
            DYY._lists = diclist;
            ENCN.SetENCN(filename);
            if (!string.IsNullOrEmpty(carno))
                filename = String.Format("{0}_{1}", filename, carno);
            if (!string.IsNullOrEmpty(issi))
                filename = String.Format("{0}_{1}", filename, issi);
            if (begtime.Equals(endtime))
                filename = String.Format("{0}_{1}_{2}", filename, begtime.ToString("yyyyMMdd"), filetype);
            else
                filename = String.Format("{0}_{1}_{2}_{3}", filename, begtime.ToString("yyyyMMdd"), endtime.ToString("yyyyMMdd"), filetype);
            
            Excelheper.Instance.SaveToClient(context, filename, new List<String>() { filename }, strProID, issi, carno, statues, begtime, endtime, entityid, type, diclist);
            //context.Response.Write("Hello World");
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