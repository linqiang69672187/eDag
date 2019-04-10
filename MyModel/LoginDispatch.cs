using System;
using System.Collections.Generic;
using System.Linq;

namespace MyModel
{
    
    public class LoginDispatch
    {
        public string DispatchISSI { get; set; }
        public DateTime LoginTime { get; set; }
    }

    public static class LoginDispatchList
    {
        public static IList<LoginDispatch> listLD = null;

        public static LoginDispatch FindLoginDispatch(string DispatchISSI)
        {
            if (listLD == null)
            {
                return null;
            }
            if (listLD.Count <= 0)//跟着莫名的问题
            {
                return null;
            }
            else
            {
                return listLD.Where(a => a.DispatchISSI == DispatchISSI).ToList<LoginDispatch>().FirstOrDefault();
            }
        }
        public static bool ISFindLoginDispatch(string DispatchISSI)
        {

            if (listLD == null)
                return false;
            if (listLD.Count > 0 && listLD.Where(a => a.DispatchISSI == DispatchISSI) != null && listLD.Where(a => a.DispatchISSI == DispatchISSI).Count() > 0 && listLD.Where(a => a.DispatchISSI == DispatchISSI).ToList<LoginDispatch>().Count > 0)
                return true;
            else return false;

        }
        public static void AddLoginDispatch(LoginDispatch logindispatch)
        {
            if (listLD == null)
                listLD = new List<LoginDispatch>();
            listLD.Add(logindispatch);
        }
        public static void RemoveLoginDispatch(string DispatchISSI)
        {
            if (listLD == null)
            {
                return;
            }
            if (listLD.Count <= 0)
            {
                return;
            }
            listLD = listLD.Where(a => a.DispatchISSI != DispatchISSI).ToList<LoginDispatch>();
        }
        public static void UpdateLoginTime(string DispatchISSI, DateTime dt)
        {
            if (listLD != null && listLD.Count > 0)
            {
                listLD = listLD.Where(a => a.DispatchISSI != DispatchISSI).ToList<LoginDispatch>();
            }
            else
            {
                listLD = new List<LoginDispatch>();
            }
           
            
            listLD.Add(new LoginDispatch() { DispatchISSI = DispatchISSI, LoginTime = dt });
        }
        public static int GetLoginDispatchCount() {
            if (listLD == null)
                return 0;
            else
                return listLD.Count();
        }
    }
}
