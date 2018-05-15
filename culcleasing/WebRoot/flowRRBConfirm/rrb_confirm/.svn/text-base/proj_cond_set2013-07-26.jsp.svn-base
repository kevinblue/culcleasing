<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="com.tenwa.culc.service.ConditionService"%>
<%@ page import="com.tenwa.culc.service1.ConditionService1"%>
<%@ page import="com.tenwa.culc.bean.ConditionBean"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商务条件 - 租前息确认</title>
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
	$(":input[name='before_interest']").removeAttr("disabled");//取消
	$(":input[name='before_interest_type']").removeAttr("disabled");//取消
	$(":input[name='lease_money']").removeAttr("disabled");//取消
	$(":input[name='actual_fund']").removeAttr("disabled");//取消
	$(":input[name='actual_fund_ratio']").removeAttr("disabled");//取消
	$(".btn_2").removeAttr("disabled");//取消
	$(":input[name='contract_id']").removeAttr("disabled");//取消
	$(":input[name='doc_id']").removeAttr("disabled");//取消
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
 * 租金测算方法改变
 */
function changeCalcWay(){
	var settle_methodVal = $("#settle_method").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("租金公差");
		$("#bj_2").show();
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("本金公差");
		$("#bj_2").show();
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("租金公比");
		$("#bj_2").show();
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("本金公比");
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
	//基础参数	
	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间
	
	//判断执行类型 -- 从数据库查询有数据则upd无则add
	String savaType = "upd";
	
	//1.如果upd则假装ConditionBean
	ConditionBean conditionBean = ConditionService.initConditionContractBean(contract_id, doc_id);
	conditionBean = ConditionService1.initConditionContractBean(conditionBean);
	
%> 

<script type="text/javascript">
$(document).ready(function(){
	//租金计算方法 settle_method
	$("select[name='settle_method']").val("<%=conditionBean.getSettle_method() %>");
	//付租类型： period_type
	$("#period_type").val("<%=conditionBean.getPeriod_type() %>");
	//设备金额 equip_amt
	$("#equip_amt").val("<%=conditionBean.getEquip_amt() %>");
	//首付款 first_payment
	$("input[name='first_payment']").val("<%=conditionBean.getFirst_payment() %>");
	//租赁本金 lease_money
	$("input[name='lease_money']").val("<%=conditionBean.getLease_money() %>");
	//租赁本金hidden字段 lease_money
	$("input[name='lease_money_hidden']").val("<%=conditionBean.getLease_money() %>");
	//保证金 caution_money
	$("input[name='caution_money']").val("<%=conditionBean.getCaution_money() %>");
	//手续费 handling_charge
	$("input[name='handling_charge']").val("<%=conditionBean.getHandling_charge() %>");
	//管理费 management_fee
	$("input[name='management_fee']").val("<%=conditionBean.getManagement_fee() %>");
	//残值收入 nominalprice
	$("input[name='nominalprice']").val("<%=conditionBean.getNominalprice() %>");
	//厂商返利 return_amt
	$("input[name='return_amt']").val("<%=conditionBean.getReturn_amt() %>");
	//租前息 before_interest
	$("input[name='before_interest']").val("<%=conditionBean.getBefore_interest() %>");
	$("input[name='before_interest_hidden']").val("<%=conditionBean.getBefore_interest() %>");
	//租前息-类型 算本、不算本 before_interest_type
	$(":radio[name='before_interest_type']").removeAttr("checked");
	$(":radio[name='before_interest_type'][value='<%=conditionBean.getBefore_interest_type() %>']").attr("checked","checked");
	$("input[name='before_interest_type_hidden']").val("<%=conditionBean.getBefore_interest_type() %>");
	
	//利息补贴 rate_subsidy
	$("input[name='rate_subsidy']").val("<%=conditionBean.getRate_subsidy() %>");
	//贴现息 discount_rate
	$("input[name='discount_rate']").val("<%=conditionBean.getDiscount_rate() %>");
	//其他收入 other_income
	$("input[name='other_income']").val("<%=conditionBean.getOther_income() %>");
	//其他支出 other_expenditure
	$("input[name='other_expenditure']").val("<%=conditionBean.getOther_expenditure() %>");
	//咨询费收入 consulting_fee_in
	$("input[name='consulting_fee_in']").val("<%=conditionBean.getConsulting_fee_in() %>");
	//咨询费支出 consulting_fee_out
	$("input[name='consulting_fee_out']").val("<%=conditionBean.getConsulting_fee_out() %>");
	//保费金额 insure_money
	$("input[name='insure_money']").val("<%=conditionBean.getInsure_money() %>");
	//净融资额 actual_fund
	$("input[name='actual_fund']").val("<%=conditionBean.getActual_fund() %>");
	$("input[name='actual_fund_hidden']").val("<%=conditionBean.getActual_fund() %>");
	//净融资额比例 actual_fund_ratio
	$("input[name='actual_fund_ratio']").val("<%=conditionBean.getActual_fund_ratio() %>");
	
	//投保方式 insure_type
	$("#insure_type").val("<%=conditionBean.getInsure_type() %>");
	//预计起租日 start_date
	$("input[name='start_date']").val("<%=getDBDateStr(conditionBean.getRent_start_date()) %>");
	
	//租赁年利率 year_rate
	$("input[name='year_rate']").val("<%=conditionBean.getYear_rate() %>");
	//罚息日利率 pena_rate
	$("input[name='pena_rate']").val("<%=conditionBean.getPena_rate() %>");
	//逾期宽限日 free_defa_inter_day
	$("input[name='free_defa_inter_day']").val("<%=conditionBean.getFree_defa_inter_day() %>");
	//付租方式 income_number_year
	$("#income_number_year").val("<%=conditionBean.getIncome_number_year() %>");
	//还租次数 income_number
	$("input[name='income_number']").val("<%=conditionBean.getIncome_number() %>");
	//租赁期限(月) lease_term
	$("input[name='lease_term']").val("<%=conditionBean.getLease_term() %>");
	//每月偿付日 income_day
	$("select[name='income_day']").val("<%=conditionBean.getIncome_day() %>");
	//利率浮动类型  rate_float_type
	$("select[name='rate_float_type']").val("<%=conditionBean.getRate_float_type() %>");
	//利率调整值 rate_float_amt
	$("input[name='rate_float_amt']").val("<%=conditionBean.getRate_float_amt() %>");
	$("input[name='rate_float_amt']").blur();
	
	//预计IRR plan_irr
	$("input[name='plan_irr']").val("<%=conditionBean.getPlan_irr() %>");
	//实际IRR irr
	$("input[name='irr']").val("<%=conditionBean.getIrr() %>");
	//调息方式 adjust_style
	$("select[name='adjust_style']").val("<%=conditionBean.getAdjust_style() %>");
	//是否批量调息 into_batch
	$("input[name='into_batch']").val("<%=conditionBean.getInto_batch() %>");

	// 资产余值 assets_value
	$("input[name='assets_value']").val("<%=conditionBean.getAssets_value() %>");
	// 考核调整 assess_adjust
	$("input[name='assess_adjust']").val("<%=conditionBean.getAssess_adjust() %>");
	// 本金公比、租金公比、本金公差、租金公差 ratio_param
	$("input[name='ratio_param']").val("<%=conditionBean.getRatio_param() %>");
	//租金开票
	$("select[name='invoice_type']").val("<%=conditionBean.getInvoice_type() %>");
	//达标irr
	$(":radio[name='StandardF']").removeAttr("checked");
	$("input[name='StandardF'][value='<%=conditionBean.getStandardF() %>']").attr("checked","checked");
	//是否达标
	$("input[name='getStandardIrr']").val("<%=conditionBean.getStandardIrr() %>");
	//保险收取方式 insure_pay_type
	$("select[name='insure_pay_type']").val("<%=conditionBean.getInsure_pay_type() %>");
	//税种
	$("select[name='tax_type']").val("<%=conditionBean.getTax_type() %>");
	//增值税发票类型
	$("select[name='tax_type_invoice']").val("<%=conditionBean.getTax_type_invoice() %>");
	//显示设置
	changeCalcWay();
});
//表单提交
function sub_updForm(){
	//判断是否选中租前息数据
	var biVal = dataBack($(":input[name='before_interest']").val());
	var bitVal = $(":radio[name='before_interest_type']:checked").val();
	
	//alert (biVal + "____"+ bitVal);
	if(biVal!="" && bitVal!=""){
		form1.onSubmit();	
	}else{
		alert("请填写租前息和租前息类型！");
		return false;
	}

}
</script>



<body onload="public_onload(0);">
<!-- form表单跳转到zjcs_projSave.jsp页面    doCument.forms[0].onsubmit()-->
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return return verification();">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				租金计算方法:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select style="width:130px;" name="settle_method" id="settle_method" 
					Require="true" onchange="changeCalcWay()">
					<script type="text/javascript">
						w(mSetOpt('',
						"等额租金|等差租金|等比租金|等额本金|等差本金|等比本金|等额租金后付(均息法)|不等额租金|不等额本金|不规则",
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
		         付租类型：
		        <select name="period_type" id="period_type" style="width: 60px;" Require="true">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
		        &nbsp;&nbsp;|
		        <BUTTON class="btn_2" onClick="return verification();">
					<img src="../../images/save.gif" align="absmiddle" border="0">更新商务信息
				</button>
				<b style="color:red;">(数据修改后，请及时更新！)</b>
				</td>
			</tr>
		
		  <tr>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>合同编号</td>
		    <td>
		    	<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" size="35" maxlength="50"/>
			  	<input name="doc_id" type="hidden" value="<%=doc_id %>">
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
		    <td scope="row" nowrap>设备金额</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0" dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>首付款</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true" readonly/>
		    	<span class="biTian">*</span>
		   	   </td> 
		   	   <td scope="row" nowrap>货币类型</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
			 <select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled">
					<option value="currency_type1">人民币</option>
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
		  	<!--  租赁本金 = 设备金额 - 首付款 onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>租赁本金</td>
		     <td>
		    	<input name="lease_money" id="lease_money" value="0" 
		    	readonly type="text" Require="true" dataType="Money" size="13" maxlength="100" maxB="100" 
		    	Require="true"/>
		    	<span class="biTian">*</span>
		    	<input name="lease_money_hidden" id="lease_money_hidden" type="hidden">
			 </td>
			<td  scope="row" nowrap>租赁保证金</td>
			<td>
				<input name="caution_money" id="caution_money" value="0" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					 type="text"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>租赁手续费</td>
			<td>
				<input name="handling_charge" type="text" value="0" 
				 	dataType="Money" size="13" maxlength="20" 
				 	maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>管理费</td>
		    <td colspan="">
		    	<input name="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"  /> 
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee_out" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"   -->
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" type="text" value="0" dataType="Money"
					  size="13" maxlength="20"  />
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="0" dataType="Money"
		    		  size="13" maxlength="10" /> 
			</td>
		  </tr>
		  <tr>	
		  	<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" type="text" value="0"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		   	 <input name="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
			</td>
			<td  scope="row" nowrap>预计IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>%
			</td>
		  </tr>
		   <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="changeValInfo()"
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" label="租前息"/>
		    		是否算本
		    		<input type="radio" name="before_interest_type" value="是"  onclick="changeValInfo()">是
		    		<input type="radio" name="before_interest_type" value="否" checked="checked" onclick="changeValInfo()">否
		    		<input type="hidden" name="before_interest_type_hidden" id="before_interest_type_hidden">
		    		<input type="hidden" name="before_interest_hidden" id="before_interest_hidden">
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>贴现息</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>资产余值</td>
		    <td>
		    	<input name="assets_value" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
		  </tr>
		  <tr>
		   	<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<!--  净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出 【2010-07-23修改，增加需要 减去租前息】 -->
		    	<input name="actual_fund" id="actual_fund" type="text" dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    	<input type="hidden" name="actual_fund_hidden" id="actual_fund_hidden">
		    		净融资额比例
					<input name="actual_fund_ratio" id="actual_fund_ratio" type="text" 
					value="" size="5" maxlength="10" readonly="readonly" 
					Require="true"/>% 
					
    				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>付租方式</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			<!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" type="text" value="0" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		   <tr>
		   <td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<!--  	display: none; 
				<div id="" style="" align="right"> 
					<input type="button"class="button" value="导入" alt="从主协议报价信息中导入" onclick=""/>
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
		  <td scope="row" nowrap>是否批量调息</td>
	   		<td>
	    		<select name="adjust_style" style="width: 100px;">
			        <script type="text/javascript">
			        	w(mSetOpt('1',"按次日|按次期","1|2"));
			        </script>
		        </select> 
		        批量调息
		        <input type="text" name="into_batch" size="5">
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
			</td>
			<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true"/>
		    	<span class="biTian">*</span>
			</td>
		</tr>
		  <tr>
		  <td scope="row" nowrap>达标IRR</td>
		    <td>
		    	<input type="text" dataType="Double" style="width: 140" name="StandardIrr" value="0" />%
				  是否达标
		        <input type="text" name="StandardF" size="5" value="否">
		    	<span class="biTian">*</span>
			</td>
		  	<td  scope="row" nowrap>实际IRR</td>
			<td>
				<input name="irr" dataType="Double" type="text" value="0" size="13" maxlength="10" label="实际IRR" />%
			</td>
			<td  scope="row" nowrap>每月偿付日</td>
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
			<td  scope="row" nowrap>投保方式</td>
			<td>
				<select style="width: 100px;" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type">
		        <script type="text/javascript">
			        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|隐含利率|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td colspan="4">
				<div id="div_rate"></div>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0" 
		    		dataType="Double" size="13" maxlength="10" maxB="10"  onblur="alertChange()" />
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
	    	<td scope="row" nowrap>租金开票方式</td>
			<td>
			<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true" label="租金开票方式">
					  <script type="text/javascript">
						w(mSetOpt('',"先开，租金总额发票|先开，本金收据，利息发票|先开，本利分开|后开，租金总额发票|后开，本金收据，利息发票|后开，本利分开|后开，本利分开两张发票|先开，本利分开两张发票|其它",
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
			<td  scope="row" nowrap>动态IRR</td>
			<td>
				<input name="dongirr" dataType="Double" type="text" value="0" size="13" maxlength="10"/>%
			</td>
			<td  scope="row" nowrap>保险收取方式</td>
			<td>
			<select style="width:100" name="insure_pay_type" id="insure_pay_type" Require="true" label="保险收取方式">
					  <script type="text/javascript">
							w(mSetOpt('',"1次性收完|分年|分季|无",
							"root.insurPayType.001|root.insurPayType.002|root.insurPayType.003|root.insurPayType.004"));
					  </script>
				</select>
				<!--
				<select style="width:100" name="insure_pay_type" id="insure_pay_type" Require="true" label="保险收取方式"></select>
				<script language="javascript" class="text">
					dict_list("insure_pay_type","root.insurPayType","root.insurPayType.001","name");
				</script>			-->		
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>税种</td>
			<td>
				<select style="width:100px;" name="tax_type" id="tax_type"  Require="true" disabled="disabled"  >
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
			<select style="width:150px;" name="tax_type_invoice" id="tax_type_invoice" Require="true" disabled="disabled" >
					  <script type="text/javascript">
							w(mSetOpt('',"增值税普通发票|增值税专用发票|无","增值税普通发票|增值税专用发票|无"));
					  </script>
				</select>
								
   				<span class="biTian">*</span>
			</td>
			</tr>
	    <tr>
		
	    	<!-- sys考核调整取消12.27
			<td scope="row" nowrap>考核调整</td>
		    <td>
		    	<input name="assess_adjust" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" onchange="changeFirst_payment()"/>
			</td>
			 -->
			 <!-- sys考核调整隐藏域 -->
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
//利率调整值输入后在利率调整值后面显示出数据
function alertChange(){
	var rate_float_amt = document.getElementsByName("rate_float_amt")[0].value;//利率调整值
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
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
	
	//alert(type+"  "+radio_val+" 金额= "+lease_money_hidden+" ..."+before_interest+" __"+actual_fund_hidden);
	
	
	if(!isNaN(before_interest) && before_interest>=0){
		//alert($("#actual_fund").val()+"你妹"+$("#lease_money").val());
		//租赁本金
		if("是"==radio_val && type =="否"){//初始状态为否
			$(":input[name='lease_money']").val( parseFloat(lease_money_hidden) + parseFloat(before_interest) );
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest) + parseFloat(before_interest_hidden) );
		}
		else if("否"==radio_val && type =="否"){//初始状态为否
			$(":input[name='lease_money']").val( lease_money_hidden );
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest) + parseFloat(before_interest_hidden) );
		}
		else if("是"==radio_val && "是"==type){//初始状态为是
			$(":input[name='lease_money']").val( parseFloat(lease_money_hidden) + parseFloat(before_interest) - parseFloat(before_interest_hidden) );
			$(":input[name='actual_fund']").val( parseFloat(actual_fund_hidden) - parseFloat(before_interest) + parseFloat(before_interest_hidden) );
		}
		else if("否"==radio_val && "是"==type){//初始状态为是
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

//保留N位小数点   
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


//计算增加净融资额比例=净融资额/设备金额
function getlmp_value(){
	var actual_fund = document.getElementsByName("actual_fund")[0].value;//净融资额
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备金额
	alert(actual_fund+ "++" + equip_amt + "___"+ (actual_fund/equip_amt)*100);
	var result;
	if(actual_fund == 0 && equip_amt == 0){
		result = "0";
	}else{
		result = round2places((actual_fund/equip_amt)*100);
	}
	document.getElementsByName("actual_fund_ratio")[0].value = result;
}

//四舍五入
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
 
 //表单提交事件
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
			alert("请填写租前息和租前息类型！");
			return false;
		}
	
		
	}
</script>
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    