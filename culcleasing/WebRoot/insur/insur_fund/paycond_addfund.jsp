<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保费资金计划 - 新增</title>
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
	var fee_type = $("select[name='fee_type'] option:selected").text();
	$(":input[name='fee_name']").val(fee_type);
	
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
//提取参数contract_id,proj_id,doc_id,cust_id
String contract_id = getStr( request.getParameter("contract_id") );
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_name = "";
String cust_id="";

//通过cust_id加载客户名称
sqlstr = "select cust_id,cust_name from vi_cust_all_info where cust_name='天安保险股份有限公司北京分公司'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	cust_name = getDBStr(rs.getString("cust_name"));
	cust_id=getDBStr(rs.getString("cust_id"));
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">资金计划&gt; 新增条目</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="paycond_save.jsp">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="cust_id" value="<%=cust_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
   <tr>
  		<td scope="row">合同编号</td>
  		<td scope="row">
  		    <input name="make_contract_id" style="width:150px;" type="text">
  		</td>
  </tr>
  <tr>
    <td scope="row">款项方式</td>
    <td scope="row">
    	
    	<input type="text" name="pay_way" value="付款" class="rd" readonly="readonly" style="width:150px;">
	    
    </td>
    
    <td scope="row">款项内容</td>
    
     
    <td>
     <select style="width:150px;" name="fee_type" onchange="showFeeName()">
     	<option value=""></option>
        <option value="26">自付保险费</option>
        <option value="37">代付保险费</option>
     </select><span class="biTian">*</span>
   
    </td>
  </tr>
     
  <tr>
    <td scope="row" id="bj_1">收款人</td>
    <td scope="row">
    <input style="width:150px;" name="pay_obj_name" type="text" value="<%=cust_name %>" Require="ture" readonly="readonly">
    <input name="pay_obj" type="hidden" value="<%=cust_id %>">
	<span class="biTian">*</span>
    </td>
	 <td scope="row">款项名称</td>
	 <td scope="row">
	 	<input type="text" name="fee_name" style="width:150px;" Require="ture">
	 	<span class="biTian">*</span>
	 </td>
  </tr>
     
  <tr>
    <td scope="row" id="bj_7">收款人开户银行</td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_name" type="text" readonly="readonly">
    </td>

	<td scope="row" id="bj_2">收款人银行账号</td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_no" type="text" readonly="readonly">
    
    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	
	style="cursor:pointer" onclick="OpenDataWindow('form1.pay_obj','付款人','cust_id','String','银行帐户','vi_cust_account','showTitle','acc_number|bank_name|account|acc_status','acc_number','acc_number','asc','form1.acc_showtitle','form1.pay_bank_no|form1.pay_bank_name|form1.account|form1.acc_status');"> 
    </td>
  </tr>   
     <tr>
	<td scope="row">付款人银行开户名</td>
    <td scope="row">
    <input name="acc_showtitle" type="hidden">
    <input style="width:150px;" name="account" type="text"  readonly="readonly">
    </td>
    
	<td scope="row">是否主帐户</td>
    <td scope="row">
    <input style="width:150px;" name="acc_status" type="text"  readonly="readonly">
    
    </td>
  </tr>  
  <!-- 新增环球方计划收款付款账号 -->
  <tr>
    <td scope="row" id="bj_3">计划付款开户银行</td>
    <td scope="row">
    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly">
    </td>

    <td scope="row" id="bj_4">计划付款银行账号</td>
    <td scope="row">
    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly">
    
    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)">
    </td>
  </tr>
     
  <tr>
    <td scope="row" id="bj_5">付款时间</td>
    <td scope="row">
    <input name="plan_date" type="text" style="width:150px;" readonly="readonly" Require="ture" 
    onpropertychange="validDate(document.form1.plan_date.value,'<%=getSystemDate(0) %>')">
    <img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">币种</td>
    <td scope="row">
    <select style="width:150px;" name="currency" id="currency" Require="true"></select>
	<script language="javascript" class="text">
	dict_list("currency","currency_type","currency_type1","name");
	</script>
	<span class="biTian">*</span>
    </td>
  </tr>
  
  <tr>
   <td scope="row" id="bj_6">收款金额</td>
    <td scope="row">
    <input name="plan_money" id="plan_money" style="width:150px;" type="text" dataType="Currency" value="0" Require="ture" onblur="checkMoney()"><span class="biTian">*</span>
    </td>
    
    <td scope="row">结算方式</td>
    <td scope="row">
	    <select style="width:150px;" name="pay_type" Require="ture">
	        <script type="text/javascript">
		        	w(mSetOpt('',"<%=paytype_name_str %>","<%=paytype_name_val %>"));
	        </script>
	     </select>
	     <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
  <td scope="row">收/支备注</td>
    <td scope="row" colspan="3">
    	<textarea rows="6" cols="4" name="fpnote"></textarea>
    </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="button" onClick="return validData();" class="btn3_mouseout"></td>

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
 //表单提交校验
 function validData(){
 	//恢复数据
 	$("#plan_money").focus();
 	//执行校验
	if(Validator.Validate(form1,3)){
	$("#plan_money").focus();
		form1.submit();
	}
 }
$(document).ready(function() {
	//register event
	$("#plan_money").blur(function(){
		numConvertCurrecyShow(this.value,this.name)
	});
	
	$("#plan_money").focus(function(){
		currecyRecoverNumShow(this.value,this.name)
	});
 });

</script>
</html>

<%if(null != db){db.close();}%>