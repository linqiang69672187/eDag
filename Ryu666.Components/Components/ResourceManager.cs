
using System.Collections;
using System.Collections.Specialized;
using System.Web.Caching;
using System.Xml;
using System.Configuration;

using System.Web;
namespace Ryu666.Components 
{
    

    /// <summary>
    /// ��Դ������
    /// ���ڶ�ȡ��Ӧ���Ե���Դ�ı�
    /// </summary>
    public class ResourceManager
    {
       
        /// <summary>
        /// վ��Ĭ������
        /// </summary>
        private static string defaultLanguage;

        /// <summary>
        /// ��ȡվ�㵱ǰ��������
        /// </summary>
        public static string SiteLanguageName
        {
            get{
                return GetSupportedLanguage(defaultLanguage);
            }
        }
        /// <summary>
        /// ��ȡ������վ�㵱ǰ���Եļ�ֵ
        /// </summary>
        public static string SiteLanguageKey
        {
            get
            {
                return defaultLanguage;
            }
            set
            {
                ResourceManager.defaultLanguage = value;
            }
        }
    

        enum ResourceManagerType {
            String,
            ErrorMessage,
			Template
        }

        /// <summary>
        /// ��̬����,����ʵ�������������ö���
        /// </summary>
        static ResourceManager()
        {
           
            defaultLanguage = ConfigurationManager.AppSettings["defaultLanguage"];
        }

        /// <summary>
        /// �����������ļ��л�ȡ֧�ֵ���������
        /// </summary>
        /// <returns>֧�ֵ��������Ե�����-ֵ��</returns>
        public static NameValueCollection GetSupportedLanguages () {
            //CSContext csContext = CSContext.Current;            

            HttpContext csContext = HttpContext.Current;
            string cacheKey = "SupportedLanguages";

            NameValueCollection supportedLanguages = Ryu666Cache.Get(cacheKey) as NameValueCollection;
            if (supportedLanguages == null) {
                string filePath = csContext.Server.MapPath("~/Languages/languages.xml");
            	CacheDependency dp = new CacheDependency(filePath);
                supportedLanguages = new NameValueCollection();

            	XmlDocument d = new XmlDocument();
                d.Load( filePath );

                foreach (XmlNode n in d.SelectSingleNode("root").ChildNodes) {
                    if (n.NodeType != XmlNodeType.Comment) {
                        supportedLanguages.Add(n.Attributes["key"].Value, n.Attributes["name"].Value);
                    }
                }

                Ryu666Cache.Max(cacheKey, supportedLanguages, dp);
            }

            return supportedLanguages;
        }

        /// <summary>
        /// ��ȡ�����ַ���
        /// </summary>
        /// <returns></returns>
		public static NameValueCollection GetLanguageCharsets()
		{
            HttpContext csContext = HttpContext.Current;
			string cacheKey = "LanguageCharsets";

			NameValueCollection languageCharsets = Ryu666Cache.Get(cacheKey) as NameValueCollection;
			if (languageCharsets == null)
			{
				string filePath = csContext.Server.MapPath("~/Languages/languages.xml");
				CacheDependency dp = new CacheDependency(filePath);
				languageCharsets = new NameValueCollection();

				XmlDocument d = new XmlDocument();
				d.Load(filePath);

				foreach (XmlNode n in d.SelectSingleNode("root").ChildNodes)
				{
					if (n.NodeType != XmlNodeType.Comment)
					{
						if (n.Attributes["emailCharset"] == null)
							continue;
						string codepage = n.Attributes["emailCharset"].Value;
						if (n.Attributes["emailSubjectCharset"] != null)
							codepage += "," + n.Attributes["emailSubjectCharset"].Value;
						
						languageCharsets.Add(n.Attributes["key"].Value, codepage);
					}
				}

				Ryu666Cache.Max(cacheKey, languageCharsets, dp);
			}

			return languageCharsets;
		}

		/// <summary>
		/// �����������ƻ�ȡ����ֵ
        /// ������ܻ�ȡ,��ʹ��Ĭ������
		/// </summary>
		/// <param name="language">��������</param>
		/// <returns>����ֵ</returns>
		public static string GetSupportedLanguage(string language)
		{
            string defaultLanguage = ResourceManager.defaultLanguage; //Ĭ������
            NameValueCollection supportedLanguages = GetSupportedLanguages();
			string supportedLanguage = supportedLanguages[language];

			if(!string.IsNullOrEmpty(supportedLanguage))
				return language;
			else
                return defaultLanguage;			
		}		

        /// <summary>
        /// ������Դ���ƴ���Դ�ļ��л�ȡ��Ӧ��Դ�ı�
        /// </summary>
        /// <param name="name">��Դ����</param>
        /// <returns>��Դ�ı�</returns>
        public static string GetString(string name) {

           return GetString(name, false);
        }

        /// <summary>
        /// ������Դ���ƴ���Դ�ļ��л�ȡ��Ӧ��Դ�ı�
        /// </summary>
        /// <param name="name">��Դ����</param>
        /// <param name="defaultOnly">ֻѡ��Ĭ������</param>
        /// <returns>��Դ�ı�</returns>
        public static string GetString(string name, bool defaultOnly)
        {
            return GetString(name,"Resources.xml",defaultOnly);
        }

        /// <summary>
        /// ������Դ���ƴ���Դ�ļ��л�ȡ��Ӧ��Դ�ı�
        /// </summary>
        /// <param name="name">��Դ����</param>
        /// <param name="fileName">��Դ�ļ���</param>
        /// <returns></returns>
        public static string GetString(string name, string fileName)
        {
            return GetString(name,fileName,false);
        }

        /// <summary>
        /// ������Դ���ƴ���Դ�ļ��л�ȡ��Ӧ��Դ�ı�
        /// </summary>
        /// <param name="name">��Դ����</param>
        /// <param name="fileName">��Դ�ļ���</param>
        /// <param name="defaultOnly">ʹ��Ĭ������</param>
        /// <returns>��Դ�ı�</returns>
        public static string GetString(string name, string fileName, bool defaultOnly) 
        {

            HttpContext csContext = HttpContext.Current;
            //ʹ��HashTableװ��������Դ
        	Hashtable resources = null;
            //�û�����
            //Ϊ��ʾ����ʹ��Session���󱣴�,���õؽ��������ʹ��Profile
            string userLanguage ;//csContext.Items["AspSession"];
            //if (csContext.Request.Cookies["userLanguage"] != null)
            //    userLanguage = csContext.Request.Cookies["userLanguage"].Value;
            //else
            //    userLanguage = null;
            try
            {
                if (csContext.Session["userLanguage"] != null)
                    userLanguage = csContext.Session["userLanguage"].ToString();
                else
                    userLanguage = null;
            }
            catch (System.Exception er) {
                userLanguage = null;
            }

                       
            if (fileName != null && fileName != "")
                resources = GetResource(ResourceManagerType.String, userLanguage, fileName, defaultOnly);
            else
                resources = GetResource(ResourceManagerType.String, userLanguage, "Resources.xml", defaultOnly);

            string text = resources[name] as string;

			//try the standard file if we passed a file that didnt have the key we were looking for
			if (text == null && fileName != null && fileName != "") 
			{
                resources = GetResource(ResourceManagerType.String, userLanguage, "Resources.xml", false);

				text = resources[name] as string;
			}

            return text;
        }    

        /// <summary>
        /// ��ȡ��Դ
        /// </summary>
        /// <param name="resourceType">��Դ����</param>
        /// <param name="userLanguage">�û�����</param>
        /// <param name="fileName">��Դ�ļ���</param>
        /// <param name="defaultOnly">ֻʹ��Ĭ������</param>
        /// <returns></returns>
        private static Hashtable GetResource (ResourceManagerType resourceType, string userLanguage, string fileName, bool defaultOnly) {


            string defaultLanguage = ResourceManager.defaultLanguage; 
            string cacheKey = resourceType.ToString() + defaultLanguage + userLanguage + fileName;

            // ����û�û�ж�������,��ʹ��Ĭ��
            //
            if (string.IsNullOrEmpty(userLanguage) || defaultOnly )
                userLanguage = defaultLanguage;

            // �ӻ����л�ȡ��Դ
            //
            Hashtable resources = Ryu666Cache.Get(cacheKey) as Hashtable;

            if (resources == null) 
            {
                resources = new Hashtable();

                resources = LoadResource(resourceType, resources, defaultLanguage, cacheKey, fileName);
                
                // ����û�����������������û�������Դ
                //
                if (defaultLanguage != userLanguage)
                    resources = LoadResource(resourceType, resources, userLanguage, cacheKey, fileName);
                
            }

            return resources;
        }

        /// <summary>
        /// ������Դ
        /// </summary>
        /// <param name="resourceType"></param>
        /// <param name="target"></param>
        /// <param name="language"></param>
        /// <param name="cacheKey"></param>
        /// <param name="fileName"></param>
        /// <returns></returns>
		private static Hashtable LoadResource (ResourceManagerType resourceType, Hashtable target, string language, string cacheKey, string fileName) 
        {
            HttpContext csContext = HttpContext.Current;
			
            string filePath = csContext.Server.MapPath("~/Languages/" + language + "/" + fileName);

//			switch (resourceType) {
//				case ResourceManagerType.ErrorMessage:
//					filePath = string.Format(filePath, "Messages.xml");
//					break;
//
//				default:
//					filePath = string.Format(filePath, "Resources.xml");
//					break;
//			}

			CacheDependency dp = new CacheDependency(filePath);

			XmlDocument d = new XmlDocument();
			try {
				d.Load( filePath );
			} catch {
				return target;
			}

			foreach (XmlNode n in d.SelectSingleNode("root").ChildNodes) 
            {
				if (n.NodeType != XmlNodeType.Comment)
                {
				
							if (target[n.Attributes["name"].Value] == null)
								target.Add(n.Attributes["name"].Value, n.InnerText);
							else
								target[n.Attributes["name"].Value] = n.InnerText;

				}
				
			}
    

            if (language == ResourceManager.defaultLanguage)
            {
                Ryu666Cache.Max(cacheKey, target, dp);
            }
            else
            {
                Ryu666Cache.Insert(cacheKey, target, dp, Ryu666Cache.MinuteFactor * 5);
            }

            return target;



        }

    }
}
