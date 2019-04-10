using System;
using System.Web;

namespace DbComponent.Comm
{
    public class CookieContent
    {
        public static void SetHostIpCookie()
        {
            HttpContext.Current.Response.Cookies["hostip"].Value = HttpContext.Current.Request.UserHostAddress;
            HttpContext.Current.Response.Cookies["hostip"].HttpOnly = false;
            HttpContext.Current.Response.Cookies["hostip"].Expires = DateTime.Now.AddDays(1);
        }
        public static string GetHostIpCookieName()
        {
            return "hostip";
        }
        public static object GetHostIpCookieValue()
        {
            if (HttpContext.Current.Request.Cookies["hostip"] != null)
            {
                return HttpContext.Current.Request.Cookies["hostip"].Value;
            }
            else
            {
                return null;
            }
        }
    }
}
