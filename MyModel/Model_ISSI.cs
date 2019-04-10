using System;

namespace MyModel
{
    public class Model_ISSI
    {
        public int id { set; get; }
        public string status { set; get; }
        public string Entity_ID { set; get; }
        public string ISSI { set; get; }
        public string OriginalIssi { set; get; }
        public string GSSIS { set; get; }
        public string Bz { get; set; }
        public string typeName { get; set; }
        public string ipAddress { get; set; }
        public string Productmodel { get; set; }
        public string Manufacturers { get; set; }
        public int IsExternal { set; get; }
        
    }
}
