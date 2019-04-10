
namespace MyModel
{
    public class Model_BSGroupInfo
    {
        /// <summary>
        /// 标示
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 基站组名称
        /// </summary>
        public string BSGroupName { get; set; }
        /// <summary>
        /// 基站组成员名称
        /// </summary>
        public string MemberIds { get; set; }
        /// <summary>
        /// 单位ID
        /// </summary>
        public string Entity_ID { get; set; }
        /// <summary>
        /// 状态
        /// </summary>
        public int Status { get; set; }
        /// <summary>
        /// 基站组issi号码
        /// </summary>
        public string BSISSI { get; set; }
    }
}
