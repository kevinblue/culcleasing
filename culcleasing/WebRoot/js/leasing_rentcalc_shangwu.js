/**
 *��ʼ��һЩ���¼�
 */
$(document).ready(function(){
	$(":radio[name='before_interest_type']").click(function(){
		var $bit_val = $(":radio[name='before_interest_type']:checked").val();
		//alert("��ѡ��"+$bit_val);
		changeTwoData();
	});
	//��ֹĳ����ø���
	$("#proj_id").attr("readonly","readonly");
	$("#contract_id").attr("readonly","readonly");
	$(":input[name='free_defa_inter_day']").attr("readonly","readonly");
	//��Ӽ���ʧȥ�����ж�ֵ�Ƿ���ȷ

	$(":input[name='income_number']").blur(function(){//�껹�����
		if( $(this).val()=="0" || isNaN($(this).val()) ){//!/^\d+$/.test($(this).val())
			alert("�껹�������д������");
			$(this).val(0);
			//$(this).focus();
		}
	});
	//��𹫱Ȳ��� ratio_param
	$(":input[name='ratio_param']").blur(function(){//����
		//��ȡ�����㷽ʽ
		var stm = $("#settle_method").val();
		var ratio_param = $(this).val();

		if( stm=="RentCalcType3" || stm=="RentCalcType6" ){
			if( isNaN(ratio_param) ){
				alert("��Ǹ������ֻ�ܲ�����д�ַ�");
				$(this).val(0.51);
				$(this).focus();
			}else if( ratio_param<=0.5 || ratio_param>=1.5 ){
				alert("����ֻ����0.5��1.5֮��");
				//$(this).val(0);
				$(this).val(0.51);
				$(this).focus();
			}
		}else if( stm=="RentCalcType2" || stm=="RentCalcType5" ){
			if( isNaN(ratio_param) ){
				alert("��Ǹ������ֻ�ܲ�����д�ַ�");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param==0 ){
				alert("���������0");
				//$(this).val(0);
				$(this).focus();
			}
		}
	});
	
	//���շ�ʽ�л�ѡ��
//	$("#insure_type").change(function(){
	//	if($(this).val()=="insure_type1"){
	//		$(":input[name='insure_money']").removeAttr("readonly");
	//	}else if($(this).val()=="insure_type2"){
	//		$(":input[name='insure_money']").removeAttr("readonly");
	//	}else{
			//$(":input[name='insure_money']").val("0");
			//$(":input[name='insure_money']").attr("readonly","readonly");
	//	}
//	});
	
	//���շ�ʽ�л�ѡ��
	$("#insure_type").change(function(){
		if($(this).val()=="insure_type1"){
			$(":input[name='insure_money']").removeAttr("readonly");
			$("#insure_pay_type").val("root.insurPayType.004");
			//$("select[name='insure_pay_type']").val("root.insurPayType.004");
		}else if($(this).val()=="insure_type2"){
			$(":input[name='insure_money']").removeAttr("readonly");
		}else{
			//$(":input[name='insure_money']").val("0");
			//$(":input[name='insure_money']").attr("readonly","readonly");
			$("select[name='insure_pay_type']").val("root.insurPayType.004");
		}
	});
	//����������ÿ�³�����
	$(":input[name='start_date']").bind("propertychange",function(){
		var staDate = $(this).val();
		var incDay = staDate.substr(staDate.length-2);

		if(incDay.substr(0,1)=="0"){
			incDay = incDay.substr(1,1);
		}
		//alert("dd"+incDay);
		$("select[name='income_day2']").val(incDay);
		$("#income_day").val(incDay);
		$("select[name='income_day2']").attr("disabled","disabled");
	});
});

//��Ŀ���У��
function checkDataInvalid(totalM,usedM){
	var equipAmt= dataBack($("#equip_amt").val());
	
	if(totalM==""){
		totalM=0;
	}
	if(usedM==""){
		usedM=0;
	}
	//У������д��ȷ
	if(isNaN(equipAmt) || equipAmt<=0){
		alert("��������ȷ���豸���������0��");
		$("#equip_amt").val("0");
	}else{
		//alert("je1: "+equipAmt+"  je2: "+usedM+"  je3: "+ totalM);
		var uM = FloatSub(totalM*1.0,FloatAdd(equipAmt*1.0,usedM*1.0));
	}

}
	

/**
 * �����㷽���ı�
 */
function changeCalcWay(){
	var settle_methodVal = $("#settle_method").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("��𹫲�");
		$("#bj_2").show();
		$("#bj_3").text("��������0");
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("���𹫲�");
		$("#bj_2").show();
		$("#bj_3").text("��������0");
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("��𹫱�");
		$("#bj_2").show();
		$("#bj_3").text("ֻ����0.5��1.5֮��");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("���𹫱�");
		$("#bj_2").show();
		$("#bj_3").text("ֻ����0.5��1.5֮��");
	}else if( settle_methodVal=="RentCalcType7" ){
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
		$("#period_type").val("0");
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
	}
}

/**
 * �����㷽���ı�
 */
function changeCalcWay2(){
	var settle_methodVal = $("#settle_method2").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("��𹫲�");
		$("#bj_2").show();
		$("#bj_3").text("��������0");
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("���𹫲�");
		$("#bj_2").show();
		$("#bj_3").text("��������0");
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("��𹫱�");
		$("#bj_2").show();
		$("#bj_3").text("ֻ����0.5��1.5֮��");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("���𹫱�");
		$("#bj_2").show();
		$("#bj_3").text("ֻ����0.5��1.5֮��");
	}else if( settle_methodVal=="RentCalcType7" ){
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
		$("#period_type").val("0");
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
	}
}

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
         ���ޱ����	�豸��-�׸���Զ����㣬���ɸ�
		�׸���	�ֶ�������տ�
		��֤��	�ֶ�������տ�
		�����ʶ�	�����ʶ�=��-��-��-��-��-��-��+��+��-��+11-12

		����	��֧���
		1-�豸���	֧
		2-�׸���	     ��
		3-���ޱ�֤��	��
		4-����������	��
		5-�����	    ��
		6-��ֵ����	��
		7-���̷���	��
		8-��ǰϢ	    ��
		9-��Ϣ����	��
		11-��������	��
		13-��ѯ������	��

		10-����Ϣ	    ֧
		12-����֧��	֧
		14-��ѯ��֧��	֧
		15-���ѽ��	֧
*/
function assignment(){ 

	var equip_amt = dataBack( $("#equip_amt").val());//�豸��
	var first_payment = dataBack( $("#first_payment").val());//�׸���
	var caution_money_value =dataBack( $("#caution_money").val()); //��֤��
	var lease_capital_value =dataBack( $("#lease_money").val());  //���ޱ���
	var handling_charge =dataBack( $("#handling_charge").val());//������
	var management_fee = dataBack( $("#management_fee").val());//�����
	
//	var equip_amt = document.getElementsByName("equip_amt")[0].value;//�豸��
//	var first_payment = document.getElementsByName("first_payment")[0].value;//�׸���
//	var caution_money_value = document.getElementsByName("caution_money")[0].value;//��֤��
//	var lease_capital_value = document.getElementsByName("lease_money")[0].value;//���ޱ���
//	var handling_charge = document.getElementsByName("handling_charge")[0].value;//������
//	var management_fee = document.getElementsByName("management_fee")[0].value;//�����
	
	
	//sys ��ֵ��ȡȡ��2011.12.27
	//var nominalprice = huifu( $("#nominalprice").val());//��ֵ����\
	//var nominalprice = document.getElementsByName("nominalprice")[0].value;//��ֵ����
	
	var return_amt = dataBack( $("#return_amt").val());//���̷���
	var before_interest = dataBack( $("#before_interest").val());//��ǰϢ
	var rate_subsidy = dataBack( $("#rate_subsidy").val());//��Ϣ����
	var discount_rate = dataBack( $("#discount_rate").val());//����Ϣ

//	var return_amt = document.getElementsByName("return_amt")[0].value;//���̷���
//	var before_interest = document.getElementsByName("before_interest")[0].value;//��ǰϢ
//	var rate_subsidy = document.getElementsByName("rate_subsidy")[0].value;//��Ϣ����
//	var discount_rate = document.getElementsByName("discount_rate")[0].value;//����Ϣ
	
	var other_income = dataBack( $("#other_income").val());//��������
	var other_expenditure = dataBack( $("#other_expenditure").val());//����֧��

//	var other_income = document.getElementsByName("other_income")[0].value;//��������
//	var other_expenditure = document.getElementsByName("other_expenditure")[0].value;//����֧��

	var consulting_fee_in = dataBack( $("#consulting_fee_in").val());//��ѯ������
	var consulting_fee_out = dataBack( $("#consulting_fee_out").val());//��ѯ��֧��
	var insure_money =dataBack( $("#insure_money").val());//���ѽ��
	
//	var consulting_fee_in = document.getElementsByName("consulting_fee_in")[0].value;//��ѯ������
//	var consulting_fee_out = document.getElementsByName("consulting_fee_out")[0].value;//��ѯ��֧��
//	var insure_money = document.getElementsByName("insure_money")[0].value;//���ѽ��
	//2012-4-5 Jaffe�޸ģ�������� ���շѸ��ݱ���֧������ ��˾���� ��Ϊ֧�� ������������
	var insure_type = $("#insure_type").val();
	
	if((lease_capital_value == null || lease_capital_value == '') || (caution_money_value == null || caution_money_value == '')){
		alert("���ޱ���ͱ�֤����Ϊ��,�����ʶ�=���ޱ���-��֤��!");
		document.all.lease_money.focus();
		return false;
	}else{ 
		var lease_amt_value ; 
		//�����ʶ�=�豸��-�׸���-��֤��-������-�����-��ֵ����-���̷���-��ǰϢ-��Ϣ����-��������-��ѯ������+����Ϣ+����֧��+��ѯ��֧��+���ѽ��	
		// lease_amt_value = equip_amt - caution_money_value - handling_charge - return_amt - 
		// other_income + consulting_fee_out + other_expenditure-before_interest-management_fee;
		var value1 = FloatSub(equip_amt,first_payment);
		
		var value2 = FloatSub(FloatSub(value1, caution_money_value),handling_charge);
		//alert("__"+value1+"----"+value2);
		
		var value3 = FloatSub(value2, management_fee);
		var value4 = value3;
		//==���Ӳ���==
		//var value4 = FloatSub(value3, nominalprice);
		
		var value5 = FloatSub(value4, return_amt);
		var value6 = FloatSub(value5, before_interest);
		
		var value7 = FloatSub(value6, rate_subsidy) ;
		var value8 = FloatSub(value7, other_income) ;
		var value9 = FloatSub(value8, consulting_fee_in);
		//alert("value9"+value9);

		var value10 = FloatAdd(discount_rate,other_expenditure);//�ӷ����ܺ�
		
		//2012-4-5 Jaffe�޸�  insure_type1
		var value11 = "0";
		//var value11 = FloatAdd(consulting_fee_out,insure_money);//�ӷ����ܺ�
		if( (insure_type != null && insure_type == 'insure_type1') ){
			value11  = FloatAdd(consulting_fee_out, insure_money);//��ȥ
		}else{
			value11 = consulting_fee_out;
		}

		//alert(value10+">>>>>"+value11);
		
		lease_amt_value = FloatAdd(value9,value10);
		lease_amt_value = FloatAdd(lease_amt_value,value11);
		
		document.getElementsByName("actual_fund")[0].value = lease_amt_value;
		//���㡮��ƺ��㱾��=�����ʶ�ӱ�֤�𡯵�ֵ accountPrincipal
		//var str_num = FloatAdd(caution_money_value,lease_amt_value);
		//document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
	getlmp_value();
}

function changeTwoData(){
	changeFirst_payment();
	assignment();
}
//��ƺ��㱾��ֵ
function get_APValue(){
	var caution_money = document.getElementsByName("caution_money")[0].value;//��֤��
	var actual_fund = document.getElementsByName("actual_fund")[0].value;
	if(caution_money == null || caution_money == '' || actual_fund == null || actual_fund == ''){
		alert("��ѡ�������ޱ�֤��;����ʶ��ֵ!");
		return false;
	}else{
		//���㡮��ƺ��㱾��=�����ʶ�ӱ�֤�𡯵�ֵ accountPrincipal
		var str_num = FloatAdd(caution_money,actual_fund);
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
  
//
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
		}
	}else{
		alert("��ѡ���ⷽʽ!");
		return false;
	}
}

/*
    �������壺
     // ���ݹ�ʽ�����ޱ��� = �豸��� - �׸��� �������ޱ����ֵ��
      CULC-�������У� ���ݹ�ʽ�����ޱ��� = �豸��� - �׸��� + ��ǰϢ + ���˵��� �������ޱ����ֵ��
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
	var equip_amt = dataBack($("#equip_amt").val());//�豸��� 
	var first_payment =dataBack( $("#first_payment").val());//�׸���
	var before_interest =dataBack( $("#before_interest").val());//��ǰϢ
	var before_interest_type = $(":radio[name='before_interest_type']:checked").val();//��ǰϢ-����-�Ƿ��㱾
	//sys���˵�����ֵȡ�� 12.27
	//var assess_adjust = document.getElementsByName("assess_adjust")[0].value;//���˵���
	
	//�ж��Ƿ�����
	if(equip_amt == null || equip_amt == ''){
		alert("�������豸���!");
		
		document.all.equip_amt.focus();
		return false;
	}
	//�ж������Ƿ�Ϸ�
	var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	if(reg_money.test(equip_amt)== false){
		str = "�豸���-���Ҹ�ʽ����";//
		alert(str);
		document.all.equip_amt.focus();
		return false;
	}
	if(reg_money.test(first_payment)== false){
		str = "�׸���-���Ҹ�ʽ����";//
		alert(str);
		document.all.first_payment.focus();
		return false;
	}
	//�������ޱ���
	var numValue = FloatSub(equip_amt,first_payment);
	if(before_interest_type!=null && "��"==before_interest_type ){
		numValue = FloatAdd(numValue,before_interest);
		//numValue = FloatSub(numValue,before_interest);
	}
	//sys���˵���ȡ��12.27
	//numValue = FloatAdd(numValue,assess_adjust);
	
	//var numValue = equip_amt - first_payment;
	//��2λС�� forcepos()ע�� 154951705.36 30990341.00
	numValue = forcepos(numValue,2);
	document.getElementsByName("lease_money")[0].value = numValue;//���ޱ���
	//���������ʶΪ�� �����ʶ�=���ޱ���-��֤�� �����׸��� �����豸���ĸ��� �����ʶ� �����¿����¼���
	document.getElementsByName("actual_fund")[0].value = '0.00';
	//assignment();
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

//���ʵ���ֵ����������ʵ���ֵ������ʾ������
function alertChange(){
	var rate_float_amt = document.getElementsByName("rate_float_amt")[0].value;//���ʵ���ֵ
	//���ʸ������� "���������ʸ�������|���������ʼӵ�|��������|�����ӵ�|���ֲ���","0|1|2|4|3"
	//���������ʸ�������  - 		���е���ֵ * (1+����ֵ) + ������
	//���������ʼӵ�			���е���ֵ + ������
	//�������� 			1+���е���ֵ/�ϴ�����ֵ * ����ֵ -- �ϴ�����ֵ = ���λ���ֵ - ���е���ֵ
	//�����ӵ�			���е���ֵ + ������
	//�̶�����  			
	
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
	//
	if(rate_float_amt == '' || rate_float_amt == null){
		div_rate.style.displa = 'block';
	}else{
		if(rate_float_type == '0'){//2010-11-23�����޸�
			name = "���������ʸ�������";
			div_rate.innerHTML = "<font color='red'>���������ʸ������ʵ���Ϊ�����е���ֵ��(1+"+rate_float_amt+")+������</font>";
		}
		if(rate_float_type == '1'){
			name = "���������ʼӵ�";
			div_rate.innerHTML = "<font color='red'>���������ʼӵ����Ϊ��(���л�������+����)</font>";
		}
		if(rate_float_type == '2'){
			name = "��������";
			div_rate.innerHTML = "<font color='red'>�������ʵ���Ϊ: 1+���е���ֵ/�ϴ�����ֵ*"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '3'){
			name = "�̶�����";
			div_rate.innerHTML = "<font color='red'>�̶�����: "+($(":input[name='year_rate']").val())+"</font>";
		}
		if(rate_float_type == '4'){
			name = "�����ӵ�";
			div_rate.innerHTML = "<font color='red'>�����ӵ�: (���л�������+����)</font>";
		}
	}
}
function changeOne(){
	//���ʸ������� "���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var rate = document.getElementById('rate_float_amt');
	var div_rate = document.getElementById('div_rate');

	/**
	if(rate_float_type == '1' || rate_float_type == '3' || rate_float_type=='4' ){
		document.getElementsByName("rate_float_amt")[0].value = '0';
		rate.disabled = true;
		div_rate.innerHTML = "";
	}else{
		rate.disabled = false;
		//return true;
	}
	**/

	alertChange();
}
//�������Ӿ����ʶ����=�����ʶ�/�豸���
function getlmp_value(){
	var actual_fund =dataBack( $("#actual_fund").val());//�����ʶ�
	//var actual_fund = document.getElementsByName("actual_fund")[0].value;//�����ʶ�
	var equip_amt =dataBack( $("#equip_amt").val());//�����ʶ�
	//var equip_amt = document.getElementsByName("equip_amt")[0].value;//�豸���
	var result;
	if(actual_fund == 0 || equip_amt == 0){
		result = "0";
	}else{
		result = round2places((actual_fund/equip_amt)*100);
	}
	document.getElementsByName("actual_fund_ratio")[0].value = result;
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


//��֤˫��������  
function check_double(obj,obj_name,obj_id){  
    var reg = /^[0-9]+(\.[0-9]+)?$/;  
    if(obj.value!=""&&!reg.test(obj.value)){  
        alert(obj_name+'�������Ϊ��Ч��˫��������');  
        obj.value = "";
        document.getElementById(obj_id).value = ""; 
        obj.focus();  
        return false;  
    }  
} 


	/**
	*  ��֤���е�input�������֤���ָ�ʽ
	*/
	function check_allInput(){
		//�жϲ��㷽ʽ|��������
		if($("#settle_method").val()==""){
			alert("�����㷽�����");
			return false;
		}else if($("#period_type").val()==""){
		
			alert("�������ͱ��");
			return false;
		}else if($("#income_number").val()<=0){
		
			alert("�������������Ҵ���0��");
			return false;
		}

		var savaType = document.getElementById('savaType').value ;//�ж���ӻ����޸�
		var list = document.getElementsByTagName("input");
		var str = "0";
		var count = 0;
		for(var i=0;i<list.length && list[i];i++)
 		{
 			//alert("list[i].type==>"+list[i].type);
 			if(list[i].type == "text"){
 				var text_value = list[i].value;
 				text_value = trim(text_value);//��ȥ�ո�
				 //�Ƿ��ַ�����֤ 				
 				 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
                 if(text_value.match(reg_ff)) { 
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
 		//alert("str1====>"+str);
 		str = trim(str);//��ȥ�ո�
		if(count > 0){
			//alert("join1");
			return false; 
		}else{
			//alert("join2");
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


	/**
	 * ���������ַ��Ƿ���������ַ�
	 * ����:str  �ַ���
	 * ����:true �� flase; true��ʾ���������ַ�
	 * ��Ҫ����ע����Ϣ��ʱ����֤
	 */
	function checkQuote(str){
	    var items = new Array("~", "`", "!", "@", "#", "$", "%", "^", "&", "*", "{", "}", "[", "]", "(", ")");
	    items.push(":", ";", "'", "|", "\\", "<", ">", "?", "/", "<<", ">>", "||", "//");
	    items.push("admin", "administrators", "administrator", "����Ա", "ϵͳ����Ա");
	    items.push("select", "delete", "update", "insert", "create", "drop", "alter", "trancate");
	    str = str.toLowerCase();//���д�д�ַ�ȫ����ת��Ϊ��Сд�ַ�
        //alert(str);
        //029-03-02-2010-00002-0000010
	    for (var i = 0; i < items.length; i++) {
	        if (str.indexOf(items[i]) >= 0) {
	            return true;
	        }
	    }
	    return false;
	}
	
	//�����㰴ť��ת�������ж�
	function submitForm(){
		//HUIFU QIAN FEN WEI
		//$("#equip_amt").focus();	
		//return false;
		 $("input[type='text']").focus();
		 	//alert("���ޱ���:"+$("#lease_money").val());
		 //	alert("�豸���:"+$("#equip_amt").val());
		//�жϼ�����������
		var str = "";
		//�豸����ޱ��� ����<=0
		if($("#equip_amt").val()<=0){
			str = "�豸�����д<=0";
			alert(str);
			$("#equip_amt").focus();
			//create_span(str,equip_amt);
			return false;
		}else if($("#lease_money").val()<=0){
			str = "���ޱ�����<=0";
			alert(str);
			$("#lease_money").focus();
			//create_span(str,lease_money);
			return false;
//		}
//		//���������ʡ��������
//		else if( !/^[0-9]+.?[0-9]*$/.test($(":input[name='year_rate']").val()) ){
//			str = "���������ʲ��Ϸ�";
//			alert(str);
//			$(":input[name='year_rate']").focus();
//			//create_span(str,year_rate);
//			return false;
		}else if( !/^\d+$/.test($(":input[name='income_number']").val()) ){
			str = "�껹�������д������";
			alert(str);
			$(":input[name='income_number']").focus();
			//create_span(str,income_number);
			return false;
		}
		
		changeFirst_payment();
		assignment();
		
		//�ȼ��
		if(check_allInput()==true){
			form1.onsubmit();	
		}
	}

