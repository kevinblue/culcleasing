<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金计划 - 修改</title>
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

sqlstr = "select * from fund_rent_plan_temp where id='"+item_id+"'";
rs = db.executeQuery(sqlstr);

String contract_id = "";
String rent_list = "";
String plan_date = "";
String rent = "";
String corpus = "";
String interest = "";
String plan_status = "";
String corpus_overage = "";
String plan_bank_name = "";
String plan_bank_no = "";
String factoring = "";

if(rs.next()){
	contract_id = getDBStr(rs.getString("contract_id"));
	rent_list = getDBStr(rs.getString("rent_list"));
	plan_date = getDBDateStr(rs.getString("plan_date"));
	rent = CurrencyUtil.convertFinance(rs.getString("rent"));
	corpus = CurrencyUtil.convertFinance(rs.getString("corpus"));
	interest = CurrencyUtil.convertFinance(rs.getString("interest"));
	plan_status = getDBStr(rs.getString("plan_status"));
	plan_bank_name = getDBStr(rs.getString("plan_bank_name"));
	plan_bank_no = getDBStr(rs.getString("plan_bank_no"));
	corpus_overage = CurrencyUtil.convertFinance(rs.getString("corpus_overage"));
	factoring = getDBStr(rs.getString("factoring"));
}
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=40 valign="middle" align="left">租金计划&gt; 修改条目</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="rent_upsave.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="item_id" value="<%=item_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
  	<td scope="row">期项</td>
    <td scope="row">
    	<input type="hidden" name="rent_list" readonly="readonly" value="<%=rent_list %>">
		<%=rent_list %>
    </td>
	<td scope="row">应收日期</td>
    <td scope="row">
    	<input type="hidden" name="plan_date" readonly="readonly" value="<%=plan_date %>">
   		<%=plan_date %>
    </td>
  </tr>
  <tr>
  	<td scope="row">租金</td>
    <td scope="row">
    	<input type="hidden" name="rent" readonly="readonly" value="<%=rent %>">
    	<%=rent %>
    </td>
	<td scope="row">本金</td>
    <td scope="row" >
    	<input type="hidden" name="corpus" readonly="readonly" value="<%=corpus %>">
    	<%=corpus %>
    </td>
  </tr>
     
  <tr>
  	<td scope="row">利息</td>
    <td scope="row">
    	<input type="hidden" name="interest" readonly="readonly" value="<%=interest %>">
   		<%=interest %>
    </td>
	<td scope="row">状态</td>
    <td scope="row">
    	<input type="hidden" name="plan_status" readonly="readonly" value="<%=plan_status %>">
    	<%=plan_status %>
    </td>
  </tr>
     
  
   <tr>
  	<td scope="row">本金余额</td>
    <td scope="row">
    	<input type="hidden" name="corpus_overage" readonly="readonly" value="<%=corpus_overage %>">
    	<%=corpus_overage %>
    </td>

 <td scope="row" nowrap>是否保理</td>
		<td scope="row">
    	<input type="hidden" name="factoring" readonly="readonly" value="<%=factoring %>">
    	<%=factoring %>
    </td>
			
  </tr>  
  <tr>
		  	 <td scope="row" id="bj_4">计划收款银行账号</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" style="width: 100"  Require="true" value="<%=plan_bank_no%>">
		    
		    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)" >
			<span class="biTian">*</span>
		    </td>
		    <td scope="row" id="bj_3">计划收款开户银行</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" style="width: 100" Require="true" value="<%=plan_bank_name%>">
			<span class="biTian">*</span>
		    </td>
</tr>
  </table>
  

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top" align="right">
<td><input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</div>
</table>
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