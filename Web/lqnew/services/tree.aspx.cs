using System;

namespace Web.lqnew.services
{
    public partial class tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        
         Response.ContentType = "application/json";
            string test = "[{\"attr\":{\"id\":\"11\",\"rel\":\"folder\"}, \"children\" : [ { \"data\" : \"彭涛test1\", \"state\" : \"closed\" },{ \"data\" : \"彭涛test2\", \"state\" : \"closed\" } ], \"data\":\"彭涛\",\"state\":\"closed\"}]";
            Response.Write(test);
            Response.End();
           
        }
    }
}