<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlayMuilVideo.aspx.cs" Inherits="Web.Video.PlayMuilVideo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <script src="../JQuery/jquery-1.5.2.js"></script>
    <script src="../MyCommonJS/addAll.js"></script>
  <script type="text/javascript" src="swfobject.js"></script>
</head>
<body style="">
    <form id="form1" runat="server">
    <div style="width:1020px;height:760px;overflow:auto" id="table_video">
        
    </div>
    </form>
</body>
</html>
  <script type="text/javascript">
      Request = {
          QueryString: function (item) {
              var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
              return svalue ? svalue[1] : svalue;
          }
      }

      window.onload = function () {
          var bound = Request.QueryString('bound');

          try {
              getNewData_ajaxStock("../Handlers/Video/GetVideoListService.ashx", { bound: bound }, function (msg) {
                  if (msg) {
                      var myarray = new Array();
                      myarray = eval(msg);
                      if (myarray.length == 0) {
                          document.getElementById("table_video").innerHTML = "您框选的区域暂无视频监控设备";
                          return;
                      }
                      var col = parseInt(Math.sqrt(myarray.length).toString());
                      if (Math.sqrt(myarray.length) > col) {
                          col = parseInt(col) + 1;
                      }
                      var width = parseInt(950 / col);
                      var height = width;
                      var rows = 0;
                      if (myarray.length == 1) {
                          width = 700;
                      }
                      var tr = "<tr>";
                      for (var p = 0; p < myarray.length; p++) {
                          if (p % col == 0) {
                              rows++;
                              tr += "</tr><tr><td align='center'  background='' style='width:" + width + "px';height:'" + width + "px'><table  width='99%' border='0' align='center' cellpadding='0' cellspacing='1' bgcolor='#c0de98' ><tr><td background='../lqnew/images/tab_14.gif'>" + myarray[p].VideoName + "</td></tr><tr><td><div id='" + myarray[p].DivID + "'></div></td></tr></table></td>";

                          } else {
                              tr += "<td align='center'  background='' style='width:" + width + "px';height:'" + width + "px'><table  width='99%' border='0' align='center' cellpadding='0' cellspacing='1' bgcolor='#c0de98' ><tr><td background='../lqnew/images/tab_14.gif'>" + myarray[p].VideoName + "</td></tr><tr><td><div id='" + myarray[p].DivID + "'></div></td></tr></table></td>"
                          }

                      }
                      tr += "</tr>";
                      height = parseInt(650 / rows);
                      document.getElementById("table_video").innerHTML = "<table height='100%' width='99%' border='0' align='center' cellpadding='0' cellspacing='1' >" + tr + "</table>";
                      for (var p = 0; p < myarray.length; p++) {
                          document.getElementById(myarray[p].DivID).innerHTML = " <embed src=\"EastcomCamera_"+p+".swf\" quality=high  width=\"" + width + "\" height=\"" + height + "\" ></embed>";

                          /*
                          if (p == 0) {
                              
                              document.getElementById(myarray[p].DivID).innerHTML = " <embed src=\"EastcomCamera_0.swf\" quality=high  width=\"" + width + "\" height=\"" + height + "\" ></embed>";
                          } else {
                              var s1 = new SWFObject("flvplayer.swf", "", width, height, "7");
                              s1.addParam("allowfullscreen", "true");
                              s1.addVariable("file", myarray[p].VideoPlayUrl + ".flv");
                              s1.addVariable("image", "preview.jpg");
                              s1.addVariable("wmode", "opaque");
                              s1.addVariable("width", width);
                              s1.addVariable("repeat", "true");
                              s1.addVariable("autostart", "true");
                              s1.addVariable("height", height);
                              s1.write(myarray[p].DivID);
                          }
                          */
                      }
                  }
              })
          } catch (err) {
              writeLog("system", "video.js AddVideo，error info:" + err);
          }
      }

    </script>