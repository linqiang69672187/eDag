<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="add_ISSIs.aspx.cs" Inherits="Web.lqnew.opePages.add_ISSIs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="/lqnew/js/pdtCode.js" type="text/javascript"></script>
    <script type="text/javascript">

        function init() {
            this.parent.$("#add_ISSIs").height(800);
            this.parent.$("#add_ISSIs_ifr").height(800);
        }
        function TerminalTypeChange(obj) {
            // add_ISSI     
            init();
            var options = $("#" + obj + " option:selected"); //获取选中的项 
            var val = options.val();
            if (val == "PDT") {
                // alert(val);
                $("#trPdtRule").show();
                var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
                // alert(pdtRuleVale);
                if (pdtRuleVale == 1) {
                    $("#trPdtBzNum").show();
                    $("#trPdtArea").hide();
                    $("#trPdtZjNum").hide();
                    $("#txtTetraRange1").attr("disabled", "true");
                    $("#txtTetraRange2").attr("disabled", "true");

                }
                else {
                    $("#trPdtBzNum").hide();
                    $("#trPdtArea").show();
                    $("#trPdtZjNum").show();
                    $("#txtTetraRange1").attr("disabled", "true");
                    $("#txtTetraRange2").attr("disabled", "true");
                }
            }
            else {
                $("#trPdtRule").hide();
                $("#trPdtBzNum").hide();
                $("#trPdtArea").hide();
                $("#trPdtZjNum").hide();
                $("#txtTetraRange1").removeAttr("disabled");
                $("#txtTetraRange2").removeAttr("disabled");
            }
        }

        function radPdtRuleChange(obj) {
            // alert(obj);
            $("#<% =hidPdtRule.ClientID %>").val(obj);
            //alert($("#<% =hidPdtRule.ClientID %>").val());
            if (obj == 1) {
                $("#trPdtBzNum").show();
                $("#trPdtArea").hide();
                $("#trPdtZjNum").hide();
                $("#txtTetraRange1").attr("disabled", "true");
                $("#txtTetraRange2").attr("disabled", "true");

                //失去焦点
                $("#txtBz01").blur(
                    function () {
                        var val01 = $("#txtBz01").val();
                        var val02 = $("#txtBz02").val();
                        var val03 = $("#txtBz03").val();
                        if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                            var v0 = val01 + val02 + val03;
                            //alert(v0);
                            var iisi = pdt2Id_bz(v0);
                            $("#txtTetraRange1").val(iisi);
                        }

                        var val11 = $("#txtBz11").val();
                        var val12 = $("#txtBz12").val();
                        var val13 = $("#txtBz13").val();
                        if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                            var v1 = val11 + val12 + val13;
                            //alert(v1);
                            var iisi1 = pdt2Id_bz(v1);
                            $("#txtTetraRange2").val(iisi1);
                        }

                    }
                    );
                $("#txtBz02").blur(
                   function () {
                       var val01 = $("#txtBz01").val();
                       var val02 = $("#txtBz02").val();
                       var val03 = $("#txtBz03").val();
                       if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                           var v0 = val01 + val02 + val03;
                           //alert(v0);
                           var iisi = pdt2Id_bz(v0);
                           $("#txtTetraRange1").val(iisi);
                       }

                       var val11 = $("#txtBz11").val();
                       var val12 = $("#txtBz12").val();
                       var val13 = $("#txtBz13").val();
                       if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                           var v1 = val11 + val12 + val13;
                           //alert(v1);
                           var iisi1 = pdt2Id_bz(v1);
                           $("#txtTetraRange2").val(iisi1);
                       }

                   }
                   );
                $("#txtBz03").blur(
                   function () {
                       var val01 = $("#txtBz01").val();
                       var val02 = $("#txtBz02").val();
                       var val03 = $("#txtBz03").val();
                       if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                           var v0 = val01 + val02 + val03;
                           //alert(v0);
                           var iisi = pdt2Id_bz(v0);
                           $("#txtTetraRange1").val(iisi);
                       }

                       var val11 = $("#txtBz11").val();
                       var val12 = $("#txtBz12").val();
                       var val13 = $("#txtBz13").val();
                       if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                           var v1 = val11 + val12 + val13;
                           //alert(v1);
                           var iisi1 = pdt2Id_bz(v1);
                           $("#txtTetraRange2").val(iisi1);
                       }

                   }
                   );

                $("#txtBz11").blur(
                 function () {
                     var val01 = $("#txtBz01").val();
                     var val02 = $("#txtBz02").val();
                     var val03 = $("#txtBz03").val();
                     if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                         var v0 = val01 + val02 + val03;
                         //alert(v0);
                         var iisi = pdt2Id_bz(v0);
                         $("#txtTetraRange1").val(iisi);
                     }

                     var val11 = $("#txtBz11").val();
                     var val12 = $("#txtBz12").val();
                     var val13 = $("#txtBz13").val();
                     if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                         var v1 = val11 + val12 + val13;
                         //alert(v1);
                         var iisi1 = pdt2Id_bz(v1);
                         $("#txtTetraRange2").val(iisi1);
                     }

                 }
                 );

                $("#txtBz12").blur(
                 function () {
                     var val01 = $("#txtBz01").val();
                     var val02 = $("#txtBz02").val();
                     var val03 = $("#txtBz03").val();
                     if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                         var v0 = val01 + val02 + val03;
                         //alert(v0);
                         var iisi = pdt2Id_bz(v0);
                         $("#txtTetraRange1").val(iisi);
                     }

                     var val11 = $("#txtBz11").val();
                     var val12 = $("#txtBz12").val();
                     var val13 = $("#txtBz13").val();
                     if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                         var v1 = val11 + val12 + val13;
                         //alert(v1);
                         var iisi1 = pdt2Id_bz(v1);
                         $("#txtTetraRange2").val(iisi1);
                     }

                 }
                 );

                $("#txtBz13").blur(
                 function () {
                     var val01 = $("#txtBz01").val();
                     var val02 = $("#txtBz02").val();
                     var val03 = $("#txtBz03").val();
                     if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                         var v0 = val01 + val02 + val03;
                         //alert(v0);
                         var iisi = pdt2Id_bz(v0);
                         $("#txtTetraRange1").val(iisi);
                     }

                     var val11 = $("#txtBz11").val();
                     var val12 = $("#txtBz12").val();
                     var val13 = $("#txtBz13").val();
                     if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                         var v1 = val11 + val12 + val13;
                         //alert(v1);
                         var iisi1 = pdt2Id_bz(v1);
                         $("#txtTetraRange2").val(iisi1);
                     }

                 }
                 );
            }
            else {
                $("#trPdtBzNum").hide();
                $("#trPdtArea").show();
                $("#trPdtZjNum").show();
                $("#txtTetraRange1").attr("disabled", "true");
                $("#txtTetraRange2").attr("disabled", "true");

                $("#txtDanHu1").blur(
                       function () {
                           var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                           var val = optionsArea.val();
                           var val1 = $("#txtDanHu1").val();
                           if (val1 != "" && !isNaN(val1)) {
                               //去掉字符串前面的0
                               var a = val1.replace(/\b(0+)/gi, "");
                               $("#txtDanHu1").val(a);
                               var len = 5 - a.length;
                               if (len > 0)
                                   for (var i = 0; i < len; i++) {
                                       a = "0" + a;
                                   }
                               var valpdbBz = pdt2Id_zj(val + a);
                               $("#<% =txtTetraRange1.ClientID %>").val(valpdbBz);
                           }

                           //验证单呼范围
                           val1 = $("#txtDanHu1").val();
                           if (val1 != "" && !isNaN(val1)) {
                               if ((val1 >= 1 && val1 <= 29999) || (val1 >= 30020 && val1 <= 32767)) {
                                   $("#spZjDhh").hide();
                               }
                               else {

                                   $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                   $("#spZjDhh").show();

                               }
                           }
                           else {

                               $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                               $("#spZjDhh").show();

                           }

                           //txtTetraRange2的值的获取
                           var val2 = $("#txtDanHu2").val();
                           if (val2 != "" && !isNaN(val2)) {
                               //去掉字符串前面的0
                               a = val2.replace(/\b(0+)/gi, "");
                               $("#txtDanHu2").val(a);
                               len = 5 - a.length;
                               if (len > 0)
                                   for (var i = 0; i < len; i++) {
                                       a = "0" + a;
                                   }
                               valpdbBz = pdt2Id_zj(val + a);
                               $("#<% =txtTetraRange2.ClientID %>").val(valpdbBz);
                           }
                       }
                        );

                       $("#txtDanHu2").blur(
                             function () {
                                 var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                                 var val = optionsArea.val();
                                 var val1 = $("#txtDanHu1").val();
                                 if (val1 != "" && !isNaN(val1)) {
                                     //去掉字符串前面的0
                                     var a = val1.replace(/\b(0+)/gi, "");
                                     $("#txtDanHu1").val(a);
                                     var len = 5 - a.length;
                                     if (len > 0)
                                         for (var i = 0; i < len; i++) {
                                             a = "0" + a;
                                         }
                                     var valpdbBz = pdt2Id_zj(val + a);
                                     $("#<% =txtTetraRange1.ClientID %>").val(valpdbBz);
                                 }


                                 //txtTetraRange2的值的获取
                                 var val2 = $("#txtDanHu2").val();
                                 if (val2 != "" && !isNaN(val2)) {
                                     //去掉字符串前面的0
                                     a = val2.replace(/\b(0+)/gi, "");
                                     $("#txtDanHu2").val(a);
                                     len = 5 - a.length;
                                     if (len > 0)
                                         for (var i = 0; i < len; i++) {
                                             a = "0" + a;
                                         }
                                     valpdbBz = pdt2Id_zj(val + a);
                                     $("#<% =txtTetraRange2.ClientID %>").val(valpdbBz);
                                 }

                                 //验证单呼范围
                                 val2 = $("#txtDanHu2").val();
                                 if (val2 != "" && !isNaN(val2)) {
                                     if ((val2 >= 1 && val2 <= 29999) || (val2 >= 30020 && val2 <= 32767)) {
                                         $("#spZjDhh").hide();
                                     }
                                     else {

                                         $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                         $("#spZjDhh").show();

                                     }
                                 }
                                 else {

                                     $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                     $("#spZjDhh").show();

                                 }
                             }
                        );
                         }
                     }

                     $("document").ready(function () {
                         var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
                         $("#<% =hidPdtRule.ClientID %>").val(pdtRuleVale);
                         // alert($("#<% =hidPdtRule.ClientID %>").val());
                         // alert(pdtRuleVale);
                         if (pdtRuleVale == 1) {
                             //失去焦点
                             $("#txtBz01").blur(
                                 function () {
                                     var val01 = $("#txtBz01").val();
                                     var val02 = $("#txtBz02").val();
                                     var val03 = $("#txtBz03").val();
                                     if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                                         var v0 = val01 + val02 + val03;
                                         //alert(v0);
                                         var iisi = pdt2Id_bz(v0);
                                         $("#txtTetraRange1").val(iisi);
                                     }

                                     var val11 = $("#txtBz11").val();
                                     var val12 = $("#txtBz12").val();
                                     var val13 = $("#txtBz13").val();
                                     if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                                         var v1 = val11 + val12 + val13;
                                         //alert(v1);
                                         var iisi1 = pdt2Id_bz(v1);
                                         $("#txtTetraRange2").val(iisi1);
                                     }

                                 }
                                 );
                             $("#txtBz02").blur(
                                function () {
                                    var val01 = $("#txtBz01").val();
                                    var val02 = $("#txtBz02").val();
                                    var val03 = $("#txtBz03").val();
                                    if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                                        var v0 = val01 + val02 + val03;
                                        //alert(v0);
                                        var iisi = pdt2Id_bz(v0);
                                        $("#txtTetraRange1").val(iisi);
                                    }

                                    var val11 = $("#txtBz11").val();
                                    var val12 = $("#txtBz12").val();
                                    var val13 = $("#txtBz13").val();
                                    if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                                        var v1 = val11 + val12 + val13;
                                        //alert(v1);
                                        var iisi1 = pdt2Id_bz(v1);
                                        $("#txtTetraRange2").val(iisi1);
                                    }

                                }
                                );
                             $("#txtBz03").blur(
                                function () {
                                    var val01 = $("#txtBz01").val();
                                    var val02 = $("#txtBz02").val();
                                    var val03 = $("#txtBz03").val();
                                    if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                                        var v0 = val01 + val02 + val03;
                                        //alert(v0);
                                        var iisi = pdt2Id_bz(v0);
                                        $("#txtTetraRange1").val(iisi);
                                    }

                                    var val11 = $("#txtBz11").val();
                                    var val12 = $("#txtBz12").val();
                                    var val13 = $("#txtBz13").val();
                                    if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                                        var v1 = val11 + val12 + val13;
                                        //alert(v1);
                                        var iisi1 = pdt2Id_bz(v1);
                                        $("#txtTetraRange2").val(iisi1);
                                    }

                                }
                                );

                             $("#txtBz11").blur(
                              function () {
                                  var val01 = $("#txtBz01").val();
                                  var val02 = $("#txtBz02").val();
                                  var val03 = $("#txtBz03").val();
                                  if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                                      var v0 = val01 + val02 + val03;
                                      //alert(v0);
                                      var iisi = pdt2Id_bz(v0);
                                      $("#txtTetraRange1").val(iisi);
                                  }

                                  var val11 = $("#txtBz11").val();
                                  var val12 = $("#txtBz12").val();
                                  var val13 = $("#txtBz13").val();
                                  if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                                      var v1 = val11 + val12 + val13;
                                      //alert(v1);
                                      var iisi1 = pdt2Id_bz(v1);
                                      $("#txtTetraRange2").val(iisi1);
                                  }

                              }
                              );

                             $("#txtBz12").blur(
                              function () {
                                  var val01 = $("#txtBz01").val();
                                  var val02 = $("#txtBz02").val();
                                  var val03 = $("#txtBz03").val();
                                  if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                                      var v0 = val01 + val02 + val03;
                                      //alert(v0);
                                      var iisi = pdt2Id_bz(v0);
                                      $("#txtTetraRange1").val(iisi);
                                  }

                                  var val11 = $("#txtBz11").val();
                                  var val12 = $("#txtBz12").val();
                                  var val13 = $("#txtBz13").val();
                                  if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                                      var v1 = val11 + val12 + val13;
                                      //alert(v1);
                                      var iisi1 = pdt2Id_bz(v1);
                                      $("#txtTetraRange2").val(iisi1);
                                  }

                              }
                              );

                             $("#txtBz13").blur(
                              function () {
                                  var val01 = $("#txtBz01").val();
                                  var val02 = $("#txtBz02").val();
                                  var val03 = $("#txtBz03").val();
                                  if (val01 != "" && val02 != "" && val03 != "" && !isNaN(val01) && !isNaN(val02) && !isNaN(val03)) {
                                      var v0 = val01 + val02 + val03;
                                      //alert(v0);
                                      var iisi = pdt2Id_bz(v0);
                                      $("#txtTetraRange1").val(iisi);
                                  }

                                  var val11 = $("#txtBz11").val();
                                  var val12 = $("#txtBz12").val();
                                  var val13 = $("#txtBz13").val();
                                  if (val11 != "" && val12 != "" && val13 != "" && !isNaN(val11) && !isNaN(val12) && !isNaN(val13)) {
                                      var v1 = val11 + val12 + val13;
                                      //alert(v1);
                                      var iisi1 = pdt2Id_bz(v1);
                                      $("#txtTetraRange2").val(iisi1);
                                  }

                              }
                              );
                         }
                         else {
                             $("#txtDanHu1").blur(
                                      function () {
                                          var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                                          var val = optionsArea.val();
                                          var val1 = $("#txtDanHu1").val();
                                          if (val1 != "" && !isNaN(val1)) {
                                              //去掉字符串前面的0
                                              var a = val1.replace(/\b(0+)/gi, "");
                                              $("#txtDanHu1").val(a);
                                              var len = 5 - a.length;
                                              if (len > 0)
                                                  for (var i = 0; i < len; i++) {
                                                      a = "0" + a;
                                                  }
                                              var valpdbBz = pdt2Id_zj(val + a);
                                              $("#<% =txtTetraRange1.ClientID %>").val(valpdbBz);
                                          }

                                          //验证单呼范围
                                          val1 = $("#txtDanHu1").val();
                                          if (val1 != "" && !isNaN(val1)) {
                                              if ((val1 >= 1 && val1 <= 29999) || (val1 >= 30020 && val1 <= 32767)) {
                                                  $("#spZjDhh").hide();
                                              }
                                              else {

                                                  $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                  $("#spZjDhh").show();

                                              }
                                          }
                                          else {

                                              $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                              $("#spZjDhh").show();

                                          }

                                          //txtTetraRange2的值的获取
                                          var val2 = $("#txtDanHu2").val();
                                          if (val2 != "" && !isNaN(val2)) {
                                              //去掉字符串前面的0
                                              a = val2.replace(/\b(0+)/gi, "");
                                              $("#txtDanHu2").val(a);
                                              len = 5 - a.length;
                                              if (len > 0)
                                                  for (var i = 0; i < len; i++) {
                                                      a = "0" + a;
                                                  }
                                              valpdbBz = pdt2Id_zj(val + a);
                                              $("#<% =txtTetraRange2.ClientID %>").val(valpdbBz);
                                          }
                                      }
                        );

                                      $("#txtDanHu2").blur(
                                            function () {
                                                var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                                                var val = optionsArea.val();
                                                var val1 = $("#txtDanHu1").val();
                                                if (val1 != "" && !isNaN(val1)) {
                                                    //去掉字符串前面的0
                                                    var a = val1.replace(/\b(0+)/gi, "");
                                                    $("#txtDanHu1").val(a);
                                                    var len = 5 - a.length;
                                                    if (len > 0)
                                                        for (var i = 0; i < len; i++) {
                                                            a = "0" + a;
                                                        }
                                                    var valpdbBz = pdt2Id_zj(val + a);
                                                    $("#<% =txtTetraRange1.ClientID %>").val(valpdbBz);
                                                }


                                                //txtTetraRange2的值的获取
                                                var val2 = $("#txtDanHu2").val();
                                                if (val2 != "" && !isNaN(val2)) {
                                                    //去掉字符串前面的0
                                                    a = val2.replace(/\b(0+)/gi, "");
                                                    $("#txtDanHu2").val(a);
                                                    len = 5 - a.length;
                                                    if (len > 0)
                                                        for (var i = 0; i < len; i++) {
                                                            a = "0" + a;
                                                        }
                                                    valpdbBz = pdt2Id_zj(val + a);
                                                    $("#<% =txtTetraRange2.ClientID %>").val(valpdbBz);
                                                }

                                                //验证单呼范围
                                                val2 = $("#txtDanHu2").val();
                                                if (val2 != "" && !isNaN(val2)) {
                                                    if ((val2 >= 1 && val2 <= 29999) || (val2 >= 30020 && val2 <= 32767)) {
                                                        $("#spZjDhh").hide();
                                                    }
                                                    else {

                                                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                        $("#spZjDhh").show();

                                                    }
                                                }
                                                else {

                                                    $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                    $("#spZjDhh").show();

                                                }
                                            }
                        );

                                        }
                     });

                                    function checkTellRule() {

                                        var result = false;
                                        var options = $("#<% =DropDownList_TerminalType.ClientID %> option:selected"); //获取选中的项 
                                        var val = options.val();
                                        if (val == "pleaseSelectTerminalType") {
                                            alert(window.parent.GetTextByName("Lang_pleaseSelectTerminalType", window.parent.useprameters.languagedata));
                                            return false;
                                        }
                                        else if (val == "PDT") {
                                            //PDT终端
                                            var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
                                            if (pdtRuleVale == "2") {
                                                result = true;
                                                //验证单呼范围
                                                var val1 = $("#txtDanHu1").val();
                                                if (val1 != "" && !isNaN(val1)) {
                                                    if ((val1 >= 1 && val1 <= 29999) || (val1 >= 30020 && val1 <= 32767)) {
                                                        $("#spZjDhh").hide();
                                                    }
                                                    else {

                                                        result = false;
                                                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                        $("#spZjDhh").show();

                                                    }
                                                }
                                                else {
                                                    result = false;
                                                    $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                    $("#spZjDhh").show();

                                                }

                                                //验证单呼范围
                                                var val2 = $("#txtDanHu2").val();
                                                if (val2 != "" && !isNaN(val2)) {
                                                    if ((val2 >= 1 && val2 <= 29999) || (val2 >= 30020 && val2 <= 32767)) {
                                                        $("#spZjDhh").hide();
                                                    }
                                                    else {
                                                        result = false;
                                                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                        $("#spZjDhh").show();

                                                    }
                                                }
                                                else {
                                                    result = false;
                                                    $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                                                    $("#spZjDhh").show();

                                                }

                                                //空口范围
                                                var v1 = $("#txtTetraRange1").val();
                                                var v2 = $("#txtTetraRange2").val();
                                                var bhc1 = $("#<% =dropArea.ClientID %> option:selected").val() + $("#txtDanHu1").val().trim();
                                                var bhc2 = $("#<% =dropArea.ClientID %> option:selected").val() + $("#txtDanHu2").val().trim();
                                                if (v1 != "" && v2 != "" && !isNaN(v1) && !isNaN(v2)) {
                                                    //验证是否转换成功
                                                    if (bhc1 == v1 || bhc2 == v2) {
                                                        $("#spIssi").html("<BR/>" + window.parent.GetTextByName("TelNumConvertFail", window.parent.useprameters.languagedata));
                                                        $("#spIssi").show();
                                                        result = false;
                                                    }
                                                    else {

                                                        if ((v1 >= 1048577 && v1 <= 16743880) && (v2 >= 1048577 && v2 <= 16743880)) {
                                                            $("#spIssi").hide();
                                                        }
                                                        else {
                                                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                                                            $("#spIssi").show();
                                                            result = false;
                                                        }

                                                        //范围段验证，一次再多添加1000个号码
                                                        if (v2 < v1) {
                                                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("piliangKSJFW1", window.parent.useprameters.languagedata));
                                                            $("#spIssi").show();
                                                            result = false;
                                                        }
                                                        else {
                                                            if (v2 - v1 > 1000) {
                                                                $("#spIssi").html("<BR/>" + window.parent.GetTextByName("piliangKSJFW2", window.parent.useprameters.languagedata));
                                                                $("#spIssi").show();
                                                                result = false;
                                                            }
                                                            else {
                                                                $("#spIssi").hide();
                                                            }

                                                        }
                                                    }
                                                }
                                                else {
                                                    $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                                                    $("#spIssi").show();
                                                    result = false;
                                                }


                                                if (result) {
                                                    $("#hidNum1").val(id2Pdt_zj($("#txtTetraRange1").val()));
                                                    $("#hidNum2").val(id2Pdt_zj($("#txtTetraRange2").val()));
                                                    $("#hidIssi1").val($("#txtTetraRange1").val());
                                                    $("#hidIssi2").val($("#txtTetraRange2").val());
                                                }
                                            }
                                            else {

                                                //标准PDT
                                                result = true;
                                                var v1 = $("#txtTetraRange1").val();
                                                var v2 = $("#txtTetraRange2").val();
                                                var bhc1 = $("#txtBz01").val().trim() + $("#txtBz02").val().trim() + $("#txtBz03").val().trim();
                                                var bhc2 = $("#txtBz11").val().trim() + $("#txtBz12").val().trim() + $("#txtBz13").val().trim();
                                                if (v1 != "" && v2 != "" && !isNaN(v1) && !isNaN(v2)) {
                                                    if (bhc1 == v1 || bhc2 == v2) {
                                                        //验证是否转换成功
                                                        $("#spIssi").html("<BR/>" + window.parent.GetTextByName("TelNumConvertFail", window.parent.useprameters.languagedata));
                                                        $("#spIssi").show();
                                                        result = false;
                                                    }
                                                    else {

                                                        if ((v1 >= 1048577 && v1 <= 16743880) && (v2 >= 1048577 && v2 <= 16743880)) {
                                                            $("#spIssi").hide();
                                                        }
                                                        else {
                                                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                                                            $("#spIssi").show();
                                                            result = false;
                                                        }


                                                        //范围段验证，一次再多添加1000个号码
                                                        if (v2 < v1) {
                                                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("piliangKSJFW1", window.parent.useprameters.languagedata));
                                                            $("#spIssi").show();
                                                            result = false;
                                                        }
                                                        else {
                                                            if (v2 - v1 > 1000) {
                                                                $("#spIssi").html("<BR/>" + window.parent.GetTextByName("piliangKSJFW2", window.parent.useprameters.languagedata));
                                                                $("#spIssi").show();
                                                                result = false;
                                                            }
                                                            else {
                                                                $("#spIssi").hide();
                                                            }

                                                        }
                                                    }
                                                }
                                                else {
                                                    $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                                                    $("#spIssi").show();
                                                    result = false;
                                                }


                                                if (result) {
                                                    $("#hidNum1").val(id2Pdt_bz($("#txtTetraRange1").val()));
                                                    $("#hidNum2").val(id2Pdt_bz($("#txtTetraRange2").val()));
                                                    $("#hidIssi1").val($("#txtTetraRange1").val());
                                                    $("#hidIssi2").val($("#txtTetraRange2").val());
                                                }
                                            }

                                            return result;
                                        }
                                        else {
                                            //非PDT
                                            result = true;
                                            var v1 = $("#txtTetraRange1").val();
                                            var v2 = $("#txtTetraRange2").val();
                                            if (v1 != "" && v2 != "" && !isNaN(v1) && !isNaN(v2)) {
                                                if ((v1 >= 1 && v1 <= 16744447) && (v2 >= 1 && v2 <= 16744447)) {
                                                    //范围段验证，一次再多添加1000个号码
                                                    if (v2 < v1) {
                                                        $("#spIssi").html("<BR/>" + window.parent.GetTextByName("piliangKSJFW1", window.parent.useprameters.languagedata));
                                                        $("#spIssi").show();
                                                        result = false;
                                                    }
                                                    else {
                                                        if (v2 - v1 > 1000) {
                                                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("piliangKSJFW2", window.parent.useprameters.languagedata));
                                                            $("#spIssi").show();
                                                            result = false;
                                                        }
                                                        else {
                                                            $("#spIssi").hide();

                                                        }

                                                    }
                                                }
                                                else {
                                                    $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                                                    $("#spIssi").show();
                                                    result = false;
                                                }

                                            }
                                            else {
                                                $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                                                $("#spIssi").show();
                                                result = false;
                                            }

                                            if (result) {
                                                $("#hidNum1").val($("#txtTetraRange1").val());
                                                $("#hidNum2").val($("#txtTetraRange2").val());
                                                $("#hidIssi1").val($("#txtTetraRange1").val());
                                                $("#hidIssi2").val($("#txtTetraRange2").val());
                                            }
                                            return result;
                                        }


                                }
    </script>
    <style type="text/css">
        .style6 td {
            background-color: transparent;
        }

        body {
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-color: #9D9D9D;
        }

        .divgrd {
            margin: 2 0 2 0;
            overflow: auto;
            height: 80px;
        }

        #txtBz1 {
            width: 38px;
        }

        #txtBz2 {
            width: 36px;
        }

        #txtBz3 {
            width: 38px;
        }

        #Text1 {
            width: 43px;
        }

        #Text2 {
            width: 47px;
        }

        #Text3 {
            width: 51px;
        }

        #txtBz01 {
            width: 40px;
        }

        #txtBz02 {
            width: 40px;
        }

        #txtBz03 {
            width: 45px;
        }

        #txtBz11 {
            width: 40px;
        }

        #txtBz12 {
            width: 40px;
        }

        #txtBz13 {
            width: 45px;
        }

        #txtDanHu1 {
            width: 86px;
        }

        #txtDanHu2 {
            width: 86px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/001.gif" /><span id="Lang_AddISSIS"><%--批量添加--%></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img style="cursor: hand;" onclick="window.parent.mycallfunction('add_ISSIs')" onmouseover="javascript:this.src='../images/close_un.png';"
                                        onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img src="../images/tab_07.png" width="14" height="32" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" id="dragtd">
                                    <table class="style1" cellspacing="1">
                                        <tr>
                                            <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png); height: 33;">
                                                <div style="background-image: url(../images/add_entity_info.png); width: 132px; height: 23px;">
                                                    <div id="Lang_ISSSInfo" style="margin-left: 28px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <%--终端信息--%>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_TerminalType"></span>&nbsp;&nbsp;
                                         <%--   终端类型--%>
                                            </td>
                                            <td align="left" class="style3" style="display: inline">

                                                <asp:DropDownList ID="DropDownList_TerminalType" runat="server" Width="120px" AppendDataBoundItems="True" DataSourceID="ObjectDataSource4" DataTextField="typeName" DataValueField="typeName" OnDataBound="DropDownList_TerminalType_DataBound">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="GetAllTerminalType" TypeName="DbComponent.ISSI"></asp:ObjectDataSource>
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="DropDownList_TerminalType" Display="None"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr id="trPdtRule" style="display: none;">
                                            <td class="auto-style2" align="right"><span id="Lang_pdtTelRule"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:HiddenField ID="hidPdtRule" runat="server" />
                                                <input id="Radio1" type="radio" checked="checked" onclick="radPdtRuleChange(this.value);" value="1" name="radPdtRule" /><span id="Lang_pdtRuleStand"></span>&nbsp;&nbsp;<input id="Radio2" onclick="    radPdtRuleChange(this.value);" value="2" type="radio" name="radPdtRule" /><span id="Lang_pdtRuleZheJiang"></span>&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr id="trPdtBzNum" style="display: none;">
                                            <td class="auto-style2" align="right"><span id="Lang_pdtTelNumRange"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <input id="txtBz01" type="text" maxlength="3" /><input id="txtBz02" type="text" maxlength="2" /><input id="txtBz03" type="text" maxlength="3" />—<input id="txtBz11" type="text" maxlength="3" /><input id="txtBz12" type="text" maxlength="2" /><input id="txtBz13" type="text" maxlength="3" /></td>
                                        </tr>
                                        <tr id="trPdtArea" style="display: none;">
                                            <td class="auto-style2" align="right"><span id="Lang_pdtArea"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:DropDownList ID="dropArea" runat="server">
                                                    <asp:ListItem Value="581">(581)省厅</asp:ListItem>
                                                    <asp:ListItem Value="582">(582)保留</asp:ListItem>
                                                    <asp:ListItem Value="583">(583)保留</asp:ListItem>
                                                    <asp:ListItem Value="584">(584)保留</asp:ListItem>
                                                    <asp:ListItem Value="585">(585)保留</asp:ListItem>
                                                    <asp:ListItem Value="586">(586)保留</asp:ListItem>
                                                    <asp:ListItem Value="587">(587)保留</asp:ListItem>
                                                    <asp:ListItem Value="588">(588)保留</asp:ListItem>
                                                    <asp:ListItem Value="589">(589)保留</asp:ListItem>
                                                    <asp:ListItem Value="571">(571)杭州</asp:ListItem>
                                                    <asp:ListItem Value="574">(574)宁波</asp:ListItem>
                                                    <asp:ListItem Value="577">(577)温州</asp:ListItem>
                                                    <asp:ListItem Value="573">(573)嘉兴</asp:ListItem>
                                                    <asp:ListItem Value="572">(572)湖州</asp:ListItem>
                                                    <asp:ListItem Value="575">(575)绍兴</asp:ListItem>
                                                    <asp:ListItem Value="579">(579)金华</asp:ListItem>
                                                    <asp:ListItem Value="570">(570)衢州</asp:ListItem>
                                                    <asp:ListItem Value="580">(580)舟山</asp:ListItem>
                                                    <asp:ListItem Value="576">(576)台州</asp:ListItem>
                                                    <asp:ListItem Value="578">(578)丽水</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="trPdtZjNum" style="display: none;">
                                            <td class="auto-style2" align="right"><span id="Lang_pdtSingleTelRange"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <input id="txtDanHu1" type="text" runat="server" />—<input id="txtDanHu2" type="text" runat="server" />
                                                <span id="spZjDhh" style="display: none; color: red;">dd</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right"><span id="Lang_pdtKKHRange"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" valign="top">
                                                <asp:TextBox ID="txtTetraRange1" runat="server" Width="86px"></asp:TextBox>—<asp:TextBox ID="txtTetraRange2" runat="server" Width="86px"></asp:TextBox>
                                                <span id="spIssi" style="display: none; color: red;">DDD</span>
                                                <asp:HiddenField ID="hidNum1" runat="server" />
                                                <asp:HiddenField ID="hidNum2" runat="server" />
                                                <asp:HiddenField ID="hidIssi1" runat="server" />
                                                <asp:HiddenField ID="hidIssi2" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_SubordinateunitsBelong"></span>&nbsp;&nbsp;
                                            <%--所属单位： --%>
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:DropDownList ID="DropDownList1" Width="120px" runat="server" AppendDataBoundItems="True"
                                                    DataSourceID="ObjectDataSource2" DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                    TypeName="DbComponent.Entity">
                                                    <SelectParameters>
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                                 &nbsp; &nbsp; &nbsp; &nbsp;
                                                <asp:CheckBox ID="chkIsExternal" runat="server" Text="外系统" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_Remark"></span>&nbsp;&nbsp;
                                            <%--备注：--%>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtBZ" runat="server" Width="190px" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="ValidatorBZ" runat="server" Display="None"
                                                    ControlToValidate="txtBZ"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="ValidatorBZ"
                                                    Width="150px" HighlightCssClass="cssValidatorCalloutHighlight">
                                                    <Animations>
                                                <OnShow>
                                                    <Sequence>
                                                        <HideAction Visible="true" />
                                                        <FadeIn />
                                                    </Sequence>
                                                </OnShow>
                                                <OnHide>
                                                    <Sequence>
                                                        <FadeOut Duration=".4" />
                                                        <HideAction Visible="false" />
                                                        <StyleAction Attribute="display" Value="none"/>
                                                    </Sequence>
                                                </OnHide>
                                                    </Animations>
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_zhuliuzuBelong"></span>&nbsp;&nbsp;
                                            <%--驻留组：--%>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="0">无</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" valign="top" align="right">
                                                <span id="Lang_saomiaozuBelong"></span>&nbsp;&nbsp;
                                            <%--扫描组：--%><br />
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="30">
                                                                                <img src="images/tab_03.gif" width="15" height="30" />
                                                                            </td>
                                                                            <td background="images/tab_05.gif">
                                                                                <ul class="hor_ul">
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                                                            Width="100px" DataTextField="name" DataValueField="id">
                                                                                            <asp:ListItem Value="0">选择单位</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetAllEntityInfo"
                                                                                            TypeName="DbComponent.Entity">
                                                                                            <SelectParameters>
                                                                                                <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                            </SelectParameters>
                                                                                        </asp:ObjectDataSource>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList4" runat="server">
                                                                                            <asp:ListItem Value="Group_name">组名</asp:ListItem>
                                                                                            <asp:ListItem Value="GSSI">小组标识</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:TextBox ID="TextBox2" runat="server" Width="65px"></asp:TextBox></li>
                                                                                    <li>
                                                                                        <asp:ImageButton ID="Lang_Search" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"
                                                                                            ImageUrl="../images/btn_search.png" OnClick="ImageButton6_Click" /></li>
                                                                                </ul>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_07.gif" width="14" height="30" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" ID="UpdateProgress1" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" /><span id="Lang_UnderOperate">正在处理数据请稍后....</span>
                                                                                    </ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="3" OnRowCommand="GridView1_RowCommand"
                                                                                    OnRowDataBound="GridView1_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton7" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="Group_name" HeaderText="组名" SortExpression="Group_name">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="GSSI" HeaderText="小组标识" SortExpression="GSSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="AllGroupInfocount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                    <SelectParameters>
                                                                                        <asp:Parameter DefaultValue="0" Name="grouptype" Type="Int32" />
                                                                                        <asp:ControlParameter ControlID="DropDownList3" Name="Entity_ID" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="DropDownList4" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="TextBox2" Name="textseach" PropertyName="Text" />
                                                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                    </SelectParameters>
                                                                                </asp:ObjectDataSource>
                                                                            </td>
                                                                            <td width="9" background="images/tab_16.gif">&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="15">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="29">
                                                                                <img src="images/tab_20.gif" width="15" height="29" />
                                                                            </td>
                                                                            <td background="images/tab_21.gif">
                                                                                <asp:Label ID="Label1" runat="server" OnLoad="Label1_Load"><img src="../images/viewinfo_bg.png" /><span id="Lang_AddedSaomiaozu"><%--已添加扫描组…--%></span></asp:Label>
                                                                                <asp:DropDownList ID="DropDownList5" runat="server" Height="16px" Visible="False">
                                                                                    <asp:ListItem Value="0">已添加扫描组</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_22.gif" width="14" height="29" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" valign="top" align="right">
                                                <span id="Lang_multicastgroupBelong"></span>&nbsp;&nbsp;
                                           <%-- 通播组：--%>
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="30">
                                                                                <img src="images/tab_03.gif" width="15" height="30" />
                                                                            </td>
                                                                            <td background="images/tab_05.gif">
                                                                                <ul class="hor_ul">
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList6" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource3"
                                                                                            Width="100px" DataTextField="name" DataValueField="id">
                                                                                            <asp:ListItem Value="0">选择单位</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList7" runat="server">
                                                                                            <asp:ListItem Value="Group_name">组名</asp:ListItem>
                                                                                            <asp:ListItem Value="GSSI">小组标识</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:TextBox ID="TextBox3" runat="server" Width="65px"></asp:TextBox></li>
                                                                                    <li>
                                                                                        <asp:ImageButton ID="Lang_Search2" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"
                                                                                            ImageUrl="../images/btn_search.png" OnClick="ImageButton8_Click" /></li>
                                                                                </ul>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_07.gif" width="14" height="30" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel2" ID="UpdateProgress2" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" />正在处理数据请稍后....
                                                                                    </ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ID="GridView2" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource5" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="3" OnRowCommand="GridView2_RowCommand"
                                                                                    OnRowDataBound="GridView2_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton9" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="Group_name" HeaderText="组名" SortExpression="Group_name">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="GSSI" HeaderText="小组标识" SortExpression="GSSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="AllGroupInfocount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                    <SelectParameters>
                                                                                        <asp:Parameter DefaultValue="1" Name="grouptype" Type="Int32" />
                                                                                        <asp:ControlParameter ControlID="DropDownList6" Name="Entity_ID" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="DropDownList7" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="TextBox3" Name="textseach" PropertyName="Text" />
                                                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                    </SelectParameters>
                                                                                </asp:ObjectDataSource>
                                                                            </td>
                                                                            <td width="9" background="images/tab_16.gif">&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="15">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="29">
                                                                                <img src="images/tab_20.gif" width="15" height="29" />
                                                                            </td>
                                                                            <td background="images/tab_21.gif">
                                                                                <asp:Label ID="Label2" runat="server" OnLoad="Label2_Load"><img src="../images/viewinfo_bg.png" /><span id="Lang_AddedTongbozu">已添加通播组</span>…</asp:Label>
                                                                                <asp:DropDownList ID="DropDownList8" runat="server" Height="16px" Visible="False">
                                                                                    <asp:ListItem Value="0">已添加通播组</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_22.gif" width="14" height="29" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" height="30">
                                    <asp:ImageButton ID="LangConfirm" ImageUrl="../images/add_ok.png" runat="server"
                                        OnClick="ImageButton1_Click" OnClientClick="return checkTellRule();" />&nbsp;&nbsp;&nbsp;
                                <img id="Lang-Cancel" style="cursor: hand;" onclick="window.parent.mycallfunction('add_ISSIs')"
                                    src="../images/add_cancel.png" />
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="15">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="15">
                                    <img src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1">&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14">
                                    <img src="../images/tab_22.png" width="14" height="15" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript">
        //function DropDownList_TerminalType_selectChanged() {
        //    var Tbody1 = document.getElementById("Tbody1");
        //    for (var i = 0; i < Tbody1.children.length; i++) {
        //        Tbody1.removeChild(Tbody1.children[i]);
        //    }

        //    ISSIs.length = 0;
        //    $("#HiddenField1").attr("value", "");
        //}
    </script>
</body>
</html>
<script type="text/javascript">
    var Lang_SubmitFirst = window.parent.GetTextByName("Lang_SubmitFirst", window.parent.useprameters.languagedata);
    var Lang_ISSSMustInt = window.parent.GetTextByName("Lang_ISSSMustInt", window.parent.useprameters.languagedata);
    var Lang_ISSSsIdRange = window.parent.GetTextByName("Lang_ISSSsIdRange", window.parent.useprameters.languagedata);
    var Lang_BeginCantLessEnd = window.parent.GetTextByName("Lang_BeginCantLessEnd", window.parent.useprameters.languagedata);
    var Lang_OnelinecantMore100 = window.parent.GetTextByName("Lang_OnelinecantMore100", window.parent.useprameters.languagedata);
    var Lang_hasRepeat = window.parent.GetTextByName("Lang_hasRepeat", window.parent.useprameters.languagedata);
    var Lang_ISSSHasExistInRange = window.parent.GetTextByName("Lang_ISSSHasExistInRange", window.parent.useprameters.languagedata);
    var Lang_ipAddressParttenIsNotValidate = window.parent.GetTextByName("Lang_ipAddressParttenIsNotValidate", window.parent.useprameters.languagedata);

    // var ISSIs = [];
    //var terminalTypeSelect = document.getElementById("DropDownList_TerminalType");
    //terminalTypeSelect.onchange = function () {
    //    DropDownList_TerminalType_selectChanged();
    //}
    window.parent.closeprossdiv();
    //function createtr() {

    //    var tr = document.getElementById("pretr");
    //    if (tr) {
    //        alert(Lang_SubmitFirst);
    //        return;
    //    }

    //        //if(terminalTypeSelect && terminalTypeSelect.value.trim() == "LTE"){
    //        //    $("#Tbody1").prepend("<tr id='pretr' style='font-size:12px;background-color:#FFFFFF;Height:20px;'><th scope='col' > " + window.parent.GetTextByName("Lang_ISSS", window.parent.useprameters.languagedata) + "&nbsp;&nbsp;<input id='tdText1'  type='text' style='width:60px' maxlength='16' />&nbsp;&nbsp;IP  <input  style='width:60px'  id='tdText2' type='text' maxlength='15' /></th><th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'><a onclick='insertLine()'><img src='images/001.gif' /> <font title='" + window.parent.GetTextByName("Lang_Submit", window.parent.useprameters.languagedata) + "' color='black'></font></a></th></tr>");
    //        //}
    //        //else{
    //        $("#Tbody1").prepend("<tr id='pretr' style='font-size:12px;background-color:#FFFFFF;Height:20px;'><th scope='col' > " + window.parent.GetTextByName("Lang_ISSS", window.parent.useprameters.languagedata) + "&nbsp;&nbsp;<input id='tdText1'  type='text' style='width:60px' maxlength='16' /> — <input  style='width:60px'  id='tdText2' type='text' maxlength='16' /></th><th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'><a onclick='insertLine()'><img src='images/001.gif' /> <font title='" + window.parent.GetTextByName("Lang_Submit", window.parent.useprameters.languagedata) + "' color='black'></font></a></th></tr>");
    //        //}

    //}
    //var tbdiv = document.getElementById("tbtbz");
    //if (tbdiv) {
    //    tbdiv.onmouseout = function () {
    //        dragEnable = 'True';
    //    }
    //    tbdiv.onmouseover = function () {
    //        dragEnable = 'False';
    //    }
    //}
    //function insertLine() {
    //    var num1 = $("#tdText1").val();
    //    var num2 = $("#tdText2").val();

    //    //if (terminalTypeSelect && terminalTypeSelect.value.trim() == "LTE") {
    //    //    //num1为ISSI,num2为IP
    //    //    if (ValiateInt(num1) == false) {      //判断为数字
    //    //        alert(Lang_ISSSMustInt);
    //    //        return;
    //    //    }
    //    //    if (num1 < 1 || num1 > 9999999999999999) {
    //    //        alert(Lang_ISSSsIdRange2);
    //    //        return;
    //    //    }
    //    //    if (window.parent.isinarray(num1.toString(), ISSIs)) {
    //    //        alert(Lang_hasRepeat);   //判断范围是否重复
    //    //        return;
    //    //    }
    //    //    var reg = checkIpPartten(num2);
    //    //    if (reg == null) {
    //    //        alert(Lang_ipAddressParttenIsNotValidate);   //判断Ip格式是否正确
    //    //        return;
    //    //    }

    //    //    var param = { "num1": num1, "num2": num1 };
    //    //    window.parent.jquerygetNewData_ajax("../../WebGis/Service/ISSIsAllreadyin.aspx", param, function (request) {
    //    //        var intreturn = parseInt(request);
    //    //        if (intreturn > 0) {
    //    //            alert(Lang_ISSSHasExistInRange);   //判断范围是否重复
    //    //        }
    //    //        else {                    
    //    //            createline();
    //    //        }

    //    //    }, false, false);

    //    //}
    //    //else {
    //        if (ValiateInt(num1) == false || ValiateInt(num2) == false) {      //判断为数字
    //            alert(Lang_ISSSMustInt);
    //            return;
    //        }
    //        if (num1 < 1 || num1 > 9999999999999999 || num2 < 1 || num2 > 9999999999999999) {
    //            alert(Lang_ISSSsIdRange2);
    //            return;
    //        }
    //        if (parseFloat(num1) > parseFloat(num2)) {  //判断数值2大于等于数值1
    //            alert(Lang_BeginCantLessEnd);
    //            return;
    //        }
    //        if (parseFloat(num2) - parseFloat(num1) >= 100) {  //判断数值2大于等于数值1
    //            alert(Lang_OnelinecantMore100);
    //            return;
    //        }

    //        for (var i = num1; i <= num2; i++) {

    //            if (window.parent.isinarray(i.toString(), ISSIs)) {
    //                alert(Lang_hasRepeat);   //判断范围是否重复
    //                return;
    //            }
    //        }

    //        var param = { "num1": num1, "num2": num2 };
    //        window.parent.jquerygetNewData_ajax("../../WebGis/Service/ISSIsAllreadyin.aspx", param, function (request) {
    //            var intreturn = parseInt(request);
    //            if (intreturn > 0) {
    //                alert(Lang_ISSSHasExistInRange);   //判断范围是否重复
    //            }
    //            else {
    //                createline();
    //            }

    //        }, false, false);
    //    //}
    //}
    //function createline() {
    //    var num1 = $("#tdText1").val();
    //    var num2 = $("#tdText2").val();
    //    $("#pretr").remove();
    //    //if (terminalTypeSelect && terminalTypeSelect.value.trim() == "LTE") {
    //    //    $("#Tbody1").prepend("<tr id=" + num1 + "  style='font-size:12px;background-color:#FFFFFF;'><th scope='col'style='font-weight:normal;color:black;Height:20px;' > " + num1 + "&nbsp;&nbsp;&nbsp;&nbsp;IP&nbsp; " + num2 + " </th><th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'><a onclick=removeLine(" + num1 + "," + num1 + ") ><img src='images/083.gif' /> <font title='" + window.parent.GetTextByName("Delete", window.parent.useprameters.languagedata) + "' id='Lang_Delete' color='black'></font></a></th></tr>");

    //    //    ISSIs.push((num1 + "|" + num2).toString());

    //    //}
    //    //else {
    //        $("#Tbody1").prepend("<tr id=" + num1 + "  style='font-size:12px;background-color:#FFFFFF;'><th scope='col'style='font-weight:normal;color:black;Height:20px;' > " + num1 + " — " + num2 + " </th><th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'><a onclick=removeLine(" + num1 + "," + num2 + ") ><img src='images/083.gif' /> <font title='" + window.parent.GetTextByName("Delete", window.parent.useprameters.languagedata) + "' id='Lang_Delete' color='black'></font></a></th></tr>");
    //        for (var i = num1; i <= num2; i++) {
    //            ISSIs.push(i.toString());
    //        }

    //    //}

    //    var issivalue = "";
    //    for (var n = 0; n < ISSIs.length; n++) {
    //        issivalue += (n == 0) ? ISSIs[n] : "," + ISSIs[n];
    //    }
    //    $("#HiddenField1").attr("value", issivalue);
    //}
    //function removeLine(num1, num2) {
    //    $("#" + num1).remove();
    //    for (var i = num1; i <= num2; i++) {
    //        ISSIs.splice(window.parent.indeofarray(i.toString(), ISSIs), 1);
    //    }
    //    var issivalue = "";
    //    for (var n = 0; n < ISSIs.length; n++) {
    //        issivalue += (n == 0) ? ISSIs[n] : "," + ISSIs[n];
    //    }

    //    $("#HiddenField1").attr("value", issivalue);
    //}
    //function checkIpPartten(ip){
    //    var exp = "^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$";
    //        //"(\\d+).(\\d+).(\\d+).(\\d+)";

    //    var re = new RegExp(exp);
    //    var reg = ip.match(re);

    //    return reg;
    //}

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
