<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@page import="com.tenwa.culc.service1.BeginService1"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tenwa.culc.util.ERPDataSource"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - ��ͬ���׽ṹ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/beginnumberseparation.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>


<script Language="Javascript">
function downloadTemplate(){
	var settle_methodVal = $("#settle_method").val();
	var period_typeVal = $("#period_type").val();
	//alert(settle_methodVal+"__555__"+period_typeVal);
	//window.open("file_download.jsp?settle_method="+settle_methodVal+"&period_type="+period_typeVal);
	if(settle_methodVal=="RentCalcType8" || settle_methodVal=="RentCalcType9" || settle_methodVal=="RentCalcType10"){
		window.open("file_download.jsp?settle_method="+settle_methodVal+"&period_type="+period_typeVal);	
	}else{
		alert("�ò������Ͳ�֧��ģ�����أ������߲��㣡");
	}
}
function showUploadDiv(){
	$("#uploadDiv").fadeIn("slow");
}

/**
 *��ʼ��һЩ���¼�
 */
$(document).ready(function(){
	//��ֹĳ����ø���
	$("#contract_id").attr("readonly","readonly");
	$(":input[name='free_defa_inter_day']").attr("readonly","readonly");
	//��Ӽ���ʧȥ�����ж�ֵ�Ƿ���ȷ
	$(":input[name='year_rate']").blur(function(){//������
		if( !/^[0-9]+.?[0-9]*$/.test($(this).val()) ){ // /^[0-9]+.?[0-9]*$/
			alert("��������д��ʽ����ȷ");
			$(this).val(0);
			$(this).focus();
		}
	});
	$(":input[name='income_number']").blur(function(){//�껹�����
		if( !/^\d+$/.test($(this).val()) ){
			alert("�껹�������д������");
			$(this).val(0);
			$(this).focus();
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
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param<=0 || ratio_param>=1 ){
				alert("����ֻ����0��1֮��");
				$(this).val(0);
				$(this).focus();
			}
		}else if( stm=="RentCalcType2" || stm=="RentCalcType5" ){
			if( isNaN(ratio_param) ){
				alert("��Ǹ���������д�ַ�");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param==0 ){
				alert("���������0");
				$(this).val(0);
				$(this).focus();
			}
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
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
	//$(":input").attr("class","readonlyShowR");
});
</script>


</head>

<%
	//��������	
	String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
	//��ȡ����
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String flow_date = getStr(request.getParameter("flow_date"));
	String begin_order_index = getStr(request.getParameter("begin_order_index"));
	String nowDateTime = getSystemDate(0);//��ǰ��ʽ��֮���ʱ��

	//�ж�ִ������ -- �����ݿ��ѯ��������upd����add
	String savaType = BeginService.judgeSaveType(begin_id, doc_id);
	
	//1.���upd���װConditionBean
	BeginInfoBean beginInfoBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfoBean  = BeginService.initBeginInfoBean(begin_id, doc_id);
		beginInfoBean  = BeginService1.initBeginInfoBean(beginInfoBean);
	}
%> 

<%
//�����ֵ���������ֵ
if( beginInfoBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//�����㷽�� settle_method
	//$("select[name='settle_method']").val("<%=beginInfoBean.getSettle_method() %>");
	$("input[name='settle_method']").val("<%=beginInfoBean.getSettle_method() %>");
	$("select[name='settle_method2']").val("<%=beginInfoBean.getSettle_method() %>");
	//�������ͣ� period_type
	//$("#period_type").val("<%=beginInfoBean.getPeriod_type() %>");
	$("#period_type").val("<%=beginInfoBean.getPeriod_type() %>");
	$("input[name='period_type']").val("<%=beginInfoBean.getPeriod_type() %>");
	//�豸��� equip_amt
	$("#equip_amt").val("<%=beginInfoBean.getEquip_amt() %>");
	//���ޱ��� lease_money
	$("input[name='lease_money']").val("<%=beginInfoBean.getLease_money() %>");
	//�����ʶ� actual_fund
	$("input[name='actual_fund']").val("<%=beginInfoBean.getActual_fund() %>");
	
	//Ԥ�������� start_date
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfoBean.getStart_date()) %>");
	
	//���������� year_rate
	$("input[name='year_rate']").val("<%=Double.parseDouble(beginInfoBean.getYear_rate()) %>");
	//��Ϣ������ pena_rate
	$("input[name='pena_rate']").val("<%=beginInfoBean.getPena_rate() %>");
	//���ڿ����� free_defa_inter_day
	$("input[name='free_defa_inter_day']").val("<%=beginInfoBean.getFree_defa_inter_day() %>");
	//���ⷽʽ income_number_year
	$("input[name='income_number_year']").val("<%=beginInfoBean.getIncome_number_year() %>");
	//$("#income_number_year").val("<%=beginInfoBean.getIncome_number_year() %>");
	//������� income_number
	$("input[name='income_number']").val("<%=beginInfoBean.getIncome_number() %>");
	//��������(��) lease_term
	$("input[name='lease_term']").val("<%=beginInfoBean.getLease_term() %>");
	//ÿ�³����� income_day
	$("select[name='income_day2']").val("<%=beginInfoBean.getIncome_day() %>");
	$("#income_day").val("<%=beginInfoBean.getIncome_day() %>");
	//���ʸ�������  rate_float_type
	$("select[name='rate_float_type']").val("<%=beginInfoBean.getRate_float_type() %>");
	//���ʵ���ֵ rate_float_amt
	$("input[name='rate_float_amt']").val("<%=beginInfoBean.getRate_float_amt() %>");
	$("input[name='rate_float_amt']").blur();
	
	//Ԥ��IRR plan_irr
	$("input[name='plan_irr']").val("<%=beginInfoBean.getPlan_irr() %>");
	//ʵ��IRR fact_irr
	$("input[name='fact_irr']").val("<%=beginInfoBean.getFact_irr() %>");
	//��Ϣ��ʽ adjust_style
	$("select[name='adjust_style']").val("<%=beginInfoBean.getAdjust_style() %>");
	//�Ƿ�������Ϣ into_batch
	$(":radio[name='into_batch']").removeAttr("checked");
	$("input[name='into_batch'][value='<%=beginInfoBean.getInto_batch() %>']").attr("checked","checked");
	//�����Ƿ���⹫��
	$(":radio[name='is_open']").removeAttr("checked");
	$("input[name='is_open'][value='<%=beginInfoBean.getIs_open() %>']").attr("checked","checked");
	
	// �ʲ���ֵ assets_value
	$("input[name='assets_value']").val("<%=beginInfoBean.getAssets_value() %>");
	// ���𹫱ȡ���𹫱ȡ����𹫲��𹫲� ratio_param
	$("input[name='ratio_param']").val("<%=beginInfoBean.getRatio_param() %>");
	//Ԥ���տ���������
	$("input[name='plan_bank_name']").val("<%=beginInfoBean.getPlan_bank_name() %>");
	//Ԥ���տ������˺�
	$("input[name='plan_bank_no']").val("<%=beginInfoBean.getPlan_bank_no() %>");
	//���Ʊ��ʽ
	$("select[name='invoice_type']").val("<%=beginInfoBean.getInvoice_type() %>");
	//�Ƿ���
	$(":radio[name='factoring']").removeAttr("checked");
	$("input[name='factoring'][value='<%=beginInfoBean.getFactoring() %>']").attr("checked","checked");
	//˰��
	$("select[name='tax_type']").val("<%=beginInfoBean.getTax_type() %>");
	//��ֵ˰��Ʊ����
	$("select[name='tax_type_invoice']").val("<%=beginInfoBean.getTax_type_invoice() %>");
	
	//���˰��
	$("select[name='tax_rate']").val("<%=beginInfoBean.getTax_rate() %>");
	//��ʾ����
	changeCalcWay();
});
</script>
<%
}else{%>
<script type="text/javascript">
$(document).ready(function(){
	//���μ��صĸ�ֵ����
	$("#income_day").val("<%=getCurrentDatePart(3) %>");
	$("select[name='income_day2']").val("<%=getCurrentDatePart(3) %>");
});
</script>
<%
}
%>


<body onload="public_onload(0);">
<form name="form1" method="post"  action="" onSubmit="return verification();">
<input type="hidden" name="saveType" id="savaType" value="<%=savaType %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="begin_id" value="<%=begin_id %>">
<input type="hidden" name="flowSysDate" value="<%=flow_date %>">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- ������ֵ  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="80%" align="center" class="tab_table_title">
			<tr height="40" style="font-weight: bold;">
				<%
					String usedLeaseMoney = BeginService.getUsedLeaseMoneyB(contract_id, flow_date);
					String totalLeaseMoney = BeginService.getTotalLeaseMoney(contract_id);
					String leftLeaseMoney = MathExtend.subtract(totalLeaseMoney, usedLeaseMoney);
				%>
				<td colspan="3" style="font-size: 16px;">��ͬ���ޱ���<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalLeaseMoney) %></b></td>
				<td colspan="3" style="font-size: 16px;">���������ޱ���<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedLeaseMoney) %></b></td>
				<td colspan="2" style="font-size: 16px;">ʣ�����ޱ���<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftLeaseMoney) %></b>
				<input type="hidden" id="validLM" value="<%=leftLeaseMoney %>">
				<input type="hidden" name="begin_order_index" id="begin_order_index" value="<%=begin_order_index %>">
				</td>
			</tr>
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				�����㷽��:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" name="settle_method">
				 <select style="width:130px;" name="settle_method2" id="settle_method" 
					Require="true" onchange="changeCalcWay()">
					<script type="text/javascript">
						w(mSetOpt('',
						"�ȶ����|�Ȳ����|�ȱ����|�ȶ��|�Ȳ��|�ȱȱ���|�ȶ�����(��Ϣ��)|���ȶ����|���ȶ��|������",
						"RentCalcType1|RentCalcType2|RentCalcType3|RentCalcType4|RentCalcType5|RentCalcType6|RentCalcType7|RentCalcType8|RentCalcType9|RentCalcType10"));
					</script>
				</select>
				<!--
		        <select style="width:130px;" name="settle_method2" id="settle_method" Require="true" 
		        onchange="changeCalcWay()" disabled="disabled"></select>
				<script language="javascript">
				dict_list("settle_method2","RentCalcType","","name");
				</script>--><span class="biTian">*</span>
		        &nbsp;&nbsp;|
		        <div id="bj_1" style="float: left;"></div>
				<div id="bj_2" style="display: none;float: left;margin-left: 24px;">
		   			<input name="ratio_param" id="ratio_param" type="text" dataType="Double" value="0.00" size="13" maxlength="10" maxB="10" readonly="readonly">
				</div>
		        <div id="bj_3" style="float: left; color: red;margin-left: 5px;"></div>
		        &nbsp;&nbsp;|
		         �������ͣ�
		        <input type="hidden" name="period_type">
		        <select name="period_type2" id="period_type" disabled="disabled" style="width: 60px;" Require="true">
		        <script type="text/javascript">
			        w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
				</td>
			</tr>
		
		  <tr>
		  	<!-- �����ֶν��� -->
		  	<td scope="row" nowrap>��ͬ���</td>
		    <td>
		    	<input name="contract_id" style="width:150px;" id="contract_id" type="text" value="<%=contract_id%>" size="25" maxlength="50" readonly="readonly"/>
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>��������</td>
		     <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled">
					<option value="currency_type1">�����</option>
				</select><!--
				<select style="width:100px;" name="currencyVal"  id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>-->
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>���ޱ���</td>
		     <td>
		    	<input name="lease_money" id="lease_money" readonly="readonly" value="0" type="text" Require="true" dataType="Money" 
		    	size="13" maxlength="100" maxB="100" Require="true" onblur="checkValid()" style="width: 100"/>
		    	<span class="biTian">*</span>
			 </td>
			<td scope="row" nowrap>�����ʶ�</td>
		    <td>
		    	<input name="actual_fund" id="actual_fund" type="text" value="" readonly="readonly"
		    	dataType="Money" size="13" maxlength="20" maxB="20" style="width: 100"/> 
    			<span class="biTian">*</span>
			</td>
		  </tr> 
		  
		  <tr>
		 	<td scope="row" nowrap>�ʲ���ֵ</td>
		    <td>
		    	<input name="assets_value" style="width: 100" type="text" value="0" readonly="readonly" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
		  	<td  scope="row" nowrap>����������</td>
			<td nowrap="nowrap">
				<input name="year_rate" id="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly="readonly"/>%
				<span class="biTian">*</span>
			</td>  
			<td scope="row" nowrap>���ڿ�����</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="3"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>ʵ��IRR</td>
			<td>
				<input name="fact_irr" type="text" value="0" size="13" maxlength="10" style="width: 100" readonly="readonly"/>
			</td>
		  </tr>
		  
		  <tr>
		  <td scope="row" nowrap>���ⷽʽ</td>
			<td>
				<!-- sys ���ⷽʽ begin-->
		    	<input type="hidden"  name="income_number_year" style="width: 100px;" value="" readonly="readonly">
		    	<% if(beginInfoBean.getIncome_number_year().equals("1")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="�¸�" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("2")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="˫�¸�" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("3")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="����" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("6")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="���긶" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("12")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="�긶" readonly="readonly">
		    	<%} %>
		    	<!-- end -->
			</td>
			<!-- <td scope="row" nowrap>���ⷽʽ</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			 -->
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" id="income_number" type="text" value="0"  onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>ÿ�³�����</td>
			<td>
				<input type="hidden" name="income_day" id="income_day" style="width: 100">
				<select name="income_day2" style="width: 100px;" disabled="disabled" style="width: 100">
					<script type="text/javascript">
						for(var i=1;i<=31;i++){
							document.write("<option value='"+i+"'>"+i+"</option>");
						}
					</script>
				</select>	 
				<span class="biTian">*</span>
			</td>
			 <td  scope="row" nowrap>Ԥ��IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly" style="width: 100"/>
			</td>
		  </tr>
		  
		  <tr>
		   	<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly style="width: 100" r/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>	
		  
		  <tr>
		  	 <td colspan="8">
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:12px" color=grey>
			</td>
		  </tr>
		  <tr>
		  	 <td scope="row" id="bj_4">�ƻ��տ������˺�</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" style="width: 100">
		    
		    </td>
		    <td scope="row" id="bj_3">�ƻ��տ������</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" style="width: 100">
		    </td>
		  	<td  scope="row" nowrap>���ʶ��⹫��</td>
			<td>
				<input type="radio" name="is_open" value="��" disabled="disabled">�� &nbsp;
				<input type="radio" name="is_open" value="��" disabled="disabled">�� &nbsp;
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��Ϣ������</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly=" readonly"/>%%
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  	<td scope="row" nowrap>���ʸ�������</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()" style="width:150px;" disabled="disabled">
		        <script type="text/javascript" >
			        w(mSetOpt('0',"���������ʸ�������|���������ʼӵ�|��������|���ֲ���","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true"  readonly="readonly" style="width: 100" disabled="disabled"/>
		    	<span class="biTian">*</span>
			</td>
		  	
		    <td scope="row" nowrap>���Ʊ��ʽ</td>
			<td>
			<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true" label="���Ʊ��ʽ">
					  <script type="text/javascript">
						w(mSetOpt('',"�ȿ�������ܶƱ|�ȿ��������վݣ���Ϣ��Ʊ|�ȿ��������ֿ�|�󿪣�����ܶƱ|�󿪣������վݣ���Ϣ��Ʊ|�󿪣������ֿ�|�󿪣������ֿ����ŷ�Ʊ|�ȿ��������ֿ����ŷ�Ʊ|����",
						"root.RentInvoice.001|root.RentInvoice.002|root.RentInvoice.003|root.RentInvoice.004|root.RentInvoice.005|root.RentInvoice.006|root.RentInvoice.007|root.RentInvoice.008|root.RentInvoice.009"));
					</script>
				</select>
				<!--
				<select style="width:130px;" name="invoice_type" id="invoice_type" Require="true" label="���Ʊ��ʽ" disabled="disabled"></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>-->
				<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  <td scope="row" nowrap>��Ϣ��ʽ</td>
		  <td>
		    	<select name="adjust_style" style="width:150px;" disabled="disabled">
			        <script type="text/javascript">
			        	w(mSetOpt('2',"������|������|������","1|2|4"));
			        </script>
		        </select> 
		        ������Ϣ
		        <input type="radio" name="into_batch" value="��" checked="checked" disabled="disabled">��
		    	<input type="radio" name="into_batch" value="��" disabled="disabled">��
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly" style="width: 100"/>
			</td>
			
			<td scope="row" nowrap>�Ƿ���</td>
		    <td>
		        <input type="radio" name="factoring" value="��" checked="checked" disabled="disabled">��
		    	<input type="radio" name="factoring" value="��" disabled="disabled">��
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>˰��</td>
			<td>
				<select style="width:100px;" name="tax_type" id="tax_type"  Require="true"  >
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
			<select style="width:150px;" name="tax_type_invoice" id="tax_type_invoice" Require="true" label="������ȡ��ʽ">
					  <script type="text/javascript">
							w(mSetOpt('',"��ֵ˰��ͨ��Ʊ|��ֵ˰ר�÷�Ʊ|��","��ֵ˰��ͨ��Ʊ|��ֵ˰ר�÷�Ʊ|��"));
					  </script>
				</select>
								
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>˰��</td>
			<td>
			<select style="width:140px;" name="tax_rate" id="tax_rate" Require="true" label="˰��">
			<%
			ERPDataSource erp = new ERPDataSource();
			String invoiceStr = "select title,parentid from ifelc_conf_dictionary where parentid = 'root.tax_rate' order by title desc ";
			ResultSet rsdic= erp.executeQuery(invoiceStr);
			while(rsdic.next()){
				String title = rsdic.getString("title");
				%>
				<option value ="<%=title %>"><%=Double.valueOf(title).toString() %></option>
				<%
			}
			if(null!=rsdic){
				rsdic.close();
			}
			if(null !=erp){
				erp.close();
			}
			%>
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
/**
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
**/
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

//�жϱ��ε����ʱ������Ƿ�Ϸ�
function checkValid(){
	var validLM = $("#validLM").val();
	var lm = dataBack($("#lease_money").val());
	
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
		}else if($("#year_rate").val()<=0){
			alert("���������ʱ�����Ҵ���0��");
			return false;
		}
		//alert($("#income_number").val());
		
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
	 				if(reg_money.test(dataBack(text_value))== false){
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
	$("input[type='text']").focus();
	var str = "";
	
	//���ޱ��� ����<=0
	if(dataBack($("#lease_money").val())<=0){
		str = "���ޱ�����<=0";
		alert(str);
		$("#lease_money").focus();
		return false;
	}
	//���������ʡ��������
	else if( !/^[0-9]+.?[0-9]*$/.test($(":input[name='year_rate']").val()) ){
		str = "���������ʲ��Ϸ�";
		alert(str);
		$(":input[name='year_rate']").focus();
		//create_span(str,year_rate);
		return false;
	}else if( !/^[1-9]*\d$/.test($(":input[name='income_number']").val()) ){
		str = "�껹�������д������";
		alert(str);
		$(":input[name='income_number']").focus();
		return false;
	}
		
	//�ȼ��
	if(check_allInput()){
		form1.onsubmit();	
	}
}
//���ύ�¼�
	function verification(){
		if(Validator.Validate(form1,2)){
		$("input[type='text']").focus();  
			form1.submit();
			return true;
		}else{
			return false;
		}
	}
</script>

<script type="text/javascript">
$(document).ready(function() {
    $("input[type='text']").each(function(i) {
		$(this).blur(function (){mouse(this.value,this.name)});
		$(this).focus(function (){huifumouse(this.value,this.name)});
 	});
    
    $("input[type='text']").blur(); 
 });
</script>
</html>