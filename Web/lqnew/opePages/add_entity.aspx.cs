using Ryu666.Components;
using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class add_entity : BasePage
    {
        public int entity_depth=100000;
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            DbComponent.Entity entity = new DbComponent.Entity();
            entity_depth = entity.GetEntityIndex(int.Parse(Request.Cookies["id"].Value));
            if (!Page.IsPostBack)
            {               
                
                if (entity_depth != 0 && entity_depth != -1) //非一级单位
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("NOTbasicentity") + "');window.parent.closeprossdiv();;window.parent.mycallfunction('add_entity');</script>");
                }
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                validateEntityLength.ErrorMessage = "<b>" + ResourceManager.GetString("errorUnNomal");
                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                
               // RegularExpressionValidator1.ValidationExpression = Properties.Resources.strUnNomalValidationExpression;

               // RegularExpressionValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
                rfvTxtName.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("ReinsertEntityName") + "</b>";//请重新输入单位名
                try
                {                    

                    if (Request.QueryString["id"] != null && Request.QueryString["id"].ToString()!="")
                    {
                        if (entity_depth == -1)
                        {                            
                            ListItem LTopEntity_none = new ListItem();
                            LTopEntity_none.Text = ResourceManager.GetString("Lang_SelectedUnits");
                            LTopEntity_none.Value = "none";
                            DropDownList2.Items.Add(LTopEntity_none);
                        }
                        
                        Label_entity.Text = ResourceManager.GetString("LangParentEntity");
                        DbComponent.Entity funEntity = new DbComponent.Entity();
                        DataTable dttopentity = funEntity.GetAllEntityInfo(int.Parse(Request.Cookies["id"].Value));
                        for (int i = 0; i < dttopentity.Rows.Count; i++)
                        {
                            ListItem LTopEntity = new ListItem();
                            LTopEntity.Text = dttopentity.Rows[i][1].ToString();
                            LTopEntity.Value = dttopentity.Rows[i][0].ToString() + "," + dttopentity.Rows[i][3].ToString();
                            DropDownList2.Items.Add(LTopEntity);
                        }
                        
                        DropDownList3.Items[0].Text = ResourceManager.GetString("Lang_SelectedUnits");
                        string[] drvalue = Regex.Split(Request.QueryString["id"].Trim(), ",", RegexOptions.IgnoreCase);
                        int ParentID = Convert.ToInt16(drvalue[0]);
                        int Depth = Convert.ToInt16(drvalue[1]);
                        string newvalue = ParentID.ToString() + "," + Depth.ToString();
                        try
                        {
                            DropDownList2.SelectedValue = newvalue;
                            //ToShowLastEntity();
                        }
                        catch (System.Exception ex)
                        {                            
                            Response.Write(newvalue);
                        }
                        DropDownList2.AutoPostBack = false;
                    }
                    else
                    {
                        if (entity_depth == -1)
                        {
                            Label_entity.Text = ResourceManager.GetString("Lang-RootEntity");
                            string sqltopentity = "select id, name, Depth from Entity where Depth = 0";
                            DataTable dttopentity = DbComponent.UChangeETree.ExecuteReadconn(sqltopentity, "topentity");
                            ListItem LTopEntity_none = new ListItem();
                            LTopEntity_none.Text = ResourceManager.GetString("Lang_SelectedUnits");
                            LTopEntity_none.Value = "none";
                            DropDownList2.Items.Add(LTopEntity_none);
                            for (int i = 0; i < dttopentity.Rows.Count; i++)
                            {
                                ListItem LTopEntity = new ListItem();
                                LTopEntity.Text = dttopentity.Rows[i][1].ToString();
                                LTopEntity.Value = dttopentity.Rows[i][0].ToString() + "," + dttopentity.Rows[i][2].ToString();
                                DropDownList2.Items.Add(LTopEntity);
                            }
                            DropDownList2.AutoPostBack = true;
                            DropDownList2.SelectedIndexChanged += SelectTopEntityChanged;
                            DropDownList3.Items[0].Text = ResourceManager.GetString("Lang_SelectedUnits");
                        }
                        else if (entity_depth == 0) {
                            Label_entity.Text = ResourceManager.GetString("LangParentEntity");
                            DbComponent.Entity funEntity = new DbComponent.Entity();
                            DataTable dtbelongentity = funEntity.GetAllEntityInfo(int.Parse(Request.Cookies["id"].Value));
                            for (int i = 0; i < dtbelongentity.Rows.Count; i++)
                            {
                                ListItem LTopEntity = new ListItem();
                                LTopEntity.Text = dtbelongentity.Rows[i][1].ToString();
                                LTopEntity.Value = dtbelongentity.Rows[i][0].ToString() + "," + dtbelongentity.Rows[i][3].ToString();
                                DropDownList2.Items.Add(LTopEntity);
                            }
                            DropDownList2.AutoPostBack = false;
                        }
                    }

                    rbtxtLo.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_rbtxtLoErr") + "</b>";
                    RangeValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_RangeValidator1Err") + "</b>";
                    ValidatorBZ.ErrorMessage = "<b>" + ResourceManager.GetString("errorBZ") + "</b>";
                }
                catch (System.Exception et)
                {
                    Response.Write(et);
                }

            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }

        }
         protected bool checkUnNomal(String str) {
            var pattern = new Regex("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！#￥……&*（）——|{}【】‘；：”“'。，、？]");
          
            if (pattern.IsMatch(str) )//包含特殊字符
                return true;
            else
                return false;//不包含特殊字符
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {            
            try
            {
                if (checkUnNomal(TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("dwmcbhtszf") + "');</script>");
                    return;
                }
                mypic.Src = "../../" + HidPic.Value.ToString();
                DbComponent.Entity addentit = new DbComponent.Entity();
                if (addentit.IsExistEntityNameForAdd(TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('"+ResourceManager.GetString("EntityHasExist")+"');</script>");
                    return;
                }

                //string[] drodownvalue = Regex.Split(DropDownList1.SelectedValue, ",", RegexOptions.IgnoreCase);
                string name = TextBox1.Text.Trim();
                string bz = txtBZ.Text.Trim();
                string strpicurl = "UpLoad/Uploads/Default_EntityPic/Default_EntityPic.png";
                strpicurl = HidPic.Value.ToString();
                //int ParentID = Convert.ToInt16(drodownvalue[0]);
                //int Depth = Convert.ToInt16(drodownvalue[1]);
                int ParentID = 0;
                int Depth = 0;
                if (DropDownList2.SelectedItem.Value != "none")
                {
                    if (entity_depth == -1)
                    {
                        //if (DropDownList2.SelectedItem.Value == "none")
                        //{
                        //    ParentID = int.Parse(Request.Cookies["id"].Value);
                        //    Depth = 0;
                        //}
                        if (DropDownList2.SelectedItem.Value != "none")
                        {
                            if (DropDownList3.Visible == false)
                            {
                                ParentID = int.Parse(DropDownList2.SelectedValue.Split(',')[0]);
                                Depth = int.Parse(DropDownList2.SelectedValue.Split(',')[1]) + 1;
                            }
                            else
                            {
                                if (DropDownList3.SelectedItem.Value == "none")
                                {
                                    ParentID = int.Parse(DropDownList2.SelectedValue.Split(',')[0]);
                                    Depth = int.Parse(DropDownList2.SelectedValue.Split(',')[1]) + 1;
                                }
                                else
                                {
                                    ParentID = int.Parse(DropDownList3.SelectedValue.Split(',')[0]);
                                    Depth = int.Parse(DropDownList3.SelectedValue.Split(',')[1]) + 1;
                                }
                            }
                        }
                    }
                    if (entity_depth == 0)
                    {
                        ParentID = int.Parse(DropDownList2.SelectedValue.Split(',')[0]);
                        Depth = int.Parse(DropDownList2.SelectedValue.Split(',')[1]) + 1;
                    }
                    decimal Lo = 0;
                    decimal La = 0;
                    if (!string.IsNullOrEmpty(txtLo.Text.Trim()))
                    {
                        Lo = Convert.ToDecimal(txtLo.Text.Trim());
                    }
                    if (!string.IsNullOrEmpty(txtLa.Text.Trim()))
                    {
                        La = Convert.ToDecimal(txtLa.Text.Trim());
                    }
                    DateTime dtimi = DateTime.Now;
                    string divID = dtimi.Year.ToString() + dtimi.Month.ToString() + dtimi.Day.ToString() + dtimi.Hour.ToString() + dtimi.Minute.ToString() + dtimi.Second.ToString();

                    if (addentit.AddEntityinfo(name, ParentID, Depth, bz, Lo, La, divID, strpicurl, this.Page))
                    {
                        //注释原来的，新的将window.parent.CloseJWD()函数删除---------------xzj--2018/6/29-------------
                        //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.reloadtree();window.parent.CloseJWD();window.parent.lq_changeifr('manager_entity');window.parent.AddPoliceStation('" + divID + "','" + La.ToString() + "','" + Lo.ToString() + "','" + name + "','" + strpicurl + "');window.parent.mycallfunction('add_entity');</script>");
                        int id = int.Parse(addentit.GetIdByDivID(divID));
                        var entity = "{'ID' : '" + id + "', 'DivID' : '" + divID + "', 'La' :" + La + ", 'Lo' :" + Lo + ", 'policename' :'" + name + "', 'picurl' :'" + strpicurl + "' }";
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_entity');window.parent.psLayerManager.addPoliceStation(" + entity + ");window.parent.mycallfunction('add_entity');</script>");
                        //注释原来的，新的将window.parent.CloseJWD()函数删除---------------xzj--2018/6/29-------------
                        log.Info(ResourceManager.GetString("AddEntity") + name + ResourceManager.GetString("lang_Success"));
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                    }
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Alert_PleaseChooseRootEntity") + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
            }            
        }

        protected void SelectTopEntityChanged(object sender, EventArgs e)
        {
            if (entity_depth == -1)
            {
                ToShowLastEntity();
            }
        }

        private void ToShowLastEntity()
        {
            if (DropDownList2.SelectedItem.Value != "none")
            {
                if (Request.QueryString["id"] != null && Request.QueryString["id"].ToString() != "")
                {
                    LangParentEntity.Visible = false;
                    DropDownList3.Visible = false;
                }
                else
                {
                    LangParentEntity.Visible = true;
                    DropDownList3.Visible = true;
                }
                //获取选中顶级单位的所有下级单位
                String TopentityIdstring = DropDownList2.SelectedValue.Split(',')[0];
                int TopentityId = int.Parse(TopentityIdstring);
                DbComponent.UChangeETree MyUserTree11 = new DbComponent.UChangeETree();
                String TopentityChildren = MyUserTree11.GetParentIDNameDepth(TopentityId);
                DropDownList3.Items.Clear();
                DropDownList3.Items.Add(new ListItem(ResourceManager.GetString("Lang_SelectedUnits"), "none"));
                string[] Children = TopentityChildren.Split(';');

                //为二级下拉框赋值
                for (int i = 1; i < Children.Length - 1; i++)
                {
                    String[] childrenIdNameDepth = Children[i].Split(',');
                    ListItem dtchildrenentity = new ListItem();
                    dtchildrenentity.Text = childrenIdNameDepth[1].ToString();
                    dtchildrenentity.Value = childrenIdNameDepth[0].ToString() + "," + childrenIdNameDepth[2].ToString();
                    DropDownList3.Items.Add(dtchildrenentity);
                }
                if (DropDownList3.Items.Count <= 0)
                {
                    DropDownList3.Items.Add(new ListItem("", "none"));
                    DropDownList3.SelectedItem.Value = "none";
                    LangParentEntity.Visible = false;
                    DropDownList3.Visible = false;
                }
            }
            else
            {
                LangParentEntity.Visible = false;
                DropDownList3.Visible = false;
            }
        }
                
    }
}