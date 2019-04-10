#region
/*
 * yangdj
 * **/
#endregion
using System.Collections.Generic;

namespace DbComponent.IDAO
{
    public interface IBSGroupInfoDao
    {
        /// <summary>
        /// add new bs group
        /// </summary>
        /// <param name="BSGroupName"></param>
        /// <param name="MemberIds"></param>
        /// <param name="EntityID"></param>
        /// <param name="Status"></param>
        /// <returns></returns>
        bool Save(string     BSGroupName, 
                  string     MemberIds, 
                  string     EntityID, 
                  bool       Status, 
                  string     BSISSI);
       
        /// <summary>
        /// update bs group information
        /// </summary>
        /// <param name="BSGroupName"></param>
        /// <param name="MemberIds"></param>
        /// <param name="EntityID"></param>
        /// <param name="Status"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool Update(string      BSGroupName, 
                    string      MemberIds, 
                    string      EntityID,
                    bool        Status,
                    int         ID);
     
        /// <summary>
        /// delete bs group information by id
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool Delete(int ID);
      
        /// <summary>
        /// get bs group information by id
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        MyModel.Model_BSGroupInfo GetBSGroupInfoByID(int ID);
     
        /// <summary>
        /// get bs group list by entityid
        /// </summary>
        /// <param name="entityid"></param>
        /// <returns></returns>
        IList<MyModel.Model_BSGroupInfo> GetBsGroupInfoList(string entityid);
      
        /// <summary>
        /// get bs group information by issi
        /// </summary>
        /// <param name="ISSI"></param>
        /// <returns></returns>
        MyModel.Model_BSGroupInfo GetBSGroupInfoByISSI(string ISSI);
       
        /// <summary>
        /// is exist issi
        /// </summary>
        /// <param name="ISSI"></param>
        /// <returns></returns>
        bool IsExistBSGISSI(string ISSI);
       
        /// <summary>
        /// get all bs group list
        /// </summary>
        /// <returns></returns>
        IList<MyModel.Model_BSGroupInfo> GetAllBSGroup();
       
        /// <summary>
        /// is exist this name in this entity
        /// </summary>
        /// <param name="BSName"></param>
        /// <param name="EntityID"></param>
        /// <returns></returns>
        bool IsExistBSNameInThisEntity(string       BSName, 
                                       string       EntityID);
        /// <summary>
        /// when edit bs information,is exist this name in this entity
        /// </summary>
        /// <param name="BSName">基站名称</param>
        /// <param name="EntityID">单位di</param>
        /// <param name="ID">基站组id</param>
        /// <returns></returns>
        bool IsExistBSNameInThisEntityForEdit(string    BSName, 
                                              string    EntityID, 
                                              int       ID);
    }
}
