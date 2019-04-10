#region Author
/*
 *Modules:DB Oper Factory Class
 *CreateTime:2011-07-26
 *Author:yangdj    
 *Company:Eastcom
 **/

#endregion

using DbComponent.FS_Info;
using DbComponent.IDAO;

namespace DbComponent.FactoryMethod
{
    /// <summary>
    /// Create dispatch DataBase Oper Class
    /// </summary>
    public class DispatchInfoFactory
    {
        #region Fields
        private static ISMSInfoDao _smsinfoDao;
        private static IUserTypeDao _userTypeDao;
        private static IStockadeDao _stockadeDao;
        private static IBaseStationDao _baseStationDao;
        private static IDTGroupInfoDao _dtrroupinfoDao;
        private static IDispatchInfoDao _dispatchInfoDao;
        private static IUserISSIViewDao _userISSIViewDao;
        private static IDispatchUserViewDao _dispatchUserViewDao;
        private static IIsInStockadeViewDao _isInStockadeViewDao;
        private static IFixedStationDao _FixedStationDao;
        private static IDXGroupInfoDao _dxGroupInfoDao;
        private static IBSGroupInfoDao _sbGroupInfoDao;
        #endregion

        #region Methods
        public static ISMSInfoDao CreateSmsInfoDao()
        {
            if (_smsinfoDao == null)
                _smsinfoDao = new SMSInfoDao();
            return _smsinfoDao;
        }
        public static IUserTypeDao CreateUserTypeDao()
        {
            if (_userTypeDao == null)
                _userTypeDao = new UserTypeDao();
            return _userTypeDao;
        }
        public static IStockadeDao CreateStockadeDao()
        {
            if (_stockadeDao == null)
                _stockadeDao = new StockadeDao();
            return _stockadeDao;
        }
        public static IBaseStationDao CreateBaseStationDao()
        {
            if (_baseStationDao == null)
                _baseStationDao = new BaseStationDao();
            return _baseStationDao;
        }
        public static IDTGroupInfoDao CreateDTGroupInfoDao()
        {
            if (_dtrroupinfoDao == null)
                _dtrroupinfoDao = new DTGroupInfoDao();
            return _dtrroupinfoDao;
        }
        public static IDispatchInfoDao CreateDispatchInfoDao()
        {
            if (_dispatchInfoDao == null)
                _dispatchInfoDao = new DispatchInfoDao();
            return _dispatchInfoDao;
        }
        public static IUserISSIViewDao CreateUserISSIViewDao()
        {
            if (_userISSIViewDao == null)
                _userISSIViewDao = new UserISSIViewDao();
            return _userISSIViewDao;
        }
        public static IIsInStockadeViewDao CreateIsInStockadeViewDao()
        {
            if (_isInStockadeViewDao == null)
                _isInStockadeViewDao = new IsInStockadeViewDao();
            return _isInStockadeViewDao;
        }
        public static IDispatchUserViewDao CreateDispatchUserViewDao()
        {
            if (_dispatchUserViewDao == null)
                _dispatchUserViewDao = new DispatchUserViewDao();
            return _dispatchUserViewDao;
        }

        public static IDXGroupInfoDao CreateDXGroupInfoDao()
        {
            if (_dxGroupInfoDao == null)
                _dxGroupInfoDao = new DXGroupInfoDao();
            return _dxGroupInfoDao;
        }
        public static IBSGroupInfoDao CreateBSGroupInfoDao()
        {
            if (_sbGroupInfoDao == null)
                _sbGroupInfoDao = new BSGroupInfoDao();
            return _sbGroupInfoDao;
        }
        public static IFixedStationDao CreatFixedStationDao()
        {
            if (_FixedStationDao == null)
                _FixedStationDao = new FixedStation();
            return _FixedStationDao;
        }
        #endregion
    }
}
