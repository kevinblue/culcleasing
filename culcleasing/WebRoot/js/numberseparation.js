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
 * Only Readjsp
 * ���ǧ��λ �����ʾ   ���磺345324123.87 ===> 345,324,123.87 
 * para: srcNumber  -  Ԫ�����ֵ
 * para: name - Ԫ�ص�Id��ֵ
**/
function mouseRead(srcNumber,name){
	   var day =srcNumber;
	
	   var ifFilter = filterOperTag(name,"1");
	   if(ifFilter=="1"){
		   //Ԫ����Ҫ���ˣ������в���
		   $("#"+name).val(day);
			//document.getElementById(name).value=day;
	   }else{
			//1.У�������Ƿ�Ϊ���ֲ���ֱ�Ӹ�ֵ
			///^([1-9]+\.) | (\d\.) $/
			if (/[^0-9\.]/.test(srcNumber) || isNaN(srcNumber) ) {
				 $("#"+name).val(day);
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


