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
<title>租金测算 - 合同交易结构</title>
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
		alert("该测算类型不支持模板下载，请在线测算！");
	}
}
function showUploadDiv(){
	$("#uploadDiv").fadeIn("slow");
}

/**
 *初始化一些表单事件
 */
$(document).ready(function(){
	//禁止某几项不让更改
	$("#contract_id").attr("readonly","readonly");
	$(":input[name='free_defa_inter_day']").attr("readonly","readonly");
	//添加几项失去焦点判断值是否正确
	$(":input[name='year_rate']").blur(function(){//年利率
		if( !/^[0-9]+.?[0-9]*$/.test($(this).val()) ){ // /^[0-9]+.?[0-9]*$/
			alert("年利率填写格式不正确");
			$(this).val(0);
			$(this).focus();
		}
	});
	$(":input[name='income_number']").blur(function(){//年还租次数
		if( !/^\d+$/.test($(this).val()) ){
			alert("年还租次数填写正整数");
			$(this).val(0);
			$(this).focus();
		}
	});
	//租金公比参数 ratio_param
	$(":input[name='ratio_param']").blur(function(){//公比
		//先取出测算方式
		var stm = $("#settle_method").val();
		var ratio_param = $(this).val();

		if( stm=="RentCalcType3" || stm=="RentCalcType6" ){
			if( isNaN(ratio_param) ){
				alert("抱歉，公比只能不能填写字符");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param<=0 || ratio_param>=1 ){
				alert("公比只允许0到1之间");
				$(this).val(0);
				$(this).focus();
			}
		}else if( stm=="RentCalcType2" || stm=="RentCalcType5" ){
			if( isNaN(ratio_param) ){
				alert("抱歉，公差不能填写字符");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param==0 ){
				alert("公差不允许填0");
				$(this).val(0);
				$(this).focus();
			}
		}
	});
	
	//起租日期与每月偿付日
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
 * 租金测算方法改变
 */
function changeCalcWay(){
	var settle_methodVal = $("#settle_method").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("租金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("本金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("租金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0到1之间");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("本金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0到1之间");
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
	//基础参数	
	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String flow_date = getStr(request.getParameter("flow_date"));
	String begin_order_index = getStr(request.getParameter("begin_order_index"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间

	//判断执行类型 -- 从数据库查询有数据则upd无则add
	String savaType = BeginService.judgeSaveType(begin_id, doc_id);
	
	//1.如果upd则假装ConditionBean
	BeginInfoBean beginInfoBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfoBean  = BeginService.initBeginInfoBean(begin_id, doc_id);
		beginInfoBean  = BeginService1.initBeginInfoBean(beginInfoBean);
	}
%> 

<%
//如果有值则加载属性值
if( beginInfoBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//租金计算方法 settle_method
	//$("select[name='settle_method']").val("<%=beginInfoBean.getSettle_method() %>");
	$("input[name='settle_method']").val("<%=beginInfoBean.getSettle_method() %>");
	$("select[name='settle_method2']").val("<%=beginInfoBean.getSettle_method() %>");
	//付租类型： period_type
	//$("#period_type").val("<%=beginInfoBean.getPeriod_type() %>");
	$("#period_type").val("<%=beginInfoBean.getPeriod_type() %>");
	$("input[name='period_type']").val("<%=beginInfoBean.getPeriod_type() %>");
	//设备金额 equip_amt
	$("#equip_amt").val("<%=beginInfoBean.getEquip_amt() %>");
	//租赁本金 lease_money
	$("input[name='lease_money']").val("<%=beginInfoBean.getLease_money() %>");
	//净融资额 actual_fund
	$("input[name='actual_fund']").val("<%=beginInfoBean.getActual_fund() %>");
	
	//预计起租日 start_date
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfoBean.getStart_date()) %>");
	
	//租赁年利率 year_rate
	$("input[name='year_rate']").val("<%=Double.parseDouble(beginInfoBean.getYear_rate()) %>");
	//罚息日利率 pena_rate
	$("input[name='pena_rate']").val("<%=beginInfoBean.getPena_rate() %>");
	//逾期宽限日 free_defa_inter_day
	$("input[name='free_defa_inter_day']").val("<%=beginInfoBean.getFree_defa_inter_day() %>");
	//付租方式 income_number_year
	$("input[name='income_number_year']").val("<%=beginInfoBean.getIncome_number_year() %>");
	//$("#income_number_year").val("<%=beginInfoBean.getIncome_number_year() %>");
	//还租次数 income_number
	$("input[name='income_number']").val("<%=beginInfoBean.getIncome_number() %>");
	//租赁期限(月) lease_term
	$("input[name='lease_term']").val("<%=beginInfoBean.getLease_term() %>");
	//每月偿付日 income_day
	$("select[name='income_day2']").val("<%=beginInfoBean.getIncome_day() %>");
	$("#income_day").val("<%=beginInfoBean.getIncome_day() %>");
	//利率浮动类型  rate_float_type
	$("select[name='rate_float_type']").val("<%=beginInfoBean.getRate_float_type() %>");
	//利率调整值 rate_float_amt
	$("input[name='rate_float_amt']").val("<%=beginInfoBean.getRate_float_amt() %>");
	$("input[name='rate_float_amt']").blur();
	
	//预计IRR plan_irr
	$("input[name='plan_irr']").val("<%=beginInfoBean.getPlan_irr() %>");
	//实际IRR fact_irr
	$("input[name='fact_irr']").val("<%=beginInfoBean.getFact_irr() %>");
	//调息方式 adjust_style
	$("select[name='adjust_style']").val("<%=beginInfoBean.getAdjust_style() %>");
	//是否批量调息 into_batch
	$(":radio[name='into_batch']").removeAttr("checked");
	$("input[name='into_batch'][value='<%=beginInfoBean.getInto_batch() %>']").attr("checked","checked");
	//利率是否对外公开
	$(":radio[name='is_open']").removeAttr("checked");
	$("input[name='is_open'][value='<%=beginInfoBean.getIs_open() %>']").attr("checked","checked");
	
	// 资产余值 assets_value
	$("input[name='assets_value']").val("<%=beginInfoBean.getAssets_value() %>");
	// 本金公比、租金公比、本金公差、租金公差 ratio_param
	$("input[name='ratio_param']").val("<%=beginInfoBean.getRatio_param() %>");
	//预计收款银行名称
	$("input[name='plan_bank_name']").val("<%=beginInfoBean.getPlan_bank_name() %>");
	//预计收款银行账号
	$("input[name='plan_bank_no']").val("<%=beginInfoBean.getPlan_bank_no() %>");
	//租金开票方式
	$("select[name='invoice_type']").val("<%=beginInfoBean.getInvoice_type() %>");
	//是否保理
	$(":radio[name='factoring']").removeAttr("checked");
	$("input[name='factoring'][value='<%=beginInfoBean.getFactoring() %>']").attr("checked","checked");
	//税种
	$("select[name='tax_type']").val("<%=beginInfoBean.getTax_type() %>");
	//增值税发票类型
	$("select[name='tax_type_invoice']").val("<%=beginInfoBean.getTax_type_invoice() %>");
	
	//租金税率
	$("select[name='tax_rate']").val("<%=beginInfoBean.getTax_rate() %>");
	//显示设置
	changeCalcWay();
});
</script>
<%
}else{%>
<script type="text/javascript">
$(document).ready(function(){
	//初次加载的赋值操作
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
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="80%" align="center" class="tab_table_title">
			<tr height="40" style="font-weight: bold;">
				<%
					String usedLeaseMoney = BeginService.getUsedLeaseMoneyB(contract_id, flow_date);
					String totalLeaseMoney = BeginService.getTotalLeaseMoney(contract_id);
					String leftLeaseMoney = MathExtend.subtract(totalLeaseMoney, usedLeaseMoney);
				%>
				<td colspan="3" style="font-size: 16px;">合同租赁本金：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalLeaseMoney) %></b></td>
				<td colspan="3" style="font-size: 16px;">已起租租赁本金：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedLeaseMoney) %></b></td>
				<td colspan="2" style="font-size: 16px;">剩余租赁本金：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftLeaseMoney) %></b>
				<input type="hidden" id="validLM" value="<%=leftLeaseMoney %>">
				<input type="hidden" name="begin_order_index" id="begin_order_index" value="<%=begin_order_index %>">
				</td>
			</tr>
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				租金计算方法:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" name="settle_method">
				 <select style="width:130px;" name="settle_method2" id="settle_method" 
					Require="true" onchange="changeCalcWay()">
					<script type="text/javascript">
						w(mSetOpt('',
						"等额租金|等差租金|等比租金|等额本金|等差本金|等比本金|等额租金后付(均息法)|不等额租金|不等额本金|不规则",
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
		         付租类型：
		        <input type="hidden" name="period_type">
		        <select name="period_type2" id="period_type" disabled="disabled" style="width: 60px;" Require="true">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
				</td>
			</tr>
		
		  <tr>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>合同编号</td>
		    <td>
		    	<input name="contract_id" style="width:150px;" id="contract_id" type="text" value="<%=contract_id%>" size="25" maxlength="50" readonly="readonly"/>
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>货币类型</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled">
					<option value="currency_type1">人民币</option>
				</select><!--
				<select style="width:100px;" name="currencyVal"  id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>-->
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>租赁本金</td>
		     <td>
		    	<input name="lease_money" id="lease_money" readonly="readonly" value="0" type="text" Require="true" dataType="Money" 
		    	size="13" maxlength="100" maxB="100" Require="true" onblur="checkValid()" style="width: 100"/>
		    	<span class="biTian">*</span>
			 </td>
			<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<input name="actual_fund" id="actual_fund" type="text" value="" readonly="readonly"
		    	dataType="Money" size="13" maxlength="20" maxB="20" style="width: 100"/> 
    			<span class="biTian">*</span>
			</td>
		  </tr> 
		  
		  <tr>
		 	<td scope="row" nowrap>资产余值</td>
		    <td>
		    	<input name="assets_value" style="width: 100" type="text" value="0" readonly="readonly" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
		  	<td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" id="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly="readonly"/>%
				<span class="biTian">*</span>
			</td>  
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="3"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>实际IRR</td>
			<td>
				<input name="fact_irr" type="text" value="0" size="13" maxlength="10" style="width: 100" readonly="readonly"/>
			</td>
		  </tr>
		  
		  <tr>
		  <td scope="row" nowrap>付租方式</td>
			<td>
				<!-- sys 付租方式 begin-->
		    	<input type="hidden"  name="income_number_year" style="width: 100px;" value="" readonly="readonly">
		    	<% if(beginInfoBean.getIncome_number_year().equals("1")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="月付" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("2")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="双月付" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("3")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="季付" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("6")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="半年付" readonly="readonly">
		    	<%}else if(beginInfoBean.getIncome_number_year().equals("12")){%>
		    	<input type="text"  name="income_number_year1" style="width: 100px;" value="年付" readonly="readonly">
		    	<%} %>
		    	<!-- end -->
			</td>
			<!-- <td scope="row" nowrap>付租方式</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			 -->
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" id="income_number" type="text" value="0"  onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>每月偿付日</td>
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
			 <td  scope="row" nowrap>预计IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly" style="width: 100"/>
			</td>
		  </tr>
		  
		  <tr>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
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
		  	 <td scope="row" id="bj_4">计划收款银行账号</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" style="width: 100">
		    
		    </td>
		    <td scope="row" id="bj_3">计划收款开户银行</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" style="width: 100">
		    </td>
		  	<td  scope="row" nowrap>利率对外公开</td>
			<td>
				<input type="radio" name="is_open" value="是" disabled="disabled">是 &nbsp;
				<input type="radio" name="is_open" value="否" disabled="disabled">否 &nbsp;
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" style="width: 100" readonly=" readonly"/>%%
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()" style="width:150px;" disabled="disabled">
		        <script type="text/javascript" >
			        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|隐含利率|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true"  readonly="readonly" style="width: 100" disabled="disabled"/>
		    	<span class="biTian">*</span>
			</td>
		  	
		    <td scope="row" nowrap>租金开票方式</td>
			<td>
			<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true" label="租金开票方式">
					  <script type="text/javascript">
						w(mSetOpt('',"先开，租金总额发票|先开，本金收据，利息发票|先开，本利分开|后开，租金总额发票|后开，本金收据，利息发票|后开，本利分开|后开，本利分开两张发票|先开，本利分开两张发票|其它",
						"root.RentInvoice.001|root.RentInvoice.002|root.RentInvoice.003|root.RentInvoice.004|root.RentInvoice.005|root.RentInvoice.006|root.RentInvoice.007|root.RentInvoice.008|root.RentInvoice.009"));
					</script>
				</select>
				<!--
				<select style="width:130px;" name="invoice_type" id="invoice_type" Require="true" label="租金开票方式" disabled="disabled"></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>-->
				<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  <td scope="row" nowrap>调息方式</td>
		  <td>
		    	<select name="adjust_style" style="width:150px;" disabled="disabled">
			        <script type="text/javascript">
			        	w(mSetOpt('2',"按次日|按次期|按次年","1|2|4"));
			        </script>
		        </select> 
		        批量调息
		        <input type="radio" name="into_batch" value="是" checked="checked" disabled="disabled">是
		    	<input type="radio" name="into_batch" value="否" disabled="disabled">否
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly" style="width: 100"/>
			</td>
			
			<td scope="row" nowrap>是否保理</td>
		    <td>
		        <input type="radio" name="factoring" value="是" checked="checked" disabled="disabled">是
		    	<input type="radio" name="factoring" value="否" disabled="disabled">否
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>税种</td>
			<td>
				<select style="width:100px;" name="tax_type" id="tax_type"  Require="true"  >
					  <script type="text/javascript">
						w(mSetOpt('',"营业税|增值税","营业税|增值税"));
					</script>
				</select>
				<span class="biTian">*</span>
			</td> 
		  </tr>
		<tr>
			<td  scope="row" nowrap>增值税发票类型</td>
			<td>
			<select style="width:150px;" name="tax_type_invoice" id="tax_type_invoice" Require="true" label="保险收取方式">
					  <script type="text/javascript">
							w(mSetOpt('',"增值税普通发票|增值税专用发票|无","增值税普通发票|增值税专用发票|无"));
					  </script>
				</select>
								
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>税率</td>
			<td>
			<select style="width:140px;" name="tax_rate" id="tax_rate" Require="true" label="税率">
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
//付租方式值改变清空换租次数的值
function changIncome_number_year_value(){	
	var income_number_year = document.getElementsByName("income_number_year")[0].value;
	if(income_number_year == null || income_number_year == ''){
		alert("请选择具体的付租方式!");
		return false;
	}
	document.getElementsByName("income_number")[0].value = '';
	document.getElementsByName("lease_term")[0].value = '';
}

function changLeaseT_value(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//付租方式
	var income_number_value = document.getElementsByName("income_number")[0].value;//还租次数
	// 还租次数 = 租赁期限/付租方式 //租赁期限 = 还租次数*付租方式
	if(income_number_year_value != null || income_number_year_value != ''){
		if(income_number_value == null || income_number_value == ''){
			alert("请输入还租次数!");
			return false;
		}else{
			var lt_value = income_number_value * income_number_year_value;
			document.getElementsByName("lease_term")[0].value = lt_value; 
		}
	}else{
		alert("请选择付租方式!");
		return false;
	}
}


//利率调整值输入后在利率调整值后面显示出数据
function alertChange(){
	var rate_float_amt = document.getElementsByName("rate_float_amt")[0].value;//利率调整值
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|隐含利率|隐含加点|保持不变","0|1|2|4|3"
	//按央行利率浮动比率  - 		央行调整值 * (1+浮动值) + 旧利率
	//按央行利率加点			央行调整值 + 旧利率
	//隐含利率 			1+央行调整值/上次利率值 * 浮动值 -- 上次利率值 = 本次基础值 - 央行调整值
	//隐含加点			央行调整值 + 旧利率
	//固定不变  			
	
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
	//
	if(rate_float_amt == '' || rate_float_amt == null){
		div_rate.style.displa = 'block';
	}else{
		if(rate_float_type == '0'){//2010-11-23需求修改
			name = "按央行利率浮动比率";
			div_rate.innerHTML = "<font color='red'>按央行利率浮动比率调整为：央行调整值×(1+"+rate_float_amt+")+旧利率</font>";
		}
		if(rate_float_type == '1'){
			name = "按央行利率加点";
			div_rate.innerHTML = "<font color='red'>按央行利率加点调整为：(央行基础利率+幅度)</font>";
		}
		if(rate_float_type == '2'){
			name = "隐含利率";
			div_rate.innerHTML = "<font color='red'>隐含利率调整为: 1+央行调整值/上次利率值*"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '3'){
			name = "固定不变";
			div_rate.innerHTML = "<font color='red'>固定不变: "+($(":input[name='year_rate']").val())+"</font>";
		}
		if(rate_float_type == '4'){
			name = "隐含加点";
			div_rate.innerHTML = "<font color='red'>隐含加点: (央行基础利率+幅度)</font>";
		}
	}
}
/**
function changeOne(){
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
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
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
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

//判断本次的融资本金金额是否合法
function checkValid(){
	var validLM = $("#validLM").val();
	var lm = dataBack($("#lease_money").val());
	
	if(isNaN(validLM)) validLM = 0;
    if(isNaN(lm)) lm = 0;

	//判断输入是否合法
	var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	if( reg_money.test(lm)== false){
		str = "设备金额-货币格式错误";//
		$("#lease_money").next(".biTian").text(str);
		$("#lease_money").focus();
	}else if( Number(lm) > Number(validLM)){
		alert("租赁本金不合法，不能大于"+validLM);
		$("#lease_money").val("0");
		$("#lease_money").focus();
	}
}

/**
	*  验证所有的input输入框，验证各种格式
	*/
	function check_allInput(){
		//判断测算方式|付租类型
		if($("#settle_method").val()==""){
			alert("租金计算方法必填！");
			return false;
		}else if($("#period_type").val()==""){
			alert("付租类型必填！");
			return false;
		}else if($("#income_number").val()<=0){
			alert("还租次数必填，并且大于0！");
			return false;
		}else if($("#year_rate").val()<=0){
			alert("租赁年利率必填，并且大于0！");
			return false;
		}
		//alert($("#income_number").val());
		
		var savaType = document.getElementById('savaType').value ;//判断添加还是修改
		var list = document.getElementsByTagName("input");
		var str = "0";
		var count = 0;
		for(var i=0;i<list.length && list[i];i++)
 		{
 			//alert("list[i].type==>"+list[i].type);
 			if(list[i].type == "text"){
 				var text_value = list[i].value;
 				text_value = trim(text_value);//除去空格
				 //非法字符的验证 				
 				 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
                 if(text_value.match(reg_ff)) { 
                     str = "输入框所填的字符串不能包含特殊字符:。-- /* ';\"% < > // \"等" ;
                     alert(str);
                     count = count + 1;
                     break;
                  }
 				//alert(list[i].name+"="+text_value+"----"+list[i].dataType);
	 			//货币格式 : /^[+]?\d+(\.[0-9]{1,2})?$/ 金额格式不正确，必须为正实数并且小数在两位以内
	 			if(list[i].dataType == 'Money' || list[i].dataType == 'money'){
	 				var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	 				//alert("MONEY验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_money.test(text_value));
	 				if(reg_money.test(dataBack(text_value))== false){
	 					str = "货币格式错误";//
	 					//var pos = getElementPos(list[i].name);  //测算该字段的坐标 
						//alert("距左边距离"+ pos.x +",距上边距离"+pos.y); 
						create_span(str,list[i].name);//进行对应字段的错误提示
						count = count + 1;
	 					break;
	 				}else{
	 					str = "";
						create_span(str,list[i].name);//正确情况置为空
	 				}
	 			}
	 			//数字类型: /^\d+$/    
	 			if(list[i].dataType == 'Number' || list[i].dataType == 'number'){
	 				//var reg_number = /^\d+$/;
	 				//alert("Number验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_number.test(text_value));
	 				if(isNaN(text_value) == false){
	 					str = "必须为数字";//
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//正整数格式包括0：^\d+$   验证非正整数（负整数 + 0） ^((-\d+)|(0+))$ 
	 			if(list[i].dataType == 'Integer' || list[i].dataType == 'integer'){
	 				var reg_Integer =  /^\d+$/;
	 				//alert("Integer验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Integer.test(text_value));
	 				if(reg_Integer.test(text_value) == false){
	 					str = "必须为正整数包含0";
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//double格式：/^[-\+]?\d+(\.\d+)?$/
	 			if(list[i].dataType == 'Double' || list[i].dataType == 'double'){
	 				var reg_Double =  /^[-\+]?\d+(\.\d+)?$/;
	 				//alert("Double验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Double.test(text_value));
	 				if(reg_Double.test(text_value) == false){
	 					str = "必须为实数";
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//利率格式: /^\d+(\.[0-9]{1,8})?$/,
	 			if(list[i].dataType == 'Rate' || list[i].dataType == 'rate'){
	 				var reg_Rate =  /^\d+(\.[0-9]{1,8})?$/;
	 				//alert("reg_Rate验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Rate.test(text_value));
	 				if(reg_Rate.test(text_value) == false){
	 					str = "必须为正实数并且小数在八位以内";
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
 			}//input是输入框的判断结束
 		}//for 循环结束
 		//alert("str1====>"+str);
 		str = trim(str);//除去空格
		if(count > 0){
			//alert("join1");
			return false; 
		}else{
			//alert("join2");
			return true;
		}
	}
	/**
	*判断错误的条件下插入一个span节点，并显示错误原因，输入正确则将该节点置为空
	*参数1：str 错误原因
	*参数2：name 节点属性名称或者id
	*/
	function create_span(str,name){
		var tem_name = name+"_msg";
		//如果节点span不存在就创建一个，如果存在就将值置为空
		if (null==document.getElementById(tem_name) || document.getElementById(tem_name)=='undefined') {
		    var newSpan = document.createElement("span");
			newSpan.id = name+"_msg";
			document.getElementById(name).parentNode.appendChild(newSpan);//找到父节点TD下创建一个span元素
		} else {
		   document.getElementById(tem_name).innerHTML ="";
		}
		document.getElementById(tem_name).innerHTML =  "<br><font color='red'>"+str+"</font>";//
	}
	/*
    方法描述： 去除多余空格函数
    	return: s 2边的多余的空格已经去除掉
    	author:  sea
    	date: 2010-04-13
	*/
	function trim(s){  
  		return s.replace(/(^\s*)|(\s*$)/g,"");      
	}


//租金测算按钮跳转的区分判断
function submitForm(){
	//判断几个核心数据
	$("input[type='text']").focus();
	var str = "";
	
	//租赁本金 不能<=0
	if(dataBack($("#lease_money").val())<=0){
		str = "租赁本金不能<=0";
		alert(str);
		$("#lease_money").focus();
		return false;
	}
	//租赁年利率、还租次数
	else if( !/^[0-9]+.?[0-9]*$/.test($(":input[name='year_rate']").val()) ){
		str = "租赁年利率不合法";
		alert(str);
		$(":input[name='year_rate']").focus();
		//create_span(str,year_rate);
		return false;
	}else if( !/^[1-9]*\d$/.test($(":input[name='income_number']").val()) ){
		str = "年还租次数填写正整数";
		alert(str);
		$(":input[name='income_number']").focus();
		return false;
	}
		
	//先检测
	if(check_allInput()){
		form1.onsubmit();	
	}
}
//表单提交事件
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