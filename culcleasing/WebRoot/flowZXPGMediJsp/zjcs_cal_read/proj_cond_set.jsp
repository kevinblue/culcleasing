<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="com.tenwa.culc.bean.ConditionMediBean"%>
<%@page import="com.tenwa.culc.service.ConditionMediService"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目交易结构</title>
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
	//获取参数
	String proj_id = getStr(request.getParameter("proj_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	//1.如果upd则假装ConditionBean
	ConditionMediBean conditionMediBean = null;
	conditionMediBean  = ConditionMediService.initConditionBean(proj_id,doc_id);
%> 

<%
//如果有值则加载属性值
if( conditionMediBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//设备金额 equip_amt
	$("#equip_amt").val("<%=conditionMediBean.getEquip_amt() %>");
	//首付款 first_payment
	$("input[name='first_payment']").val("<%=conditionMediBean.getFirst_payment() %>");
	
	//租赁本金 lease_money
	$("input[name='lease_money']").val("<%=conditionMediBean.getLease_money() %>");
	//保证金 caution_money
	$("input[name='caution_money']").val("<%=conditionMediBean.getCaution_money() %>");
	//手续费 handling_charge
	$("input[name='handling_charge']").val("<%=conditionMediBean.getHandling_charge() %>");
	//管理费 management_fee
	$("input[name='management_fee']").val("<%=conditionMediBean.getManagement_fee() %>");
	
	//其他收入 other_income
	$("input[name='other_income']").val("<%=conditionMediBean.getOther_income() %>");
	//其他支出 other_expenditure
	$("input[name='other_expenditure']").val("<%=conditionMediBean.getOther_expenditure() %>");
	//咨询费收入 consulting_fee_in
	$("input[name='consulting_fee_in']").val("<%=conditionMediBean.getConsulting_fee_in() %>");
	//咨询费支出 consulting_fee_out
	$("input[name='consulting_fee_out']").val("<%=conditionMediBean.getConsulting_fee_out() %>");
	
	//残值收入 nominalprice
	$("input[name='nominalprice']").val("<%=conditionMediBean.getNominalprice() %>");
	//厂商返利 return_amt
	$("input[name='return_amt']").val("<%=conditionMediBean.getReturn_amt() %>");
	//保费金额 insure_money 
	$("input[name='insure_money']").val("<%=conditionMediBean.getInsure_money() %>");
	//预计起租日 start_date
	$("input[name='start_date']").val("<%=getDBDateStr(conditionMediBean.getRent_start_date()) %>");
	
	//租前息 before_interest
	$("input[name='before_interest']").val("<%=conditionMediBean.getBefore_interest() %>");
	//租前息-类型 算本、不算本 before_interest_type
	$(":radio[name='before_interest_type']").removeAttr("checked");
	$(":radio[name='before_interest_type'][value='<%=conditionMediBean.getBefore_interest_type() %>']").attr("checked","checked");
	//利息补贴 rate_subsidy
	$("input[name='rate_subsidy']").val("<%=conditionMediBean.getRate_subsidy() %>");
	//贴现息 discount_rate
	$("input[name='discount_rate']").val("<%=conditionMediBean.getDiscount_rate() %>");
	
	
	//净融资额 actual_fund
	$("input[name='actual_fund']").val("<%=conditionMediBean.getActual_fund() %>");
	//净融资额比例 actual_fund_ratio
	$("input[name='actual_fund_ratio']").val("<%=conditionMediBean.getActual_fund_ratio() %>");
	//付租方式 income_number_year
	$("#income_number_year").val("<%=conditionMediBean.getIncome_number_year() %>");
	//还租次数 income_number
	$("input[name='income_number']").val("<%=conditionMediBean.getIncome_number() %>");
	//租赁期限(月) lease_term
	$("input[name='lease_term']").val("<%=conditionMediBean.getLease_term() %>");
	
	//是否有保底租金is_floor
	$(":radio[name='is_floor']").removeAttr("checked");
	$(":radio[name='is_floor'][value='<%=conditionMediBean.getIs_floor() %>']").attr("checked","checked");
	//管理方付款方式manager_pay_type
	$("select[name='manager_pay_type']").val("<%=conditionMediBean.getManager_pay_type()%>");
	
	//投保方式 insure_type
	$("#insure_type").val("<%=conditionMediBean.getInsure_type() %>");
	//保险收取方式 insure_pay_type
	$("select[name='insure_pay_type']").val("<%=conditionMediBean.getInsure_pay_type() %>");
	//预计收款银行名称
	$("input[name='plan_bank_name']").val("<%=conditionMediBean.getPlan_bank_name() %>");
	//预计收款银行账号
	$("input[name='plan_bank_no']").val("<%=conditionMediBean.getPlan_bank_no() %>");
	
	//每月偿付日 income_day
	$("#income_day").val("<%=conditionMediBean.getIncome_day() %>");
	//利率浮动类型  rate_float_type
	$("select[name='rate_float_type']").val("<%=conditionMediBean.getRate_float_type() %>");
	//利率调整值 rate_float_amt
	$("input[name='rate_float_amt']").val("<%=Double.parseDouble(conditionMediBean.getRate_float_amt()) %>");
	$("input[name='rate_float_amt']").blur();
	//调息方式 adjust_style
	$("select[name='adjust_style']").val("<%=conditionMediBean.getAdjust_style() %>");
	//是否批量调息 into_batch
	$(":radio[name='into_batch']").removeAttr("checked");
	$("input[name='into_batch'][value='<%=conditionMediBean.getInto_batch() %>']").attr("checked","checked");
	//租金计算方法 settle_method
	$("select[name='settle_method']").val("<%=conditionMediBean.getSettle_method() %>");
	//付租类型： period_type
	$("#period_type").val("<%=conditionMediBean.getPeriod_type() %>");
	//年利率
	$("#year_rate").val("<%=Double.parseDouble(conditionMediBean.getYear_rate()) %>");
	//利率是否对外公开
	$(":radio[name='is_open']").removeAttr("checked");
	$("input[name='is_open'][value='<%=conditionMediBean.getIs_open() %>']").attr("checked","checked");
	//显示设置
	changeCalcWay();
	//是否保底
	changeFloor();
});
</script>
<%
}
%>


<body onload="public_onload(0);">
<form name="form1" method="post"  action="proj_cond_set.jsp">
<!-- 隐藏域传值区域  罚息利率|逾期宽限日-->
<input name="pena_rate"  type="hidden" value="0">
<input name="free_defa_inter_day" type="hidden" value="0">
<input name="floor_rent"  type="hidden" value="0">
<input type="hidden" name="income_day" id="income_day">

<!-- 隐藏域传值区域  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		  <tr>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>项目编号</td>
		    <td>
		    	<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" size="35"/>
		    	<span class="biTian">*</span>
		     </td>
			 
		    <td scope="row" nowrap>设备金额</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" value="0" size="13"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>首付款</td>
		      <td>
		    	<input name="first_payment" id="first_payment" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
		   	   </td> 
		   	   <td scope="row" nowrap>货币类型</td>
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
		  	<!--  租赁本金 = 设备金额 - 首付款 onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>租赁本金</td>
		     <td>
		    	<input name="lease_money" id="lease_money" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
			 </td>
			 <td scope="row" nowrap>付租方式</td>
		    <td >
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
		    	<input name="income_number" id="income_number" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
			</td>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" id="lease_term" type="text" value="0" size="13"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  <tr>

			<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<input name="actual_fund" id="actual_fund" type="text" size="13"/>
		    		净融资额比例
    				<input name="actual_fund_ratio" id="actual_fund_ratio"  class="readonlyShowR" size="5" type="text" />% 
			</td>
			
			<td  scope="row" nowrap>投保方式</td>
			<td>
				<select style="width:100" name="insure_type" id="insure_type"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>保险收取方式</td>
			<td>
				<select style="width:100" name="insure_pay_type" id="insure_pay_type"></select>
				<script language="javascript" class="text">
					dict_list("insure_pay_type","root.insurPayType","root.insurPayType.001","name");
				</script>					
   				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" size="13"/>
				<span class="biTian">*</span>
			</td>
		  </tr>
				
		  <tr>
		  	<td  scope="row" nowrap>是否保底</td>
		  	<td>
	    		<input type="radio" name="is_floor" style="border: none;" value="是" checked="checked">是
	    		<input type="radio" name="is_floor" style="border: none;" value="否" >否
		  	</td>
		  	
		  	<td  scope="row" nowrap>管理方付款方式</td>
		  	<td>
		  		<select style="width:100" name="manager_pay_type" id="manager_pay_type"></select>
				<script language="javascript" class="text">
					dict_list("manager_pay_type","root.manager_pay_type","root.manager_pay_type.001","name");
				</script>					
   				<span class="biTian">*</span>
		  	</td>
		  	 <td scope="row" nowrap>计划收款银行账号</td>
		    <td scope="row">
		    	<input style="width:150px;" name="plan_bank_no" id="plan_bank_no" type="text" style="width: 100">
		    </td>
		    <td scope="row" nowrap>计划收款开户银行</td>
		    <td scope="row">
		   		<input style="width:150px;" name="plan_bank_name" id="plan_bank_name" type="text" style="width: 100">
		    </td>
		  </tr>
		  
		  <tr id="tr_CS">
		  	<td  scope="row" nowrap>测算类型</td>
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
		         付租类型：
		        <select name="period_type" id="period_type" style="width: 60px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
		        &nbsp;&nbsp;
			</td>
			<td  scope="row" nowrap>利率对外公开</td>
			<td>
				<input type="radio" name="is_open" value="是" style="border: none;" checked="checked">是 &nbsp;
				<input type="radio" name="is_open" value="否" style="border: none;">否
			</td>
			</tr>
			
			<tr id="tr_TX">
				<td  scope="row" nowrap>租赁年利率</td>
				<td nowrap="nowrap">
					<input name="year_rate" id="year_rate" type="text" value="0.00"  size="13"/>%
					<span class="biTian">*</span>
				</td>
				
				<td scope="row" nowrap>利率浮动类型</td>
		    	<td>
			    	<select name="rate_float_type" style="width:140">
			        <script type="text/javascript">
				        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|隐含利率|保持不变","0|1|2|3"));
			        </script>
			        </select> 
			    	<span class="biTian">*</span>
				</td>
				
		    	<td scope="row" nowrap>利率调整值</td>
			    <td>
			    	<input name="rate_float_amt" id="rate_float_amt" type="text" value="0" size="13"/>
			    	<span class="biTian">*</span>
				</td>
				<td scope="row" nowrap >调息方式</td>
			    <td >
			    	<select name="adjust_style"  style="width:60px;">
				        <script type="text/javascript">
				        	w(mSetOpt('2',"按次日|按次期","1|2"));
				        </script>
			        </select> 
			      	  批量调息
			        <input type="radio" name="into_batch" style="border: none;" value="是" checked="checked">是
			    	<input type="radio" name="into_batch" style="border: none;" value="否">否
			    	<span class="biTian">*</span>
				</td>
		  </tr>	
		  
		  <!-- 华丽的分割线..下面都为非必填项 -->
		  <tr>
			<td colspan="8">
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:12px" color="gray">
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" id="consulting_fee_in" type="text" value="0" size="13"/>
			</td>
			<td  scope="row" nowrap>租赁保证金</td>
			<td>
				<input name="caution_money" id="caution_money" type="text" value="0" size="13"/>
			</td>
			<td  scope="row" nowrap>租赁手续费</td>
			<td>
				<input name="handling_charge" id="handling_charge" type="text" value="0" size="13"/>
			</td>
			<td scope="row" nowrap>管理费</td>
		    <td colspan="">
		    	<input name="management_fee" id="management_fee" type="text" value="0" size="13"/>
			</td>
		  </tr>	
		  
		  <tr>	
		  	<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" id="nominalprice" type="text" value="0" size="13"/>
			</td>
				<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee_out" id="consulting_fee_out" type="text" value="0" size="13"/>
			</td>
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" id="other_income" type="text" value="0" dataType="Money" size="13"/>
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" id="other_expenditure" type="text" value="0" dataType="Money" size="13"/>
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" id="before_interest" type="text" value="0"  size="13"/>
		    		是否算本
		    		<input type="radio" id="before_interest_type" name="before_interest_type" value="是" >是
		    		<input type="radio" id="before_interest_type" name="before_interest_type" value="否" checked="checked">否
			</td>
			 <td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" id="return_amt" type="text" value="0" size="13"/>
			</td>
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		   	 <input name="insure_money" id="insure_money" type="text" value="0" size="13"/>
			</td>
			<td></td>			
			<td></td>			
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" id="rate_subsidy" type="text" value="0" size="13"/>
			</td>
			<td scope="row" nowrap>贴现息</td>
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
         
    <%if( conditionMediBean!=null ){//如果有值%>
    $("input[type='text']").blur(); 
    <%}%>  
 });
 
 function changeFloor(){
 	var floorV = $(":radio[name='is_floor']:checked").val();
 	if(floorV=="是"){
 		//保底显示下面行
 		$("#tr_CS").css("display","block");
 		$("#tr_TX").css("display","block");
 		//设置必填元素
 		$("#settle_method").attr("Require","true");
 		$("#period_type").attr("Require","true");
 		$("#year_rate").attr("Require","true");
 		$("#rate_float_amt").attr("Require","true");
 	}else{
 		//非必填元素
 		$("#settle_method").removeAttr("Require");
 		$("#period_type").removeAttr("Require");
 		$("#year_rate").removeAttr("Require");
 		$("#rate_float_amt").removeAttr("Require");
 		//非保底 不显示数据行
 		$("#tr_CS").css("display","none");
 		$("#tr_TX").css("display","none");
 	}
 }
</script>
</html>
