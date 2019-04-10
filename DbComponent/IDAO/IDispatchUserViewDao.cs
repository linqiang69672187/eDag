#region
/*
 * yangdj
 * **/
#endregion

namespace DbComponent.IDAO
{
    public interface IDispatchUserViewDao
    {
        /// <summary>
        /// get dispatch_user_view by issi
        /// </summary>
        /// <param name="issi"></param>
        /// <returns></returns>
        MyModel.Model_DispatchUser_View GetDispatchUserByISSI(string issi);
        /// <summary>
        /// get dispatch_user_view by id
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        MyModel.Model_DispatchUser_View GetDispatchUserByID(int ID);
    }
}
