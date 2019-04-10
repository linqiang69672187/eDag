using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MyModel
{
    public class Model_HistoryRSSI_info
    {
        /// <summary>
        /// 标识ID
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 标识ISSI
        /// </summary>
        public string ISSI { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        public Decimal Longitude { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        public Decimal Latitude { get; set; }

        /// <summary>
        /// 手台场强
        /// </summary>
        public string MsRssi { get; set; }

        /// <summary>
        /// 上行场强
        /// </summary>
        public string UlRssi { get; set; }

        /// <summary>
        /// 入库时间
        /// </summary>
        public DateTime Inserttb_time { get; set; }
    }
}
