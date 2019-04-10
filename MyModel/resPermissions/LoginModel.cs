using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MyModel.resPermissions
{
    public class LoginModel
    {
        // Fields

        private int id;
        private String usename;
        private String pwd;
        private String entityId;
        private String hdissi;
        private DateTime loginintime;
        private DateTime lastinlinetime;
        private int usertype;
        private String accessUnitsAndUsertype;

        // Constructors

        /** default constructor */
        public LoginModel()
        {
        }

        /** full constructor */
        public LoginModel(String usename, String pwd, String entityId, String hdissi,
                DateTime loginintime, DateTime lastinlinetime, int usertype,
                String accessUnitsAndUsertype)
        {
            this.usename = usename;
            this.pwd = pwd;
            this.entityId = entityId;
            this.hdissi = hdissi;
            this.loginintime = loginintime;
            this.lastinlinetime = lastinlinetime;
            this.usertype = usertype;
            this.accessUnitsAndUsertype = accessUnitsAndUsertype;
        }

        // Property accessors

        public int getId()
        {
            return this.id;
        }

        public void setId(int id)
        {
            this.id = id;
        }

        public String getUsename()
        {
            return this.usename;
        }

        public void setUsename(String usename)
        {
            this.usename = usename;
        }

        public String getPwd()
        {
            return this.pwd;
        }

        public void setPwd(String pwd)
        {
            this.pwd = pwd;
        }

        public String getEntityId()
        {
            return this.entityId;
        }

        public void setEntityId(String entityId)
        {
            this.entityId = entityId;
        }

        public String getHdissi()
        {
            return this.hdissi;
        }

        public void setHdissi(String hdissi)
        {
            this.hdissi = hdissi;
        }

        public DateTime getLoginintime()
        {
            return this.loginintime;
        }

        public void setLoginintime(DateTime loginintime)
        {
            this.loginintime = loginintime;
        }

        public DateTime getLastinlinetime()
        {
            return this.lastinlinetime;
        }

        public void setLastinlinetime(DateTime lastinlinetime)
        {
            this.lastinlinetime = lastinlinetime;
        }

        public int getUsertype()
        {
            return this.usertype;
        }

        public void setUsertype(int usertype)
        {
            this.usertype = usertype;
        }

        public String getAccessUnitsAndUsertype()
        {
            return this.accessUnitsAndUsertype;
        }

        public void setAccessUnitsAndUsertype(String accessUnitsAndUsertype)
        {
            this.accessUnitsAndUsertype = accessUnitsAndUsertype;
        }
    }

    public class AccessUnits
    {
        public string entityId { get; set; }
    }

    public class AccessZhishu
    {
        public string entityId { get; set; }
    }

    public class AccessUserType
    {
        public string entityId { get; set; }
        public int[] usertypeIds { get; set; }
        public bool mark { get; set; }
    }
}
