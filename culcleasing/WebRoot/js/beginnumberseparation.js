/**
 *��ʼ��һЩ���¼�
 */
$(document).ready(function(){
	//ע��readonly���Ե�����ʾ��ʽ���� 2012-01-12����
	$("input[readonly='true']").attr("class","readonlyShow");
});

/** 
 * ���ǧ��λ �����ʾ   ���磺345324123.87 ===> 345,324,123.87 
 * para: srcNumber  -  Ԫ�����ֵ
 * para: name - Ԫ�ص�Id��ֵ
**/
function mouse(srcNumber,name){
	   var day =srcNumber;
	   var ifFilter = filterOperTag(name,"1");
	   if(ifFilter=="1"){
		   //Ԫ����Ҫ���ˣ������в���
		   $("#"+name).val(day);
			//document.getElementById(name).value=day;
	   }else{
			//1.У�������Ƿ�Ϊ����
			///^([1-9]+\.) | (\d\.) $/
			if (/[^0-9\.]/.test(srcNumber) || isNaN(srcNumber) ) {
				 alert("�������ݸ�ʽ������������д!");
				 $("#"+name).val("0");
				 document.getElementById(name).focus();
			}else{
				//2.����ǧ��λƴ��
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
 * ĳЩ��ǩԪ�ع��ˣ�������ǧ��λ����
 * tagName : ���˱�ǩ����
 * type : ���ͣ�Ĭ��Ϊ1
 * result: resVal - ����ֵ��1Ϊ��Ҫ���� 0 ������Ҫ����
 **/
function filterOperTag(tagName, type){

	var resVal = "0";
	if(type=="1"){
		 if("income_number"==tagName || "lease_term"==tagName || "free_defa_inter_day"==tagName 
			  || "proj_id"==tagName || "contract_id"==tagName || "start_date"==tagName
			  || "before_interest_type"==tagName ||"income_number_year1"==tagName
			  || "into_batch"==tagName|| "plan_bank_no"==tagName ||"plan_bank_name"==tagName
			  || "rate_float_amt"==tagName ||"year_rate"==tagName||"fact_irr"==tagName
			  || "plan_irr"==tagName ||"pena_rate"==tagName||"ratio_param"==tagName
			  ||"plan_bank_name"==tagName || "plan_bank_no"==tagName
			  ||  "rate_float_amt"==tagName){
			resVal="1";
		}
	}else if(type=="2"){
		 if("income_number"==tagName || "lease_term"==tagName || "free_defa_inter_day"==tagName 
			  || "proj_id"==tagName || "contract_id"==tagName || "start_date"==tagName
			  || "before_interest_type"==tagName ||"income_number_year1"==tagName
			  || "into_batch"==tagName || "plan_bank_no"==tagName ||"plan_bank_name"==tagName
			  || "rate_float_amt"==tagName ||"year_rate"==tagName||"fact_irr"==tagName
			  || "plan_irr"==tagName ||"pena_rate"==tagName||"ratio_param"==tagName
			  ||"plan_bank_name"==tagName || "plan_bank_no"==tagName
			  ||  "rate_float_amt"==tagName){
			resVal="1";
		}
	}

	return resVal;
}

/**
 * ǧ��λ���ݵĻָ�������ʾ  ���磺345,324,123.87 ==> 345324123.87
 * para: srcNumber  -  Ԫ�����ֵ
 * para: name - Ԫ�ص�Id��ֵ
**/
function huifumouse(srcNumber,name){
   //�ȹ������в�Ҫ�ָ���ʾ������
   var ifFilter = filterOperTag(name,"1");
   if(ifFilter=="1"){
	  //�����κβ���
   }else{
	   //�ָ�
		var zhi= srcNumber.replace(/,/g,"");
		document.getElementById(name).value=zhi;
   }
}

/**
 * ��ǧ��λ���ݻָ�Ϊ��ǧ��λ��ֵ  ���磺345,324,123.87 ==> 345324123.87
 * para: dataNumb  -  Ҫ������ֵ 
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


