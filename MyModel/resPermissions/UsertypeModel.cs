using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MyModel.resPermissions
{
    public class UsertypeModel
    {
        // Fields

	private String id;
	private String typeName;
	private String typeIcons;
	private String normalIcons;
	private String urgencyIcons;
	private String unNormalIcons;

	// Constructors

	/** full constructor */
	public void Usertype(String typeName, String typeIcons, String normalIcons,
			String urgencyIcons, String unNormalIcons) {
		this.typeName = typeName;
		this.typeIcons = typeIcons;
		this.normalIcons = normalIcons;
		this.urgencyIcons = urgencyIcons;
		this.unNormalIcons = unNormalIcons;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTypeIcons() {
		return this.typeIcons;
	}

	public void setTypeIcons(String typeIcons) {
		this.typeIcons = typeIcons;
	}

	public String getNormalIcons() {
		return this.normalIcons;
	}

	public void setNormalIcons(String normalIcons) {
		this.normalIcons = normalIcons;
	}

	public String getUrgencyIcons() {
		return this.urgencyIcons;
	}

	public void setUrgencyIcons(String urgencyIcons) {
		this.urgencyIcons = urgencyIcons;
	}

	public String getUnNormalIcons() {
		return this.unNormalIcons;
	}

	public void setUnNormalIcons(String unNormalIcons) {
		this.unNormalIcons = unNormalIcons;
	}
    }
}
