/**
 *Description��EzServerClient�����ĵ�����
 */
 /*
 *Description:��������ĵ������õ�ȫ����
 */
if(typeof EzServerClient == "undefined" || !EzServerClient)var EzServerClient = {};
 /*
 *Description:��������ĵ������õ�ȫ�ֱ���
 */
EzServerClient.GlobeParams = {};


/**********************************************************************************/
/*************************����ΪEzServer Client���ò�������*************************/
/**********************************************************************************/
/**
 *����˵��������ͼͼƬ�����ַ����ά����ڶ����У�[][0]ָͼƬ����������;[][1])ָͼƬ��������ַ;[][2]ָ������[][1]֮�µ�ͼƬ��������ַ��[][2]��ʡ�ԣ�
 *�������ͣ�{[][(2|3)][]String} String���͵�n*(2|3)*n����ά����
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
//EzServerClient.GlobeParams.MapSrcURL = [["ʸ����ͼ", ["http://10.52.2.238:9080/PGIS_S_TileMapServer/Maps/default"]],
//										["Ӱ���ͼ", ["http://10.52.2.238:9080/PGIS_S_TileMapServer/Maps/sm"]],
//										["ʸ�����ӵ�ͼ", ["http://10.52.2.238:9080/PGIS_S_TileMapServer/Maps/slyx"]]];
EzServerClient.GlobeParams.MapSrcURL = [["ʸ����ͼ", ["http://10.79.1.96:9080/PGIS_S_TileMapServer/Maps/default"]],
										["Ӱ���ͼ", ["http://10.79.1.96:9080/PGIS_S_TileMapServer/Maps/sm"]],
										["ʸ�����ӵ�ͼ", ["http://10.79.1.96:9080/PGIS_S_TileMapServer/Maps/RV"]]];
//EzServerClient.GlobeParams.MapSrcURL = [["ʸ�����ӵ�ͼ",["http://192.168.10.14:701/EzServer_DF_SLYX"],["http://192.168.10.14:701/EzServer_DF_YX"]]];
//http://192.168.10.241:9080/EzServerV634/Maps/map-jw-china
//http://192.168.10.241:9080/EzServerV634/Maps/BJ_Geog
//http://192.168.10.142:10000/EzServer6/Maps/EzMapAggr
/*********************
 *�ϱ߱����е�[][1]��[][2]�������ö��ͼƬ��Դ��ַ����ͼƬ�����ڼ�Ⱥ���Լ���ͼƬ��������������EzServerClient.GlobeParams.MapSrcURL= [["ʸ��Ӱ��",["http://192.168.10.3/EzServer","http://192.168.10.4/EzServer"]]];
**********************/

/**
 *����˵�������ð�Ȩ��Ϣ
 *�������ͣ�{String}
 *ȡֵ��Χ��������
 *Ĭ��ֵ��""
 *����������������ʾ
 */
EzServerClient.GlobeParams.Copyright = "&copy; 2010 PGIS";	

/**
 *����˵�������ð汾��Ϣ
 *�������ͣ�{Float}
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.Version = 0.3;


/**
 *����˵��������ȫͼ��ʾʱ��ͼ��ʾ��Χ
 *�������ͣ�{[4]Float} ����Ϊ4��Float��������
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapFullExtent = [116.67871,34.47558,117.97167,35.35058];
//EzServerClient.GlobeParams.MapFullExtent = [13225108.33007,4493646.95507,13458090.67382,4740966.67382];

/**
 *����˵�������õ�ͼ��ʼ��ʾ����
 *�������ͣ�{Float}
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapInitLevel = 10;

/**
 *����˵�������õ�ͼ��ʾ����󼶱�
 *�������ͣ�{Float}
 *ȡֵ��Χ��[0,20]
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapMaxLevel = 19;

/**
 *����˵�������õ�ͼ�����ƫ��������Ϊ����������ǰ�����ʵ�ʼ���=��ǰ����+EzServerClient.GlobeParams.ZoomOffset��
 *�������ͣ�{Float}
 *ȡֵ��Χ��������
 *Ĭ��ֵ��0
 *����������������ʾ
 */
EzServerClient.GlobeParams.ZoomOffset = 0;

/**
 *����˵����������Դ��ͼͼƬ��С������ͼƬ��Դ�������ṩͼƬ�Ĵ�С������
 *�������ͣ�{Int}
 *ȡֵ��Χ��128|256
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapUnitPixels = 256;

/**
 *����˵�������õ�ͼ����ϵ���ͣ���γ������ϵΪ1���ط�����ʱΪEzServerClient.GlobeParams.MapConvertScale���趨��ֵ
 *�������ͣ�{Int}
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapCoordinateType = 1;
//EzServerClient.GlobeParams.MapCoordinateType = 114699;

/**
 *����˵�������õط�����ϵ���ű�����������ͼʱ��������ֵ�趨��ֵ��
 *�������ͣ�{Int}
 *ȡֵ��Χ��������
 *Ĭ��ֵ��114699
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapConvertScale = 114699;

/**
 *����˵�������õط�����ϵX��ƫ��������ʱ��������ͼʱ��������ֵ�趨��ֵ��
 *�������ͣ�{Int}
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapConvertOffsetX = 0;
/**
 *����˵�������õط�����ϵY��ƫ��������ʱ��������ͼʱ��������ֵ�趨��ֵ��
 *�������ͣ�{Int}
 *ȡֵ��Χ��������
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapConvertOffsetY = 0;


/**
 *����˵�������õ�ͼͼƬ�Ƿ����
 *�������ͣ�{Boolean}
 *ȡֵ��Χ��true|false
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.IsOverlay = true;

/**
 *����˵�������������ͼͼƬ��Դ�Ƿ�ͨ������
 *�������ͣ�{Boolean}
 *ȡֵ��Χ��true|false
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.MapProx = false;

/**
 *����˵��������EzServerClient���õ�ַ
 *�������ͣ�{String}
 *ȡֵ��Χ����
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.EzServerClientURL = "http://10.52.2.238:9080/PGIS_S_TileMap";

/**
 *����˵���������Ҫ���ÿռ�ʸ�����ݷ�������Ҫ��������Ĭ��EzMapService�����õ�ַ���й�EzMapService����Ľ��������EzMapService���йؽ��ܣ���ѡ���ã�
 *�������ͣ�{String}
 *ȡֵ��Χ����
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.EzMapServiceURL = "http://10.52.2.242:8889/PGIS_S_Map";	/**http://10.52.2.238:9080/PGIS_S_Map*/

/**
 *����˵���������Ҫ���õ������������Ҫ��������Ĭ��EzGeographicProcessingService���õ�ַ���й�EzGeographicProcessingService����Ľ��������EzGeographicProcessingService���йؽ��ܣ���ѡ���ã�
 *�������ͣ�{String}
 *ȡֵ��Χ����
 *Ĭ��ֵ����
 *����������������ʾ
 */
EzServerClient.GlobeParams.EzGeoPSURL = "http://192.168.10.183:10000/EzGeographicProcessingService";	

/**
 *����˵�������õ�ͼ�����߼����ǽ���������ģ��Լ����õ���ʲô�汾��ͼ
 *�������ͣ�{Int}
 *ȡֵ��Χ��{0,1,2,3}
 *Ĭ��ֵ��2
 *����������������ʾ
 */
EzServerClient.GlobeParams.ZoomLevelSequence = 2;
//EzServerClient.GlobeParams.ZoomLevelSequence = 0;// ��ͼ�ȼ����ͻ������򣬷�����������
//EzServerClient.GlobeParams.ZoomLevelSequence = 1;// ��ͼ�ȼ����ͻ��˽��򣬷�����������
//EzServerClient.GlobeParams.ZoomLevelSequence = 2;// ��ͼ�ȼ����ͻ��˽��򣬷������˽���
//EzServerClient.GlobeParams.ZoomLevelSequence = 3;// ��ͼ�ȼ����ͻ������򣬷������˽���
/**********************************************************************************/
/************************************�������ý���***********************************/
/**********************************************************************************/


/**
 *�ַ������ã�Ĭ������"�ַ���ΪGB2312"�����������"�ַ���ΪUTF-8"����"�ַ���ΪUTF-8"�򿪣�ע��"�ַ���ΪGB2312"����
 */
/**********************************�ַ���ΪGB2312***********************************/
//����EzServerClient6.js�ű�
//document.writeln("<script type='text/javascript' charset='GB2312' src='/Pjs/EzServerClient6.js'></script>");
// ����EzServer.css��ʽ��
//document.writeln("<LINK type='text/css' charset='GB2312' rel='stylesheet' href='" + EzServerClient.GlobeParams.EzServerClientURL + "/css/EzServer.css'>");
// ��������˵��������EzGeographicProcessingService��ͨ������������ؽű�
//document.writeln("<script type='text/javascript' charset='GB2312' src='" + EzServerClient.GlobeParams.EzGeoPSURL + "/ezgeops_js/EzGeoPS.js'></script>");

/**********************************�ַ���ΪUTF-8***********************************/
/*
// ����EzServerClient6.js�ű�
document.writeln("<script type='text/javascript' charset='UTF-8' src='" + EzServerClient.GlobeParams.EzServerClientURL + "/js_UTF-8/EzServerClient6.js'></script>");
// ����EzServer.css��ʽ��
document.writeln("<LINK charset='GB2312' href='" + EzServerClient.GlobeParams.EzServerClientURL + "/css/EzServer_UTF-8.css' type='text/css' rel='stylesheet'>");
// ��������˵��������EzGeographicProcessingService��ͨ������������ؽű�
document.writeln("<script type='text/javascript' charset='GB2312' src='" + EzServerClient.GlobeParams.EzGeoPSURL + "/ezgeops_js/EzGeoPS.js'></script>");
*/