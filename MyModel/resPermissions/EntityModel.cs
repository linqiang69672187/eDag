using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MyModel.resPermissions
{
    public class EntityModel
    {
        private String id;
        private String name;
        private String parentId;
        private String depth;
        private String bz;
        private Double lo;
        private Double la;
        private String divId;
        private String picUrl;

        // Constructors

        /** default constructor */
        public EntityModel()
        {
        }

        /** full constructor */
        public EntityModel(String name, String parentId, String depth, String bz,
                Double lo, Double la, String divId, String picUrl)
        {
            this.name = name;
            this.parentId = parentId;
            this.depth = depth;
            this.bz = bz;
            this.lo = lo;
            this.la = la;
            this.divId = divId;
            this.picUrl = picUrl;
        }

        // Property accessors

        public String getId()
        {
            return this.id;
        }

        public void setId(String id)
        {
            this.id = id;
        }

        public String getName()
        {
            return this.name;
        }

        public void setName(String name)
        {
            this.name = name;
        }

        public String getParentId()
        {
            return this.parentId;
        }

        public void setParentId(String parentId)
        {
            this.parentId = parentId;
        }

        public String getDepth()
        {
            return this.depth;
        }

        public void setDepth(String depth)
        {
            this.depth = depth;
        }

        public String getBz()
        {
            return this.bz;
        }

        public void setBz(String bz)
        {
            this.bz = bz;
        }

        public Double getLo()
        {
            return this.lo;
        }

        public void setLo(Double lo)
        {
            this.lo = lo;
        }

        public Double getLa()
        {
            return this.la;
        }

        public void setLa(Double la)
        {
            this.la = la;
        }

        public String getDivId()
        {
            return this.divId;
        }

        public void setDivId(String divId)
        {
            this.divId = divId;
        }

        public String getPicUrl()
        {
            return this.picUrl;
        }

        public void setPicUrl(String picUrl)
        {
            this.picUrl = picUrl;
        }
    }
}
