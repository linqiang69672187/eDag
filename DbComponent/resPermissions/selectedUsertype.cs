using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Data;
using MyModel.resPermissions;
using Ryu666.Components;
namespace DbComponent.resPermissions
{
    public class selectedUsertype : SelfEntityAndUsertypeByEntityId
    {
        public JArray usertypeIds = new JArray();
	public void setUsertypeIds(JArray _usertypeIds){
		this.usertypeIds=_usertypeIds;	
	}

	
	public override String getUsertypeByEntityid(String entityId,DataTable list_EntitySubUsertype,DataTable list_AllUsertype)
    {
		StringBuilder entityUsertype = new StringBuilder();
		Boolean hasOwnUsertype = false;
		entityUsertype.Append("[");
		int index = 0;

        for (int i = 0; i < list_EntitySubUsertype.Rows.Count; i++)
        {
            JObject m = new JObject();
            m["entityId"] = list_EntitySubUsertype.Rows[i]["entityId"].ToString();
            m["usertypeId"] = list_EntitySubUsertype.Rows[i]["usertypeId"].ToString();
            m["TypeName"] = list_EntitySubUsertype.Rows[i]["TypeName"].ToString();

			if (entityId==m["entityId"].ToString()
					&& isSelectedUsertype(m["usertypeId"].ToString())) {
				hasOwnUsertype = true;
				++index;
				if (index == 1) {
					entityUsertype.Append("{");
				} else {
					entityUsertype.Append(",{");
				}
				entityUsertype.Append("\"id\":" + "\""
						+ m["usertypeId"].ToString() + "\",\"text\":"
						+ "\"" + m["TypeName"].ToString() + "\",\"type\":"
						+ "\"usertype\"" + ",\"entityId\":\""
						+ m["entityId"].ToString() + "\"");
				entityUsertype.Append("}");
			}
		}
		if (!hasOwnUsertype) {
            for (int i = 0; i < list_AllUsertype.Rows.Count; i++)
            {
                UsertypeModel ut = new UsertypeModel();
                ut.setId(list_AllUsertype.Rows[i]["ID"].ToString());
                ut.setTypeName(list_AllUsertype.Rows[i]["TypeName"].ToString());

					if (isSelectedUsertype(ut.getId().ToString())) {
					++index;
					if (index == 1) {
						entityUsertype.Append("{");
					} else {
						entityUsertype.Append(",{");
					}
					entityUsertype.Append("\"id\":" + "\""
							+ ut.getId().ToString() + "\",\"text\":" + "\""
							+ ut.getTypeName().ToString() + "\",\"type\":"
							+ "\"usertype\"" + ",\"entityId\":" + "\""
							+ entityId + "\"");
					entityUsertype.Append("}");
				}
			}
		}

		entityUsertype.Append("]");
		return entityUsertype.ToString();
	}
    public override String packZhishu(String entityId)
    {
        StringBuilder zs = new StringBuilder();
        String zhishu = "zhishu";
        try
        {
            zhishu = ResourceManager.GetString("Lang_zhishu");
        }
        catch (Exception ex) { }
        zs.Append("\"id\":" + "\"" + entityId + "\",\"text\":" + "\"" + zhishu + "\",\"type\":" + "\"zhishu\"" + ",\"state\":" + "\"closed\",\"volume\":\"part\",");
        return zs.ToString();
    }
	public Boolean isSelectedUsertype(String usertypeId) {
		Boolean isSeleccted = false;
		for (int i = 0; i < usertypeIds.Count(); i++) {
			if (usertypeId==usertypeIds[i].ToString()) {
				isSeleccted = true;
				break;
			}
		}
		return isSeleccted;
	}
    }
}
