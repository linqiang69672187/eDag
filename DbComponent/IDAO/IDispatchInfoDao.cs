#region Author
/*
 *Modules:IDispatchInfoDao
 *CreateTime:2011-07-26
 *Author:yangdj    
 *Company:Eastcom
 **/

#endregion
using MyModel;
using System.Data;

namespace DbComponent.IDAO
{
    /// <summary>
    /// dispatch operator interface
    /// </summary>
    public interface IDispatchInfoDao
    {
        #region Methods
        /// <summary>
        /// add dispatch information
        /// </summary>
        /// <param name="model">new dispatch model </param>
        /// <returns> if add success return ture else return false</returns>
        bool                     AddDispatchInfo(Model_Dispatch model);
       
        /// <summary>
        /// edit dispatch information
        /// </summary>
        /// <param name="newModel">new dispatch information（new id must the same as old id）</param>
        /// <returns></returns>
        bool                     UpdateDispatchInfo(Model_Dispatch newModel);
       
        /// <summary>
        /// delete dispatch by id
        /// </summary>
        /// <param name="DispatchID">ID</param>
        /// <returns>if delete success return true else return false</returns>
        bool                     DeleteDispatchInfo(int DispatchID);
       
        /// <summary>
        /// get dispatch list by condition
        /// </summary>
        /// <param name="selectcondition">select conditon</param>
        /// <param name="textseach"></param>
        /// <param name="id"></param>
        /// <param name="stringid"></param>
        /// <param name="sort"></param>
        /// <param name="startRowIndex"></param>
        /// <param name="maximumRows"></param>
        /// <returns></returns>
        DataTable                GetAllDsipatch(int        selectcondition, 
                                                string     textseach,
                                                int        id, 
                                                string     stringid, 
                                                string     sort, 
                                                int        startRowIndex, 
                                                int        maximumRows);
        /// <summary>
        /// get dispatch list's count by condition
        /// </summary>
        /// <param name="selectcondition"></param>
        /// <param name="textseach"></param>
        /// <param name="id"></param>
        /// <param name="stringid"></param>
        /// <returns></returns>
        int                      getallIIScount(int         selectcondition, 
                                                string      textseach,
                                                int         id, 
                                                string      stringid);
        /// <summary>
        /// get dispatch information by id
        /// </summary>
        /// <param name="ID">ID</param>
        /// <returns>dispatch information</returns>
        Model_Dispatch_View      GetModelDispatchViewByID(int ID);
        /// <summary>
        /// get dispatch information by issi
        /// </summary>
        /// <param name="ISSI">ISSI</param>
        /// <returns>dispatch information</returns>
        Model_Dispatch_View      GetModelDispatchViewByISSI(string ISSI);
        #endregion
    }
}
