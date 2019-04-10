using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MyModel.resPermissions;
using Newtonsoft.Json.Linq;
using Ryu666.Components;
namespace DbComponent.resPermissions
{
    public class SubEntityAndUsertypeByEntityId : SubEntityAndUsertypeByEntityId_virtual
    {
        public String getSubEntityAndUsertypeByEntityId(String EntityId, Boolean isCallBack)
        {
            String subentityAndUsertype = "";


            try
            {
                resPermissionsDao resPermissionsDaoClass = new resPermissionsDao();
                // AllEntity
                DataTable list_AllEntity = resPermissionsDaoClass.getAllEntity(EntityId);

                // EntitySubUsertype
                DataTable list_EntitySubUsertype = resPermissionsDaoClass.getEntitySubUsertype(EntityId);

                // AllUsertype
                DataTable list_AllUsertype = resPermissionsDaoClass.getAllUsertype(EntityId);

                subentityAndUsertype = getSubEntityAndUsertype(EntityId, list_AllEntity, list_EntitySubUsertype, list_AllUsertype, true, isCallBack);

            }
            catch (Exception e)
            {

            }


            return subentityAndUsertype;
        }

        public String getSubEntityAndUsertype(String EntityId,
                DataTable list_AllEntity, DataTable list_EntitySubUsertype,
                DataTable list_AllUsertype, Boolean isUsertype, Boolean isCallBack)
        {
            StringBuilder subentity = new StringBuilder();

            //subentity.append("[");
            for (int i = 0; i < list_AllEntity.Rows.Count; i++)
            {
                EntityModel en = new EntityModel();
                en.setId(list_AllEntity.Rows[i]["ID"].ToString());
                en.setName(list_AllEntity.Rows[i]["Name"].ToString());
                en.setDepth(list_AllEntity.Rows[i]["Depth"].ToString());
                //生成根级单位节点
                if (en.getId().ToString() == EntityId)
                {
                    if (!isCallBack)
                    {
                        subentity.Append("{");
                        subentity.Append(packRootUnit(en, EntityId));
                        subentity.Append("\"children\":");
                        subentity.Append("[");
                        subentity.Append(getSubEU(en.getId().ToString(), list_AllEntity, list_EntitySubUsertype, list_AllUsertype, isUsertype));
                        subentity.Append("]");
                        subentity.Append("}");
                    }
                    else
                    {
                        subentity.Append(getSubEU(en.getId().ToString(), list_AllEntity, list_EntitySubUsertype, list_AllUsertype, isUsertype));

                    }
                }
            }
            //subentity.Append("]");
            return subentity.ToString();
        }
        public override String packRootUnit(EntityModel en, String EntityId)
        {
            StringBuilder entity = new StringBuilder();
            entity.Append("\"id\":" + "\"" + EntityId + "\",\"text\":" + "\"" + en.getName() + "\",\"type\":" + "\"unit\",\"depth\":\"" + en.getDepth() + "\",");
            return entity.ToString();
        }
        public override String getSubEU(String entityId, DataTable list_AllEntity,
                DataTable list_EntitySubUsertype, DataTable list_AllUsertype,
                Boolean isUsertype)
        {

            StringBuilder subentity = new StringBuilder();

            int index = 0;

            //zhishuAndSubEntity		
            for (int i = 0; i < list_AllEntity.Rows.Count; i++)
            {
                EntityModel en = new EntityModel();
                en.setId(list_AllEntity.Rows[i]["ID"].ToString());
                en.setName(list_AllEntity.Rows[i]["Name"].ToString());
                en.setDepth(list_AllEntity.Rows[i]["Depth"].ToString());
                en.setParentId(list_AllEntity.Rows[i]["ParentID"].ToString());
                if (isUsertype && en.getId().ToString() == entityId && en.getDepth() != "-1")
                {
                    // 添加警员类型			
                    subentity.Append("{");
                    subentity.Append(packZhishu(entityId));
                    ++index;
                    subentity.Append("\"children\":");
                    subentity.Append(getUsertypeByEntityid(entityId, list_EntitySubUsertype, list_AllUsertype));
                    subentity.Append("}");
                }
                if (en.getParentId() == entityId)
                {
                    ++index;
                    if (index == 1)
                    {
                        subentity.Append("{");
                    }
                    else
                    {
                        subentity.Append(",{");
                    }
                    subentity.Append(packUnit(en));

                    subentity.Append(packUnitChildren(en, list_AllEntity, list_EntitySubUsertype, list_AllUsertype, isUsertype));
                }
            }

            return subentity.ToString();
        }
        public override String packUnitChildren(EntityModel en, DataTable list_AllEntity,
                DataTable list_EntitySubUsertype, DataTable list_AllUsertype,
                Boolean isUsertype)
        {
            StringBuilder subentity = new StringBuilder();
            subentity.Append(",\"children\":");
            subentity.Append("[");
            //递归读取子节点,取消递归读取，客户端树形采用延迟加载
            //subentity.Append(getSubEU(en.getId().ToString(),list_AllEntity, list_EntitySubUsertype,list_AllUsertype, isUsertype));
            subentity.Append("]");
            subentity.Append("}");
            return subentity.ToString();
        }
        public override String packZhishu(String entityId)
        {
            StringBuilder zs = new StringBuilder();
            String zhishu = "zhishu";
            try
            {
                zhishu = ResourceManager.GetString("Lang_zhishu");
            }
            catch(Exception ex){}
            zs.Append("\"id\":" + "\"" + entityId + "\",\"text\":" + "\"" + zhishu + "\",\"type\":" + "\"zhishu\"" + ",\"state\":" + "\"closed\",");
            return zs.ToString();
        }
        public override String packUnit(EntityModel en)
        {
            StringBuilder entity = new StringBuilder();
            entity.Append("\"id\":" + "\"" + en.getId().ToString() + "\",\"text\":" + "\"" + en.getName() + "\",\"type\":" + "\"unit\"" + ",\"state\":" + "\"closed\"");
            return entity.ToString();
        }
        public override String getUsertypeByEntityid(String entityId,
                DataTable list_EntitySubUsertype, DataTable list_AllUsertype)
        {
            StringBuilder entityUsertype = new StringBuilder();
            //Iterator it_EntitySubUsertype = list_EntitySubUsertype.iterator();
            Boolean hasOwnUsertype = false;
            entityUsertype.Append("[");
            int index = 0;

            for (int i = 0; i < list_EntitySubUsertype.Rows.Count; i++)
            {
                JObject m = new JObject();
                m["entityId"] = list_EntitySubUsertype.Rows[i]["entityId"].ToString();
                m["usertypeId"] = list_EntitySubUsertype.Rows[i]["usertypeId"].ToString();
                m["TypeName"] = list_EntitySubUsertype.Rows[i]["TypeName"].ToString();

                if (entityId == m["entityId"].ToString())
                {
                    hasOwnUsertype = true;
                    ++index;
                    if (index == 1)
                    {
                        entityUsertype.Append("{");
                    }
                    else
                    {
                        entityUsertype.Append(",{");
                    }
                    entityUsertype.Append(packOwnUsertype(m));
                    entityUsertype.Append("}");
                }
            }
            if (!hasOwnUsertype)
            {

                for (int i = 0; i < list_AllUsertype.Rows.Count; i++)
                {
                    UsertypeModel ut = new UsertypeModel();
                    ut.setId(list_AllUsertype.Rows[i]["ID"].ToString());
                    ut.setTypeName(list_AllUsertype.Rows[i]["TypeName"].ToString());
                    ++index;
                    if (index == 1)
                    {
                        entityUsertype.Append("{");
                    }
                    else
                    {
                        entityUsertype.Append(",{");
                    }
                    entityUsertype.Append(packUsertype(ut, entityId));
                    entityUsertype.Append("}");
                }
            }

            entityUsertype.Append("]");
            return entityUsertype.ToString();
        }
        public override String packOwnUsertype(JObject m)
        {
            StringBuilder userType = new StringBuilder();
            userType.Append("\"id\":" + "\"" + m["usertypeId"].ToString() + "\",\"text\":" + "\"" + m["TypeName"].ToString() + "\",\"type\":" + "\"usertype\"" + ",\"entityId\":\"" + m["entityId"].ToString() + "\"");
            return userType.ToString();
        }
        public override String packUsertype(UsertypeModel ut, String entityId)
        {
            StringBuilder userType = new StringBuilder();
            userType.Append("\"id\":" + "\"" + ut.getId().ToString() + "\",\"text\":" + "\"" + ut.getTypeName().ToString() + "\",\"type\":" + "\"usertype\"" + ",\"entityId\":" + "\"" + entityId + "\"");
            return userType.ToString();
        }
    }
}
