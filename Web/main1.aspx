<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian1.aspx.cs" Inherits="Web.mian1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <style type="text/css">
        v\:* {
            behavior: url(#default#VML);
            position: absolute;
        }

        o\:* {
            behavior: url(#default#VML);
        }

        v\:shape {
            behavior: url(#default#VML);
        }
    </style>
    <%--邮件菜单样式--%>
    <style type="text/css">
        html, body, #map {
                margin: 0;
                width: 100%;
                height: 100%;
            }

        body, div, ul, li {
            margin: 0;
            padding: 0;
        }

        body {
            font: 12px/1.5 \5fae\8f6f\96c5\9ed1;
        }

        ul {
            list-style-type: none;
        }

        #policemouseMenu, #policemouseMenu_invalide, #groupmouseMenu, #dispatchmouseMenu, #carDutyMenu {
            position: absolute;
            top: -9999px;
            left: -9999px;
            z-index: 22;
        }

            #policemouseMenu ul, #policemouseMenu_invalide ul, #groupmouseMenu ul, #dispatchmouseMenu ul, #carDutyMenu ul {
                float: left;
                border: 1px solid #979797;
                background: #f1f1f1 url(Images/line.png) 24px 0 repeat-y;
                padding: 2px;
                box-shadow: 2px 2px 2px rgba(0,0,0,.6);
            }

                #policemouseMenu ul li, #policemouseMenu_invalide ul li, #groupmouseMenu ul li, #dispatchmouseMenu ul li, #carDutyMenu ul li {
                    float: left;
                    clear: both;
                    height: 24px;
                    cursor: pointer;
                    line-height: 24px;
                    white-space: nowrap;
                    padding: 0 30px;
                }

                    #policemouseMenu ul li.sub, #policemouseMenu_invalide ul li.sub, #groupmouseMenu ul li.sub, #dispatchmouseMenu ul li.sub, #carDutyMenu ul li.sub {
                        background-repeat: no-repeat;
                        background-position: right 9px;
                        background-image: url(Images/arrow.png);
                    }

                    #policemouseMenu ul li.active, #policemouseMenu_invalide ul li.active, #groupmouseMenu ul li.active, #dispatchmouseMenu ul li.active, #carDutyMenu ul li.active {
                        background-color: #f1f3f6;
                        border-radius: 3px;
                        border: 1px solid #aecff7;
                        height: 22px;
                        line-height: 22px;
                        background-position: right -8px;
                        padding: 0 29px;
                    }

                #policemouseMenu ul ul, #policemouseMenu_invalide ul ul, #groupmouseMenu ul ul, #dispatchmouseMenu ul ul, #carDutyMenu ul ul {
                    display: none;
                    position: absolute;
                }

        #MSN {
            position: absolute;
            z-index: 99;
            width: 320px;
            height: 20px;
            bottom: 5px;
            font-size: 12px;
            color: White;
        }

            #MSN ul {
                margin-top: 5px;
                text-align: center;
                list-style: none;
            }

        #scrollarea {
            margin-left: 5px;
            width: 320px;
            text-align: left;
        }
    </style>

    <link href="CSS/OpenLayers/ol.css" rel="stylesheet" />
    <script src="JS/OpenLayers/ol-debug.js" type="text/javascript"></script>

    <link href="CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="CSS/lq_style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/smartMenu.css" type="text/css" />
    <script src="lqnew/js/StringPrototypeFunction.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="pro_dropdown_2/pro_dropdown_2.css" />
    <script src="lqnew/js/GlobalVar.js" type="text/javascript"></script>
    <script src="MyCommonJS/addAll.js" type="text/javascript"></script>
    <script src="JS/addAll.js" type="text/javascript"></script>
    <script src="lqnew/js/PointIn.js" type="text/javascript"></script>
    <script src="lqnew/js/Stockade.js" type="text/javascript"></script>
    <script src="lqnew/js/DrawPolygon.js" type="text/javascript"></script>
    <script src="lqnew/js/BaseStation.js" type="text/javascript"></script>
    <script src="lqnew/js/PoliceStation.js" type="text/javascript"></script>
    <script src="lqnew/js/List.js" type="text/javascript"></script>
    <script src="lqnew/js/DefaultJS.js" type="text/javascript"></script>
    <script src="lqnew/js/DrawOval.js" type="text/javascript"></script>
    <script src="lqnew/js/PlayerJS.js" type="text/javascript"></script>
    <script src="lqnew/js/GlobalConst.js" type="text/javascript"></script>
    <script src="WebGis/js/model/ReplaceJQ.js" type="text/javascript"></script>
    <script src="../lqnew/js/Cookie.js" type="text/javascript"></script>
    <script src="../lqnew/js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../lqnew/js/Dragobj.js" type="text/javascript"></script>
    <script src="lqnew/js/LogModule.js" type="text/javascript"></script>
    <script type="text/javascript" src="SWF/swfobject.js"></script>
    <script src="JS/map.js" type="text/javascript"></script>
    <script src="JS/EzMapAPI.js" type="text/javascript"></script>
    <script src="JS/video.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
     <div id="map" style="width: 100%; height:1024px;border-bottom:solid"></div>
   
    </form>
    <script type="text/javascript">


        // 自定义分辨率和瓦片坐标系
        var resolutions = [];
        var maxZoom = 10;

        for (var i = 0; i <= maxZoom; i++) {
            resolutions[i] = Math.pow(2, maxZoom - i);
        }

        var center = ol.proj.transform([119.9143982, 30.4486737], 'EPSG:4326', 'EPSG:3857');

        var osmSource = new ol.source.XYZ({
            wrapX: false,
            //tileGrid: tilegrid,
            tileSize: 200,
            tileUrlFunction: function (tileCoord) {  // 参数tileCoord为瓦片坐标
                var z = tileCoord[0];
                var x = tileCoord[1] + 1;
                var y = (-tileCoord[2]);
                return 'http://10.8.59.197:8081/Normal/' + z + '/' + y + '_' + x + '.png'
            }
        });
        // 添加一个使用离线瓦片地图的层
        var offlineMapLayer = new ol.layer.Tile({

            source: osmSource
        });
        //创建地图
        var map = new ol.Map({
            view: new ol.View({
                //extent: [30.4486737, 29.9751599, 120.4637146, 29.9751599],
                origin: center,
                //projection: 'EPSG:4326',
                center: center,
                zoom: 1,
                minZoom: 1,
                maxZoom: 10,
                maxResolution:40075016.68557849 /200,
                minResolution:40075016.68557849 /200/Math.pow(2, 10)


            }),
            // 在默认控件的基础上，再加上其他内置的控件
            controls: ol.control.defaults().extend([
                new ol.control.MousePosition(),
                new ol.control.ScaleLine(),
                new ol.control.ZoomSlider(),
            ]),
            target: 'map'
        });

        var policeLayer = new ol.layer.Vector({
            wrapX: false,
            source: new ol.source.Vector()
        })
        
       //调试代码
        var offlineMapStreet = new ol.layer.Tile({
            source: new ol.source.TileDebug({
                projection: 'EPSG:4326',
                tileGrid: osmSource.getTileGrid()
            })
        });

        map.addLayer(offlineMapLayer);

        map.addLayer(offlineMapStreet);

        // 添加一个空心的五星
        var star = new ol.Feature({
           
            geometry: new ol.geom.Point(ol.proj.transform([120.1358950, 30.1819968], 'EPSG:4326', 'EPSG:3857'))
        });
        star.setStyle(new ol.style.Style({
            image: new ol.style.RegularShape({
                points: 5,
                radius1: 20,
                radius2: 10,
                stroke: new ol.style.Stroke({
                    color: 'red',
                    size: 2
                })
            })
        }));

        policeLayer.getSource().addFeature(star);
        map.addLayer(policeLayer);

</script>

</body>
</html>
