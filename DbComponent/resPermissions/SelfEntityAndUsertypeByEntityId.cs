using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Ryu666.Components;
using MyModel.resPermissions;
namespace DbComponent.resPermissions
{
    public class SelfEntityAndUsertypeByEntityId : SubEntityAndUsertypeByEntityId
    {
        public override String packRootUnit(EntityModel en, String EntityId)
        {
            StringBuilder entity = new StringBuilder();
            entity.Append("\"id\":" + "\"" + EntityId + "\",\"text\":" + "\"" + en.getName() + "\",\"type\":" + "\"unit\",\"depth\":\"" + en.getDepth() + "\",\"volume\":\"part\",");
            return entity.ToString();
        }
        public override String getSubEU(String entityId, DataTable list_AllEntity,
            DataTable list_EntitySubUsertype, DataTable list_AllUsertype,
            Boolean isUsertype)
        {
            
            StringBuilder subentity = new StringBuilder();

            int index = 0;
            if (isUsertype)
            {
                // 添加警员类型
                String zhishu = "zhishu";
                try
                {
                    zhishu = ResourceManager.GetString("Lang_zhishu");
                }
                catch (Exception ex) { }

                subentity.Append("{");
                subentity.Append(packZhishu(entityId));
                ++index;
                subentity.Append("\"children\":");
                subentity.Append(getUsertypeByEntityid(entityId, list_EntitySubUsertype, list_AllUsertype));
                subentity.Append("}");
            }

            return subentity.ToString();
        }
    }
}
