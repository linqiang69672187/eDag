#region
/*
 * 杨德军
 * **/
#endregion
using MyModel;
using System.Collections.Generic;

namespace DbComponent.IDAO
{
    public interface IDXGroupInfoDao
    {

        int getallGroupcount(int selectcondition, string textseach, int id, string stringid, int gtype);
        /// <summary>
        /// 为操作窗口的派接、多选获取组列表
        /// </summary>
        /// <returns></returns>
        IList<Model_DXGroup> GetDXGroupForCallPanl(int    Type, 
                                                   string Entity_ID);
        /// <summary>
        /// 根据GroupIndex修改GSSIS字段
        /// </summary>
        /// <param name="GroupIndex"></param>
        /// <returns></returns>
        bool UpdateGSSIByGroupIndex(string GroupIndex, 
                                    string GSSIS);
        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="Group_name"></param>
        /// <param name="Group_index"></param>
        /// <param name="GSSIS"></param>
        /// <param name="Entity_ID"></param>
        /// <returns></returns>
        bool Add(string Group_name,
                 string Group_index,
                 string GSSIS, 
                 string Entity_ID, 
                 int    GType);
        /// <summary>
        /// 根据ID查询状态
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool SelectStatusByID(int ID);
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool Delete(int ID);
        /// <summary>
        /// 根据GSSI修改状态
        /// </summary>
        /// <param name="GSSI"></param>
        /// <returns></returns>
        bool UpdateStatusByGSSI(string GSSI);
        /// <summary>
        /// 是否存在GSSI
        /// </summary>
        /// <param name="GSSI"></param>
        /// <returns></returns>
        bool IsExistGSSI(string GSSI);
        /// <summary>
        /// 根据ID获取多选组信息
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Model_DXGroup GetDxGroupByID(int ID);
        /// <summary>
        /// 修改组信息
        /// </summary>
        /// <param name="id"></param>
        /// <param name="Group_name"></param>
        /// <param name="Group_index"></param>
        /// <param name="GSSIS"></param>
        /// <param name="Entity_ID"></param>
        /// <returns></returns>
        bool UpdateGXGroup(int    id,
                           string Group_name, 
                           string GSSIS, 
                           string Entity_ID);
        /// <summary>
        /// 判断派接组名称是否存在（添加时用）
        /// </summary>
        /// <param name="PjName"></param>
        /// <param name="Entityid"></param>
        /// <returns></returns>
        bool IsExistPJNameByEntityForAdd(string PjName, 
                                         string Entityid);
        /// <summary>
        /// 判断派接组名称是否存在（修改时用）
        /// </summary>
        /// <param name="PjName"></param>
        /// <param name="Entityid"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool IsExistPjNameByEntityForEdit(string PjName, 
                                          string Entityid, 
                                          int    ID);
        /// <summary>
        /// 判断多选组名称是否存在（添加时用）
        /// </summary>
        /// <param name="PjName"></param>
        /// <param name="Entityid"></param>
        /// <returns></returns>
        bool IsExistDxNameByEntityForAdd(string PjName, 
                                         string Entityid);
        /// <summary>
        /// 判断多选组名称是否存在（修改时用）
        /// </summary>
        /// <param name="PjName"></param>
        /// <param name="Entityid"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool IsExistDxNameByEntityForEdit(string PjName, 
                                          string Entityid,
                                          int    ID);

        IList<Model_DXGroup> GetAllResultInGissi(string GSSI);
    }
}
