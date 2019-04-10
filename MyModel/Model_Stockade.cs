using System;
using System.Collections.Generic;
namespace MyModel
{
    public class Model_Stockade
    {
        public int ID { get; set; }
        public string LoginName { get; set; }
        public string PointArray { get; set; }
        public string Title { get; set; }
        public DateTime CreateTime { get; set; }
        public bool isShow { get; set; }
        public string DivID { get; set; }
        public string DivStyle { get; set; }
        public int Type { get; set; }
        public IList<int> UID { get; set; }
    }
}
