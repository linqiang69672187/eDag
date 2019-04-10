#region
/*
 * 杨德军
 * **/
#endregion
using MyModel;
using System.Collections.Generic;
namespace DbComponent.IDAO
{
    public interface IIsInStockadeViewDao
    {
        /// <summary>
        /// 根据登录调度用户名获取他所划分的电子栅栏
        /// </summary>
        /// <param name="LoginName">登录调度用户名</param>
        /// <returns></returns>
        IList<Model_IsInStockade_View>   GetListByLoginName(string LoginName);
        /// <summary>
        /// 根据id修改状态
        /// </summary>
        /// <param name="id"></param>
        /// <param name="newStatus"></param>
        /// <returns></returns>
        bool                             UpdateLastStatus(int    id, 
                                                          string newStatus);
        /// <summary>
        /// 获取用户数量
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        int                              GetUserCountByUserID(int userID);
    }
}
