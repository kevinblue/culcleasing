<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- ��ͬ���׽ṹ ��contract_condition_temp  -->
<title> ������ - ��ͬ���׽ṹ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- ���ڿؼ� -->
<script src="../../js/calend.js"></script>
<script language="javascript"> 
/*
    �������壺
        ���ݹ�ʽ�������ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧��-�׸��� ���㡮�����ʶ��ֵ��
        �豸�� equip_amt,��֤�� caution_money,������ handling_charge,
        ���̷�Ӷ return_amt,�������� other_income,��ѯ�� consulting_fee,����֧�� other_expenditure 
        ����֮ǰ�ԡ����ޱ��𡯺͡���֤�𡯽��п��ж�
    return:
        ��������ֵ�����������ʶ�ֶ�
    author:
        sea
    date:
        2010-05-10
*/
function assignment(){ 
	//alert('join');
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//�豸��
	var caution_money_value = document.getElementsByName("caution_money")[0].value;//��֤��
	var lease_capital_value = document.getElementsByName("lease_money")[0].value;//���ޱ���
	var handling_charge = document.getElementsByName("handling_charge")[0].value;//������
	var return_amt = document.getElementsByName("return_amt")[0].value;//���̷�Ӷ
	var other_income = document.getElementsByName("other_income")[0].value;//��������
	var consulting_fee = document.getElementsByName("consulting_fee")[0].value;//��ѯ��
	var other_expenditure = document.getElementsByName("other_expenditure")[0].value;//����֧��
	var first_payment = document.getElementsByName("first_payment")[0].value;//�׸���
	var management_fee = document.getElementsByName("management_fee")[0].value;//�����
	
	var before_interest = document.getElementsByName("before_interest")[0].value;//��ǰϢ��2010-07-23���޸ġ�
	
	//alert('�豸��'+equip_amt+'-��֤��'+caution_money_value+'-������'+handling_charge+'-���̷�Ӷ'+return_amt+'-��������'+other_income+'+��ѯ��'+consulting_fee+'+����֧��'+other_expenditure);
	if((lease_capital_value == null || lease_capital_value == '') || (caution_money_value == null || caution_money_value == '')){
		alert("���ޱ���ͱ�֤����Ϊ��,�����ʶ�=���ޱ���-��֤��!");
		document.all.lease_money.focus();
		return false;
	}else{ 
		//var lease_amt_value = lease_capital_value - caution_money_value; 
		//�����ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧�� -��ǰϢ-�����
		lease_amt_value = equip_amt - caution_money_value - handling_charge - return_amt - other_income + consulting_fee + other_expenditure-before_interest-management_fee;
		var value1 = FloatSub(equip_amt,caution_money_value);
		var value2 = FloatSub(handling_charge,return_amt);
		var value3 = FloatSub(value1,value2);
		var value4 = FloatSub(value3,other_income);//�������ܺ�
		var value5 = FloatAdd(consulting_fee,other_expenditure);//�ӷ����ܺ�
		var value6 = FloatAdd(value4,value5);//
		lease_amt_value =  FloatSub(value6,first_payment);//����ֵ 
		lease_amt_value =  FloatSub(lease_amt_value,before_interest);//��ȥ��ǰϢ
		lease_amt_value =  FloatSub(lease_amt_value,management_fee);//��ȥ�����
		
		//alert(lease_amt_value);
		document.getElementsByName("net_lease_money")[0].value = lease_amt_value;
		//���㡮��ƺ��㱾��=�����ʶ�ӱ�֤�𡯵�ֵ accountPrincipal
		var str_num = FloatAdd(caution_money_value,lease_amt_value);
		document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
	getlmp_value();
}
//��ƺ��㱾��ֵ
function get_APValue(){
	
	var caution_money = document.getElementsByName("caution_money")[0].value;//��֤��
	var net_lease_money = document.getElementsByName("net_lease_money")[0].value;
	if(caution_money == null || caution_money == '' || net_lease_money == null || net_lease_money == ''){
		alert("��ѡ�������ޱ�֤��;����ʶ��ֵ!");
		return false;
	}else{
		//���㡮��ƺ��㱾��=�����ʶ�ӱ�֤�𡯵�ֵ accountPrincipal
		var str_num = FloatAdd(caution_money,net_lease_money);
		document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
}
//�������ӷ�����   
 function FloatAdd(arg1,arg2){   
   var r1,r2,m;   
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
   m=Math.pow(10,Math.max(r1,r2))   
   return (arg1*m+arg2*m)/m   
  } 
 //��������������   
 function FloatSub(arg1,arg2){   
	 var r1,r2,m,n;   
	 try{
	 		r1 = arg1.toString().split(".")[1].length
	 	}catch(e){
	 		r1=0
	 	}   
	 try{
	 		r2=arg2.toString().split(".")[1].length
	 	}catch(e){
	 		r2=0
	 	}   
	 m = Math.pow(10,Math.max(r1,r2));   
	 //��̬���ƾ��ȳ���   
	 n = (r1>=r2)?r1:r2;   
	 return ((arg1*m-arg2*m)/m).toFixed(n);   
 }  
/*
    �������壺
        ���ݹ�ʽ���������� = ( �������*���ⷽʽ ) 
       if(��������==��ĩ,���������ޡ�= �������� + ���ⷽʽ),��������������ޡ���ֵ��
        ����֮ǰ�ԡ��������͡�,�����ⷽʽ��,�����������������֤
       �����ⷽʽ���Ƿ�����������:1->�¸�|3->����|6->���긶|12->�긶
        �ڡ����������input����򴥷����¼�onchange
        �ڡ���������(��)��input����򴥷����¼�onclick
    return:
        ��������ֵ�������������ޡ��ֶ�
    author:
        sea
    date:
        2010-05-14
*/
function changLease_term_value(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//���ⷽʽ
	var income_number_value = document.getElementsByName("income_number")[0].value;//�������
	//var lease_term_value = document.getElementsByName("lease_term")[0].value; //��������(��)
	var period_type_value = document.getElementsByName("period_type")[0].value; //�������� Ϊ��ĩ��һ��ORһ����ORһ��
	// ������� = ��������/���ⷽʽ //�������� = �������*���ⷽʽ
	if(income_number_year_value != null || income_number_year_value != ''){
		if(income_number_value == null || income_number_value == ''){
			alert("�����뻹�����!");
			return false;
		}else{
			var lt_value = income_number_value * income_number_year_value;
			//��������Ϊ����ĩ֧���������������ޡ�����϶�Ӧ�����ⷽʽ������
			if(period_type_value == 0 || period_type_value == '0'){
				var int_lt_value = parseInt(lt_value);
				lt_value = int_lt_value + parseInt(income_number_year_value);
			}
			document.getElementsByName("lease_term")[0].value = lt_value; 
		}
	}else{
		alert("��ѡ���ⷽʽ!");
		return false;
	}
}
//�������޼���
function changLeaseT_value(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//���ⷽʽ
	var income_number_value = document.getElementsByName("income_number")[0].value;//�������
	// ������� = ��������/���ⷽʽ //�������� = �������*���ⷽʽ
	if(income_number_year_value != null || income_number_year_value != ''){
		if(income_number_value == null || income_number_value == ''){
			alert("�����뻹�����!");
			return false;
		}else{
			var lt_value = income_number_value * income_number_year_value;
			document.getElementsByName("lease_term")[0].value = lt_value; 
			//2011-03-15��������
			//�������������޺���������ʵĲ�ѯ����,���� �������ͣ����ⷽʽ�����޼��� ���߽�ϲ�ѯ�Ƿ���������Э�������������
			var period_type = document.getElementsByName("period_type")[0].value;//�������� �ڳ���ĩ
			var main_proj_id = document.getElementsByName("main_proj_id")[0].value;//����Ŀ���
			//�������Ŀ���Ϊ�����ʾ���ǵ�����Ŀ����Ҫ����������
			if(main_proj_id != null && main_proj_id != "undefined" && main_proj_id != ""){
				//����ajax�����ѯ������Э���Ӧ�������ʷ��ظ�ֵ��������input�� 2011-03-15
				sendStreet(period_type,lt_value,main_proj_id,income_number_year_value);
			}
		}
	}else{
		alert("��ѡ���ⷽʽ!");
		return false;
	}
	
}


/***************ͬ��һ������changLease_term_value ������ĸú�����ʱδ�õ�
    �������壺
        ���ݹ�ʽ��������� = ��������/�껹����� ���㡮�����������ֵ��
        ����֮ǰ�ԡ��������ޡ��͡��껻�������������֤
       �����ⷽʽ(�껻�����)���Ƿ�����������:1->�¸�|3->����|6->���긶|12->�긶
    return:
        ��������ֵ����������������ֶ�
    author:
        sea
    date:
        2010-05-10
*/
function changeLease_term(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//�껹�����(���ⷽʽ)
	var income_number_value = document.getElementsByName("income_number")[0].value;//�������
	//�껹�����(���ⷽʽ)���ж�
	if(income_number_year_value == null || income_number_year_value == ''){
		alert("��ѡѡ���ⷽʽ!"); 
		document.getElementsByName("lease_term")[0].value = '';//��������
		document.all.income_number_year.focus();
		return false;
		
	}
	var lease_term_value = document.getElementsByName("lease_term")[0].value; //��������(��)
	//if(income_number_year_value == 1){//�¸�����Ҫ�ж� }
	if(income_number_year_value == 3){//����
		if(lease_term_value%3 != 0){
			alert("���ⷽʽΪ����ʱ:�������޼������ڲ���3����������");
			document.all.lease_term.focus();
			return false;
		}
	} 
	if(income_number_year_value == 6){//���긶
		if(lease_term_value%6 != 0){
			alert("���ⷽʽΪ���긶ʱ:�������޼������ڲ���6����������");
			document.all.lease_term.focus();
			return false;
		}
	}
	if(income_number_year_value == 12){//�긶
		if(lease_term_value%12 != 0){
			alert("���ⷽʽΪ�긶ʱ:�������޼������ڲ���12����������");
			document.all.lease_term.focus();
			return false;
		}
	} 
	// ������� = ��������/�껹�����
	var income_number_value = lease_term_value/income_number_year_value;  
	document.getElementsByName("income_number")[0].value = income_number_value;//��ֵ
} 
/*
    �������壺
        ���ݹ�ʽ�����ޱ��� = �豸��� - �׸��� �������ޱ����ֵ��
        ����֮ǰ�ԡ��豸���͡��׸��������֤
    param:
    return:
        ��������ֵ���������ޱ����ֶ�
    author:
        sea
    date:
        2010-05-10
*/
function changeFirst_payment(){
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//�豸��� 
	var first_payment = document.getElementsByName("first_payment")[0].value;//�׸���
	if(equip_amt == null || equip_amt == ''){
		alert("�������豸���!");
		document.all.equip_amt.focus();
		return false;
	}
	var numValue = equip_amt - first_payment;
	//����2λС��
	numValue = forcepos(numValue,2);
	document.getElementsByName("lease_money")[0].value = numValue;//���ޱ���
	//���ü��㾻���ʶ�ĺ���
	//if(first_payment != null && first_payment != ''){// �׸��Ϊ��
	//	assignment();
	//}
	//���������ʶΪ�� �����ʶ�=���ޱ���-��֤�� �����׸��� �����豸���ĸ��� �����ʶ� �����¿����¼���
	document.getElementsByName("net_lease_money")[0].value = '';
}
//���ⷽʽֵ�ı���ջ��������ֵ
function changIncome_number_year_value(){	
	var income_number_year = document.getElementsByName("income_number_year")[0].value;
	if(income_number_year == null || income_number_year == ''){
		alert("��ѡ�����ĸ��ⷽʽ!");
		return false;
	}
	document.getElementsByName("income_number")[0].value = '';
	document.getElementsByName("lease_term")[0].value = '';
}

//***************************************************************

//���ʵ���ֵ����������ʵ���ֵ������ʾ������
function alertChange(){
	var rate_float_amt = document.getElementsByName("rate_float_amt")[0].value;//���ʵ���ֵ
	//���ʸ������� "���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
	//
	if(rate_float_amt == '' || rate_float_amt == null){
		div_rate.style.displa = 'block';
	}else{
		if(rate_float_type == '0'){
			name = "���������ʸ�������";
			div_rate.innerHTML = "<font color='red'>���������ʸ������ʵ���Ϊ��(���л�������+����)��"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '1'){//2010-11-23�����޸�
			name = "���������ʼӵ�";
			div_rate.innerHTML = "<font color='red'>���������ʼӵ����Ϊ��(���л�������+����)+"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '2'){
			name = "�̶����������";
			div_rate.innerHTML = "<font color='red'>�̶����������:"+rate_float_amt+"</font>";
		}
	}
}

function changeOne(){
	//���ʸ������� "���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var rate = document.getElementById('rate_float_amt');
	var div_rate = document.getElementById('div_rate');
	if(rate_float_type == '3'){
		document.getElementsByName("rate_float_amt")[0].value = '0';
		rate.disabled = true;
		div_rate.innerHTML = "";
	}else{
		rate.disabled = false;
		alertChange();
		//return true;
	}
}

//�������Ӿ����ʶ����=�����ʶ�/�豸���
function getlmp_value(){
	var net_lease_money = document.getElementsByName("net_lease_money")[0].value;//�����ʶ�
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//�豸���
	var result;
	if((net_lease_money == 0 && equip_amt == 0)||(net_lease_money == '0' && equip_amt == '0')){
		result = "0";
	}else{
		result = round2places((net_lease_money/equip_amt)*100);
	}
	document.getElementsByName("lease_money_proportion")[0].value = result;
}
//��������
function round2places(numToRound) 
{ 
	//var numToRound=document.getElementById("numToRound").value;
	var result; 
	result=numToRound*100; 
	result=Math.round(result); 
	result=result/100; 
	return result;
} 

	function submitForm(){
		if(check_allInput()){
			var type = document.getElementById('measure_type').value;//�����㷽��
			if(type == '0' || type == 0){
				form1.target ="rentplan";
			}else{
				form1.target ="_blank";
			}
			form1.submit();
		}
	}
	/**
	*  ��֤���е�input�������֤���ָ�ʽ
	*/
	function check_allInput(){
		var savaType = document.getElementById('savaType').value ;//�ж���ӻ����޸�
		var delay = document.getElementById('delay').value ;//�ӳ�����
		var list = document.getElementsByTagName("input");
		var str = "0";
		var count = 0;
		for(var i=0;i<list.length && list[i];i++)
 		{
 			if(list[i].type == "text"){
 				var text_value = list[i].value;
 				text_value = trim(text_value);//��ȥ�ո�
				 //�Ƿ��ַ�����֤ 				
 				 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
                 if(text_value.match(reg_ff)){ 
                     str = "�����������ַ������ܰ��������ַ�:��-- /* ';\"% < > // \"��" ;
                     alert(str);	
                     count = count + 1;
                     break;
                  }
 				//alert(list[i].name+"="+text_value+"----"+list[i].dataType);
	 			//���Ҹ�ʽ : /^[+]?\d+(\.[0-9]{1,2})?$/ ����ʽ����ȷ������Ϊ��ʵ������С������λ����
	 			if(list[i].dataType == 'Money' || list[i].dataType == 'money'){
	 				var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	 				//alert("MONEY��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_money.test(text_value));
	 				if(reg_money.test(text_value)== false){
	 					str = "���Ҹ�ʽ����";//
	 					//var pos = getElementPos(list[i].name);  //������ֶε����� 
						//alert("����߾���"+ pos.x +",���ϱ߾���"+pos.y); 
						create_span(str,list[i].name);//���ж�Ӧ�ֶεĴ�����ʾ
						count = count + 1;
	 					break;
	 				}else{
	 					str = "";
						create_span(str,list[i].name);//��ȷ�����Ϊ��
	 				}
	 			}
	 			//��������: /^\d+$/    
	 			if(list[i].dataType == 'Number' || list[i].dataType == 'number'){
	 				//var reg_number = /^\d+$/;
	 				//alert("Number��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_number.test(text_value));
	 				if(isNaN(text_value) == false){
	 					str = "����Ϊ����";//
	 					create_span(str,list[i].name);//���ж�Ӧ�ֶεĴ�����ʾ
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//��������ʽ����0��^\d+$   ��֤���������������� + 0�� ^((-\d+)|(0+))$ 
	 			if(list[i].dataType == 'Integer' || list[i].dataType == 'integer'){
	 				var reg_Integer =  /^\d+$/;
	 				//alert("Integer��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_Integer.test(text_value));
	 				if(reg_Integer.test(text_value) == false){
	 					str = "����Ϊ����������0";
	 					create_span(str,list[i].name);//���ж�Ӧ�ֶεĴ�����ʾ
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//double��ʽ��/^[-\+]?\d+(\.\d+)?$/
	 			if(list[i].dataType == 'Double' || list[i].dataType == 'double'){
	 				var reg_Double =  /^[-\+]?\d+(\.\d+)?$/;
	 				//alert("Double��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_Double.test(text_value));
	 				if(reg_Double.test(text_value) == false){
	 					str = "����Ϊʵ��";
	 					create_span(str,list[i].name);//���ж�Ӧ�ֶεĴ�����ʾ
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//���ʸ�ʽ: /^\d+(\.[0-9]{1,8})?$/,
	 			if(list[i].dataType == 'Rate' || list[i].dataType == 'rate'){
	 				var reg_Rate =  /^\d+(\.[0-9]{1,8})?$/;
	 				//alert("reg_Rate��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_Rate.test(text_value));
	 				if(reg_Rate.test(text_value) == false){
	 					str = "����Ϊ��ʵ������С���ڰ�λ����";
	 					create_span(str,list[i].name);//���ж�Ӧ�ֶεĴ�����ʾ
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
 			}//input���������жϽ���
 		}//for ѭ������
 		//str = trim(str);//��ȥ�ո�
		if(count > 0){
			return false; 
		}else{
			return true;
		}
	}
	/**
	*�жϴ���������²���һ��span�ڵ㣬����ʾ����ԭ��������ȷ�򽫸ýڵ���Ϊ��
	*����1��str ����ԭ��
	*����2��name �ڵ��������ƻ���id
	*/
	function create_span(str,name){
		var tem_name = name+"_msg";
		//����ڵ�span�����ھʹ���һ����������ھͽ�ֵ��Ϊ��
		if (null==document.getElementById(tem_name) || document.getElementById(tem_name)=='undefined') {
		    var newSpan = document.createElement("span");
			newSpan.id = name+"_msg";
			document.getElementById(name).parentNode.appendChild(newSpan);//�ҵ����ڵ�TD�´���һ��spanԪ��
		} else {
		   document.getElementById(tem_name).innerHTML ="";
		}
		document.getElementById(tem_name).innerHTML =  "<br><font color='red'>"+str+"</font>";//
	}
	/*
    ���������� ȥ������ո���
    	return: s 2�ߵĶ���Ŀո��Ѿ�ȥ����
    	author:  sea
    	date: 2010-04-13
	*/
	function trim(s){  
  		return s.replace(/(^\s*)|(\s*$)/g,"");      
	}
	//��ȡԪ�ض�Ӧ�����귽��
	function getElementPos(elementId) {   
		 var ua = navigator.userAgent.toLowerCase();   
		 var isOpera = (ua.indexOf('opera') != -1);   
		 var isIE = (ua.indexOf('msie') != -1 && !isOpera); // not opera spoof   
		 var el = document.getElementById(elementId);   
		 if(el.parentNode === null || el.style.display == 'none') {   
		  return false;   
		 }         
		 var parent = null;   
		 var pos = [];        
		 var box;        
		 if(el.getBoundingClientRect)    //IE   
		 {            
		  box = el.getBoundingClientRect();   
		  var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);   
		  var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);   
		  return {x:box.left + scrollLeft, y:box.top + scrollTop};   
		 }else if(document.getBoxObjectFor)    // gecko       
		 {   
		  box = document.getBoxObjectFor(el);    
		  var borderLeft = (el.style.borderLeftWidth)?parseInt(el.style.borderLeftWidth):0;    
		  var borderTop = (el.style.borderTopWidth)?parseInt(el.style.borderTopWidth):0;    
		  pos = [box.x - borderLeft, box.y - borderTop];   
		 } else    // safari & opera       
		 {   
		  pos = [el.offsetLeft, el.offsetTop];     
		  parent = el.offsetParent;        
		  if (parent != el) {    
		   while (parent) {     
		    pos[0] += parent.offsetLeft;    
		    pos[1] += parent.offsetTop;    
		    parent = parent.offsetParent;   
		   }     
		  }      
		  if (ua.indexOf('opera') != -1 || ( ua.indexOf('safari') != -1 && el.style.position == 'absolute' )) {    
		   pos[0] -= document.body.offsetLeft;   
		   pos[1] -= document.body.offsetTop;            
		  }       
		 }                 
		 if (el.parentNode) {    
		    parent = el.parentNode;   
		   } else {   
		    parent = null;   
		   }   
		 while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { // account for any scrolled ancestors   
		  pos[0] -= parent.scrollLeft;   
		  pos[1] -= parent.scrollTop;   
		  if (parent.parentNode) {   
		   parent = parent.parentNode;   
		  } else {   
		   parent = null;   
		  }   
		 }   
		 return {x:pos[0], y:pos[1]};   
    }   

//�����㷽��ѡΪƽϢ����һЩ������ѡ��
function change_disable(){
	var measure_type = document.getElementsByName("measure_type_tem")[0].value;
	if(measure_type == 5 || measure_type == '5'){//ƽϢ������»�ѡ���������
		document.getElementById('first_payment').disabled = true;//�׸���
		document.getElementById('handling_charge').disabled = true;//����������
		document.getElementById('nominalprice').disabled = true;//�ʲ���ֵ
		document.getElementById('return_amt').disabled = true;//���̷���
		document.getElementById('before_interest').disabled = true;//��ǰϢ
		document.getElementById('pena_rate').disabled = true;//��Ϣ������
		document.getElementById('accountPrincipal').disabled = true;//��ƺ��㱾��
		document.getElementById('liugprice').disabled = true;//�����ۿ�
		document.getElementById('consulting_fee').disabled = true;//��ѯ��
	}else{
		document.getElementById('first_payment').disabled = false;//�׸���
		document.getElementById('handling_charge').disabled = false;//����������
		document.getElementById('nominalprice').disabled = false;//�ʲ���ֵ
		document.getElementById('return_amt').disabled = false;//���̷���
		document.getElementById('before_interest').disabled = false;//��ǰϢ
		document.getElementById('pena_rate').disabled = false;//��Ϣ������
		document.getElementById('accountPrincipal').disabled = false;//��ƺ��㱾��
		document.getElementById('liugprice').disabled = false;//�����ۿ�
		document.getElementById('consulting_fee').disabled = false;//��ѯ��
	}
}
</script>

</head>
<body  onload="alertChange();change_disable();">
<%
	String context = request.getContextPath();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
	String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	//��ԡ��������������޸Ĳ���
	String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ��� 
	//��ȡmodel ��Ϊ����Ӻ��޸��ж� ���Ϊ"add"�޸�Ϊ"mod"ɾ��Ϊ"del"
	String model = getStr(request.getParameter("model"));
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� measure_id
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
	
	//��2011-01-10 ƽϢ�����ӡ� START //////////////////////////////////////////////////////////////////
	//����һ�����������ж��Ƿ���ƽϢ���Ĳ����������ƽϢ���򲻷��ֶ���Ҫ���ֻ��
	String pinxi = "flase";
	//Ĭ��Ϊ�ȶ������㷽ʽ
	String q_px = " select isnull(measure_type,'1') as measure_type from  contract_condition_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
	String measure_type  = "";//ȡ�����㷽�� 4 ��ʾƽϢ��
	ResultSet rs_px = db.executeQuery(q_px);
	while(rs_px.next()){
		 measure_type  = getDBStr(rs_px.getString("measure_type"));//ȡ�����㷽�� 4 ��ʾƽϢ��
		if("5".equals(measure_type)){//ƽϢ��
			pinxi = "true";
		}
	}
	rs_px.close();
	//��2011-01-10 ƽϢ�����ӡ� END //////////////////////////////////////////////////////////////////
	
	//
	List<String> list = new ArrayList<String>();
	String tableName = "";//����
	//��Ŀ��Ų�Ϊ��
	if(model == null || model.equals("") || model.equals("0")){
		model = "add";
	}
	if(model.equals("mod")){//��ʱ���޸ĲŻ��Ȳ�ѯһ�� ���Ӳ�����ѯ����
		StringBuffer querySql = new StringBuffer();
		//�ж������Ƿ�Ϊ�� 0-29
		querySql.append("select contract_id,currency,equip_amt,first_payment,")//0-3
		 		.append("lease_money,caution_money,net_lease_money,")//4-6
		 		.append("handling_charge,income_number_year,lease_term,")//7-9
		 		.append("income_number,nominalprice,period_type,return_amt,")//10-13
		 		.append("year_rate,rate_float_type,before_interest,")//14-16
		 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")//17-20
		 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")//21-25
		 		.append("create_date,modify_date,modificator,rate_float_amt,consulting_fee, ")//26-30
		 		.append(" market_irr,  ")//�����ֶ� �г�irr 31
		 		.append("lease_money_proportion,  ")//�������ֶ� 2010-07-27��32 �����ʶ����
		 		.append("accountPrincipal,  ")//�������ֶ� 2010-08-06��33 
		 		.append("rentScale,  ")//�������ֶ� 2010-08-20��34 Բ����
		 		.append("liugprice,  ")//�������ֶ� 2010-09-21��35 �����ۣ�ԭ���������۸ĳɲ�ֵ��
		 		.append("delay,  ")//�������ֶ� 2010-10-20��36 �ӳ�����
		 		.append("grace,  ")//�������ֶ� 2010-10-20��37 ��������
		 		.append("management_fee,  ")//�������ֶ� 2010-11-11��38 ����� 
		 		.append("isnull(ajdustStyle,'0'),  ")//�������ֶ� 2010-11-23��39 ��Ϣ��ʽ
		 		.append("isnull(amt_return,'��') as amt_return  ")//�������ֶ� 2011-01-10��40 �豸�Ƿ��˻�
		 		.append(" from contract_condition_temp ")
		 		.append(" where contract_id = '"+contract_id+"' ")
		 		.append(" and measure_id = '"+doc_id+"' "); 
		 		
		 		
		//���ݺ�ͬ������ж��ǲ�ѯ��ͬ���׽ṹ�����������������׽ṹ��
	 	ResultSet rs;
	 	int countNum = 41;
	 	rs = db.executeQuery(querySql.toString());//ִ�в�ѯ
	 	System.out.println("chaxun------------->"+querySql);
	 	//rs.last(); //�Ƶ����һ��
		//int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
		//rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
	 	int i = 1;
	 	while(rs.next()){
	 		//ѭ��ȡֵ ȡ�ñ��ǰcountNum�У��±��1��ʼȡ
	 		for(;i <= countNum;i++){
		 		list.add(getDBStr(rs.getString(i)));
	 		}
	 	}
	 	rs.close();
	 }
	 
	//��2011-03-02 ����Ŀ�����������ӡ�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
	//���ӣ�1.���ݺ�ͬ�Ų����������Ŀ���main_proj_id  ����������ʾ�ǵ�����Ŀ�����ǲ���Ҫ���������ʵĻ���
	//2.��������Ŀ���main_proj_id���������ͣ��ڳ�����ĩ�����ʽ���¸������������긶���긶������(��)������Ϊ��λ  �������Ӧ��������
	String q_mpi = " select main_proj_id,contract_id,* from contract_info where contract_id = '"+contract_id+"' ";
	ResultSet rs_mpi = db.executeQuery(q_mpi);
	String main_proj_id = "";//����Ŀ���
	if(rs_mpi.next()){
		main_proj_id =  getDBStr(rs_mpi.getString("main_proj_id"));
	}
	rs_mpi.close();
	String readonly_bl = "false";//������Э���������������Ҫ�ı���
	String year_rate_bl = "0.00";
	
	//����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
	 
%> 
<!-- form����ת��zjcs_businessOperating.jspҳ��  -->
<form name="form1" method="post" target="rentplan" action="zjcs_contractSave.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% hight="75%" align=center cellspacing=0 border="0" cellpadding="0">
<!-- ������ֵ  -->
<input type="hidden" name="main_proj_id" id="main_proj_id" value="<%=main_proj_id%>"/>
<input type="hidden" name="modelType" id="modelType" value="zjcsModel"/>
<input type="hidden" name="savaType" id="savaType" value="<%=model%>"/>
<input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>"/>
<input type="hidden" name="measure_type_tem" id="measure_type_tem" value="<%=measure_type%>"/>
<tr valign="top">
	<td  align=center width=100% height=100%>
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:370px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" hight=100%" align="center" class="tab_table_title">
		<%
			if(list.size() > 0 && model.equals("mod")){
		%>
 			 <tr>
  				<td scope="row" nowrap>��Ŀ���</td>
    			<td>
    			<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" 
    		 	 size="35" maxlength="50" readonly="readonly"/>
    			<span class="biTian">*</span>
     			</td>
  				<td scope="row" nowrap>��ͬ���</td>
    			<td>
    			<input name="contract_id" id="contract_id" type="text" value="<%=list.get(0)%>" 
    		 	 size="25" maxlength="50" readonly="readonly"/>
    			<span class="biTian">*</span>
     			</td>
	 			<td scope="row" nowrap>��������</td>
    		    <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
					<select name="currency" id="currency">
					<script>
							w(mSetOpt("<%=list.get(1)%>","�����|��Ԫ|��Ԫ|��������|�¹����|�۱�|���ô�Ԫ|������|��ʿ����|����ʱ����|ŷԪ","0|1|2|3|4|5|6|7|8|9|10")); 
					</script>
					</select>
    				<span class="biTian">*</span>
				</td>
    			<td scope="row" nowrap>�豸���</td>
    				<td>
    					<input name="equip_amt" id="equip_amt" type="text" 
    						value="<%=formatNumberDoubleTwo(getDBStr(list.get(2)))%>" 
    						dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"
    						onchange="changeFirst_payment()"/>
       				<span class="biTian">*</span>
     			</td>
  			</tr> 
  				
  			<tr>
      			<td scope="row" nowrap>�׸���</td>
      			<td>
    				<input name="first_payment" type="text" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(3)))%>" 
    				onchange="changeFirst_payment()" 
    				dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
    				<span class="biTian">*</span>
   	   			</td> 
 				<!--  ���ޱ��� = �豸��� - �׸���   -->
   				<td scope="row" nowrap>���ޱ���</td>
    			 <td>
    				<input name="lease_money" id="lease_money" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(4)))%>" 
    				readonly type="text" Require="true" 
    				dataType="Money" size="20" maxlength="100" maxB="100"/>
    				<span class="biTian">*</span>
	 			</td>
	 			<td  scope="row" nowrap>���ޱ�֤��</td>
				<td>
					<input name="caution_money" id="caution_money"
					 value="<%=formatNumberDoubleTwo(getDBStr(list.get(5)))%>" 
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true" 
					onchange="assignment()" type="text"/>
					<span class="biTian">*</span>
				</td>
				<td  scope="row" nowrap>����������</td>
				<td>
					<input name="handling_charge" type="text" 
					value="<%=formatNumberDoubleTwo(getDBStr(list.get(7)))%>" 
		 			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
		 			onchange="assignment()" />
					<span class="biTian">*</span>
				</td>
  			</tr>

   			<tr>
   				<td scope="row" nowrap>�����</td>
			    <td colspan="">
			    	<input name="management_fee" type="text" value="<%=getDBStr(list.get(38))%>"  
			    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" onchange=""/> 
					<span class="biTian">*</span>
				</td>
  				<td scope="row" nowrap>�����ʶ�</td>
   	 			<td>
    				<!-- onclick="assignment()"  �����ʶ� = ���ޱ��� - ��֤��  -->
    				<input name="net_lease_money" id="net_lease_money" type="text" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(6)))%>" readonly 
    				dataType="Money" size="20" maxlength="20" maxB="20"  Require="true" onclick="assignment()"/>
    				�����ʶ����
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="<%=formatNumberDoubleTwo(getDBStr(list.get(32)))%>" size="5" 
					maxlength="5" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
				</td>
	 			<td scope="row" nowrap>���ⷽʽ</td>
	   			<td>
	   	 			<select name="income_number_year" id="income_number_year" 
	   	 				onchange="changIncome_number_year_value()">
						<script>
								w(mSetOpt("<%=list.get(8)%>","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
						</script>
					</select>
	   				<span class="biTian">*</span>
				</td>
				<td scope="row" nowrap>��������</td>
			    <td>
			    <select name="period_type" >
			        <script>
				        	w(mSetOpt('<%=list.get(12)%>',"�ڳ�|��ĩ","1|0"));
			        </script>
			     </select>
			     <span class="biTian">*</span>
				</td> 
		 	</tr>
		  
		  <tr>
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" type="text" value="<%=list.get(10)%>" onChange="changLeaseT_value()"
		    		dataType="Integer" size="20" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td>
		    	<input name="lease_term" type="text" value="<%=list.get(9)%>" onClick="changLeaseT_value()" 
		    		dataType="Integer" size="10" maxlength="10" maxB="10"  Require="true" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
		<!--   -->
			<td  scope="row" nowrap>�ʲ���ֵ</td>
			<td>
				<input name="nominalprice" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(11)))%>"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>���̷���</td>
			<td>
				<input name="return_amt" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(13)))%>"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
					onchange="assignment()" />
				<span class="biTian">*</span>
			</td>
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap>���ʸ�������</td>
		    <td>
		        <select name="rate_float_type" onblur="changeOne()">
		        <script>
			        	w(mSetOpt('<%=list.get(15)%>',"���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="<%=getDBStr(list.get(29))%>" onblur="alertChange()"
		    		dataType="Double" size="20" maxlength="10" maxB="10"  Require="true"/>
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td scope="row" nowrap>��Ϣ��ʽ</td>
		    <td>
		    	<select name="ajdustStyle">
		        <script>
			        	w(mSetOpt('<%=list.get(39)%>',"������|������|������|������","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
		 </tr>
		 
		 <tr>
		 	<td scope="row" nowrap>��ǰϢ</td>
		    <td>
		    	<input name="before_interest" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(16)))%>"  
		    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" onchange="assignment()"/>
		    	<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>����������</td>
			<td>
				<input name="year_rate" id="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"  
					dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="changLeaseT_value()" />%
					<!--  	��ʱ��ȷ���÷����Ƿ�����   
					onPropertychange="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment)"
					--> 
				<span class="biTian">*</span>
			</td>  
		  	<td scope="row" nowrap>���ʵ���ϵ��</td>
		    <td> 
		    	<!-- �������ʵ���ϵ��radio��Ĭ�ϳ�ʼ�� -->
		    	<%
		    		String ramValue = list.get(17);
		    		if(ramValue.equals("365/360")){
		    	%>	
		    		<input type="radio" name="rate_adjustment_modulus" value="360/360" style="border:none;">360/360
					<input type="radio" name="rate_adjustment_modulus" value="365/360" checked style="border:none;">365/360
		    	<%	
		    		}else{ 
		    	%>
		    		<input type="radio" name="rate_adjustment_modulus" value="360/360" checked style="border:none;">360/360
					<input type="radio" name="rate_adjustment_modulus" value="365/360" style="border:none;">365/360
		    	<%
		    		}
		    	%>	
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��Ϣ������</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(18)))%>"  
		         size="20" maxlength="20" dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- ������ж����뷽ʽ ֻ���������� onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('��Ϣ������ȷ��������');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td>  
		  </tr>
		  
		  <tr>
		  	<td  scope="row" nowrap>ÿ�³�����</td>
			<td>
				<select name="income_day">
					<% 
						for(int i = 1;i <= 31;i++){
							int num_temp = Integer.parseInt(getDBStr(list.get(19)));
							if(num_temp == i){
					%>
						<option value="<%=getDBStr(list.get(19))%>" selected><%=getDBStr(list.get(19))%></option>
					<% 
							}else{
					%>
						<option value="<%=i%>"><%=i%></option>	
					<% 
							}
						}
					%>
				</select>	
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>������</td>
			<td>
				<input name="start_date" type="text" value="<%=getDBDateStr(list.get(20))%>"  
					 size="20" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>�����㷽��</td>
			<td><!-- �ȶ��2 ��ʱ���ص� ����0|�ֹ�����3 -->
				<select name="measure_type" onchange="change_disable()">
		        <script>
		        	w(mSetOpt('<%=list.get(22)%>',"�ȶ����|������|ƽϢ��","1|0|5"));
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td> 
			<!-- ����ӵ���ѯ�� -->
		  	<td scope="row" nowrap>��ѯ��</td>
		  	<td >
		  		<input name="consulting_fee" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(30)))%>"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
					onchange="assignment()" />
				<span class="biTian">*</span>
				
				<!-- �Ǽ���  ȡ��¼�˵����� -->
				<input type="hidden" name="creator" value="<%=getDBStr(list.get(25))%>"  />
				<!-- �Ǽ�ʱ�� -->
				<input name="create_date" type="hidden" value="<%=getDBStr(list.get(26))%>"/> 
				<!-- ������ -->
				<input name="modificator" type="hidden" value="<%=getDBStr(list.get(28))%>" />
				<!-- �������� -->
				<input name="modify_date" type="hidden" value="<%=getDBStr(list.get(27))%>" /> 
			</td>
		</tr>
		
		<tr>
			<td scope="row" nowrap>�г�IRR</td>
		  	<td>
		  		<input name="market_irr" type="text" value="<%=formatNumberStr(getDBStr(list.get(31)),"#,##0.000000")%>"  
					size="13" maxlength="10" readonly="readonly" />%
			</td>
			<!-- ��������Ϊ����IRR ԭ����Ϊ�ڲ�������(IRR) -->
			<td  scope="row" nowrap>����IRR</td>
			<td>
				<input name="plan_irr" type="text" value="<%=formatNumberStr(getDBStr(list.get(21)),"#,##0.000000")%>"  
					size="20" maxlength="10" readonly="readonly" />%
			</td> 
		  	<!-- ����ӵĻ�ƺ��㱾�� = �����ʶ�+��֤��  2010-08-06 -->
		  	<td scope="row" nowrap>��ƺ��㱾��</td>
		  	<td>
		  		<input name="accountPrincipal" type="text" 
		  			value="<%=formatNumberDoubleTwo(getDBStr(list.get(33)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onblur="get_APValue()" readonly="readonly"/>
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>�����ۿ�</td>
		  	<td>
		  		<input name="liugprice" type="text" 
		  			value="<%=formatNumberDoubleTwo(getDBStr(list.get(35)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onblur="get_APValue()"/>
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	<td  scope="row" nowrap>��������</td>
			<td>
				<input name="other_income" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(23)))%>"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require=""
					onchange="assignment()" />
			</td>
			<td scope="row" nowrap>����֧��</td>
		    <td>
		    	<input name="other_expenditure" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(24)))%>"  
		    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" 
		    		onchange="assignment()" /> 
			</td>
			<!-- �����ֶ� 2010-08-20--->
			<td scope="row" nowrap>Բ����</td>
		  	<td>
		  		<select name="rentScale">
		        <script>
		        	var rentScaleValue = '<%=list.get(34)%>';
		        	//alert(rentScaleValue);
		        	if(rentScaleValue != null && rentScaleValue != ''){
			        	w(mSetOpt('<%=list.get(34)%>',"Ԫ|��|��","0|1|2"));
		        	}else{
			        	w(mSetOpt('0',"Ԫ|��|��","0|1|2"));
		        	}
			        
		        </script>
		        </select>
				<span class="biTian">*</span>
		    </td>
		    <td  scope="row" nowrap>�ӳ�����</td>
			<td>
				<input name="delay" type="text" value="<%=getDBStr(list.get(36))%>"  
					dataType="Integer" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
		 </tr>  
		      
		 <tr>
		 	<td scope="row" nowrap>��������</td>
		    <td colspan="">
		    	<input name="grace" type="text" value="<%=getDBStr(list.get(37))%>"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" onchange="assignment()"/> 
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>�豸�˻�</td>
		    <td colspan="">
		    	<select name="amt_return" onchange="">
			        <script>
			        	var amt_return = '<%=list.get(40)%>';
			        	if(amt_return != null && amt_return != ''){
				        	w(mSetOpt('<%=list.get(40)%>',"��|��","��|��"));
			        	}else{
				        	w(mSetOpt('��',"��|��","��|��"));
			        	}
				        
			        </script>
		        </select>
			</td>
		    <td colspan="4">    
				<BUTTON class="btn_2" name="btnSave" value="������"  onClick="submitForm()">
				<img src="../../images/save.gif" align="absmiddle" border="0">������</button>
			  </td>
		  </tr>
		<% 	
			//********************************************************************************************add	
		}else{
		%>
		<!-- <input type="hidden" name="proj_id" id="proj_id" value=""/> -->
		  <tr>
		  	<td scope="row" nowrap>��Ŀ���</td>
		    <td>
		    	<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" 
		    		  size="20" maxlength="50" readonly="readonly"/>
		    	<span class="biTian">*</span>
		     </td>
		     <td scope="row" nowrap>��ͬ���</td>
    			<td>
    			<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" 
    		 	 size="20" maxlength="50" readonly="readonly"/>
    			<span class="biTian">*</span>
     			</td>
			 <td scope="row" nowrap>��������</td>
		     <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
				<select name="currency" id="currency">
					<script>
						w(mSetOpt("0","�����|��Ԫ|��Ԫ|��������|�¹����|�۱�|���ô�Ԫ|������|��ʿ����|����ʱ����|ŷԪ","0|1|2|3|4|5|6|7|8|9|10")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>�豸���</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0" onchange="changeFirst_payment()"
		    		dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		  </tr> 
		  	
		  <tr>
		     <td scope="row" nowrap>�׸���</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	onchange="changeFirst_payment()" dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
		    	<span class="biTian">*</span>
		   	   </td> 
			  <!--  ���ޱ��� = �豸��� - �׸��� onclick="changeFirst_payment()"   -->
			   <td scope="row" nowrap>���ޱ���</td>
			     <td>
			    	<input name="lease_money" id="lease_money" value="0" 
			    	readonly type="text" Require="true" dataType="Money" size="20" maxlength="100" maxB="100" Require="true"/>
			    	<span class="biTian">*</span>
				</td>
				<td  scope="row" nowrap>���ޱ�֤��</td>
				<td>
					<input name="caution_money" id="caution_money" value="0" 
						dataType="Money" size="20" maxlength="20" maxB="20"  Require="true" 
						onchange="assignment()" type="text"/>
					<span class="biTian">*</span>
				</td>
				<td  scope="row" nowrap>����������</td>
				<td>
					<input name="handling_charge" type="text" value="0" 
					 	dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
					 	onchange="assignment()" />
					<span class="biTian">*</span>
				</td> 
		  </tr>
		
		  <tr>
		  	<td scope="row" nowrap>�����</td>
		    <td colspan="">
		    	<input name="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" onchange=""/> 
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>�����ʶ�</td>
		    <td>
		    	<!--onclick="assignment()"  �����ʶ� = ���ޱ��� - ��֤��  -->
		    	<input name="net_lease_money" id="net_lease_money" type="text" 
		    		value="0" readonly onclick="assignment()"
		    		dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		    	�����ʶ����
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="" size="5" 
					maxlength="5" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>%  
		    		<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ⷽʽ</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" onchange="changIncome_number_year_value()">
					<script>
						w(mSetOpt("","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��������</td>
		    <td><select name="period_type" >
		        <script>
			        w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        </script>
		        </select>
		        <span class="biTian">*</span>
			</td> 
		  </tr>	
		
		  <tr> 
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" type="text" value="0"    onChange="changLeaseT_value()"
		    		dataType="Integer" size="20" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="10" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>�ʲ���ֵ</td>
			<td>
				<input name="nominalprice" type="text" value="0"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>���̷���</td>
			<td>
				<input name="return_amt" type="text" value="0"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
					onchange="assignment()" />
				<span class="biTian">*</span>
			</td>
		 </tr>
		 	
		 <tr>
		  	<td scope="row" nowrap>���ʸ�������</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()">
		        <script>
			        w(mSetOpt('0',"���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="20" maxlength="10" maxB="10" Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td scope="row" nowrap>��Ϣ��ʽ</td>
		    <td>
		    	<select name="ajdustStyle">
		        <script>
		        	w(mSetOpt('0',"������|������|������|������","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
		 </tr>
		
		 <tr>
			<td scope="row" nowrap>��ǰϢ</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="assignment()"
		    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		  <td  scope="row" nowrap>����������</td>
			<td>
				<input name="year_rate" id="year_rate" type="text" value=""  onblur="changLeaseT_value()" 
					dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true"/>%
					<!--  	��ʱ��ȷ���÷����Ƿ�����   
					onPropertychange="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment)"
					--> 
				<span class="biTian">*</span>
			</td>  
		  	<td scope="row" nowrap>���ʵ���ϵ��</td>
		    <td> 
		    	<!-- �������ʵ���ϵ��radio��Ĭ�ϳ�ʼ�� -->
		    	<input type="radio" name="rate_adjustment_modulus" value="360/360" checked style="border:none;">360/360
				<input type="radio" name="rate_adjustment_modulus" value="365/360" style="border:none;">365/360
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��Ϣ������</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="20" maxlength="20" dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- ������ж����뷽ʽ ֻ���������� onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('��Ϣ������ȷ��������');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			 </td>  
		  </tr>
		  
		  <tr>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"  -->	 
			<td  scope="row" nowrap>ÿ�³�����</td>
			<td>
				<select name="income_day">
					<% 
						for(int i = 1;i <= 31;i++){
					%>
						<option value="<%=i%>"><%=i%></option>
					<% 
						}
					%>
				</select>	 
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>������</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="20" maxlength="20" Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			<!-- �ȶ��2 ��ʱ���ص�   ����0|�ֹ�����3-->
			<td  scope="row" nowrap>�����㷽��</td>
			<td>
				<select name="measure_type"  onchange="change_disable()">
		        <script>
			        w(mSetOpt('1',"�ȶ����|������|ƽϢ��","1|0|5"));
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td>
			<!-- ����ӵ���ѯ�� -->
		  	<td scope="row" nowrap>��ѯ��</td>
		  	<td >
		  		<input name="consulting_fee" type="text" value="0"  
					dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
					onchange="assignment()" />
				<span class="biTian">*</span>
				
				<!-- �Ǽ���  ȡ��¼�˵����� -->
				<input type="hidden" name="creator" value=""/>
				<!-- �Ǽ�ʱ�� -->
				<input name="create_date" type="hidden" value="<%=nowDateTime%>" /> 
				<!-- ������ -->
				<input name="modificator" type="hidden" value=""/>
				<!-- �������� -->
				<input name="modify_date" type="hidden" value="<%=nowDateTime%>" /> 
			</td> 
		  </tr>
		  
	   
	  	<tr>
			<td scope="row" nowrap>�г�IRR</td>
		  	<td>
		  		<input name="market_irr" type="text" value="0"  
					size="13" maxlength="10" readonly="readonly" />%
			</td>
			<td  scope="row" nowrap>����IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0"  
				  size="20" maxlength="10" readonly/>
			</td> 
			<!-- ����ӵĻ�ƺ��㱾�� = �����ʶ�+��֤��  2010-08-06 -->
		  	<td scope="row" nowrap>��ƺ��㱾��</td>
		  	<td>
		  		<input name="accountPrincipal" type="text" 
		  			value="0"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onblur="get_APValue()" readonly="readonly"/>
				<span class="biTian">*</span>
			</td>
			<!-- �����ֶ� 2010-09-21 ԭ���������۸ĳɲ�ֵ--->
			<td scope="row" nowrap>�����ۿ�</td>
		  	<td>
		  		<input name="liugprice" type="text" 
		  			value="0.00"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
		</tr>
		  
		  <tr>
		  	<td  scope="row" nowrap>��������</td>
			<td>
				<input name="other_income" type="text" value="0"  
					  size="20" maxlength="20"  onchange="assignment()" />
			</td>
			<td scope="row" nowrap>����֧��</td>
		    <td>
		    	<input name="other_expenditure" type="text" value="0"
		    		  size="20" maxlength="10" onchange="assignment()" /> 
			</td>
			<!-- �����ֶ� 2010-08-19-->
			<td scope="row" nowrap>Բ����</td>
		  	<td>
		  		<select name="rentScale">
		        <script>
			        w(mSetOpt('0',"Ԫ|��|��","0|1|2"));
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>�ӳ�����</td>
			<td>
				<input name="delay" type="text" value="0"  
					dataType="Integer" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()" />
				<span class="biTian">*</span>
			</td>
		 </tr>  
		      
		 <tr>
		 	<td scope="row" nowrap>��������</td>
		    <td colspan="">
		    	<input name="grace" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" onchange="assignment()"/> 
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>�豸�˻�</td>
			    <td colspan="">
			    	<select name="amt_return">
				        <script>
				        	w(mSetOpt('��',"��|��","��|��"));
				        </script>
			        </select>
				</td>
			<td colspan="4">
				<BUTTON class="btn_2" name="btnSave" value="������"  onClick="submitForm()">
				<img src="../../images/save.gif" align="absmiddle" border="0">������</button>
			</td>
		  </tr>
		<%
		}
		db.close();
		%>
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
</html>
<<script type="text/javascript">
	//ajax------------------------------------------------------------------------------------
var xmlreq = false; //����һ��XMLHttpRequest����  
function newXMLHttpRequest() {    
    if (window.XMLHttpRequest) {    
         xmlreq = new XMLHttpRequest();  // �ڷ�Microsoft������д���XMLHttpRequest����    
     }
     else if (window.ActiveXObject)
     {    
        try 
        {   //ͨ��MS ActiveX����XMLHttpRequest    
            xmlreq = new ActiveXObject("Msxml2.XMLHTTP");   // ���԰��°�InternetExplorer��������    
        } catch (e1) {    
            try 
            {   // ���������ActiveX����ʧ��    
                xmlreq = new ActiveXObject("Microsoft.XMLHTTP");    // ���԰��ϰ�InternetExplorer��������    
            }
           	catch (e2) 
            {    
	                 // ����ͨ��ActiveX����XMLHttpRequest    
            }    
       	}    
     }    
}
function sendStreet(period_type,lt_value,main_proj_id,income_number_year){ 
//ע������������servlet��ע��web.xml�������	  
 url="<%=context%>/AjaxServlet?period_type="+period_type+"&lease_term="+lt_value+"&main_proj_id="+main_proj_id+"&income_number_year="+income_number_year;
 param= "";
    if(url.length == 0){    
        return;    
    }else{    
        if( param == null || param == "undefined" ){    
            param = "";    
        }    
        newXMLHttpRequest();    
        try{    
            xmlreq.onreadystatechange=getStreet;    //ָ����Ӧ�ĺ��� proce()    
            xmlreq.open("GET", url, true);      //��GET��ʽ�������ݣ���url�����첽��ʽ    
            xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");    
            xmlreq.send(param); //��������    
        }catch(exception){    
            alert("��Ҫ���ʵ���Դ������!");    
        }    
    }     
}  
//�ص����� �Ƿ���    
function getStreet(){    
    if(xmlreq.readyState == 4){     //����״̬    
        if(xmlreq.status == 200 || xmlreq.status == 0){ //��Ϣ�ѳɹ����أ���ʼ������Ϣ;      
            addStreet(xmlreq.responseText); 
        }else{  
            window.alert("�������ҳ�����쳣");    
            alert(xmlreq.statusText);    
        }    
    }    
} 
//������չ����Ľ��
function addStreet(returnvalue){
	var r_v = trim(returnvalue);
   if(returnvalue!="" && returnvalue!= null && r_v.length > 0){
		document.getElementById("year_rate").value = returnvalue;
		document.getElementById("year_rate").readOnly = true;
	}else{ 
		//document.getElementById("year_rate").value = "0";
		document.getElementById("year_rate").readOnly = false;
	}
} 
</script>
