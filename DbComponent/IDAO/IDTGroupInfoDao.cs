#region
/*
 * 杨德军
 * **/
#endregion
using MyModel;

namespace DbComponent.IDAO
{
    /// <summary>
    /// 通播组操作接口
    /// </summary>
    public interface IDTGroupInfoDao
    {
        /// <summary>
        /// 添加通播组信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        bool                     AddTDGroupInfo(Model_DTGroupInfo model);
        /// <summary>
        /// 修改通播组信息
        /// </summary>
        /// <param name="newModel"></param>
        /// <returns></returns>
        bool                     UpdateTDGroupInfo(Model_DTGroupInfo newModel);
        /// <summary>
        /// 删除通播组信息
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool                     DeleteTDGroupInfoByID(int ID);
        /// <summary>
        /// 根据组号获取通播组信息
        /// </summary>
        /// <param name="gssi"></param>
        /// <returns></returns>
        Model_DTGroupInfo        GetTDGroupInfoByGSSI(string gssi);
    }
}
