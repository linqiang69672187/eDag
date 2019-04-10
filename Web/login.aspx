<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Web.login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">  
        body, html, form
        {
            height: 100%;
            margin: 0px; 
            color: White;
            font-size: 12px;
        }
        #div1
        {
        position:absolute;
        z-index:0;
        height: 100%;
        width: 100%;
        }
        #tblogin
        {
            width: 451px;
            height: 206px;
            background: url('Images/login/loginin.png') no-repeat;

        }
        #Button1
        {
            cursor: pointer;
            background-color: transparent;
            background: url('Images/login/loginbt_bg.png') -138px 0px;
            width: 67px;
            height: 22px;
            color: #ffffff;
            border: 0;
        }
        #Button2
        {
            cursor: pointer;
            background-color: transparent;
            background: url('Images/login/loginbt_bg.png');
            border: 0;
            width: 67px;
            height: 22px;
            color: #ffffff;
        }
        #Button2:hover
        {
            cursor: pointer;
            background-position: -69px 0px;
        }
        #Button1:hover
        {
            cursor: pointer;
            background-position: -207px 0px;
        }
        #title1
        {
            width: 451px;
            height: 70px;
        }
        #Button4
        {
            background: url('Images/login/config.png');
            border: 0px;
            margin-right: 10px;
            margin-top: 7px;
            width: 40px;
            height: 23px;
        }
        #TextBox1, #TextBox2
        {
            border: 1px solid #2489ae;
        }
        .style1
        {
            width: 54px;
        }
    </style>
    <script src="MyCommonJS/ajax.js" type="text/javascript"></script>
    <script src="lqnew/js/LanuageXmlToJson.js" type="text/javascript"></script>
    
<script type="text/javascript">
    function winopen() {
        var targeturl = "default.aspx"
        window.location = targeturl;
    }
</script>


</head>
<body onload="aload()" >
    <form id="form1" runat="server">
    <div id="div1"><img alt="" src="images/login/login_bg.jpg" style="width:100%;height:100%;" /></div>
    <div  id="divlogin" style="position:absolute;z-index:1;">
    <table >
        <tr>
            <td align="center">
                <table >
                    <tr>
                        <td id="title1" ><img id="titlepic"   /></td>
                    </tr>
                </table>
                <table id="tblogin">
                    <tr>
                        <td>
                            <table style="height: 202px; width: 100%;" border="0" cellspacing="0">
                                <tr>
                                    <td style="width: 170px; height: 100%">
                                    </td>
                                    <td>
                                        <table width="100%" height="202px" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table id="myloginit" border="0" cellspacing="0" cellpadding="0"  style="width:271;height:87;">
                                                        <tr>
                                                            <td align="right" height="26px" class="style1" >
                                                            <span id="usertype"><%--用户类型--%></span><span>&nbsp;&nbsp</span>
                                                            </td>
                                                            <td align="left">                                      
    <table><tr><td id="dispatchtd" style="cursor:pointer" onclick="dispatch_td_onclick();"><span id="dispatchuser"><%--调度用户--%></span><asp:RadioButton ID="dispatchuser_radio" runat="server" GroupName="usertype"/></td>
    <td id="configtd" style="cursor:pointer" onclick="config_td_onclick();"><span id="configuser"><%--配置用户--%></span><asp:RadioButton ID="configuser_radio" runat="server" GroupName="usertype" /></td></tr></table>
                                                            </td>
                                                            
                                                        </tr>
                                                        <tr>
                                                            <td align="right" height="26px" class="style1" >
                                                            <span id="usename"></span><span>&nbsp;&nbsp</span>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="TextBox1" runat="server" Height="18px" Width="118px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" height="26px" class="style1" >
                                                               <span id="password"></span><span>&nbsp;&nbsp</span>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="TextBox2" Height="18px" Width="118px" runat="server" TextMode="Password"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                                    Display="Dynamic" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" height="35px" align="left">
                                                                &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Button2" runat="server" Text="" OnClick="Button2_Click" />                                                                &nbsp;
                                                              <input id="Button1" type="button" onclick="self.close();" value="" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="42px" align="right" valign="bottom" >
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </div>
    </form>
     
</body>
</html>
<script type="text/javascript">
    var langdata;
    var aload = function () {
        var divx = document.getElementById("divlogin");
        divx.style.left = (parseFloat(document.body.clientWidth) - 463) / 2;
        divx.style.top = (parseFloat(document.body.clientHeight) - 292) / 2;
        getlanguage();
    }

    window.onresize = function () {
        var divx = document.getElementById("divlogin");
        divx.style.left = (parseFloat(document.body.clientWidth) - 463) / 2;
        divx.style.top = (parseFloat(document.body.clientHeight) - 292) / 2;
    };
    var div = document.getElementById("divlogin");
    div.style.left = (parseFloat(document.body.clientWidth) - parseFloat(463)) / 2;
    div.style.top = (parseFloat(document.body.clientHeight) - parseFloat(292)) / 2;
    function callactivex() {
        var activex = document.getElementById("EasctcomActiveX");
        if (activex) {
            activex.btclick();
        }
    }
    function getlanguage() {
        var param = {
            "id": "0"
        };
        jquerygetNewData_ajax("WebGis/Service/LanuageXmlToJson.aspx", param, function (request) {
            if (request != null) {
                langdata = request.root.resource;
            }
            document.title = GetTextByName("WebGisTitle", langdata);
            document.getElementById("usertype").innerHTML = GetTextByName("L_Usertype", langdata);
            document.getElementById("dispatchuser").innerHTML = GetTextByName("dispatchuser", langdata);
            document.getElementById("configuser").innerHTML = GetTextByName("configuser", langdata);
            document.getElementById("usename").innerHTML = GetTextByName("usename", langdata);
            document.getElementById("password").innerHTML = GetTextByName("password", langdata);
            document.getElementById("Button2").value = GetTextByName("ButtonLogin", langdata);
            document.getElementById("Button1").value = GetTextByName("ButtonCancel", langdata);
            document.getElementById("titlepic").src = GetTextByName("LoginTitlePic", langdata);           
            
        }, false, false);
    }
    function dispatch_td_onclick(td)
    {
        var dispatchuser_radiobutton = document.getElementById('dispatchuser_radio');
        if (dispatchuser_radiobutton) {
            dispatchuser_radiobutton.checked = 'true';
        }
    }
    function config_td_onclick()
    {
        var configuser_radiobutton = document.getElementById('configuser_radio');
        if(configuser_radiobutton)
        {
            configuser_radiobutton.checked = 'true';
        }
    }
    
</script>
