#region
/*
 * yangdj
 * **/
#endregion
using MyModel;
using System.Data;

namespace DbComponent.IDAO
{
    public interface IBaseStationDao
    {
        /// <summary>
        /// add new BaseStation
        /// </summary>
        /// <param name="model">new basestation</param>
        /// <returns>is add successed</returns>
        bool                     AddBaseStation(Model_BaseStation model);
       
        /// <summary>
        /// update basestation information
        /// </summary>
        /// <param name="newModel">new basestation</param>
        /// <returns>is update successed</returns>
        bool                     UpdateBaseStation(Model_BaseStation newModel);
        
        /// <summary>
        /// delete basesation by id
        /// </summary>
        /// <param name="ID">id</param>
        /// <returns>is delete successed</returns>
        bool                     DeleteBaseStation(int ID);
        
        /// <summary>
        /// get basestation information by id
        /// </summary>
        /// <param name="ID">id</param>
        /// <returns>basestation information</returns>
        Model_BaseStation        GetBaseStationByID(int ID);
       
        /// <summary>
        /// get basestation information by issi
        /// </summary>
        /// <param name="ISSI">issi</param>
        /// <returns>basestation information</returns>
        Model_BaseStation GetBaseStationByISSI(string ISSI, int switchID);//xzj--20181217--添加交换
        
        /// <summary>
        /// get all basestation's count
        /// </summary>
        /// <returns></returns>
        int                      getAllBaseStationCount();
        
        /// <summary>
        /// get basestation list by conditons
        /// </summary>
        /// <param name="sort"></param>
        /// <param name="startRowIndex"></param>
        /// <param name="maximumRows"></param>
        /// <returns></returns>
        DataTable                GetAllBaseStation(string       sort,
                                                   int          startRowIndex, 
                                                   int          maximumRows);
        
        /// <summary>
        /// get all basestation list
        /// </summary>
        /// <returns></returns>
        DataTable                GetAllBaseStation();
        
        /// <summary>
        /// get id of basestation by divid
        /// </summary>
        /// <param name="DivID">divdid</param>
        /// <returns>id of basestation</returns>
        string                   GetIDByDivID(string DivID);
        
        /// <summary>
        /// is exist issi for add
        /// </summary>
        /// <param name="ISSI"></param>
        /// <returns></returns>
        bool FindBaseStationISSIForAdd(string ISSI,int switchID);//xzj--20181217--添加交换
        
        /// <summary>
        /// is exist issi for edit
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="ISSI"></param>
        /// <returns></returns>
            bool FindBaseStationISSIForUpdate(int ID, string ISSI, int switchID);//xzj--20181217--添加交换
 
        /// <summary>
        /// is exist name for add 
        /// </summary>
        /// <param name="StationName"></param>
        /// <returns></returns>
        bool FindBaseStationNameForAdd(string StationName);
       
        /// <summary>
        /// is exist name for edit
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="StationName"></param>
        /// <returns></returns>
        bool FindBaseStationNameForUpdate(int           ID, 
                                          string        StationName);
        
        /// <summary>
        /// is exist issi in basestation group
        /// </summary>
        /// <param name="ISSI"></param>
        /// <returns></returns>
        bool IsInBSGroup(string ISSI, int switchID);//xzj--20181217--添加交换

        /// <summary>
        /// get termial count of basestation
        /// </summary>
        /// <param name="BsId"></param>
        /// <returns></returns>
        int getAllBsDeviceCount(string BsId,int switchID);

        /// <summary>
        /// Get the terminal name
        /// </summary>
        /// <returns></returns>
        DataTable GetAllBaseStationUserName(string Type,string SName);

    }
}
