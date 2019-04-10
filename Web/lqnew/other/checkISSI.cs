using System.Text.RegularExpressions;

namespace Web.lqnew.other
{
    public class checkISSI
    {
        /// <summary>
        /// 正则匹配SSI号
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static bool RegexIssiValue(string value)
        {
            if (value.Length > 1) {
                if (value.IndexOf("0") == 0) {
                    return false;
                }
            }
            Regex regex = new Regex(@"^\d*$");
            return regex.IsMatch(value);
        }
    }
}