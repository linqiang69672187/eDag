
namespace DbComponent.FS_Info
{
    public class Model_FixedStation
    {
        public int ID { get; set; }
        public string GSSIS { get; set; }   //驻留组
        public string StationISSI { get; set; }   //固定台标识 
        public decimal Lo { get; set; }
        public decimal La { get; set; }
        public string Entity_ID { get; set; }    //所属单位
        public bool IsDisplay { get; set; }        //定位

    }
}
