<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="com.tenwa.culc.service.ConditionService"%>
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
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
	
	//�豸��|�׸���
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
	//��ǰϢ-���� �㱾�����㱾 before_interest_type
	$(":radio[name='before_interest_type']").removeAttr("checked");
	$(":radio[name='before_interest_type'][value='<%=conditionBean.getBefore_interest_type() %>']").attr("checked","checked");
	
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
	
	//��ʾ����
	changeCalcWay();
});
//���ύ
function sub_updForm(){
	//�ж��Ƿ�ѡ����ǰϢ����
	var biVal = $(":input[name='before_interest']").val();
	var bitVal = $(":input[name='before_interest_type']").val();

	form1.submit();	
}
</script>



<body onload="public_onload(0);">
<!-- form����ת��zjcs_projSave.jspҳ��    doCument.forms[0].onsubmit()-->
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return Validator.Validate(this,2);check_allInput();">
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
		        <select style="width:130px;" name="settle_method" id="settle_method" Require="true" onchange="changeCalcWay()"></select>
				<script language="javascript">
				dict_list("settle_method","RentCalcType","","name");
				</script><span class="biTian">*</span>
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
		        <BUTTON class="btn_2" onClick="return sub_updForm();">
					<img src="../../images/save.gif" align="absmiddle" border="0">����������Ϣ
				</button>
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
			 <td scope="row" nowrap>��������</td>
		     <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
		     	<%-- 
		     	--%>
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
    				
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>�豸���</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0"
		    		dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>�׸���</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true" readonly/>
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
			<td  scope="row" nowrap>Ͷ����ʽ</td>
			<td>
				<select style="width: 100px;" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ѽ��</td>
		    <td colspan="">
		   	 <input name="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
			</td>
		  </tr>
		  
		   <tr>
		  	<td scope="row" nowrap>��ǰϢ</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="changeValInfo()"
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />
		    		�Ƿ��㱾
		    		<input type="radio" name="before_interest_type" value="��" checked="checked" onclick="changeValInfo()">��
		    		<input type="radio" name="before_interest_type" value="��" onclick="changeValInfo()">��
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
			<td  scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		   	<td scope="row" nowrap>�����ʶ�</td>
		    <td>
		    	<!--  �����ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧�� ��2010-07-23�޸ģ�������Ҫ ��ȥ��ǰϢ�� -->
		    	<input name="actual_fund" id="actual_fund" type="text" value="" readonly onclick="assignment()" 
		    	dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    		�����ʶ����
    				<input name="actual_fund_ratio" id="actual_fund_ratio" type="text" 
					value="" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
			</td>
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
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0" 
		    		dataType="Double" size="13" maxlength="10" maxB="10"  onblur="alertChange()" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td  scope="row" nowrap>Ԥ��IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>%
			</td> 
		  </tr>
		
		 
		  
		  <tr>
			<td scope="row" nowrap>�ʲ���ֵ</td>
		    <td>
		    	<input name="assets_value" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
			<td scope="row" nowrap>���˵���</td>
		    <td>
		    	<input name="assess_adjust" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
			
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
	   		<td  scope="row" nowrap>ʵ��IRR</td>
			<td>
				<input name="irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>%
			</td>
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
	var before_interest_type = $(":input[name='before_interest_type']").val();
	var before_interest = $(":input[name='before_interest']").val();
	
	if(!isNaN(before_interest) && before_interest>=0){
		//���ޱ���
		if(before_interest_type!=null && "��"==before_interest_type ){
			$(":input[name='lease_money']").val( $(":input[name='lease_money']").val()-before_interest );
		}
		//�����ʶ�
		$(":input[name='actual_fund']").val( $(":input[name='actual_fund']").val()-before_interest );
		//$(":input[name='actual_fund_ratio']").val( "81.220000" );
		$(":input[name='actual_fund_ratio']").val( ($(":input[name='actual_fund']").val()*1.00/$(":input[name='first_payment']").val())*100.00 );
	}
}

</script>
</body>
</html>
