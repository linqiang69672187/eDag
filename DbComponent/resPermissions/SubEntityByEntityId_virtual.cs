using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using MyModel.resPermissions;
using Newtonsoft.Json.Linq;
using Ryu666.Components;

namespace DbComponent.resPermissions
{
    public class SubEntityByEntityId_virtual
    {
        public virtual String packRootUnit(EntityModel en, String configuserEntityId)
        {
            return null;
        }
        public virtual String getSubEU(String entityId, DataTable list_AllEntity,
                DataTable list_EntitySubUsertype, DataTable list_AllUsertype,
                Boolean isUsertype)
        {
            return null;
        }
        public virtual String packUnitChildren(EntityModel en, DataTable list_AllEntity,
                DataTable list_EntitySubUsertype, DataTable list_AllUsertype,
                Boolean isUsertype)
        {
            return null;
        }
        public virtual String packZhishu(String entityId)
        {
            return null;
        }
        public virtual String packUnit(EntityModel en)
        {
            return null;
        }
        public virtual String getUsertypeByEntityid(String entityId,
                DataTable list_EntitySubUsertype, DataTable list_AllUsertype)
        {
            return null;
        }
        public virtual String packOwnUsertype(JObject m)
        {
            return null;
        }
        public virtual String packUsertype(UsertypeModel ut, String entityId)
        {
            return null;
        }
    }
}
