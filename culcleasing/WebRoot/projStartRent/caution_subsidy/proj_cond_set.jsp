<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利息补贴</title>
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
</head>

<%
	//基础参数	
	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String begin_order_index = getStr(request.getParameter("begin_order_index"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间

	//判断执行类型 -- 从数据库查询有数据则upd无则add
	String savaType = BeginService.judgeSaveType(begin_id, doc_id);
	
	//1.如果upd则假装ConditionBean
	BeginInfoBean beginInfoBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfoBean  = BeginService.initBeginInfoBean(begin_id, doc_id);
	}
%> 

<%
//如果有值则加载属性值
if( beginInfoBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//租金计算方法 settle_method
	$("select[name='settle_method']").val("<%=beginInfoBean.getSettle_method() %>");
	//付租类型： period_type
	$("#period_type").val("<%=beginInfoBean.getPeriod_type() %>");
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
	$("#income_number_year").val("<%=beginInfoBean.getIncome_number_year() %>");
	//还租次数 income_number
	$("input[name='income_number']").val("<%=beginInfoBean.getIncome_number() %>");
	//租赁期限(月) lease_term
	$("input[name='lease_term']").val("<%=beginInfoBean.getLease_term() %>");
	//每月偿付日 income_day
	$("select[name='income_day2']").val("<%=beginInfoBean.getIncome_day() %>");
	$("select[name='income_day']").val("<%=beginInfoBean.getIncome_day() %>");
	//利率浮动类型  rate_float_type
	$("select[name='rate_float_type']").val("<%=beginInfoBean.getRate_float_type() %>");
	//利率调整值 rate_float_amt
	$("input[name='rate_float_amt']").val("<%=beginInfoBean.getRate_float_amt() %>");
	$("input[name='rate_float_amt']").blur();
	
	//预计IRR plan_irr
	$("input[name='plan_irr']").val("<%=beginInfoBean.getPlan_irr() %>");
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
	
	//显示设置
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
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="80%" align="center" class="tab_table_title">
			<tr height="40" style="font-weight: bold;">
				<%
					String totalLeaseMoney = BeginService.getTotalLeaseMoney(contract_id);
					String usedLeaseMoney = BeginService.getUsedLeaseMoney(contract_id);
					String leftLeaseMoney = MathExtend.subtract(totalLeaseMoney, usedLeaseMoney);
				%>
				<td colspan="3" style="font-size: 16px;">合同利息补贴：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalLeaseMoney) %></b></td>
				<td colspan="3" style="font-size: 16px;">已使用利息补贴：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedLeaseMoney) %></b></td>
				<td colspan="2" style="font-size: 16px;">剩余利息补贴：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftLeaseMoney) %></b>
				<input type="hidden" id="validLM" value="<%=leftLeaseMoney %>">
				<input type="hidden" name="begin_order_index" id="begin_order_index" value="<%=begin_order_index %>">
				</td>
			</tr>
			<tr><td colspan="8"></td></tr>
			<tr><td colspan="8"></td></tr>
			
		  <!-- 本次利息补贴信息 -->	
		  <tr>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>本次利息补贴金额</td>
		    <td>
		    	<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" size="25" maxlength="50"/>
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>本息利息补贴期限</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
		    	<span class="biTian">*</span>
			</td>
		    
		  </tr> 
		  
		  <tr>
		 	<td scope="row" nowrap>资产余值</td>
		    <td>
		    	<input name="assets_value" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
		  	<td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" id="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<span class="biTian">*</span>
			</td>  
			
		  	<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />%%
		    	<span class="biTian">*</span>
			</td>  
			
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="3"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			
			 <td scope="row" id="bj_3">计划收款开户银行</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly">
		    </td>
		
		    <td scope="row" id="bj_4">计划收款银行账号</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly">
		    
		    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)">
		    </td>
		  	<td  scope="row" nowrap>利率对外公开</td>
			<td>
				<input type="radio" name="is_open" value="是">是 &nbsp;
				<input type="radio" name="is_open" value="否">否 &nbsp;
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		   <td scope="row" nowrap>付租方式</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" type="text" value="0"  onChange="changLeaseT_value()"
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
			
			<td  scope="row" nowrap>每月偿付日</td>
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
		  
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()">
		        <script type="text/javascript">
			        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|隐含利率|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td  scope="row" nowrap>预计IRR</td>
			<td>
				<input name="plan_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>
			</td> 
		  </tr>
		 
		  <tr>
			<td scope="row" nowrap>调息方式</td>
		    <td>
		    	<select name="adjust_style" style="width: 100px;">
			        <script type="text/javascript">
			        	w(mSetOpt('2',"按次日|按次期","1|2"));
			        </script>
		        </select> 
		        批量调息
		        <input type="radio" name="into_batch" value="是" checked="checked">是
		    	<input type="radio" name="into_batch" value="否">否
		    	<span class="biTian">*</span>
			</td>
				
			<td scope="row" nowrap>租金开票方式</td>
			<td>
				<select style="width:150px;" name="invoice_type" id="invoice_type" Require="true"></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>
				<span class="biTian">*</span>
			</td>
			
	   		<td colspan="4"></td>
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
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
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
	}
}
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
//判断本次的融资本金金额是否合法
function checkValid(){
	var validLM = $("#validLM").val();
	var lm = $("#lease_money").val();
	
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
	 				if(reg_money.test(text_value)== false){
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
	var str = "";
	//租赁本金 不能<=0
	if($("#lease_money").val()<=0){
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
		form1.submit();	
	}
}
</script>
</html>
