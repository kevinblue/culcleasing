<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script src="/dict/js/js_dictionary.js"></script>

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">其他流出制定&gt; 新增</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="other_cashout_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">起始日期</td>
    <td scope="row">
     <input id="start_date" name="start_date" type="text" readonly Require="ture">
	<img onClick="openCalendar(start_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	<span class="biTian">*</span>
	</td>
    <td scope="row">结束日期</td>
    <td scope="row">
     <input id="end_date" name="end_date" type="text" readonly Require="ture">
	<img onClick="openCalendar(end_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	<span class="biTian">*</span>
   	</td>
  </tr>

  <tr>
  
    <td scope="row">流出金额</td>
    <td scope="row" colspan="3">
    <input name="cash_money" type="text" Require="ture" dataType="Money">
	<span class="biTian">*</span>
    </td>
    </tr>
    <tr>
    <td scope="row">备注</td>
    <td scope="row" colspan="3">
   	<textarea rows="6" cols="4" name="remark" id="idea" Require="ture"></textarea>
  	<span class="biTian">*</span>
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


</html>

