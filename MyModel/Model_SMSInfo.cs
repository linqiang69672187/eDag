using System;

namespace MyModel
{
    public class Model_SMSInfo
    {
        public int ID { get; set; }
        public int SMSType { get; set; }
        public string SendISSI { get; set; }
        public string RevISSI { get; set; }
        public bool IsRead { get; set; }
        public bool IsSend { get; set; }
        public string SMSContent { get; set; }
        public bool IsReturn { get; set; }
        public DateTime SendTime { get; set; }
        public DateTime RevTime { get; set; }
        public DateTime ReadTime { get; set; }
        public string SMSMsg { get; set; }
        public string SMSID { get; set; }
        public int ReturnID { get; set; }
        public Decimal Lo { get; set; }
        public Decimal La { get; set; }
        public int IsGroup { get; set; }
        public int DispatcherID { get; set; }
    }
}
