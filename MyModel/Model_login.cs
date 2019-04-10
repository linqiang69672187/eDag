
namespace MyModel
{
    public class Model_login
    {
        public int id { set; get; }
        public string Usename { set; get; }
        public string Pwd { set; get; }
        public string Entity_ID { set; get; }
        public string HDISSI { set; get; }
        public int RoleId { set; get; }
        public string Power { set; get; }
    }
    public class Model_LoginParameter
    {
        public string Usename { set; get; }
        public int voiceType_Int { set; get; }
    }
}
