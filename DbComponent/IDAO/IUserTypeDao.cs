using MyModel;
using System.Collections.Generic;

namespace DbComponent.IDAO
{
    public interface IUserTypeDao
    {
        /// <summary>
        /// 添加用户类别
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        bool                     AddUserType(Model_UserType model);
        /// <summary>
        /// 修改用户类别
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        bool                     UpdateUserType(Model_UserType model);
        /// <summary>
        /// 删除用户类别
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool                     DeleteUserType(int ID);
        /// <summary>
        /// 根据ID获取用户类型
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Model_UserType           GetUserTypeByID(int ID);
        /// <summary>
        /// 获取所有用户类别
        /// </summary>
        /// <returns></returns>
        IList<Model_UserType>    GetAllForList();
        /// <summary>
        /// 查找用户名是否存在 为新增
        /// </summary>
        /// <param name="UserTypeName">需要验证的用户名</param>
        /// <returns></returns>
        bool                     FindUserTypeNameIsExist(string UserTypeName);
        /// <summary>
        /// 查找用户名是否存在 为修改
        /// </summary>
        /// <param name="UserTypeName">需要验证的用户名</param>
        /// <returns></returns>
        bool                    FindUserTypeNameIsExistForUpdate(int ID, string UserTypeName);
        /// <summary>
        /// 判断用户类型是否被用户绑定了
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool                    IsUsed(int ID);
        /// <summary>
        /// 图片类型名称是否正被使用
        /// </summary>
        /// <param name="PicName">图片名称</param>
        /// <returns></returns>
        bool                    PicIsUsed(string PicName);
    }
}
