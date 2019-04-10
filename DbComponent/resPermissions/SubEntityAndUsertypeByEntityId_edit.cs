using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;
using DbComponent.Comm.enums;
using System.Data;
using MyModel.resPermissions;
using Ryu666.Components;
namespace DbComponent.resPermissions
{
    public class SubEntityAndUsertypeByEntityId_edit : SubEntityAndUsertypeByEntityId
    {
        //public String subLoginuserResourcePermissionsString = "";
	public  JArray unit=new JArray();
	public  JArray zhishu=new JArray();
	public  JArray usertype=new JArray();
	public void editSubLoginuserResourcePermissionsByEntityId(){
		
	}
	public void setSubLoginuserResourcePermissions(String subloginuserId){
        getResPermission(subloginuserId);
	}

    public override String packUnitChildren(EntityModel en, DataTable list_AllEntity,
            DataTable list_EntitySubUsertype, DataTable list_AllUsertype,
			Boolean isUsertype)
	{
		StringBuilder subentity = new StringBuilder();
		subentity.Append(",\"children\":");		
		subentity.Append("[");
		//递归读取子节点
		subentity.Append(getSubEU(en.getId().ToString(),list_AllEntity, list_EntitySubUsertype,list_AllUsertype, isUsertype));
		subentity.Append("]");
		subentity.Append("}");
		return subentity.ToString();
	}

    public override String packRootUnit(EntityModel en, String configuserEntityId)
    {
		StringBuilder entity = new StringBuilder();
		if(isUnitInPermission(en.getId().ToString())){
            entity.Append("\"id\":" + "\"" + configuserEntityId + "\",\"text\":" + "\"" + en.getName() + "\",\"type\":" + "\"unit\"," + "\"checked\":" + "\"true\",\"depth\":\"" + en.getDepth() + "\",");
		}
		else{
            entity.Append("\"id\":" + "\"" + configuserEntityId + "\",\"text\":" + "\"" + en.getName() + "\",\"type\":" + "\"unit\",\"depth\":\"" + en.getDepth() + "\",");
		}
		return entity.ToString();
	}
	
	public override String packZhishu(String entityId){
		StringBuilder zs=new StringBuilder();
        String zhishu = "zhishu";
        try
        {
            zhishu = ResourceManager.GetString("Lang_zhishu");
        }
        catch (Exception ex) { }
		if(iszhishuInPermission(entityId)){
			zs.Append("\"id\":" + "\"" + entityId + "\",\"text\":" + "\""+ zhishu + "\",\"type\":" + "\"zhishu\""+ ",\"state\":" + "\"closed\","+ "\"checked\":"+ "\"true\",");
		}
		else{
			zs.Append("\"id\":" + "\"" + entityId + "\",\"text\":" + "\""+ zhishu + "\",\"type\":" + "\"zhishu\""+ ",\"state\":" + "\"closed\",");
		}
		return zs.ToString();
	}

    public override String packUnit(EntityModel en)
    {
		StringBuilder entity = new StringBuilder();
		if(isUnitInPermission(en.getId().ToString())){
			entity.Append("\"id\":" + "\"" + en.getId().ToString()	+ "\",\"text\":" + "\"" + en.getName() + "\",\"type\":"	+ "\"unit\""+",\"state\":" + "\"closed\","+ "\"checked\":"+ "\"true\"");
		}
		else{
			entity.Append("\"id\":" + "\"" + en.getId().ToString()	+ "\",\"text\":" + "\"" + en.getName() + "\",\"type\":"	+ "\"unit\""+",\"state\":" + "\"closed\"");
		}
		return entity.ToString();
	}

    public override String packOwnUsertype(JObject m)
    {
		StringBuilder userType = new StringBuilder();
		if(isUsertypeInPermission(m["usertypeId"].ToString(),m["entityId"].ToString())){
			userType.Append("\"id\":" + "\""+ m["usertypeId"].ToString() + "\",\"text\":"+ "\"" + m["TypeName"].ToString() + "\",\"type\":"	+ "\"usertype\""+",\"entityId\":\""+m["entityId"].ToString()+"\","+ "\"checked\":"+ "\"true\"");
		}else
		{
			userType.Append("\"id\":" + "\""+ m["usertypeId"].ToString() + "\",\"text\":"+ "\"" + m["TypeName"].ToString() + "\",\"type\":"	+ "\"usertype\""+",\"entityId\":\""+m["entityId"].ToString()+"\"");
		}
			return userType.ToString();				
	}

    public override String packUsertype(UsertypeModel ut, String entityId)
    {
		StringBuilder userType = new StringBuilder();
		if(isUsertypeInPermission(ut.getId().ToString(),entityId)){
			userType.Append("\"id\":" + "\""+ ut.getId().ToString() + "\",\"text\":"+ "\"" + ut.getTypeName().ToString() + "\",\"type\":"+ "\"usertype\""+ ",\"entityId\":"	+ "\""+entityId+"\","+ "\"checked\":"+ "\"true\"");
		}else
		{
			userType.Append("\"id\":" + "\""+ ut.getId().ToString() + "\",\"text\":"+ "\"" + ut.getTypeName().ToString() + "\",\"type\":"+ "\"usertype\""+ ",\"entityId\":"	+ "\""+entityId+"\"");
		}
			return userType.ToString();
	}
	
	public Boolean isUnitInPermission(String entityId){
		Boolean re=false;
		for(int i=0;i<unit.Count();i++){
			JObject jo = (JObject)unit[i];
			if(entityId==jo["entityId"].ToString()){
				re=true;
				break;
			}
		}
		return re;
	}
	public Boolean iszhishuInPermission(String entityId){
		Boolean re=false;
		for(int i=0;i<zhishu.Count();i++){
			JObject jo = (JObject)zhishu[i];
			if(entityId==jo["entityId"].ToString()){
				re=true;
				break;
			}
		}
		return re;
	}
	public Boolean isUsertypeInPermission(String usertypeid,String entityId){
		Boolean re=false;
		for(int i = 0;i<usertype.Count();i++){			
			JObject jo = (JObject)usertype[i];
			String enId=jo["entityId"].ToString();
			if(enId==entityId){
				JArray usertypeIds=(JArray)jo["usertypeIds"];
				for(int j = 0;j<usertypeIds.Count();j++){					
					String utId=usertypeIds[j].ToString();
					if(utId==usertypeid){
						re=true;
					}
				}
			}
		}
		return re;
	}
    public void getResPermission(String loginUserId)
    {
        try
        {
            LoginuserResourcePermissions LoginuserResourcePermissionsClass = new LoginuserResourcePermissions();
            JArray joRelust = LoginuserResourcePermissionsClass.getLoginuserResPermissionsByUserId_JObject(loginUserId);
            for (int i = 0; i < joRelust.Count(); i++)
            {
                if (joRelust[i]["unit"] != null)
                {
                    unit = JArray.Parse(joRelust[i]["unit"].ToString());
                }
                if (joRelust[i]["zhishu"] != null)
                {
                    zhishu = JArray.Parse(joRelust[i]["zhishu"].ToString());
                }
                if (joRelust[i]["usertype"] != null)
                {
                    usertype = JArray.Parse(joRelust[i]["usertype"].ToString());
                }
            }
        }
        catch (Exception ex) { }
    }
    }
}
