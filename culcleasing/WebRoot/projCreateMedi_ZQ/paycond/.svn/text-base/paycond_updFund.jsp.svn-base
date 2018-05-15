<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划 - 修改</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  src="../../js/sys_test_time.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//选择款项方式
function changePayWay(){
	var payWayVal = $(":input[name='pay_way']").val();
	var feeTypeVal = $(":input[name='fee_type']").val();
	if(payWayVal=='收款'){
		$(":input[name='pay_obj']").val($(":input[name='cust_name']").val());
		//判断款项内容是否正确
		if(feeTypeVal=='24' || feeTypeVal=='21' || feeTypeVal=='18' || feeTypeVal=='26'){
			alert("选择款项内容为付款款项，请重新选择款项！");
			$(":input[name='fee_type']").val('');
		}
	}else{
		$(":input[name='pay_obj']").val("");
		//判断款项内容是否正确
		if( feeTypeVal!='' && feeTypeVal!='24' && feeTypeVal!='21' && feeTypeVal!='18' && feeTypeVal!='26'){
			alert("选择款项内容为收款款项，请重新选择款项！");
			$(":input[name='fee_type']").val('');
		}
	}
}
//选择款项内容
function checkVal(){
	var feeTypeVal = $(":input[name='fee_type']").val();
	var payWayVal = $(":input[name='pay_way']").val();
	//alert(feeTypeVal);
	if(feeTypeVal=='24' || feeTypeVal=='21' || feeTypeVal=='18' || feeTypeVal=='26'){
		if(payWayVal=='收款'){
			alert("该款项内容非收款款项，请重新选择款项！");
			$(":input[name='fee_type']").val('');
		}
	}
}
//校验计划金额是否正确
function checkMoney(){
	var planMoneyVal = $(":input[name='plan_money']").val();
	planMoneyVal = currecyRecoverNum(planMoneyVal);

	var reg = /^[0-9]+(\.[0-9]+)?$/;  
	if(planMoneyVal!=''){
		if(!reg.test(planMoneyVal)){  
	        alert('计划金额填写格式有误！');  
	        $(":input[name='plan_money']").val('');
	        $(":input[name='plan_money']").focus();  
	    }  
	}
}

//选择收付款人账号信息
function choi_custBank(){
	//判断是否有选中开户
	var custId = $(":input[name='pay_obj']").val();
	if(custId==""){
		alert( "请先选择"+$("#bj_1").text());
	}else{
		popUpWindow('pay_bank_info.jsp?cust_id='+custId,250,350);
	}
}

//款项名称
function showFeeName(){
	var fee_type = $("select[name='fee_type']:selected").val();
	//alert(fee_type);
}

</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
//提取参数item_id
String item_id = getStr( request.getParameter("item_id") ); 

sqlstr = "select pffcpt.*,pay_objname=dbo.getCustName(pffcpt.pay_obj) from proj_fund_fund_charge_plan_temp pffcpt where id='"+item_id+"'";
rs = db.executeQuery(sqlstr);

String proj_id = "";
String doc_id = "";
String pay_way = "";
String fee_type = "";
String fee_name = "";
String pay_obj = "";
String pay_obj_name = "";
String pay_bank_name = "";
String pay_bank_no = "";
String plan_bank_name = "";
String plan_bank_no = "";
String plan_date = "";
String currency_type = "";
String plan_money = "";
String pay_type = "";
String fpnote = "";

if(rs.next()){
	proj_id = getDBStr(rs.getString("proj_id"));
	doc_id = getDBStr(rs.getString("measure_id"));
	pay_way = getDBStr(rs.getString("pay_way"));
	fee_type = getDBStr(rs.getString("fee_type"));
	fee_name = getDBStr(rs.getString("fee_name"));
	pay_obj = getDBStr(rs.getString("pay_obj"));
	pay_obj_name = getDBStr(rs.getString("pay_objname"));
	pay_bank_name = getDBStr(rs.getString("pay_bank_name"));
	pay_bank_no = getDBStr(rs.getString("pay_bank_no"));
	plan_bank_name = getDBStr(rs.getString("plan_bank_name"));
	plan_bank_no = getDBStr(rs.getString("plan_bank_no"));
	plan_date = getDBDateStr(rs.getString("plan_date"));
	currency_type = getDBStr(rs.getString("currency"));
	plan_money = getDBStr(rs.getString("plan_money"));
	pay_type = getDBStr(rs.getString("pay_type"));
	fpnote = getDBStr(rs.getString("fpnote"));
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">资金计划&gt; 修改条目</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="paycond_upsave.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="fee_type" value="<%=fee_type %>">
<input type="hidden" name="pay_way" value="<%=pay_way %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">款项方式</td>
    <td scope="row">
     <select style="width:150px;" name="pay_way" onchange="changePayWay()" Require="ture" disabled="disabled">
        <script type="text/javascript">
	        	w(mSetOpt('<%=pay_way %>',"|收款|付款","|收款|付款"));
        </script>
     </select>
     <span class="biTian">*</span>
    </td>
    
    <td scope="row">款项内容</td>
    <td scope="row">
     <select style="width:150px;" name="fee_type" Require="ture" disabled="disabled">
        <script type="text/javascript">
	        	w(mSetOpt('<%=fee_type %>',"<%=feetype_name_str %>","<%=feetype_name_val %>"));
        </script>
     </select>
     <span class="biTian">*</span>
    </td>
  </tr>
     
  <tr>
    <td scope="row" id="bj_1"><%="收款".equals(pay_way)?"付款人":"收款人" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_obj_name" type="text" value="<%=pay_obj_name %>" Require="ture" >
    <input name="pay_obj" type="hidden" value="<%=pay_obj %>">

	<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('pay_obj.jsp',250,350)">
	 <span class="biTian">*</span>
    </td>

	<td>款项名称</td>
	<td>
		<input type="text" name="fee_name" style="width:150px;" Require="ture" value="<%=fee_name %>">
	 	<span class="biTian">*</span>
	</td>
  </tr>
  
   <tr>
	<td scope="row"><%="收款".equals(pay_way)?"付款人开户银行":"收款人开户银行" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_name" type="text" value="<%=pay_bank_name %>" readonly="readonly">
    </td>
    
	<td scope="row"><%="收款".equals(pay_way)?"付款人银行帐号":"收款人银行帐号" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_no" type="text" value="<%=pay_bank_no %>" readonly="readonly">
    <input name="acc_showtitle" type="hidden">
    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="OpenDataWindow('form1.pay_obj','<%="收款".equals(pay_way)?"付款人":"收款人" %>','cust_id','String','银行帐户','vi_cust_account','showTitle','acc_number|bank_name|account|acc_status','acc_number','acc_number','asc','form1.acc_showtitle','form1.pay_bank_no|form1.pay_bank_name|form1.account|form1.acc_status');;"> 
    </td>
  </tr>   
   <tr>
	<td scope="row"><%="收款".equals(pay_way)?"付款人银行开户名":"收款人银行开户名" %></td>
    <td scope="row">
    <input style="width:150px;" name="account" type="text" value="<%=getDBStr(rs.getString("account")) %>" readonly="readonly">
    </td>
    
	<td scope="row">是否主帐户</td>
    <td scope="row">
    <input style="width:150px;" name="acc_status" type="text" value="<%=getDBStr(rs.getString("acc_status")) %>" readonly="readonly">
    </td>
  </tr>   
  
   <!-- 新增环球方计划收款\付款账号 -->
  <tr>
    <td scope="row" id="bj_3"><%="收款".equals(pay_way)?"计划收款开户银行":"计划付款开户银行" %></td>
    <td scope="row">
    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" value="<%=plan_bank_name %>">
    </td>

    <td scope="row" id="bj_4"><%="收款".equals(pay_way)?"计划收款银行账号":"计划付款银行账号" %></td>
    <td scope="row">
    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" value="<%=plan_bank_no %>">
    
    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)">
    </td>
  </tr>
     
  <tr>
    <td scope="row"><%="收款".equals(pay_way)?"收款时间":"付款时间" %></td>
    <td scope="row">
    <input name="plan_date" type="text" style="width:150px;" readonly="readonly" 
    onpropertychange="validDate(document.form1.plan_date.value,'<%=getSystemDate(0) %>')" dataType="Date" Require="ture" value="<%=plan_date %>">
    <img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">币种</td>
    <td scope="row">
    <select style="width:150px;" name="currency" id="currency" Require="true"></select>
	<script language="javascript" class="text">
	dict_list("currency","currency_type","<%=currency_type %>","name");
	</script>
	<span class="biTian">*</span>
    </td>
  </tr>
  
  <tr>
   <td scope="row"><%="收款".equals(pay_way)?"收款金额":"付款金额" %></td>
    <td scope="row">
    <input name="plan_money" id="plan_money" style="width:150px;" type="text" dataType="Money" Require="ture" onblur="checkMoney()" value="<%=plan_money %>">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">结算方式</td>
    <td scope="row">
	    <select style="width:150px;" name="pay_type" Require="ture">
	        <script type="text/javascript">
		        	w(mSetOpt('<%=pay_type %>',"<%=paytype_name_str %>","<%=paytype_name_val %>"));
	        </script>
	     </select>
	     <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
  <td scope="row">备注</td>
    <td scope="row" colspan="3">
    	<textarea rows="6" cols="4" name="fpnote"><%=fpnote %></textarea>
    </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</div>
<!-- end cwMain -->
</body>
<script type="text/javascript">
$(document).ready(function() {
	//register event
	$("#plan_money").blur(function(){
		numConvertCurrecyShow(this.value,this.name)
	});
	
	$("#plan_money").focus(function(){
		currecyRecoverNumShow(this.value,this.name)
	});
	
	//exec event
	$("#plan_money").blur();
 });

</script>
</html>

<%if(null != db){db.close();}%>