/**
 * 用户编号(个呼号码，组呼号码）和空中接口地址的转化
 */

/**默认不写num,转为10进制
 * 
 * @param {Object} str1 待转数
 * @param {Object} num 进制
 * @return {TypeName} 
 */
	function parseIntDefault10(str1,num){
		if(num==null||num==""){return parseInt(str1,10);}
		else{return parseInt(str1,num);};
	} 
/**
 * 标准转换
 * @param pdt2Id
 * @return
 */
	function pdt2Id_bz(pdtId){
		var idString = pdtId;
		var np = parseIntDefault10(pdtId.substring(0, 3));//区号
		var fin = parseIntDefault10(pdtId.substring(3, 5));//组呼队号
		var rin = parseIntDefault10(pdtId.substring(5, 8));//组呼号
		var id = parseIntDefault10(pdtId);		
		if(np >= 328 && np <= 806){
	        if(fin >= 20 && fin <= 41){
	           if(rin >= 200 && rin <= 899){
	             id = (np - 328)*parseIntDefault10("8000",16) + (fin - 20)*700 + (rin - 200) + parseIntDefault10("100001",16);
	             idString = id;
	           }
	        }
	        if(fin >= 42 && fin <= 89){
	           if(rin >= 200 && rin <= 549){
	            id = (np - 328)*parseIntDefault10("8000",16) + (fin - 42)*350 + (rin - 200) + parseIntDefault10("103C29",16);
	            idString = id;
	           }
	        }
	      }
		return idString;
		
	}
	
/**
 * 标准反转
 * @param id2pdt
 * @return
 */
	function id2Pdt_bz( idString){
			var pdtString = idString;
		   if(idString!=""){
		   var id = parseIntDefault10(idString);
		   if(id >= 1 && id <= 16744447){
		        var nai,np,fin = 0,rin = 0;
				var temp1,temp2,temp3;
				nai = id >> 15;
				np = nai + 296;
				temp1 = (np -328) << 15;
				temp2 = id - temp1;
				if(temp2 < 0x100001){
					//pdtString = "cant transform";
					return pdtString+"";
				}else if(temp2 < 0x103c29){
					temp3 = temp2 - 0x100001;
					fin = temp3 / 700;
					fin += 20;
					rin = temp3 % 700;
					rin += 200;
				}else{
					temp3 = temp2 - 0x103c29;
					fin = temp3 / 350;
					fin += 42;
					rin = temp3 % 350;
					rin += 200;
				}
					var npValue = np;
					var finValue =  Math.floor(fin);
					var rinValue = rin;
							if(npValue >= 328 && npValue <= 806 && finValue >=20 &&finValue <= 89 && rinValue >= 200 && rinValue <= 899){
							  pdtString = np+""+Math.floor(fin)+""+rin;//转成String
							}else{
								//pdtString = "cant transform";
							}
		   }else{
			   //pdtString = "cant transform";
		   }
		  }
		return pdtString+"";
		
	}
	
/**
 * 浙江标准	
 * @param pdtId
 * @return
 */
	function pdt2Id_zj(pdtId){
		var idString = pdtId;
		var np = parseIntDefault10(pdtId.substring(0, 3));//区号
		var in_s = pdtId.substring(3, 8);
		var rin = parseIntDefault10(in_s);//组呼号
		var id = parseIntDefault10(pdtId);		
		if(in_s != null && ((rin >=1 && rin <=29999) || (rin >=30020 && rin <=32767))){
				id =(np-296)*parseIntDefault10("8000",16) + rin;
				idString = id+"";
			 }
		return idString;
		
	}
	
/**
 * 浙江标准反转	
 * @param Id2pdt
 * @return
 */
	function id2Pdt_zj(idString){
		 var pdtReturn = idString;
		 var pdtString = "";
		  if(idString!=""){
		 var id = parseIntDefault10(idString);	   
	     pdtString =  id%parseIntDefault10("8000",16)+"";//单呼号码赋值
	     for(var i=pdtString.length;i<5;i++){
	    	 pdtString = "0"+pdtString;
	     }
	     	var a = id >> 15;
	     	var npTypeValue = a+296;
	     	pdtReturn = npTypeValue+""+ pdtString;
	     }
		return pdtReturn+"";
		
	}

	
/*********************************************************************************************************
	******************************************************************************************************
	******************************************************************************************************
									通话组转码
	******************************************************************************************************
	*******************************************************************************************************/
	
//部级区号

var ministerialCodeArray = [804];

//省级区号

var provincialCodeArray = [800,360,328,623,334,348,390,422,430,450,480,520,540,560,581,590,720,740,667,780,789,620,485,640,380,700,400,495,702,440,670,656,658,585];

//市级区号

var MunicipalAreaCode = [801,802,803,361,362,363,329,330,331,624,625,626,336,337,338,339,340,341,342,343,344,345,335,351,349,352,353,354,355,356,357,358,359,350,371,

                         372,373,374,375,376,377,378,379,391,370,392,393,394,395,396,398,420,410,411,412,413,414,415,416,417,418,419,421,427,429,431,432,433,434,435,

                         436,437,438,439,451,452,453,454,455,456,457,459,464,467,458,468,469,471,472,473,474,475,476,477,478,479,470,482,483,525,510,511,512,513,514,

                         515,516,517,518,519,523,527,531,532,533,534,535,536,537,538,539,530,543,546,631,632,633,634,635,551,552,553,554,555,556,557,558,567,559,550,

                         561,562,563,564,565,566,571,572,573,574,575,576,577,578,579,570,580,591,592,593,594,595,596,597,598,599,721,710,711,712,713,714,715,716,717,

                         718,719,722,724,726,727,728,731,732,733,734,735,736,737,738,739,730,743,744,745,746,666,660,662,663,668,750,751,752,753,754,755,756,757,758,

                         759,760,762,763,766,768,769,771,772,773,774,775,776,777,778,779,770,781,782,783,784,791,701,792,793,794,795,796,797,798,799,790,600,601,602,

                         603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,621,486,487,488,489,490,491,492,493,494,641,691,692,642,643,644,645,646,

                         647,648,649,650,651,652,653,654,381,382,383,384,385,386,387,696,697,698,401,402,403,404,405,406,407,408,409,399,496,497,498,499,500,501,502,

                         503,504,505,506,507,508,509,703,704,705,706,707,441,442,443,444,445,446,447,448,449,671,672,673,674,675,676,677,678,679,680,681,682,683,684,

                         685,686,657,659,586,587,588];

//数组判断是否包含某一元素

Array.prototype.Contains = function(element) {

    for (var i = 0; i < this.length; i++) {

        if (this[i] == element) {

            return true;

        }

    }

    return false;

};


/**
 * 通话组国标转及反转
 */
	function group_marks_to_id_bz(pdtId){
	    var np = parseIntDefault10(pdtId.substring(0, 3));
	    var fgn =  parseIntDefault10(pdtId.substring(3, 5));
	    var gn = parseIntDefault10(pdtId.substring(5, 8));
	    var id = pdtId
	    if(np >= 328 && np <= 806){
	        if(fgn >= 20 && fgn <= 89){
	            if(gn >= 900 && gn <= 999){
	              id = (np - 328)*parseIntDefault10('8000',16) + (fgn - 20)*100 + (gn - 900) + parseIntDefault10('100001',16);
	            }
	        } else if (fgn >= 90 && fgn <= 99) {
	            fgn = fgn + "";
	        	var temp0 = fgn.substr(0,1);//存放截取的第一位数
    			var temp1 = fgn.substr(1,1);//存放截取的第二位数
	        	if(temp0 == 9){
	        	   if((((temp1 == 0 || temp1 == 7) && MunicipalAreaCode.Contains(parseIntDefault10(np,10))) ||
	        	        (temp1 == 8 && provincialCodeArray.Contains(parseIntDefault10(np,10))) || 
	        	        (temp1 == 9 && ministerialCodeArray.Contains(parseIntDefault10(np,10)))) &&  
	        	        (gn >= 0 && gn <= 999 && gn.toString() != "")){
        	   	 	       id = parseIntDefault10(gn,10) + parseIntDefault10('100000',16)+(np-328)*parseIntDefault10('8000',16)+parseIntDefault10((temp1*1000 + 7001));
	        	   }
                }
	        }
	    }
	    return id;
}

function group_id_to_marks_bz(id){
			var pdtString = id;
	    	var tempGrade ;//存放G值的倍数
	        var npTypeGradeValue;//存放np值
	        var fgnGradeValue;//存放组呼号码前两位
	        var gnGradeValue;//存放后三位数
	        tempGrade = parseIntDefault10((id -7001 - parseIntDefault10('100000',16))%parseIntDefault10('8000',16)/1000);
	        if(tempGrade >= 0 && tempGrade<=9){
	             npTypeGradeValue =parseIntDefault10((id - parseIntDefault10('100000',16))/parseIntDefault10('8000',16)+328);
	             gnGradeValue = (id -1- parseIntDefault10('100000',16))%parseIntDefault10('8000',16)%1000;
	             //temp2Grade = 90000+tempGrade*1000+temp1Grade;
	             fgnGradeValue = 90 + tempGrade;
	             if(((tempGrade == 0 || tempGrade == 7) && MunicipalAreaCode.Contains(parseIntDefault10(npTypeGradeValue,10))) ||
	             (tempGrade == 8 && provincialCodeArray.Contains(parseIntDefault10(npTypeGradeValue,10))) ||
	             (tempGrade == 9 && ministerialCodeArray.Contains(parseIntDefault10(npTypeGradeValue,10)))){
				          pdtString = npTypeGradeValue+""+fgnGradeValue+""+gnGradeValue;//转成String
				         return pdtString;      
	             }
	         }
           //分级转换不出来，按标准转换
	        var nai,np,fgn,gn,temp1,temp2,temp3;
	        np = (id >> 15) + 296;
	        temp1 = (np -328) << 15;
			temp2 = id - temp1;
			if(temp2 < 0x100001){
				return null;
			}else{
				temp3 = temp2 - 0x100001;
				fgn = temp3 / 100;
				fgn += 20;
				gn = temp3 % 100;
				gn += 900;
		     }
		    	var npValue = np;
				var fgnValue =  Math.floor(fgn);
				var gnValue = gn;
				if(npValue >= 328 && npValue <= 806 && fgnValue >=20 &&fgnValue <= 89 && gnValue >= 900 && gnValue <= 999){
				   pdtString = np+""+Math.floor(fgn)+""+gn;//转成String
				   return pdtString;    
				}
			return pdtString;
}

/**
 * 通话组浙江标准转及反转
 */

function grouppdtToId_zj(pdtId){
    var idString=pdtId;//返回值
	var npTypeObj = parseIntDefault10(pdtId.substring(0, 3));
    var temp;//存放截取的第一位数
    var temp1;//存放截取的第二位数
    var temp2;//存放截取的后三位数
    var temp3;//存放ssi
          var goupnumberValue = parseIntDefault10(pdtId.substring(3, 8));
         if(goupnumberValue >= 90000 && goupnumberValue <= 99999){//判断是否分级组呼号
		  goupnumberValue = goupnumberValue+"";
          if(goupnumberValue.length == 5){
              temp = goupnumberValue.substr(0,1);
              temp1 = goupnumberValue.substr(1,1);
              if(temp == 9){
	               temp2 = goupnumberValue.substr(2,goupnumberValue.length);
	               temp3 = parseIntDefault10(temp2,10) + parseIntDefault10('100000',16)+(npTypeObj-328)*parseIntDefault10('8000',16)+parseIntDefault10((temp1*1000 + 7001));
	               idString = temp3;
				}   
          	}
		}
    return idString;
}

function gourpidTopdt_zj(id){
    	var pdtId = id;
         var temp ;//存放G值的倍数
         var npTypeValue;//存放np值
         var temp1;//存放后三位数
         var temp2;//存放组呼号码
         temp = parseIntDefault10((id -7001 - parseIntDefault10('100000',16))%parseIntDefault10('8000',16)/1000);
         if(temp >= 0 && temp<=9){
              npTypeValue =parseIntDefault10((id - parseIntDefault10('100000',16))/parseIntDefault10('8000',16)+328);
              temp1 = (id -1- parseIntDefault10('100000',16))%parseIntDefault10('8000',16)%1000;
              temp2 = 90000+temp*1000+temp1;
            	pdtId = npTypeValue+""+temp2;
         }
         return pdtId;
}

/*******************************************************************************************************************
 ******************************************************************************************************************* 
 *******************************************************************************************************************
 *****************************根据类型自动转换1：为浙江标准，2为国家标准
 *******************************************************************************************************************
 *******************************************************************************************************************
 */

/**
 * 根据转换类型自动转换
 * @param {Object} idString
 * @param {Object} pdtType
 * @return {TypeName} 
 */
	function id2PdtByType(idString,pdtType){
		var pdtString = idString;
		if (parseIntDefault10(idString) >= 1048577 && parseIntDefault10(idString) <= 16744170) {
			if(pdtType==1){
				pdtString = id2Pdt_zj(idString);
			}else if(pdtType==2){
				pdtString = id2Pdt_bz(idString);
			}else{
				pdtString = idString;
			}
		}
		return pdtString;
	}

/**
 * 根据转换类型自动转换
 * @param {Object} pdtString
 * @param {Object} pdtType
 * @return {TypeName} 
 */
	function pdt2IdByType(pdtString,pdtType){
		var idString = pdtString;
		if(pdtString.length>=7){
			if(pdtType==1){
				idString = pdt2Id_zj(pdtString);
			}else if(pdtType==2){
				idString = pdt2Id_bz(pdtString);
			}else{
				idString = pdtString;
			}
		}
		return idString;
	}
/**
 * 组号码转换-空口转pdt
 * @param {Object} idString
 * @param {Object} pdtType
 * @return {TypeName} 
 */
	function groupId2PdtByType(idString,pdtType){
		var pdtString = idString;
		if (parseIntDefault10(idString) >= 1048577 && parseIntDefault10(idString) <= 16744170) {
			if(pdtType==1){
				pdtString = gourpidTopdt_zj(idString);
			}else if(pdtType==2){
				pdtString = group_id_to_marks_bz(idString);
			}else{
				pdtString = idString;
			}
		}
		return pdtString;
	}

/**
 * 组号码转换-pdt转空口
 * @param {Object} pdtString
 * @param {Object} pdtType
 * @return {TypeName} 
 */
	function pdt2groupIdByType(pdtString,pdtType){
		var idString = pdtString;
		if(pdtString.length>=7){
			if(pdtType==1){
				idString = grouppdtToId_zj(pdtString);
			}else if(pdtType==2){
				idString = group_marks_to_id_bz(pdtString);
			}else{
				idString = pdtString;
			}
		}
		return idString;
	}
/**
	console.log(pdt2Id_zj("57102221"));
	console.log(id2Pdt_zj("9013421"));
	console.log("标准转化");
	console.log(pdt2Id_bz("57120275"));
	console.log(id2Pdt_bz("9011276"));
	*/