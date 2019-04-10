using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DbComponent.LogModule
{
    interface ILog<T>
    {
        bool SaveLog(T t);

        DataTable GetLogs(T t);
    }
}
