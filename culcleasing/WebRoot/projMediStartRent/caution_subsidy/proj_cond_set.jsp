<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginMediService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoMediBean"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
/**
 *��ʼ��һЩ���¼�
 */
$(document).ready(function(){
	//��ֹĳ����ø���
	$("#contract_id").attr("readonly","readonly");
	$(":input[name='free_defa_inter_day']").attr("readonly","readonly");
	//��Ӽ���ʧȥ�����ж�ֵ�Ƿ���ȷ
	$(":input[name='income_number']").blur(function(){//�껹�����
		if( !/^\d+$/.test($(this).val()) ){
			alert("�껹�������д������");
			$(this).val(0);
			$(this).focus();
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
		$("#bj_3").text("ֻ����0��1֮��");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("���𹫱�");
		$("#bj_2").show();
		$("#bj_3").text("ֻ����0��1֮��");
	}else if( settle_methodVal=="RentCalcType7" ){
		$("#period_type").val("1");
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$(":input[name='ratio_param']").val("0");
	}
}
</script>
</head>

<%
	//��������	
	String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
	//��ȡ����
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String begin_order_index = getStr(request.getParameter("begin_order_index"));
	String nowDateTime = getSystemDate(0);//��ǰ��ʽ��֮���ʱ��

	//�ж�ִ������ -- �����ݿ��ѯ��������upd����add
	String savaType = BeginMediService.judgeSaveType(begin_id, doc_id);
	
	//1.���upd���װConditionBean
	BeginInfoMediBean beginInfoMediBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfoMediBean  = BeginMediService.initBeginInfoBean(begin_id, doc_id);
	}
%> 

<%
//�����ֵ���������ֵ
if( beginInfoMediBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//�豸��� equip_amt
	$("#equip_amt").val("<%=beginInfoMediBean.getEquip_amt() %>");
	//���ޱ��� lease_money
	$("input[name='lease_money']").val("<%=beginInfoMediBean.getLease_money() %>");
	//�����ʶ� actual_fund
	$("input[name='actual_fund']").val("<%=beginInfoMediBean.getActual_fund() %>");
	
	//Ԥ�������� start_date
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfoMediBean.getRent_start_date()) %>");
	
	//��Ϣ������ pena_rate
	$("input[name='pena_rate']").val("<%=beginInfoMediBean.getPena_rate() %>");
	//���ڿ����� free_defa_inter_day
	$("input[name='free_defa_inter_day']").val("<%=beginInfoMediBean.getFree_defa_inter_day() %>");
	//���ⷽʽ income_number_year
	$("#income_number_year").val("<%=beginInfoMediBean.getIncome_number_year() %>");
	//������� income_number
	$("input[name='income_number']").val("<%=beginInfoMediBean.getIncome_number() %>");
	//��������(��) lease_term
	$("input[name='lease_term']").val("<%=beginInfoMediBean.getLease_term() %>");
	//ÿ�³����� income_day
	$("select[name='income_day2']").val("<%=beginInfoMediBean.getIncome_day() %>");
	$("select[name='income_day']").val("<%=beginInfoMediBean.getIncome_day() %>");
	//Ԥ���տ���������
	$("input[name='plan_bank_name']").val("<%=beginInfoMediBean.getPlan_bank_name() %>");
	//Ԥ���տ������˺�
	$("input[name='plan_bank_no']").val("<%=beginInfoMediBean.getPlan_bank_no() %>");
	
	//��ʾ����
	changeCalcWay();
});
</script>
<%
}
%>

<body onload="public_onload(0);">
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return Validator.Validate(this,2);">
<input type="hidden" name="saveType" id="savaType" value="<%=savaType %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="begin_id" value="<%=begin_id %>">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- ������ֵ  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="80%" align="center" class="tab_table_title">
			<tr height="40" style="font-weight: bold;">
				<%
					String totalLeaseMoney = BeginMediService.getTotalLeaseMoney(contract_id);
					String usedLeaseMoney = BeginMediService.getUsedLeaseMoney(contract_id);
					String leftLeaseMoney = MathExtend.subtract(totalLeaseMoney, usedLeaseMoney);
				%>
				<td colspan="3" style="font-size: 16px;">��ͬ��Ϣ������<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalLeaseMoney) %></b></td>
				<td colspan="3" style="font-size: 16px;">��ʹ����Ϣ������<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedLeaseMoney) %></b></td>
				<td colspan="2" style="font-size: 16px;">ʣ����Ϣ������<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftLeaseMoney) %></b>
				<input type="hidden" id="validLM" value="<%=leftLeaseMoney %>">
				<input type="hidden" name="begin_order_index" id="begin_order_index" value="<%=begin_order_index %>">
				</td>
			</tr>
			<tr><td colspan="8"></td></tr>
			<tr><td colspan="8"></td></tr>
			
		  <!-- ������Ϣ������Ϣ -->	
		  <tr>
		  	<!-- �����ֶν��� -->
		  	<td scope="row" nowrap>������Ϣ�������</td>
		    <td>
		    	<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" size="25" maxlength="50"/>
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>��Ϣ��Ϣ��������</td>
		     <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
		    	<span class="biTian">*</span>
			</td>
		    
		  </tr> 
		  
		  <tr>
			
		  	<td scope="row" nowrap>��Ϣ������</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />%%
		    	<span class="biTian">*</span>
			</td>  
			
			<td scope="row" nowrap>���ڿ�����</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="3"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			
			 <td scope="row" id="bj_3">�ƻ��տ������</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly">
		    </td>
		
		    <td scope="row" id="bj_4">�ƻ��տ������˺�</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly">
		    
		    <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)">
		    </td>
		  </tr>
		  
		  <tr>
		   <td scope="row" nowrap>���ⷽʽ</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" type="text" value="0"  onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>ÿ�³�����</td>
			<td>
				<input type="hidden" name="income_day" id="income_day" value="<%=getCurrentDatePart(3) %>">
				<select name="income_day2" style="width: 100px;" disabled="disabled">
					<script type="text/javascript">
						for(var i=1;i<=31;i++){
							document.write("<option value='"+i+"'>"+i+"</option>");
						}
					</script>
				</select>	 
				<span class="biTian">*</span>
			</td>
		  </tr>	
		 
		  
		</table>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
<script type="text/javascript">
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
//�жϱ��ε����ʱ������Ƿ�Ϸ�
function checkValid(){
	var validLM = $("#validLM").val();
	var lm = $("#lease_money").val();
	
	if(isNaN(validLM)) validLM = 0;
    if(isNaN(lm)) lm = 0;

	//�ж������Ƿ�Ϸ�
	var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	if( reg_money.test(lm)== false){
		str = "�豸���-���Ҹ�ʽ����";//
		$("#lease_money").next(".biTian").text(str);
		$("#lease_money").focus();
	}else if( Number(lm) > Number(validLM)){
		alert("���ޱ��𲻺Ϸ������ܴ���"+validLM);
		$("#lease_money").val("0");
		$("#lease_money").focus();
	}
}

/**
	*  ��֤���е�input�������֤���ָ�ʽ
	*/
	function check_allInput(){
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


//�����㰴ť��ת�������ж�
function submitForm(){
	//�жϼ�����������
	var str = "";
	//���ޱ��� ����<=0
	if($("#lease_money").val()<=0){
		str = "���ޱ�����<=0";
		alert(str);
		$("#lease_money").focus();
		return false;
	}else if( !/^[1-9]*\d$/.test($(":input[name='income_number']").val()) ){
		str = "�껹�������д������";
		alert(str);
		$(":input[name='income_number']").focus();
		return false;
	}
	
	//�ȼ��
	if(check_allInput()){
		form1.submit();	
	}
}
</script>
</html>
