using System.Text.RegularExpressions;

namespace DbComponent
{
  public  class stringfilter
    {
        /**/
        /// <summary>
        /// 过滤sql中非法字符
        /// </summary>
        /// <param name="value">要过滤的字符串 </param>
        /// <returns>string </returns>
        public static string Filter(string value)
        {
            if (string.IsNullOrEmpty(value)) return string.Empty;
            value = Regex.Replace(value, @";", string.Empty);
            value = Regex.Replace(value, @"'", string.Empty);
            value = Regex.Replace(value, @"&", string.Empty);
            value = Regex.Replace(value, @"%20", string.Empty);
            value = Regex.Replace(value, @"--", string.Empty);
            value = Regex.Replace(value, @"==", string.Empty);
            value = Regex.Replace(value, @" <", string.Empty);
            value = Regex.Replace(value, @">", string.Empty);
            value = Regex.Replace(value, @"%", string.Empty);
            value = Regex.Replace(value, @":", string.Empty);
      

            return value;
        }
    }
}
