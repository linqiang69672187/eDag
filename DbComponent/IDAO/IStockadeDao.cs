using MyModel;
using System.Collections.Generic;
namespace DbComponent.IDAO
{
    public interface IStockadeDao
    {
        /// <summary>
        /// 隐藏电子栅栏
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        bool                     HideStockade(string DivID);
        /// <summary>
        /// 显示电子栅栏
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        bool                     ShowStockade(string DivID);
        /// <summary>
        /// 添加电子栅栏
        /// </summary>
        /// <param name="Stockade">新的电子栅栏</param>
        /// <returns></returns>
        bool                     AddStockade(Model_Stockade Stockade);
        /// <summary>
        /// 删除电子栅栏
        /// </summary>
        /// <param name="ID">电子栅栏ID</param>
        /// <returns></returns>
        bool                     DeleteStockade(int ID);
        /// <summary>
        /// 修改此电子栅栏相应的用户列表
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        bool                     UpdateUsers(string DivID,string[] users);
        /// <summary>
        /// 根据DIVID删除电子栅栏
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        bool                     DeleteStockadeByDivID(string DivID);
        /// <summary>
        /// 根据DivID获取电子栅栏类型
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        int                      GetTypeByDivID(string DivID);
        /// <summary>
        /// 根据DivId获得电子栅栏的最后状态
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns>0表示没越界，1表示越界</returns>
        int GetLastSatusByDivID(string DivID);
        /// <summary>
        /// 根据divID 获取用户名
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        string                   GetMyStockUserName(string DivID);
        /// <summary>
        /// 根据idvID获取用户米跟相应ID
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        string                   GetMyStockUsers(string DivID);
        /// <summary>
        /// 根据DivID获取电子栅栏
        /// </summary>
        /// <param name="DivID"></param>
        /// <returns></returns>
        Model_Stockade           GetStockadeByDivID(string DivID);
        /// <summary>
        /// 获取isShow为1的所有记录
        /// </summary>
        /// <returns></returns>
        IList<Model_Stockade>    GetStockadeListByLoginName(string LoginName);
        /// <summary>
        /// 电子栅栏名称是否存在
        /// </summary>
        /// <param name="StockadoName">电子栅栏名称</param>
        /// <returns></returns>
        bool                     IsExist(string StockadoName);
        string GetMyStockUserName2String(string DivID);
    }
}
