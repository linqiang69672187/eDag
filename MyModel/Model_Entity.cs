using System;

namespace MyModel
{
    public class Model_Entity
    {
        /// <summary>
        /// 标示
        /// </summary>
        public int               id { set; get; }
        /// <summary>
        /// 层级
        /// </summary>
        public int               Depth { set; get; }
        /// <summary>
        /// 父单位ID
        /// </summary>
        public int               ParentID { set; get; }
        public string            bz { set; get; }
        public string            Name { set; get; }
        public string            DivID { get; set; }
        public Decimal           Lo { get; set; }
        public Decimal           La { get; set; }
        public string            PicUrl { get; set; }
        
    }
}
