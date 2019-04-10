
namespace MyModel
{
    public class Model_DXGroup
    {
        /// <summary>
        /// 标示
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 组名
        /// </summary>
        public string Group_name { get; set; }
        /// <summary>
        /// 多选组GIIS
        /// </summary>
        public string Group_index { get; set; }
        /// <summary>
        /// 小组成员
        /// </summary>
        public string GSSIS { get; set; }
        /// <summary>
        /// 单位ID
        /// </summary>
        public string Entity_ID { get; set; }
        /// <summary>
        /// 状态（呼叫中，未呼叫中）
        /// </summary>
        public bool Status { get; set; }
        /// <summary>
        /// 类型 
        /// </summary>
        public int GType { get; set; }
    }
}
