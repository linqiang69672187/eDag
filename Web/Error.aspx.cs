using System;
using System.IO;
using System.Text;
namespace Web
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            String[] str = Directory.GetDirectories(this.Server.MapPath(@"lqnew\opePages\UpLoad\usertypepic"));
            
            foreach (string s in str) {
                Response.Write("</br><input type='radio' name='usertypepic' value='" + Path.GetFileName(s) + "' />" + Path.GetFileName(s));
                foreach (string f in Directory.GetFiles(s))
                {

                    Response.Write( "<img style='width:20px;height:30px' src='lqnew\\opePages\\UpLoad\\usertypepic\\" + Path.GetFileName(s) + "\\" + Path.GetFileName(f) + "' /> &nbsp;&nbsp;");
                }
            }
            //IList<MyModel.LoginDispatch> list = new List<MyModel.LoginDispatch>();
            //if (list.Where(a => a.DispatchISSI == "ere").ToList<MyModel.LoginDispatch>().Count() > 0)
            //{
            //    Response.Write("有值");
            //}
            //else
            //{
            //    Response.Write("无值");
            //}
        }
    }
}