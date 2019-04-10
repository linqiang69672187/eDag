using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System;
using System.Net;
using System.DirectoryServices;
using System.DirectoryServices.Protocols;
using System.Security.Permissions;


namespace DbComponent
{
    class GetLDAPInfo 
    {

        public string GetInfoByISSI(string ISSI)
        {
            string returnResult = "";
            try
            {               
                string ldapServer = getLdapServerPath();
                string ldapDN = getLdapDN();
                string entryDir = "LDAP://" + ldapServer + "/" + ldapDN;

                DirectoryEntry entry = new DirectoryEntry(entryDir);
                entry.AuthenticationType = AuthenticationTypes.None;
                DirectorySearcher searcher = new DirectorySearcher(entry);
                //searcher.Filter = "()";
                SearchResult result = searcher.FindOne();
                
                
            }
            catch(Exception ex){
                returnResult = "none";
            }
            return returnResult;
        }

        public string getLdapServerPath()
        {
            string ldapServer = "";
            string NMC_IP = System.Configuration.ConfigurationManager.AppSettings["NMC_IP"];
            string NMC_LDAP_Port = System.Configuration.ConfigurationManager.AppSettings["NMC_LDAP_Port"];
            
            ldapServer = NMC_IP+":"+NMC_LDAP_Port;
            return ldapServer;
        }
        public string getLdapDN()
        {
            string ldapDN = "";
            string NMC_LDAP_DN = System.Configuration.ConfigurationManager.AppSettings["NMC_LDAP_DN"];
            ldapDN = NMC_LDAP_DN;
            return ldapDN;
        }
    }
}
