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
    class LDAPConnect 
    {
                
        public LdapConnection getLdapConnection(){
            string ldapServer = getLdapServerPath();
            LdapConnection ldapConnection = new LdapConnection(ldapServer);
            return ldapConnection;
        }
        public string getLdapServerPath()
        {
            string ldapServer = "";

            return ldapServer;
        }
    }
}
