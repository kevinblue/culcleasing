<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="com.tenwa.culc.bean.ConditionMediBean"%>
<%@page import="com.tenwa.culc.service.ConditionMediService"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���׽ṹ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
	//$(":input").attr("class","readonlyShowR");
});
</script>
</head>

<%
	//��ȡ����
	String proj_id = getStr(request.getParameter("proj_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	//1.���upd���װConditionBean
	ConditionMediBean conditionMediBean = null;
	conditionMediBean  = ConditionMediService.initConditionBean(proj_id,doc_id);
%> 

<%
//�����ֵ���������ֵ
if( conditionMediBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//�豸��� equip_amt
	$("#equip_amt").val("<%=conditionMediBean.getEquip_amt() %>");
	//�׸��� first_payment
	$("input[name='first_payment']").val("<%=conditionMediBean.getFirst_payment() %>");
	
	//���ޱ��� lease_money
	$("input[name='lease_money']").val("<%=conditionMediBean.getLease_money() %>");
	//��֤�� caution_money
	$("input[name='caution_money']").val("<%=conditionMediBean.getCaution_money() %>");
	//������ handling_charge
	$("input[name='handling_charge']").val("<%=conditionMediBean.getHandling_charge() %>");
	//����� management_fee
	$("input[name='management_fee']").val("<%=conditionMediBean.getManagement_fee() %>");
	
	//�������� other_income
	$("input[name='other_income']").val("<%=conditionMediBean.getOther_income() %>");
	//����֧�� other_expenditure
	$("input[name='other_expenditure']").val("<%=conditionMediBean.getOther_expenditure() %>");
	//��ѯ������ consulting_fee_in
	$("input[name='consulting_fee_in']").val("<%=conditionMediBean.getConsulting_fee_in() %>");
	//��ѯ��֧�� consulting_fee_out
	$("input[name='consulting_fee_out']").val("<%=conditionMediBean.getConsulting_fee_out() %>");
	
	//��ֵ���� nominalprice
	$("input[name='nominalprice']").val("<%=conditionMediBean.getNominalprice() %>");
	//���̷��� return_amt
	$("input[name='return_amt']").val("<%=conditionMediBean.getReturn_amt() %>");
	//���ѽ�� insure_money 
	$("input[name='insure_money']").val("<%=conditionMediBean.getInsure_money() %>");
	//Ԥ�������� start_date
	$("input[name='start_date']").val("<%=getDBDateStr(conditionMediBean.getRent_start_date()) %>");
	
	//��ǰϢ before_interest
	$("input[name='before_interest']").val("<%=conditionMediBean.getBefore_interest() %>");
	//��ǰϢ-���� �㱾�����㱾 before_interest_type
	$(":radio[name='before_interest_type']").removeAttr("checked");
	$(":radio[name='before_interest_type'][value='<%=conditionMediBean.getBefore_interest_type() %>']").attr("checked","checked");
	//��Ϣ���� rate_subsidy
	$("input[name='rate_subsidy']").val("<%=conditionMediBean.getRate_subsidy() %>");
	//����Ϣ discount_rate
	$("input[name='discount_rate']").val("<%=conditionMediBean.getDiscount_rate() %>");
	
	
	//�����ʶ� actual_fund
	$("input[name='actual_fund']").val("<%=conditionMediBean.getActual_fund() %>");
	//�����ʶ���� actual_fund_ratio
	$("input[name='actual_fund_ratio']").val("<%=conditionMediBean.getActual_fund_ratio() %>");
	//���ⷽʽ income_number_year
	$("#income_number_year").val("<%=conditionMediBean.getIncome_number_year() %>");
	//������� income_number
	$("input[name='income_number']").val("<%=conditionMediBean.getIncome_number() %>");
	//��������(��) lease_term
	$("input[name='lease_term']").val("<%=conditionMediBean.getLease_term() %>");
	
	//�Ƿ��б������is_floor
	$(":radio[name='is_floor']").removeAttr("checked");
	$(":radio[name='is_floor'][value='<%=conditionMediBean.getIs_floor() %>']").attr("checked","checked");
	//�������ʽmanager_pay_type
	$("select[name='manager_pay_type']").val("<%=conditionMediBean.getManager_pay_type()%>");
	
	//Ͷ����ʽ insure_type
	$("#insure_type").val("<%=conditionMediBean.getInsure_type() %>");
	//������ȡ��ʽ insure_pay_type
	$("select[name='insure_pay_type']").val("<%=conditionMediBean.getInsure_pay_type() %>");
	//Ԥ���տ���������
	$("input[name='plan_bank_name']").val("<%=conditionMediBean.getPlan_bank_name() %>");
	//Ԥ���տ������˺�
	$("input[name='plan_bank_no']").val("<%=conditionMediBean.getPlan_bank_no() %>");
	
	//ÿ�³����� income_day
	$("#income_day").val("<%=conditionMediBean.getIncome_day() %>");
	//���ʸ�������  rate_float_type
	$("select[name='rate_float_type']").val("<%=conditionMediBean.getRate_float_type() %>");
	//���ʵ���ֵ rate_float_amt
	$("input[name='rate_float_amt']").val("<%=Double.parseDouble(conditionMediBean.getRate_float_amt()) %>");
	$("input[name='rate_float_amt']").blur();
	//��Ϣ��ʽ adjust_style
	$("select[name='adjust_style']").val("<%=conditionMediBean.getAdjust_style() %>");
	//�Ƿ�������Ϣ into_batch
	$(":radio[name='into_batch']").removeAttr("checked");
	$("input[name='into_batch'][value='<%=conditionMediBean.getInto_batch() %>']").attr("checked","checked");
	//�����㷽�� settle_method
	$("select[name='settle_method']").val("<%=conditionMediBean.getSettle_method() %>");
	//�������ͣ� period_type
	$("#period_type").val("<%=conditionMediBean.getPeriod_type() %>");
	//������
	$("#year_rate").val("<%=Double.parseDouble(conditionMediBean.getYear_rate()) %>");
	//�����Ƿ���⹫��
	$(":radio[name='is_open']").removeAttr("checked");
	$("input[name='is_open'][value='<%=conditionMediBean.getIs_open() %>']").attr("checked","checked");
	//��ʾ����
	changeCalcWay();
	//�Ƿ񱣵�
	changeFloor();
});
</script>
<%
}
%>


<body onload="public_onload(0);">
<form name="form1" method="post"  action="proj_cond_set.jsp">
<!-- ������ֵ����  ��Ϣ����|���ڿ�����-->
<input name="pena_rate"  type="hidden" value="0">
<input name="free_defa_inter_day" type="hidden" value="0">
<input name="floor_rent"  type="hidden" value="0">
<input type="hidden" name="income_day" id="income_day">

<!-- ������ֵ����  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		  <tr>
		  	<!-- �����ֶν��� -->
		  	<td scope="row" nowrap>��Ŀ���</td>
		    <td>
		    	<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" size="35"/>
		    	<span class="biTian">*</span>
		     </td>
			 
		    <td scope="row" nowrap>�豸���</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" value="0" size="13"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>�׸���</td>
		      <td>
		    	<input name="first_payment" id="first_payment" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
		   	   </td> 
		   	   <td scope="row" nowrap>��������</td>
		     <td>
				<select style="width:100px;" name="currencyVal" id="currency"></select>
				<script language="javascript" class="text">
					dict_list("currencyVal","currency_type","currency_type1","name");
				</script>
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
		    	<span class="biTian">*</span>
			</td>
		  </tr> 
		  	
		  <tr>
		  	<!--  ���ޱ��� = �豸��� - �׸��� onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>���ޱ���</td>
		     <td>
		    	<input name="lease_money" id="lease_money" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
			 </td>
			 <td scope="row" nowrap>���ⷽʽ</td>
		    <td >
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
		    	<input name="income_number" id="income_number" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
			</td>
		   	<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td>
		    	<input name="lease_term" id="lease_term" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>

			<td scope="row" nowrap>�����ʶ�</td>
		    <td>
		    	<input name="actual_fund" id="actual_fund" type="text" size="13"/>
		    		�����ʶ����
    				<input name="actual_fund_ratio" id="actual_fund_ratio"  class="readonlyShowR" size="5" type="text" />% 
			</td>
			
			<td  scope="row" nowrap>Ͷ����ʽ</td>
			<td>
				<select style="width:100" name="insure_type" id="insure_type"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>������ȡ��ʽ</td>
			<td>
				<select style="width:100" name="insure_pay_type" id="insure_pay_type"></select>
				<script language="javascript" class="text">
					dict_list("insure_pay_type","root.insurPayType","root.insurPayType.001","name");
				</script>					
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text" size="13"/>
				<span class="biTian">*</span>
			</td>
		  </tr>
				
		  <tr>
		  	<td  scope="row" nowrap>�Ƿ񱣵�</td>
		  	<td>
	    		<input type="radio" name="is_floor" style="border: none;" value="��" checked="checked">��
	    		<input type="radio" name="is_floor" style="border: none;" value="��" >��
		  	</td>
		  	
		  	<td  scope="row" nowrap>�������ʽ</td>
		  	<td>
		  		<select style="width:100" name="manager_pay_type" id="manager_pay_type"></select>
				<script language="javascript" class="text">
					dict_list("manager_pay_type","root.manager_pay_type","root.manager_pay_type.001","name");
				</script>					
   				<span class="biTian">*</span>
		  	</td>
		  	 <td scope="row" nowrap>�ƻ��տ������˺�</td>
		    <td scope="row">
		    	<input style="width:150px;" name="plan_bank_no" id="plan_bank_no" type="text" style="width: 100">
		    </td>
		    <td scope="row" nowrap>�ƻ��տ������</td>
		    <td scope="row">
		   		<input style="width:150px;" name="plan_bank_name" id="plan_bank_name" type="text" style="width: 100">
		    </td>
		  </tr>
		  
		  <tr id="tr_CS">
		  	<td  scope="row" nowrap>��������</td>
			<td colspan="5">
		        <select style="width:130px;" name="settle_method" id="settle_method"></select>
				<script language="javascript">
					dict_list("settle_method","RentCalcType","","name");
				</script><span class="biTian">*</span>
		        &nbsp;&nbsp;|
		        <div id="bj_1" style="float: left;"></div>
				<div id="bj_2" style="display: none;float: left;margin-left: 24px;">
		   			<input name="ratio_param" type="text" value="0.00" size="13">
				</div>
		        <div id="bj_3" style="float: left; color: red;margin-left: 5px;"></div>
		        &nbsp;&nbsp;|
		         �������ͣ�
		        <select name="period_type" id="period_type" style="width: 60px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
		        &nbsp;&nbsp;
			</td>
			<td  scope="row" nowrap>���ʶ��⹫��</td>
			<td>
				<input type="radio" name="is_open" value="��" style="border: none;" checked="checked">�� &nbsp;
				<input type="radio" name="is_open" value="��" style="border: none;">��
			</td>
			</tr>
			
			<tr id="tr_TX">
				<td  scope="row" nowrap>����������</td>
				<td nowrap="nowrap">
					<input name="year_rate" id="year_rate" type="text" value="0.00"  size="13"/>%
					<span class="biTian">*</span>
				</td>
				
				<td scope="row" nowrap>���ʸ�������</td>
		    	<td>
			    	<select name="rate_float_type" style="width:140">
			        <script type="text/javascript">
				        w(mSetOpt('0',"���������ʸ�������|���������ʼӵ�|��������|���ֲ���","0|1|2|3"));
			        </script>
			        </select> 
			    	<span class="biTian">*</span>
				</td>
				
		    	<td scope="row" nowrap>���ʵ���ֵ</td>
			    <td>
			    	<input name="rate_float_amt" id="rate_float_amt" type="text" value="0" size="13"/>
			    	<span class="biTian">*</span>
				</td>
				<td scope="row" nowrap >��Ϣ��ʽ</td>
			    <td >
			    	<select name="adjust_style"  style="width:60px;">
				        <script type="text/javascript">
				        	w(mSetOpt('2',"������|������","1|2"));
				        </script>
			        </select> 
			      	  ������Ϣ
			        <input type="radio" name="into_batch" style="border: none;" value="��" checked="checked">��
			    	<input type="radio" name="into_batch" style="border: none;" value="��">��
			    	<span class="biTian">*</span>
				</td>
		  </tr>	
		  
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
			<td colspan="8">
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:12px" color="gray">
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>��ѯ������</td>
		  	<td>
		  		<input name="consulting_fee_in" id="consulting_fee_in" type="text" value="0" size="13"/>
			</td>
			<td  scope="row" nowrap>���ޱ�֤��</td>
			<td>
				<input name="caution_money" id="caution_money" type="text" value="0" size="13"/>
			</td>
			<td  scope="row" nowrap>����������</td>
			<td>
				<input name="handling_charge" id="handling_charge" type="text" value="0" size="13"/>
			</td>
			<td scope="row" nowrap>�����</td>
		    <td colspan="">
		    	<input name="management_fee" id="management_fee" type="text" value="0" size="13"/>
			</td>
		  </tr>	
		  
		  <tr>	
		  	<td  scope="row" nowrap>��ֵ����</td>
			<td>
				<input name="nominalprice" id="nominalprice" type="text" value="0" size="13"/>
			</td>
				<td scope="row" nowrap>��ѯ��֧��</td>
		  	<td>
		  		<input name="consulting_fee_out" id="consulting_fee_out" type="text" value="0" size="13"/>
			</td>
			<td  scope="row" nowrap>��������</td>
			<td>
				<input name="other_income" id="other_income" type="text" value="0" dataType="Money" size="13"/>
			</td>
			<td scope="row" nowrap>����֧��</td>
		    <td colspan="">
		    	<input name="other_expenditure" id="other_expenditure" type="text" value="0" dataType="Money" size="13"/>
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>��ǰϢ</td>
		    <td>
		    	<input name="before_interest" id="before_interest" type="text" value="0"  size="13"/>
		    		�Ƿ��㱾
		    		<input type="radio" id="before_interest_type" name="before_interest_type" value="��" >��
		    		<input type="radio" id="before_interest_type" name="before_interest_type" value="��" checked="checked">��
			</td>
			 <td  scope="row" nowrap>���̷���</td>
			<td>
				<input name="return_amt" id="return_amt" type="text" value="0" size="13"/>
			</td>
			<td scope="row" nowrap>���ѽ��</td>
		    <td colspan="">
		   	 <input name="insure_money" id="insure_money" type="text" value="0" size="13"/>
			</td>
			<td></td>			
			<td></td>			
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>��Ϣ����</td>
		  	<td>
		  		<input name="rate_subsidy" id="rate_subsidy" type="text" value="0" size="13"/>
			</td>
			<td scope="row" nowrap>����Ϣ</td>
		  	<td>
		  		<input name="discount_rate" id="discount_rate" type="text" value="0" size="13"/>
			</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
<script  type="text/javascript" src="../../js/leasing_rentcalc_medi.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("input[type='text']").each(function(i) {
		$(this).blur(function (){mouseRead(this.value,this.name)});
 	});
         
    <%if( conditionMediBean!=null ){//�����ֵ%>
    $("input[type='text']").blur(); 
    <%}%>  
 });
 
 function changeFloor(){
 	var floorV = $(":radio[name='is_floor']:checked").val();
 	if(floorV=="��"){
 		//������ʾ������
 		$("#tr_CS").css("display","block");
 		$("#tr_TX").css("display","block");
 		//���ñ���Ԫ��
 		$("#settle_method").attr("Require","true");
 		$("#period_type").attr("Require","true");
 		$("#year_rate").attr("Require","true");
 		$("#rate_float_amt").attr("Require","true");
 	}else{
 		//�Ǳ���Ԫ��
 		$("#settle_method").removeAttr("Require");
 		$("#period_type").removeAttr("Require");
 		$("#year_rate").removeAttr("Require");
 		$("#rate_float_amt").removeAttr("Require");
 		//�Ǳ��� ����ʾ������
 		$("#tr_CS").css("display","none");
 		$("#tr_TX").css("display","none");
 	}
 }
</script>
</html>
