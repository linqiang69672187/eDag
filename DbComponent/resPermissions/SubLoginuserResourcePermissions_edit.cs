using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DbComponent.resPermissions
{
    public class SubLoginuserResourcePermissions_edit : SubLoginuserResourcePermissions
    {
        
	public override String getSubEntityAndUsertypeByEntityId(String entityId,Boolean isCallback)
	{

        SubEntityAndUsertypeByEntityId_edit SubEntityAndUsertypeByEntityId_editClass = new SubEntityAndUsertypeByEntityId_edit();
        SubEntityAndUsertypeByEntityId_editClass.setSubLoginuserResourcePermissions(subLoginUserId);
        String ResPermissions = SubEntityAndUsertypeByEntityId_editClass.getSubEntityAndUsertypeByEntityId(entityId, isCallback);
		return ResPermissions;
	}
    }
}
