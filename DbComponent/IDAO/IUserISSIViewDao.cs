
namespace DbComponent.IDAO
{
    public interface IUserISSIViewDao
    {
        /// <summary>
        /// 根据用户ID获取用户ISSI视图
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        MyModel.Model_UserISSIView GetUserISSIViewByID(string ID);
    }
}
