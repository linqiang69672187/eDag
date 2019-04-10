using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using System.Web.UI;

namespace DbComponent
{
    class selectedentityfile
    {
        public static string selectedentityfile_folderpath="";
        public void createselectedentityfile(Page p,string dispatchUserName)
        {
            Random rad = new Random();
            int loginnum = rad.Next(1000,10000);
            DateTime logintime = DateTime.Now;
            selectedentityfile_folderpath = "..\\SelectedEntity\\" + dispatchUserName + "\\" + logintime + "_" + loginnum;
            string filepath = selectedentityfile_folderpath + "\\SelectedEntity.txt";
            if (!Directory.Exists(p.Server.MapPath(selectedentityfile_folderpath)))
            {
                Directory.CreateDirectory(p.Server.MapPath(selectedentityfile_folderpath));
            }
            if (!File.Exists(p.Server.MapPath(@filepath)))
            {
                File.CreateText(p.Server.MapPath(@filepath));
            }
        }
    }
}
