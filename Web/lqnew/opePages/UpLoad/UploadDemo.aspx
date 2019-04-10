<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadDemo.aspx.cs" Inherits="Web.Demo.UploadDemo" %>

<%@ Register Assembly="MattBerseth.WebControls.AJAX" Namespace="MattBerseth.WebControls.AJAX.Progress"
    TagPrefix="mb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>图片上传</title>
    <link rel="Stylesheet" href="_assets/css/progress.css" />
    <link rel="Stylesheet" href="_assets/css/upload.css" />
        <!---------------xzj--2018/7/20------------注销jquery防止报错------------------>
    <!--<script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>-->
    <style type="text/css">
        BODY
        {
            font-family: Arial, Sans-Serif;
            font-size: 12px;
        }
    </style>
    <script type="text/C#" runat="server">
       
        protected void Page_Load(object sender, EventArgs args)
        {
            if (!this.IsPostBack)
            {
                this.Session["UploadInfo"] = new UploadInfo { IsReady = false };
                if (System.IO.Directory.Exists(Server.MapPath("~/lqnew/opePages/UpLoad/Uploads")))
                {

                }
                else
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("~/lqnew/opePages/UpLoad/Uploads"));
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public static object GetUploadStatus()
        {
            try
            {
                //获取文件长度
                UploadInfo info = HttpContext.Current.Session["UploadInfo"] as UploadInfo;
                string fclength = HttpContext.Current.Session["fileContentLenght"].ToString();
                if (int.Parse(fclength) > 1048576)
                {
                    return new { percentComplete = 100, message = "超出指定大小" };
                }
                if (info != null && info.FileName != null)
                {

                    int soFar = info.UploadedLength;
                    int total = info.ContentLength;

                    int percentComplete = (int)Math.Ceiling((double)soFar / (double)total * 100);
                    string message = string.Format("上传 {0} ... {1} of {2} 字节", info.FileName, soFar, total);

                    //  返回百分比
                    return new { percentComplete = percentComplete, message = message };
                }

                //  还没有准备好...
                return null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager" runat="server" EnablePageMethods="true" />
    <script type="text/javascript">
        var intervalID = 0;
        var progressBar;
        var fileUpload;
        var form;
        // 进度条      
        function pageLoad() {
            $addHandler($get('upload'), 'click', onUploadClick);
           // progressBar = $find('progress');
        }
        // 注册表单       
        function register(form, fileUpload) {
            this.form = form;
            this.fileUpload = fileUpload;
        }
        //上传验证
        function onUploadClick() {
            setTimeout(function(){
            alert("上传失败,请重新选择");
             window.returnValue ="上传失败";
             window.close();
            },10000);
            var vaild = fileUpload.value.length > 0;
            if (vaild) {
                $get('upload').disabled = 'disabled';
                updateMessage('info', '初始化上传...');
                //提交上传
                form.submit();
                // 隐藏frame
                Sys.UI.DomElement.addCssClass($get('uploadFrame'), 'hidden');
                // 0开始显示进度条
                //progressBar.set_percentage(0);
               // progressBar.show();
                // 上传过程
                intervalID = window.setInterval(function () {
                    PageMethods.GetUploadStatus(function (result) {
                    
                        if (result) {
                            if(result.percentComplete=100&&result.message=="超出指定大小")
                            {
                             onComplete('error', '上传文件出错,超出了指定大小');
                            // window.clearInterval(intervalID);
                            
                            }
                            //  更新进度条为新值
                           // progressBar.set_percentage(result.percentComplete);
                            //更新信息
                            updateMessage('info', result.message);

                            if (result == 100) {
                                // 自动消失
                                window.clearInterval(intervalID);
                            }
                        }
                    });
                }, 500);
            }
            else {
                onComplete('error', '您必需选择一个文件');
            }
        }

        function onComplete(type, msg) {
        
        if(msg=="您必需选择一个文件"||msg=="请重新选择图片"||msg=="上传文件出错,超出了指定大小"){
            if(msg=="请重新选择图片"){
            alert("文件上传失败，请重新选择");
            }else{
            alert("文件上传失败，请重新选择");
            }
             window.returnValue ="上传失败";
             window.close();
            return;
        }
        if(msg != "" && msg != undefined && msg != "请重新选择图片" && msg != "上传文件出错")
        {
         
        }else
        {
        window.returnValue ="上传失败";
            alert("文件上传失败，请重新选择");
            window.close();
            return;
        }
            window.returnValue =msg;
            window.close();
            // 自动消失
            window.clearInterval(intervalID);
            // 显示消息
            updateMessage(type, msg);
            // 隐藏进度条
           // progressBar.hide();
           // progressBar.set_percentage(0);
            // 重新启用按钮
            $get('upload').disabled = '';
            //  显示frame
            Sys.UI.DomElement.removeCssClass($get('uploadFrame'), 'hidden');
           
        }
        
        function updateMessage(type, value) {
            var status = $get('status');
            status.innerHTML = value;
            // 移除样式
            status.className = '';
            Sys.UI.DomElement.addCssClass(status, type);
        }
        $(document).ready(function () {
            $("#uploadFrame").attr("src", "Upload.aspx?type=<%=Request["type"] %>&id=<%=Request["id"] %>");
        });
        function CppCCC(filename){
            alert();
            window.returnValue =filename;
            window.close();
        }
    </script>
    <div>
        <div class="upload" style="position: absolute; left: 7px">
            <h3>
                文件上传</h3>
            <div>
                <iframe id="uploadFrame" frameborder="0" scrolling="no" src="Upload.aspx"></iframe>
                <mb:ProgressControl ID="progress" runat="server" CssClass="lightblue" Style="display: none"
                    Value="0" Mode="Manual" Speed=".4" Width="100%" />
                <div>
                    <div id="status" class="info">
                        请选择要上传的文件</div>
                    <div class="commands">
                        <input id="upload" type="button" style="text-align: center; vertical-align: middle"
                            value="上传" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
