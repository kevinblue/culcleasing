<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="com.tenwa.culc.bean.ConditionBean"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 项目交易结构</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>


<script type="text/javascript" src="../../js/numberseparation.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
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
	conditionBean=ConditionService1.initConditionContractBean(conditionBean);
	
%> 

<script type="text/javascript">
<% if(conditionBean!=null){ %>
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
	//租前息-类型 算本、不算本 before_interest_type
	$("input[name='before_interest_type']").val("<%=conditionBean.getBefore_interest_type() %>");

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
	//净融资额比例 actual_fund_ratio
	$("input[name='actual_fund_ratio']").val("<%=conditionBean.getActual_fund_ratio() %>");
	
	//投保方式 insure_type
	$("#insure_type").val("<%=conditionBean.getInsure_type() %>");
	//预计起租日 start_date
	$("input[name='start_date']").val("<%=getDBDateStr(conditionBean.getRent_start_date()) %>");
	
	//租赁年利率 year_rate
	$("input[name='year_rate']").val("<%=Double.parseDouble(conditionBean.getYear_rate()) %>");
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
	$("input[name='rate_float_amt']").val("<%=Double.parseDouble(conditionBean.getRate_float_amt()) %>");
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
	$("input[name='StandardIrr']").val("<%=conditionBean.getStandardIrr() %>");
	//保险收取方式 insure_pay_type
	$("select[name='insure_pay_type']").val("<%=conditionBean.getInsure_pay_type() %>");
	//税种
	$("select[name='tax_type']").val("<%=conditionBean.getTax_type() %>");
	//增值税发票类型
	$("select[name='tax_type_invoice']").val("<%=conditionBean.getTax_type_invoice() %>");

	//显示设置
	changeCalcWay();
	//首付款js
	//changeFirst_payment();
	//净融资额js
	//assignment();
});
</script>
<% } %>


<body onload="public_onload(0);">
<!-- form表单跳转到zjcs_projSave.jsp页面    doCument.forms[0].onsubmit()-->
<form name="form1" method="post"  action="" onSubmit="return Validator.Validate(this,2);check_allInput();">
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
				</script>
				-->
				<span class="biTian">*</span>
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
				</td>
			</tr>
		
		  <tr>
		  	<!-- 调息方式暂时隐藏,默认次期2 -->
		  	<input name="adjust_style" type="hidden" value="2">
		  	
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>合同编号</td>
		    <td>
		    	<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
			 
		    <td scope="row" nowrap>设备金额</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0"
		    		dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>首付款</td>
		      <td>
		    	<input name="first_payment" id="first_payment" type="text" value="0" 
		    	dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true"/>
		    	<span class="biTian">*</span>
		   	   </td> 
		   	   <td scope="row" nowrap>货币类型</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
		     	<%-- 
		     	--%>
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
				<input name="handling_charge" id="handling_charge" type="text" value="0" 
				 	dataType="Money" size="13" maxlength="20" 
				 	maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>管理费</td>
		    <td colspan="">
		    	<input name="management_fee" id="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange=""/> 
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" id="consulting_fee_in" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee_out" id="consulting_fee_out" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
				<span class="biTian">*</span>
			</td>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"   -->
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" id="other_income" type="text" value="0" dataType="Money"
					  size="13" maxlength="20"  />
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" id="other_expenditure" type="text" value="0" dataType="Money"
		    		  size="13" maxlength="20" onchange="assignment()"/> 
			</td>
		  </tr>	
		  
		  <tr>	
		  	<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" id="nominalprice" type="text" value="0"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" id="return_amt" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
			
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		   	 <input name="insure_money" id="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
			</td>
			<td  scope="row" nowrap>预计IRR</td>
			<td>
				<input name="plan_irr" id="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>%
			</td>
		  </tr>
		  
		   <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" id="before_interest" type="text" value="0"  onchange="changeTwoData()"
		    		dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" />
		    		是否算本
		    		<input type="text" id="before_interest_type" name="before_interest_type" size="5">
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" id="rate_subsidy" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>贴现息</td>
		  	<td>
		  		<input name="discount_rate" id="discount_rate" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>资产余值</td>
		    <td>
		    	<input name="assets_value" id="assets_value" type="text" value="0" dataType="Money" size="13" maxlength="20" maxB="20" />
			</td>
		  </tr>
		  <tr>
		   	<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<!--  净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出 【2010-07-23修改，增加需要 减去租前息】 -->
		    	<input name="actual_fund" id="actual_fund" type="text" value="" readonly onclick="assignment()" 
		    	dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    		净融资额比例
    				<input name="actual_fund_ratio" id="actual_fund_ratio" type="text" 
					value="" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
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
		    	<input name="income_number" id="income_number" type="text" value="0" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
				<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" id="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		   <tr>
		   <td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" id="year_rate" type="text" value="0.00"  
					dataType="Double" size="13" maxlength="11" maxB="11"  Require="true"/>%
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
	    		<select name="adjust_style" style="width: 140px;">
			        <script type="text/javascript">
			        	w(mSetOpt('1',"按次日|按次期","1|2"));
			        </script>
		        </select> 
		        批量调息
		        <input type="text" id="into_batch" name="into_batch" size="5">
		    	<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" id="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" id="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" id="free_defa_inter_day" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true"/>
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
		    	<input name="rate_float_amt" type="text" id="rate_float_amt" value="0" 
		    		dataType="Double" size="13" maxlength="13" maxB="13"  onblur="alertChange()" />
		    	<span class="biTian">*</span>
			</td>
		 </tr>
		 <tr>
		 	<td scope="row" nowrap>达标IRR</td>
		    <td>
		    	<input type="text" id="StandardIrr" style="width: 140" name="StandardIrr" value="0"/>%
				  是否达标
		        <input type="radio" name="StandardF" value="是" checked="checked">是
		    	<input type="radio" name="StandardF" value="否">否
		    	<span class="biTian">*</span>
			</td>
		 	<td  scope="row" nowrap>实际IRR</td>
			<td>
				<input name="irr" id="irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>%
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
		 <td scope="row" nowrap>租金开票方式</td>
			<td>
			<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true" label="租金开票方式">
					  <script type="text/javascript">
						w(mSetOpt('',"先开，租金总额发票|先开，本金收据，利息发票|先开，本利分开|后开，租金总额发票|后开，本金收据，利息发票|后开，本利分开|后开，本利分开两张发票|先开，本利分开两张发票|其它",
						"root.RentInvoice.001|root.RentInvoice.002|root.RentInvoice.003|root.RentInvoice.004|root.RentInvoice.005|root.RentInvoice.006|root.RentInvoice.007|root.RentInvoice.008|root.RentInvoice.009"));
					</script>
				</select>
				<!--
				<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true"></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>-->
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>投保方式</td>
			<td>
			<select style="width:100" name="insure_type" id="insure_type" Require="true" label="投保方式">
					  <script type="text/javascript">
						w(mSetOpt('',"本司付款|本司代付|客户自保|客户代付|管理方投保|不投保",
						"insure_type1|insure_type2|insure_type3|insure_type4|insure_type6|insure_type5"));
					 </script>
				</select>
				<!--
				<select style="width:100" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>-->
   				<span class="biTian">*</span>
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
				<select style="width:100" name="insure_pay_type" id="insure_pay_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_pay_type","root.insurPayType","root.insurPayType.001","name");
				</script>	-->				
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>增值税发票类型</td>
			<td>
			<select style="width:100" name="tax_type_invoice" id="tax_type_invoice" Require="true" label="保险收取方式">
					  <script type="text/javascript">
							w(mSetOpt('',"增值税普通发票|增值税专用发票|无","增值税普通发票|增值税专用发票|无"));
					  </script>
				</select>
								
   				<span class="biTian">*</span>
			</td>
		 </tr>
		 <tr>
		  <!--  sys 取消 考核调整 
		  	<td scope="row" nowrap>考核调整</td>
		    <td>
		    	<input name="assess_adjust" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" onchange="changeFirst_payment()" />
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
		if(rate_float_type == '4'){
			name = "隐含加点";
			div_rate.innerHTML = "<font color='red'>隐含加点: (央行基础利率+幅度)</font>";
		}
	}
}
/*
    方法含义：
        根据工式：租赁本金 = 设备金额 - 首付款 计算租赁本金的值，
        计算之前对‘设备金额’和‘首付款’进行验证
    param:
    return:
        将计算后的值赋给‘租赁本金’字段
    author:
        sea
    date:
        2010-05-10
*/
function changeFirst_payment(){
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备金额 
	var first_payment = document.getElementsByName("first_payment")[0].value;//首付款
	//判断是否输入
	if(equip_amt == null || equip_amt == ''){
		alert("请输入设备金额!");
		document.all.equip_amt.focus();
		return false;
	}
	//判断输入是否合法
	var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	if(reg_money.test(equip_amt)== false){
		str = "设备金额-货币格式错误";//
		alert(str);
		document.all.equip_amt.focus();
		return false;
	}
	if(reg_money.test(first_payment)== false){
		str = "首付款-货币格式错误";//
		alert(str);
		document.all.first_payment.focus();
		return false;
	}
	//计算租赁本金
	var numValue = equip_amt - first_payment;
	//留2位小数 forcepos()注意 154951705.36 30990341.00
	numValue = forcepos(numValue,2);
	document.getElementsByName("lease_money")[0].value = numValue;//租赁本金
	//将‘净融资额’为空 净融资额=租赁本金-保证金 无论首付款 还是设备金额的更改 净融资额 必须致空重新计算
	document.getElementsByName("actual_fund")[0].value = '';
}


/*
    方法含义：
        根据工式：净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出-首付款 计算‘净融资额’的值，
        设备款 equip_amt,保证金 caution_money,手续费 handling_charge,
        厂商返佣 return_amt,其他收入 other_income,咨询费 consulting_fee,其他支出 other_expenditure 
        计算之前对‘租赁本金’和‘保证金’进行空判断
    return:
        将计算后的值赋给‘净融资额’字段
    author:
        sea
         租赁本金①	设备款-首付款，自动计算，不可改
		首付款	手动输入金额，收款
		保证金	手动输入金额，收款
		净融资额	净融资额=①-②-③-④-⑤-⑥-⑦+⑧+⑨-⑩+11-12

		名称	收支情况
		1-设备金额	支
		2-首付款	     收
		3-租赁保证金	收
		4-租赁手续费	收
		5-管理费	    收
		6-残值收入	收
		7-厂商返利	收
		8-租前息	    收
		9-利息补贴	收
		11-其他收入	收
		13-咨询费收入	收

		10-贴现息	    支
		12-其他支出	支
		14-咨询费支出	支
		15-保费金额	支
*/
function assignment(){ 
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备款
	var first_payment = document.getElementsByName("first_payment")[0].value;//首付款
	var caution_money_value = document.getElementsByName("caution_money")[0].value;//保证金
	var lease_capital_value = document.getElementsByName("lease_money")[0].value;//租赁本金
	var handling_charge = document.getElementsByName("handling_charge")[0].value;//手续费
	var management_fee = document.getElementsByName("management_fee")[0].value;//管理费
	//sys残值从计算中取消11.12.26
	//var nominalprice = document.getElementsByName("nominalprice")[0].value;//残值收入
	
	var return_amt = document.getElementsByName("return_amt")[0].value;//厂商返利
	var before_interest = document.getElementsByName("before_interest")[0].value;//租前息
	var rate_subsidy = document.getElementsByName("rate_subsidy")[0].value;//利息补贴
	var discount_rate = document.getElementsByName("discount_rate")[0].value;//贴现息
	
	var other_income = document.getElementsByName("other_income")[0].value;//其他收入
	var other_expenditure = document.getElementsByName("other_expenditure")[0].value;//其他支出

	var consulting_fee_in = document.getElementsByName("consulting_fee_in")[0].value;//咨询费收入
	var consulting_fee_out = document.getElementsByName("consulting_fee_out")[0].value;//咨询费支出
	var insure_money = document.getElementsByName("insure_money")[0].value;//保费金额
	
	if((lease_capital_value == null || lease_capital_value == '') || (caution_money_value == null || caution_money_value == '')){
		alert("租赁本金和保证金不能为空,净融资额=租赁本金-保证金!");
		document.all.lease_money.focus();
		return false;
	}else{ 
		var lease_amt_value ; 
		//净融资额=设备款-首付款-保证金-手续费-管理费-残值收入-厂商返利-租前息-利息补贴-其他收入-咨询费收入+贴现息+其他支出+咨询费支出+保费金额	
		// lease_amt_value = equip_amt - caution_money_value - handling_charge - return_amt - 
		// other_income + consulting_fee_out + other_expenditure-before_interest-management_fee;
		var value1 = FloatSub(equip_amt,first_payment);
		
		var value2 = FloatSub(FloatSub(value1, caution_money_value),handling_charge);
		//alert("__"+value1+"----"+value2);
		
		var value3 = FloatSub(value2, management_fee);
		//sys残值计算取消
		//var value4 = FloatSub(value3, nominalprice);
		
		var value5 = FloatSub(value3, return_amt);
		var value6 = FloatSub(value5, before_interest);
		
		var value7 = FloatSub(value6, rate_subsidy) ;
		var value8 = FloatSub(value7, other_income) ;
		var value9 = FloatSub(value8, consulting_fee_in);
		//alert("value9"+value9);

		var value10 = FloatAdd(discount_rate,other_expenditure);//加法的总和
		var value11 = FloatAdd(consulting_fee_out,insure_money);//加法的总和
		//alert(value10+">>>>>"+value11);
		
		lease_amt_value = FloatSub(value9,value10);
		lease_amt_value = FloatSub(lease_amt_value,value11);
		
		document.getElementsByName("actual_fund")[0].value = lease_amt_value;
		//计算‘会计核算本金=净融资额加保证金’的值 accountPrincipal
		//var str_num = FloatAdd(caution_money_value,lease_amt_value);
		//document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
	getlmp_value();
}

//计算增加净融资额比例=净融资额/设备金额
function getlmp_value(){
	var actual_fund = document.getElementsByName("actual_fund")[0].value;//净融资额
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备金额
	var result;
	if(actual_fund == 0 && equip_amt == 0){
		result = "0";
	}else{
		result = round2places((actual_fund/equip_amt)*100);
	}
	document.getElementsByName("actual_fund_ratio")[0].value = result;
}
</script>
<script type="text/javascript">
$(document).ready(function() {

    $("input[type='text']").each(function(i) {
		$(this).blur(function (){mouseRead(this.value,this.name)});
 	});
         
    $("input[type='text']").blur();   
 });
</script>
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  