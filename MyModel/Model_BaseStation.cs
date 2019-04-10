
namespace MyModel
{
    public class Model_BaseStation
    {
        public int ID { get; set; }
        public string StationName { get; set; }
        public string StationISSI { get; set; }
        public decimal Lo { get; set; }
        public decimal La { get; set; }
        public string DivID { get; set; }
        public string PicUrl { get; set; }
        public int IsUnderGround { get; set; }
        public int SwitchID { get; set; }//xzj--20181217--添加交换
    }
}
