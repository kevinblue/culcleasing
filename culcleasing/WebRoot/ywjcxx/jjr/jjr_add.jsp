<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增节假日调整</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 新增节假日调整</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="jjr_save.jsp" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="120" scope="row">日期</td>
        <td><input name="date" type="text" class="text" readonly maxlength="10" dataType="Date" Require="true"> <img onClick="openCalendar(date);return false;" style="cursor:pointer; " src="../../images/btn_time.gif" border="0" align="absmiddle" ><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td scope="row">是否节假日</td>
    <td><select name="ishr"  class="select_css">
			<option value="1">是</option>
			<option value="0">否</option>

	        </select></td>
  </tr>
    <tr>
    <td scope="row">备注</td>
    <td><input name="notes" type="textarea" label="备注" ></td>
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