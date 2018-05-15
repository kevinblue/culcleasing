<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="com.tenwa.culc.service.ConditionService"%>
<%@ page import="com.tenwa.culc.service1.ConditionService1"%>
<%@ page import="com.tenwa.culc.bean.ConditionBean"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������� - ��ǰϢȷ��</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
	$(":input[name='before_interest']").removeAttr("disabled");//ȡ��
	$(":input[name='before_interest_type']").removeAttr("disabled");//ȡ��
	$(":input[name='lease_money']").removeAttr("disabled");//ȡ��
	$(":input[name='actual_fund']").removeAttr("disabled");//ȡ��
	$(":input[name='actual_fund_ratio']").removeAttr("disabled");//ȡ��
	$(".btn_2").removeAttr("disabled");//ȡ��
	$(":input[name='contract_id']").removeAttr("disabled");//ȡ��
	$(":input[name='doc_id']").removeAttr("disabled");//ȡ��
	$(":input[name='lease_money']").attr("readonly","readonly");
	$(":input[name='actual_fund']").attr("readonly","readonly");
	$(":input[name='actual_fund_ratio']").attr("readonly","readonly");
	$(":input[name='contract_id']").attr("readonly","readonly");
	$(":input[name='doc_id']").attr("readonly","readonly");
	$(":input[name='irr']").removeAttr("disabled");
	//$(":input[name='invoice_type']").removeAttr("disabled");
	$(":input[name='start_date']").removeAttr("disabled");
});

/**
 * �����㷽���ı�
 */
function changeCalcWay(){
	var settle_methodVal = $("#settle_method").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("��𹫲�");
		$("#bj_2").show();
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("���𹫲�");
		$("#bj_2").show();
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("��𹫱�");
		$("#bj_2").show();
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("���𹫱�");
		$("#bj_2").show();
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("input[name='ratio_param']").val("0");
	}
}
</script>
</head>

<%
	//��������	
	String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
	//��ȡ����
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String nowDateTime = getSystemDate(0);//��ǰ��ʽ��֮���ʱ��
	
	//�ж�ִ������ -- �����ݿ��ѯ��������upd����add
	String savaType = "upd";
	
	//1.���upd���װConditionBean
	ConditionBean conditionBean = ConditionService.initConditionContractBean(contract_id, doc_id);
	conditionBean = ConditionService1.initConditionContractBean(conditionBean);
	
%> 

<script type="text/javascript">
$(document).ready(function(){
	//�����㷽�� settle_method
	$("select[name='settle_method']").val("<%=conditionBean.getSettle_method() %>");
	//�������ͣ� period_type
	$("#period_type").val("<%=conditionBean.getPeriod_type() %>");
	//�豸��� equip_amt
	$("#equip_amt").val("<%=conditionBean.getEquip_amt() %>");
	//�׸��� first_payment
	$("input[name='first_payment']").val("<%=conditionBean.getFirst_payment() %>");
	//���ޱ��� lease_money
	$("input[name='lease_money']").val("<%=conditionBean.getLease_money() %>");
	//���ޱ���hidden�ֶ� lease_money
	$("input[name='lease_money_hidden']").val("<%=conditionBean.getLease_money() %>");
	//��֤�� caution_money
	$("input[name='caution_money']").val("<%=conditionBean.getCaution_money() %>");
	//������ handling_charge
	$("input[name='handling_charge']").val("<%=conditionBean.getHandling_charge() %>");
	//����� management_fee
	$("input[name='management_fee']").val("<%=conditionBean.getManagement_fee() %>");
	//��ֵ���� nominalprice
	$("input[name='nominalprice']").val("<%=conditionBean.getNominalprice() %>");
	//���̷��� return_amt
	$("input[name='return_amt']").val("<%=conditionBean.getReturn_amt() %>");
	//��ǰϢ before_interest
	$("input[name='before_interest']").val("<%=conditionBean.getBefore_interest() %>");
	$("input[name='before_interest_hidden']").val("<%=conditionBean.getBefore_interest() %>");
	//��ǰϢ-���� �㱾�����㱾 before_interest_type
	$(":radio[name='before_interest_type']").removeAttr("checked");
	$(":radio[name='before_interest_type'][value='<%=conditionBean.getBefore_interest_type() %>']").attr("checked","checked");
	$("input[name='before_interest_type_hidden']").val("<%=conditionBean.getBefore_interest_type() %>");
	
	//��Ϣ���� rate_subsidy
	$("input[name='rate_subsidy']").val("<%=conditionBean.getRate_subsidy() %>");
	//����Ϣ discount_rate
	$("input[name='discount_rate']").val("<%=conditionBean.getDiscount_rate() %>");
	//�������� other_income
	$("input[name='other_income']").val("<%=conditionBean.getOther_income() %>");
	//����֧�� other_expenditure
	$("input[name='other_expenditure']").val("<%=conditionBean.getOther_expenditure() %>");
	//��ѯ������ consulting_fee_in
	$("input[name='consulting_fee_in']").val("<%=conditionBean.getConsulting_fee_in() %>");
	//��ѯ��֧�� consulting_fee_out
	$("input[name='consulting_fee_out']").val("<%=conditionBean.getConsulting_fee_out() %>");
	//���ѽ�� insure_money
	$("input[name='insure_money']").val("<%=conditionBean.getInsure_money() %>");
	//�����ʶ� actual_fund
	$("input[name='actual_fund']").val("<%=conditionBean.getActual_fund() %>");
	$("input[name='actual_fund_hidden']").val("<%=conditionBean.getActual_fund() %>");
	//�����ʶ���� actual_fund_ratio
	$("input[name='actual_fund_ratio']").val("<%=conditionBean.getActual_fund_ratio() %>");
	
	//Ͷ����ʽ insure_type
	$("#insure_type").val("<%=conditionBean.getInsure_type() %>");
	//Ԥ�������� start_date
	$("input[name='start_date']").val("<%=getDBDateStr(conditionBean.getRent_start_date()) %>");
	
	//���������� year_rate
	$("input[name='year_rate']").val("<%=conditionBean.getYear_rate() %>");
	//��Ϣ������ pena_rate
	$("input[name='pena_rate']").val("<%=conditionBean.getPena_rate() %>");
	//���ڿ����� free_defa_inter_day
	$("input[name='free_defa_inter_day']").val("<%=conditionBean.getFree_defa_inter_day() %>");
	//���ⷽʽ income_number_year
	$("#income_number_year").val("<%=conditionBean.getIncome_number_year() %>");
	//������� income_number
	$("input[name='income_number']").val("<%=conditionBean.getIncome_number() %>");
	//��������(��) lease_term
	$("input[name='lease_term']").val("<%=conditionBean.getLease_term() %>");
	//ÿ�³����� income_day
	$("select[name='income_day']").val("<%=conditionBean.getIncome_day() %>");
	//���ʸ�������  rate_float_type
	$("select[name='rate_float_type']").val("<%=conditionBean.getRate_float_type() %>");
	//���ʵ���ֵ rate_float_amt
	$("input[name='rate_float_amt']").val("<%=conditionBean.getRate_float_amt() %>");
	$("input[name='rate_float_amt']").blur();
	
	//Ԥ��IRR plan_irr
	$("input[name='plan_irr']").val("<%=conditionBean.getPlan_irr() %>");
	//ʵ��IRR irr
	$("input[name='irr']").val("<%=conditionBean.getIrr() %>");
	//��Ϣ��ʽ adjust_style
	$("select[name='adjust_style']").val("<%=conditionBean.getAdjust_style() %>");
	//�Ƿ�������Ϣ into_batch
	$("input[name='into_batch']").val("<%=conditionBean.getInto_batch() %>");

	// �ʲ���ֵ assets_value
	$("input[name='assets_value']").val("<%=conditionBean.getAssets_value() %>");
	// ���˵��� assess_adjust
	$("input[name='assess_adjust']").val("<%=conditionBean.getAssess_adjust() %>");
	// ���𹫱ȡ���𹫱ȡ����𹫲��𹫲� ratio_param
	$("input[name='ratio_param']").val("<%=conditionBean.getRatio_param() %>");
	//���Ʊ
	$("select[name='invoice_type']").val("<%=conditionBean.getInvoice_type() %>");
	//���irr
	$(":radio[name='StandardF']").removeAttr("checked");
	$("input[name='StandardF'][value='<%=conditionBean.getStandardF() %>']").attr("checked","checked");
	//�Ƿ���
	$("input[name='getStandardIrr']").val("<%=conditionBean.getStandardIrr() %>");
	//������ȡ��ʽ insure_pay_type
	$("select[name='insure_pay_type']").val("<%=conditionBean.getInsure_pay_type() %>");
	//˰��
	$("select[name='tax_type']").val("<%=conditionBean.getTax_type() %>");
	//��ֵ˰��Ʊ����
	$("select[name='tax_type_invoice']").val("<%=conditionBean.getTax_type_invoice() %>");
	//��ʾ����
	changeCalcWay();
});
//���ύ
function sub_updForm(){
	//�ж��Ƿ�ѡ����ǰϢ����
	var biVal = dataBack($(":input[name='before_interest']").val());
	var bitVal = $(":radio[name='before_interest_type']:checked").val();
	
	//alert (biVal + "____"+ bitVal);
	if(biVal!="" && bitVal!=""){
		form1.onSubmit();	
	}else{
		alert("����д��ǰϢ����ǰϢ���ͣ�");
		return false;
	}

}
</script>



<body onload="public_onload(0);">
<!-- form����ת��zjcs_projSave.jspҳ��    doCument.forms[0].onsubmit()-->
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return return verification();">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- ������ֵ  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				�����㷽��:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select style="width:130px;" name="settle_method" id="settle_method" 
					Require="true" onchange="changeCalcWay()">
					<script type="text/javascript">
						w(mSetOpt('',
						"�ȶ����|�Ȳ����|�ȱ����|�ȶ��|�Ȳ��|�ȱȱ���|�ȶ�����(��Ϣ��)|���ȶ����|���ȶ��|������",
						"RentCalcType1|RentCalcType2|RentCalcType3|RentCalcType4|RentCalcType5|RentCalcType6|RentCalcType7|RentCalcType8|RentCalcType9|RentCalcType10"));
					</script>
				</select>
				<!--
		        <select style="width:130px;" name="settle_method" id="settle_method" Require="true" onchange="changeCalcWay()"></select>
				<script language="javascript">
				dict_list("settle_method","RentCalcType","","name");
				</script>--><span class="biTian">*</span>
				&nbsp;&nbsp;|
		        <div id="bj_1" style="float: left;"></div>
				<div id="bj_2" style="display: none;float: left;margin-left: 24px;">
		   			<input name="ratio_param" type="text" dataType="Double" value="0.00" size="13" maxlength="10" maxB="10">
				</div>
		        <div id="bj_3" style="float: left; color: red;margin-left: 5px;"></div>
		        &nbsp;&nbsp;|
		         �������ͣ�
		        <select name="period_type" id="period_type" style="width: 60px;" Require="true">
		        <script type="text/javascript">
			        w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
		        &nbsp;&nbsp;|
		        <BUTTON class="btn_2" onClick="return verification();">
					<img src="../../images/save.gif" align="absmiddle" border="0">����������Ϣ
				</button>
				<b style="color:red;">(�����޸ĺ��뼰ʱ���£�)</b>
				</td>
			</tr>
		
		  <tr>
		  	<!-- �����ֶν��� -->
		  	<td scope="row" nowrap>��ͬ���</td>
		    <td>
		    	<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" size="35" maxlength="50"/>
			  	<input name="doc_id" type="hidden" value="<%=doc_id %>">
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
		    <td scope="row" nowrap>�豸���</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0" dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>�׸���</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true" readonly/>
		    	<span class="biTian">*</span>
		   	   </td> 
		   	   <td scope="row" nowrap>��������</td>
		     <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
			 <select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled">
					<option value="currency_type1">�����</option>
				</select>
				<!--
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>-->
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
    				
		    	<span class="biTian">*</span>
			</td>
		  </tr> 
		  	
		  <tr>
		  	<!--  ���ޱ��� = �豸��� - �׸��� onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>���ޱ���</td>
		     <td>
		    	<input name="lease_money" id="lease_money" value="0" 
		    	readonly type="text" Require="true" dataType="Money" size="13" maxlength="100" maxB="100" 
		    	Require="true"/>
		    	<span class="biTian">*</span>
		    	<input name="lease_money_hidden" id="lease_money_hidden" type="hidden">
			 </td>
			<td  scope="row" nowrap>���ޱ�֤��</td>
			<td>
				<input name="caution_money" id="caution_money" value="0" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					 type="text"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>����������</td>
			<td>
				<input name="handling_charge" type="text" value="0" 
				 	dataType="Money" size="13" maxlength="20" 
				 	maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>�����</td>
		    <td colspan="">
		    	<input name="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"  /> 
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>��ѯ������</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>��ѯ��֧��</td>
		  	<td>
		  		<input name="consulting_fee_out" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"   -->
			<td  scope="row" nowrap>��������</td>
			<td>
				<input name="other_income" type="text" value="0" dataType="Money"
					  size="13" maxlength="20"  />
			</td>
			<td scope="row" nowrap>����֧��</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="0" dataType="Money"
		    		  size="13" maxlength="10" /> 
			</td>
		  </tr>
		  <tr>	
		  	<td  scope="row" nowrap>��ֵ����</td>
			<td>
				<input name="nominalprice" type="text" value="0"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>���̷���</td>
			<td>
				<input name="return_amt" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ѽ��</td>
		    <td colspan="">
		   	 <input name="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
			</td>
			<td  scope="row" nowrap>Ԥ��IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>%
			</td>
		  </tr>
		   <tr>
		  	<td scope="row" nowrap>��ǰϢ</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="changeValInfo()"
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" label="��ǰϢ"/>
		    		�Ƿ��㱾
		    		<input type="radio" name="before_interest_type" value="��"  onclick="changeValInfo()">��
		    		<input type="radio" name="before_interest_type" value="��" checked="checked" onclick="changeValInfo()">��
		    		<input type="hidden" name="before_interest_type_hidden" id="before_interest_type_hidden">
		    		<input type="hidden" name="before_interest_hidden" id="before_interest_hidden">
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��Ϣ����</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>����Ϣ</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>�ʲ���ֵ</td>
		    <td>
		    	<input name="assets_value" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
		  </tr>
		  <tr>
		   	<td scope="row" nowrap>�����ʶ�</td>
		    <td>
		    	<!--  �����ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧�� ��2010-07-23�޸ģ�������Ҫ ��ȥ��ǰϢ�� -->
		    	<input name="actual_fund" id="actual_fund" type="text" dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    	<input type="hidden" name="actual_fund_hidden" id="actual_fund_hidden">
		    		�����ʶ����
					<input name="actual_fund_ratio" id="actual_fund_ratio" type="text" 
					value="" size="5" maxlength="10" readonly="readonly" 
					Require="true"/>% 
					
    				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ⷽʽ</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;">
					<script type="text/javascript">
						w(mSetOpt("","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			<!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" type="text" value="0" 
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
		  </tr>
		   <tr>
		   <td  scope="row" nowrap>����������</td>
			<td nowrap="nowrap">
				<input name="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<!--  	display: none; 
				<div id="" style="" align="right"> 
					<input type="button"class="button" value="����" alt="����Э�鱨����Ϣ�е���" onclick=""/>
				</div>	   --> 
				<span class="biTian">*</span>
			</td>
		  </tr>	
		  <tr>
		  	 <td colspan="8">
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:12px" color=grey>
			</td>
		  </tr>
		  <tr>
		  <td scope="row" nowrap>�Ƿ�������Ϣ</td>
	   		<td>
	    		<select name="adjust_style" style="width: 100px;">
			        <script type="text/javascript">
			        	w(mSetOpt('1',"������|������","1|2"));
			        </script>
		        </select> 
		        ������Ϣ
		        <input type="text" name="into_batch" size="5">
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
			</td>
			<td scope="row" nowrap>��Ϣ������</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- ������ж����뷽ʽ ֻ���������� onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('��Ϣ������ȷ��������');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>���ڿ�����</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true"/>
		    	<span class="biTian">*</span>
			</td>
		</tr>
		  <tr>
		  <td scope="row" nowrap>���IRR</td>
		    <td>
		    	<input type="text" dataType="Double" style="width: 140" name="StandardIrr" value="0" />%
				  �Ƿ���
		        <input type="text" name="StandardF" size="5" value="��">
		    	<span class="biTian">*</span>
			</td>
		  	<td  scope="row" nowrap>ʵ��IRR</td>
			<td>
				<input name="irr" dataType="Double" type="text" value="0" size="13" maxlength="10" label="ʵ��IRR" />%
			</td>
			<td  scope="row" nowrap>ÿ�³�����</td>
			<td>
				<select name="income_day" style="width: 100px;">
					<script type="text/javascript">
						for(var i=1;i<=31;i++){
							document.write("<option value='"+i+"'>"+i+"</option>");
						}
					</script>
				</select>	 
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>Ͷ����ʽ</td>
			<td>
				<select style="width: 100px;" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  	<td scope="row" nowrap>���ʸ�������</td>
		    <td>
		    	<select name="rate_float_type">
		        <script type="text/javascript">
			        w(mSetOpt('0',"���������ʸ�������|���������ʼӵ�|��������|���ֲ���","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td colspan="4">
				<div id="div_rate"></div>
			</td>
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0" 
		    		dataType="Double" size="13" maxlength="10" maxB="10"  onblur="alertChange()" />
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
	    	<td scope="row" nowrap>���Ʊ��ʽ</td>
			<td>
			<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true" label="���Ʊ��ʽ">
					  <script type="text/javascript">
						w(mSetOpt('',"�ȿ�������ܶƱ|�ȿ��������վݣ���Ϣ��Ʊ|�ȿ��������ֿ�|�󿪣�����ܶƱ|�󿪣������վݣ���Ϣ��Ʊ|�󿪣������ֿ�|�󿪣������ֿ����ŷ�Ʊ|�ȿ��������ֿ����ŷ�Ʊ|����",
						"root.RentInvoice.001|root.RentInvoice.002|root.RentInvoice.003|root.RentInvoice.004|root.RentInvoice.005|root.RentInvoice.006|root.RentInvoice.007|root.RentInvoice.008|root.RentInvoice.009"));
					</script>
				</select>
				<!--
				<select style="width:140px;" name="invoice_type" id="invoice_type" ></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>-->
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>��̬IRR</td>
			<td>
				<input name="dongirr" dataType="Double" type="text" value="0" size="13" maxlength="10"/>%
			</td>
			<td  scope="row" nowrap>������ȡ��ʽ</td>
			<td>
			<select style="width:100" name="insure_pay_type" id="insure_pay_type" Require="true" label="������ȡ��ʽ">
					  <script type="text/javascript">
							w(mSetOpt('',"1��������|����|�ּ�|��",
							"root.insurPayType.001|root.insurPayType.002|root.insurPayType.003|root.insurPayType.004"));
					  </script>
				</select>
				<!--
				<select style="width:100" name="insure_pay_type" id="insure_pay_type" Require="true" label="������ȡ��ʽ"></select>
				<script language="javascript" class="text">
					dict_list("insure_pay_type","root.insurPayType","root.insurPayType.001","name");
				</script>			-->		
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>˰��</td>
			<td>
				<select style="width:100px;" name="tax_type" id="tax_type"  Require="true" disabled="disabled"  >
					  <script type="text/javascript">
						w(mSetOpt('',"Ӫҵ˰|��ֵ˰","Ӫҵ˰|��ֵ˰"));
					</script>
				</select>
				<span class="biTian">*</span>
			</td> 

	    </tr>
		 <tr>
		<td  scope="row" nowrap>��ֵ˰��Ʊ����</td>
			<td>
			<select style="width:150px;" name="tax_type_invoice" id="tax_type_invoice" Require="true" disabled="disabled" >
					  <script type="text/javascript">
							w(mSetOpt('',"��ֵ˰��ͨ��Ʊ|��ֵ˰ר�÷�Ʊ|��","��ֵ˰��ͨ��Ʊ|��ֵ˰ר�÷�Ʊ|��"));
					  </script>
				</select>
								
   				<span class="biTian">*</span>
			</td>
			</tr>
	    <tr>
		
	    	<!-- sys���˵���ȡ��12.27
			<td scope="row" nowrap>���˵���</td>
		    <td>
		    	<input name="assess_adjust" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" onchange="changeFirst_payment()"/>
			</td>
			 -->
			 <!-- sys���˵��������� -->
			 <input type="hidden" name="assess_adjust" value="0" dataType="Money" size="13" maxlength="10" maxB="10" onchange="changeFirst_payment()"/>
	    </tr>
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
<script type="text/javascript">
//���ʵ���ֵ����������ʵ���ֵ������ʾ������
function alertChange(){
	var rate_float_amt = document.getElementsByName("rate_float_amt")[0].value;//���ʵ���ֵ
	//���ʸ������� "���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
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

function changeValInfo(){
	//var before_interest_type = $(":input[name='before_interest_type']").val();
	var before_interest = $(":input[name='before_interest']").val();
	var before_interest_hidden = $(":input[name='before_interest_hidden']").val();
	var type = $(":input[name='before_interest_type_hidden']").val();
	var radio_val = $(":radio[name='before_interest_type']:checked").val();
	var lease_money_hidden = $(":input[name='lease_money_hidden']").val();
	var actual_fund_hidden = $(":input[name='actual_fund_hidden']").val();
	
	//alert(type+"  "+radio_val+" ���= "+lease_money_hidden+" ..."+before_interest+" __"+actual_fund_hidden);
	
	
	if(!isNaN(before_interest) && before_interest>=0){
		//alert($("#actual_fund").val()+"����"+$("#lease_money").val());
		//���ޱ���
		if("��"==radio_val && type =="��"){//��ʼ״̬Ϊ��
			$(":input[name='lease_money']").val( parseFloat(lease_money_hidden) + parseFloat(before_interest) );
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest) + parseFloat(before_interest_hidden) );
		}
		else if("��"==radio_val && type =="��"){//��ʼ״̬Ϊ��
			$(":input[name='lease_money']").val( lease_money_hidden );
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest) + parseFloat(before_interest_hidden) );
		}
		else if("��"==radio_val && "��"==type){//��ʼ״̬Ϊ��
			$(":input[name='lease_money']").val( parseFloat(lease_money_hidden) + parseFloat(before_interest) - parseFloat(before_interest_hidden) );
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest) + parseFloat(before_interest_hidden) );
		}
		else if("��"==radio_val && "��"==type){//��ʼ״̬Ϊ��
			$(":input[name='lease_money']").val(parseFloat(lease_money_hidden) - parseFloat(before_interest));
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest)+ parseFloat(before_interest_hidden));
		}
		
		//getlmp_value();
		var s1 = $(":input[name='actual_fund']").val();
		var s2 =dataBack( $(":input[name='equip_amt']").val());
		//alert(s1+"___"+s2);
		
		$(":input[name='actual_fund_ratio']").val( returnFloat( (s1/s2)*100 , 4) );
	}
}

//����NλС����   
function returnFloat(value,number){   
 var divisor = '1';   
 for(i = 1; i <= number; i++){   
  divisor += '0';
 }   
 divisor = parseInt(divisor);   
 value = Math.round(parseFloat(value)*divisor)/divisor;   
 if(value.toString().indexOf(".") < 0 && number > 0){          
  value = value.toString() + '.';   
  for(i = 1; i <= number; i++){   
   value += '0';   
  }   
 }   
 return value;   
}  


//�������Ӿ����ʶ����=�����ʶ�/�豸���
function getlmp_value(){
	var actual_fund = document.getElementsByName("actual_fund")[0].value;//�����ʶ�
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//�豸���
	alert(actual_fund+ "++" + equip_amt + "___"+ (actual_fund/equip_amt)*100);
	var result;
	if(actual_fund == 0 && equip_amt == 0){
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


</script>
<script type="text/javascript">
$(document).ready(function() {

    $("input[type='text']").each(function(i) {
		$(this).blur(function (){mouseRead(this.value,this.name)});
 	});
         
    $("input[type='text']").blur();   
 });
 
 //���ύ�¼�
	function verification(){
		var biVal = dataBack($(":input[name='before_interest']").val());
		var bitVal = $(":radio[name='before_interest_type']:checked").val();
	
		//alert (biVal + "____"+ bitVal);
		if(biVal!="" && bitVal!=""){
			if(Validator.Validate(form1,2)){
			$("input[type='text']").focus();  
				form1.submit();
				return true;
			}else{
				return false;
			};	
		}else{
			alert("����д��ǰϢ����ǰϢ���ͣ�");
			return false;
		}
	
		
	}
</script>
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    