using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DbComponent.IDAO
{
    public interface IHistoryRSSIInfoDao
    {
        /// <summary>
        /// 获取所有指定时间内的历史场强信息
        /// </summary>
        /// <param name="startTime">开始时间</param>
        /// <param name="endTime">结束时间</param>
        /// <returns>历史场强列表</returns>
        DataTable getHistoryRSSIInfos(DateTime startTime,DateTime endTime,double minX,double minY,double maxX,double maxY);
    }
}
