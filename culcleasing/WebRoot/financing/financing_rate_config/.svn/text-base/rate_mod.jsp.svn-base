<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基准利率维护</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
sqlstr = "select spl.rate,spl.modify_date,dbo.GETUSERNAME(spl.modificator) as gxr from financing_config_rate spl"; 
rs = db.executeQuery(sqlstr); 

String rate = "";

String gxrq = "";
String xm = "";

if ( rs.next() ) {
	rate = CurrencyUtil.convertFinance( rs.getString("rate") );

	gxrq = getDBDateStr( rs.getString("modify_date") );
	xm = getDBStr( rs.getString("gxr") );
}

rs.close();
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基准利率维护</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1"  method="post" action="rate_save.jsp" target="_blank" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="savetype" value="mod">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">当前利率</td>
    <td>
   	  <input name="rate" type="text"  value="<%=rate %>" Require="ture"><span class="biTian">*</span>
	</td>
  </tr>
  
  <tr>
    <td scope="row">最后更新日期</td>
    <td><%= gxrq %></td>
  </tr>
  <tr>
    <td scope="row"> 操作员</td>
    <td><%= xm %></td>
  </tr>
</table>
<!-- end cwDataNav -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="更新" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>


