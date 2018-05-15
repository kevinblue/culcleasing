<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
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
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
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
</head>

<%
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间

	//1.如果upd则假装ConditionBean
	BeginInfoBean beginInfoBean = BeginService.initBeginInfoHisBean(begin_id);
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
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfoBean.getRent_start_date()) %>");
	
	//租赁年利率 year_rate
	$("input[name='year_rate']").val("<%=beginInfoBean.getYear_rate() %>");
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
	//显示设置
	changeCalcWay();
});
</script>

<body onload="public_onload(0);">
<form name="form1" method="post"  action="" onSubmit="">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="80%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				租金计算方法:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" name="settle_method">
		        <select style="width:130px;" name="settle_method2" id="settle_method" Require="true" 
		        onchange="changeCalcWay()" disabled="disabled"></select>
				<script language="javascript">
				dict_list("settle_method2","RentCalcType","","name");
				</script><span class="biTian">*</span>
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
				<select style="width:100px;" name="currencyVal"  id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>
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
				<select style="width:130px;" name="invoice_type" id="invoice_type" Require="true" label="租金开票方式" disabled="disabled"></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>
				<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>
		  <td scope="row" nowrap>调息方式</td>
		  <td>
		    	<select name="adjust_style" style="width:150px;" disabled="disabled">
			        <script type="text/javascript">
			        	w(mSetOpt('2',"按次日|按次期","1|2"));
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
			
		  </tr>
		  
		</table>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
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
			div_rate.innerHTML = "<font color='red'>按央行利率浮动比率调整为：(央行基础利率+幅度)×"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '1'){
			name = "按央行利率加点";
			div_rate.innerHTML = "<font color='red'>按央行利率加点调整为：(央行基础利率+幅度)+"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '2'){
			name = "固定调整租金金额";
			div_rate.innerHTML = "<font color='red'>固定调整租金金额:"+rate_float_amt+"</font>";
		}
		
	}
}
</script>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       