using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MyModel
{
    public class Model_Role
    {
        public int id { set; get; }
        public string RoleName { set; get; }
        public string Power { set; get; }
        public int Status { set; get; }
        public DateTime CreateDate { set; get; }
        public string EnRoleName { set; get; }
    }
}
