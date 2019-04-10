using System.Text;
using System.Web.UI.WebControls;

namespace LQCommonCS
{
    public class ISSI
    {
        #region 选中和移除扫描通播组
        public static void RowCommand(DropDownList dlist, GridViewCommandEventArgs e,Label lb)
        {

       
            switch (e.CommandName)
            {
                case "AddSM":     
                    ImageButton imgbt = (ImageButton)(e.CommandSource);
                    string[] drvalue = e.CommandArgument.ToString().Split(',');
                    ListItem list = new ListItem();
                    list.Text = drvalue[1] + "(" + drvalue[0] + ")";
                    list.Value = drvalue[0];
                    dlist.Items.Add(list);
                    imgbt.ImageUrl = "../images/check_on.png";
                    imgbt.CommandName = "DelSM";

                    lb.Attributes["title"] += (dlist.Items.Count == 2) ?list.Text : "\n" + list.Text;
                    break;
                case "DelSM":
                    ImageButton imgbt1 = (ImageButton)(e.CommandSource);
                    string[] drvalue1 = e.CommandArgument.ToString().Split(',');
                    ListItem list1 = new ListItem();
                    list1.Text = drvalue1[1] + "(" + drvalue1[0] + ")";
                    list1.Value = drvalue1[0];
                 
                    dlist.Items.Remove(list1);
                    imgbt1.ImageUrl = "../images/check_off.png";
                    imgbt1.CommandName = "AddSM";
                    lb.Attributes["title"] = lb.Attributes["title"].Replace("\n"+list1.Text, "").Trim();
                    lb.Attributes["title"] =lb.Attributes["title"].Replace(list1.Text, "").Trim() ;
                    break;
                default:
                    break;
            }
        }
        #endregion
        #region 选中和移除基站组基站//xzj--20181217--添加交换
        public static void RowCommandForBSGroup(DropDownList dlist, GridViewCommandEventArgs e, Label lb)
        {


            switch (e.CommandName)
            {
                case "AddSM":
                    ImageButton imgbt = (ImageButton)(e.CommandSource);
                    string[] drvalue = e.CommandArgument.ToString().Split(',');
                    ListItem list = new ListItem();
                    list.Text = drvalue[1] + "(" + drvalue[2] + "," + drvalue[0] + ")";
                    list.Value = drvalue[2]+","+drvalue[0];
                    dlist.Items.Add(list);
                    imgbt.ImageUrl = "../images/check_on.png";
                    imgbt.CommandName = "DelSM";

                    lb.Attributes["title"] += (dlist.Items.Count == 2) ? list.Text : "\n" + list.Text;
                    break;
                case "DelSM":
                    ImageButton imgbt1 = (ImageButton)(e.CommandSource);
                    string[] drvalue1 = e.CommandArgument.ToString().Split(',');
                    ListItem list1 = new ListItem();
                    list1.Text = drvalue1[1] + "(" + drvalue1[2] + "," + drvalue1[0] + ")";
                    list1.Value =drvalue1[2] + ","+ drvalue1[0];

                    dlist.Items.Remove(list1);
                    imgbt1.ImageUrl = "../images/check_off.png";
                    imgbt1.CommandName = "AddSM";
                    lb.Attributes["title"] = lb.Attributes["title"].Replace("\n" + list1.Text, "").Trim();
                    lb.Attributes["title"] = lb.Attributes["title"].Replace(list1.Text, "").Trim();
                    break;
                default:
                    break;
            }
        }
        #endregion
        #region 选中和移除扫描通播组
        public static void RowCommand2(DropDownList dlist, GridViewCommandEventArgs e)
        {


            switch (e.CommandName)
            {
                case "AddSM":
                    ImageButton imgbt = (ImageButton)(e.CommandSource);
                    string[] drvalue = e.CommandArgument.ToString().Split(',');
                    ListItem list = new ListItem();

                    list.Text = drvalue[1] + ";" + drvalue[2];
                    list.Value = drvalue[0];
                    dlist.Items.Add(list);
                    imgbt.ImageUrl = "../images/check_on.png";
                    imgbt.CommandName = "DelSM";

                   
                    break;
                case "DelSM":
                    ImageButton imgbt1 = (ImageButton)(e.CommandSource);
                    string[] drvalue1 = e.CommandArgument.ToString().Split(',');
                    ListItem list1 = new ListItem();
                    list1.Text = drvalue1[1] + ";" + drvalue1[2];
                    list1.Value = drvalue1[0];
            
                    dlist.Items.Remove(list1);
                    imgbt1.ImageUrl = "../images/check_off.png";
                    imgbt1.CommandName = "AddSM";
                   
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region 生成Gridview是修改ImageButton 的命令和图片
        public static void RowDataBound(DropDownList drlist, string img, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
                ListItem list = new ListItem();
                list.Text = e.Row.Cells[1].Text + "(" + e.Row.Cells[2].Text + ")";
                list.Value = e.Row.Cells[2].Text;
                ImageButton imgbt = (ImageButton)e.Row.Cells[0].FindControl(img);
                if (drlist.Items.FindByValue(list.Value)!=null && imgbt != null)
                {
                    imgbt.ImageUrl = "../images/check_on.png";
                    imgbt.CommandName = "DelSM";
                }
            }
        }
        #endregion

        #region 生成Gridview是修改ImageButton 的命令和图片//xzj--20181217--添加交换
        public static void RowDataBoundforBSGroup(DropDownList drlist, string img, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                ListItem list = new ListItem();
                list.Text = e.Row.Cells[1].Text + "(" + e.Row.Cells[3].Text + "," + e.Row.Cells[2].Text + ")";
                list.Value = e.Row.Cells[3].Text + ","+e.Row.Cells[2].Text;
                ImageButton imgbt = (ImageButton)e.Row.Cells[0].FindControl(img);
                if (drlist.Items.FindByValue(list.Value) != null && imgbt != null)
                {
                    imgbt.ImageUrl = "../images/check_on.png";
                    imgbt.CommandName = "DelSM";
                }
            }
        }
        #endregion

        /// <summary>
        /// 生成GSSI小组列表
        /// </summary>
        /// <param name="m"></param>
        /// <returns></returns>
        #region createGSSI
        public static string CreateGroupTB(string[] m)
        {
            StringBuilder tablestring = new StringBuilder();
            if (m !=null)
            {
                tablestring.Append("<table width='99%' border='0' align='center' cellpadding='0' cellspacing='1' bgcolor='#c0de98' >");
                tablestring.Append("<tr style='height:25px;'><td  background='../images/tab_14.gif' align='center' >" + Ryu666.Components.ResourceManager.GetString("GroupName") + "</td><td width='80px' align='center' background='../images/tab_14.gif'>GSSI</td></tr>");
               foreach (string n in m)
               { if (n!=null&&n!=""){
                       string[] value = n.Split(',');
                       tablestring.Append("<tr style='height:22px;'><td  bgcolor='#FFFFFF' align='left' >&nbsp;&nbsp;" + value[0] + "</td><td  align='center' bgcolor='#FFFFFF'>" + value[1] + "</td></tr>");
                       } }
                
                
                tablestring.Append("</table>");
                return tablestring.ToString();
            }

            return Ryu666.Components.ResourceManager.GetString("NoData");
        }

        public static string CreateGroupBS(string[] m)//xzj--20181217--添加交换
        {
            StringBuilder tablestring = new StringBuilder();
            if (m != null)
            {
                tablestring.Append("<table width='99%' border='0' align='center' cellpadding='0' cellspacing='1' bgcolor='#c0de98' >");
                tablestring.Append("<tr style='height:25px;'><td  background='../images/tab_14.gif' align='center' >" + Ryu666.Components.ResourceManager.GetString("StationName") + "</td><td width='80px' align='center' background='../images/tab_14.gif'>" + Ryu666.Components.ResourceManager.GetString("BaseStationIdentification") + "</td><td width='80px' align='center' background='../images/tab_14.gif'>" + Ryu666.Components.ResourceManager.GetString("switchID") + "</td></tr>");
                foreach (string n in m)
                {
                    if (n != null && n != "")
                    {
                        string[] value = n.Split(',');
                        tablestring.Append("<tr style='height:22px;'><td  bgcolor='#FFFFFF' align='left' >&nbsp;&nbsp;" + value[0] + "</td><td  align='center' bgcolor='#FFFFFF'>" + value[1] + "</td><td  align='center' bgcolor='#FFFFFF'>" + value[2] + "</td></tr>");
                    }
                }


                tablestring.Append("</table>");
                return tablestring.ToString();
            }

            return Ryu666.Components.ResourceManager.GetString("NoData");
        }

#endregion

    }
}
