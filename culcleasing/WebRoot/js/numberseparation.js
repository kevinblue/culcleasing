/** 
 * 金额千分位 拆分显示   例如：345324123.87 ===> 345,324,123.87 
 * para: srcNumber  -  元素域的值
 * para: name - 元素的Id的值
**/
function mouse(srcNumber,name){
	   var day =srcNumber;
	
	   var ifFilter = filterOperTag(name,"1");
	   if(ifFilter=="1"){
		   //元素需要过滤，不进行操作
		   $("#"+name).val(day);
			//document.getElementById(name).value=day;
	   }else{
			//1.校验输入是否为数字
			///^([1-9]+\.) | (\d\.) $/
			if (/[^0-9\.]/.test(srcNumber) || isNaN(srcNumber) ) {
				 alert("输入数据格式错误，请重新填写!");
				 $("#"+name).val("0");
				 document.getElementById(name).focus();
			}else{
				//2.进行千分位拼接
				srcNumber=srcNumber.replace(/^(\d*)$/,"$1.");
				srcNumber=(srcNumber+"00").replace(/(\d*\.\d\d)\d*/,"$1");
				srcNumber=srcNumber.replace(".",",");
				var re=/(\d)(\d{3},)/;
				while(re.test(srcNumber)){
					srcNumber=srcNumber.replace(re,"$1,$2");
				}

				srcNumber=srcNumber.replace(/,(\d\d)$/,".$1");
				var zhi= srcNumber.replace(/^\./,"0.");
			   
				document.getElementById(name).value=zhi;	
			}
	   }
}
/** 
 * Only Readjsp
 * 金额千分位 拆分显示   例如：345324123.87 ===> 345,324,123.87 
 * para: srcNumber  -  元素域的值
 * para: name - 元素的Id的值
**/
function mouseRead(srcNumber,name){
	   var day =srcNumber;
	
	   var ifFilter = filterOperTag(name,"1");
	   if(ifFilter=="1"){
		   //元素需要过滤，不进行操作
		   $("#"+name).val(day);
			//document.getElementById(name).value=day;
	   }else{
			//1.校验输入是否为数字不是直接赋值
			///^([1-9]+\.) | (\d\.) $/
			if (/[^0-9\.]/.test(srcNumber) || isNaN(srcNumber) ) {
				 $("#"+name).val(day);
			}else{
				//2.进行千分位拼接
				srcNumber=srcNumber.replace(/^(\d*)$/,"$1.");
				srcNumber=(srcNumber+"00").replace(/(\d*\.\d\d)\d*/,"$1");
				srcNumber=srcNumber.replace(".",",");
				var re=/(\d)(\d{3},)/;
				while(re.test(srcNumber)){
					srcNumber=srcNumber.replace(re,"$1,$2");
				}

				srcNumber=srcNumber.replace(/,(\d\d)$/,".$1");
				var zhi= srcNumber.replace(/^\./,"0.");
			   
				document.getElementById(name).value=zhi;	
			}
	   }
}		
/**
 * 某些标签元素过滤，不进行千分位操作
 * tagName : 过滤标签名称
 * type : 类型，默认为1
 * result: resVal - 返回值，1为需要过滤 0 代表不需要过滤
 **/
function filterOperTag(tagName, type){
	var resVal = "0";
	if(type=="1"){
		 if("income_number"==tagName || "lease_term"==tagName || "free_defa_inter_day"==tagName 
			  || "proj_id"==tagName || "contract_id"==tagName || "start_date"==tagName
			  || "before_interest_type"==tagName ||"income_number_year1"==tagName
			  || "into_batch"==tagName||"plan_irr"==tagName||"year_rate"==tagName||"pena_rate"==tagName
			  || "StandardIrr"==tagName||"irr"==tagName||"ratio_param"==tagName
			  ||"plan_bank_name"==tagName || "plan_bank_no"==tagName ||"plan_date" ==tagName ||"rent_list"==tagName
			  || "managefee_list"==tagName ||"manage_separate_ratio"==tagName || "otherfee_list"==tagName
			  || "leas_rent_start_date"==tagName || "leas_rent_end_date"==tagName || "income_hire_date"==tagName
			  || "rate_float_amt"==tagName){
			resVal="1";
		}
	}else if(type=="2"){
		 if("income_number"==tagName || "lease_term"==tagName || "free_defa_inter_day"==tagName 
			  || "proj_id"==tagName || "contract_id"==tagName || "start_date"==tagName
			  || "before_interest_type"==tagName ||"income_number_year1"==tagName
			  || "into_batch"==tagName||"plan_irr"==tagName||"year_rate"==tagName||"pena_rate"==tagName
			  || "StandardIrr"==tagName||"irr"==tagName ||"ratio_param"==tagName
			  ||"plan_bank_name"==tagName || "plan_bank_no"==tagName ||"plan_date" ==tagName || "rent_list"==tagName
			  || "managefee_list"==tagName ||"manage_separate_ratio"==tagName || "otherfee_list"==tagName 
			  || "leas_rent_start_date"==tagName || "leas_rent_end_date"==tagName || "income_hire_date"==tagName
			  || "rate_float_amt"==tagName){
			resVal="1";
		}
	}

	return resVal;
}

/**
 * 千分位数据的恢复数字显示  例如：345,324,123.87 ==> 345324123.87
 * para: srcNumber  -  元素域的值
 * para: name - 元素的Id的值
**/
function huifumouse(srcNumber,name){
   //先过滤所有不要恢复显示的数据
   var ifFilter = filterOperTag(name,"1");
   if(ifFilter=="1"){
	  //不做任何操作
   }else{
	   //恢复
		var zhi= srcNumber.replace(/,/g,"");
		document.getElementById(name).value=zhi;
   }
}


/**
 * 将千分位数据恢复为无千分位数值  例如：345,324,123.87 ==> 345324123.87
 * para: dataNumb  -  要操作的值 
 *
**/
function dataBack( dataNumb ){
   var resVal = dataNumb;
   
   resVal = resVal.replace(/,/g,"");
   if(isNaN(resVal)){
	   resVal = "0";
   }
	
   return resVal;
}


