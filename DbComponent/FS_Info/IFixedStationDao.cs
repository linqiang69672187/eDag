using System.Data;

namespace DbComponent.FS_Info
{
    public interface IFixedStationDao
    {
        /// <summary>
        /// add new FixedStation
        /// </summary>
        /// <param name="model">new fixedstation</param>
        /// <returns>is add successed</returns>
        bool AddFixedStation(Model_FixedStation model);

        /// <summary>
        /// update FixedStation information
        /// </summary>
        /// <param name="newModel">new basestation</param>
        /// <returns>is update successed</returns>
        bool UpdateFixedStation(Model_FixedStation newModel);

        /// <summary>
        /// delete FixedStation by id
        /// </summary>
        /// <param name="ID">id</param>
        /// <returns>is delete successed</returns>
        bool DeleteFixedStation(int ID);

        /// <summary>
        /// get FixedStation information by issi
        /// </summary>
        /// <param name="ISSI">issi</param>
        /// <returns>basestation information</returns>
        Model_FixedStation GetFixedStationByISSI(string ISSI);

        /// <summary>
        /// get FixedStation information by id
        /// </summary>
        /// <param name="ID">id</param>
        /// <returns>FixedStation information</returns>
        Model_FixedStation GetFixedStationByID(int ID);

        /// <summary>
        /// get all basestation's count
        /// </summary>
        /// <returns></returns>
        int getAllFixedStationCount();

        int getAllFixedStationCount(string selectcondition,
                                    string textseach,
                                       int id);

        /// <summary>
        /// get FixedStation list by conditons
        /// </summary>
        /// <param name="sort"></param>
        /// <param name="startRowIndex"></param>
        /// <param name="maximumRows"></param>
        /// <returns></returns>
        DataTable GetAllFixedStation(string selectcondition,
                                     string textseach,
                                        int id,
                                     string sort,
                                        int startRowIndex,
                                        int maximumRows);
        DataTable GetAllFixedStation(string sort,
                                        int startRowIndex,
                                        int maximumRows);

        /// <summary>
        /// get all basestation list
        /// </summary>
        /// <returns></returns>
        DataTable GetAllFixedStation();

        /// <summary>
        /// get id of FixedStation by divid
        /// </summary>
        /// <param name="DivID">divdid</param>
        /// <returns>id of FixedStation</returns>
        string GetIDByEntity_ID(string Entity_ID);

        /// <summary>
        /// is exist issi for add
        /// </summary>
        /// <param name="ISSI"></param>
        /// <returns></returns>
        bool FindFixedStationISSIForAdd(string ISSI);

        /// <summary>
        /// is exist issi for edit
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="ISSI"></param>
        /// <returns></returns>
        bool FindFixedStationISSIForUpdate(int ID,
                                          string ISSI);

        /// <summary>
        /// is exist name for add 
        /// </summary>
        /// <param name="GSSIS"></param>
        /// <returns></returns>
        bool FindFixedStationNameForAdd(string GSSIS);

        /// <summary>
        /// is exist name for edit
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="StationName"></param>
        /// <returns></returns>
        bool FindFixedStationNameForUpdate(int ID,
                                          string GSSIS);

        ///// <summary>
        ///// is exist issi in FixedStation group
        ///// </summary>
        ///// <param name="ISSI"></param>
        ///// <returns></returns>
        //bool IsInBSGroup(string ISSI);

    }
}
