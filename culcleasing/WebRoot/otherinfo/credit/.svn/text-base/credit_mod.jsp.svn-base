<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改客户授信额度 - 其他基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String id = getStr( request.getParameter("czid") );
sqlstr = "select * from vi_cust_credit_info where cust_id='" + id+"'"; 
rs = db.executeQuery(sqlstr); 

String cust_name = "";
String cust_type = "";
String credit = "";
String start_date = "";
String end_date = "";

String gxrq = "";
String xm = "";

if ( rs.next() ) {
	cust_name = getDBStr( rs.getString("cust_name") );
	cust_type = getDBStr( rs.getString("cust_type") );
	credit = getDBStr( rs.getString("credit") );
	start_date = getDBDateStr( rs.getString("start_date") );
	end_date = getDBDateStr( rs.getString("end_date") );
	
	gxrq = getDBDateStr( rs.getString("modify_date") );
	xm = getDBStr( rs.getString("modificator_name") );
}

rs.close();
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">其他基础信息管理 &gt; 修改客户授信额度</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1"  method="post" action="credit_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="kid" value="<%= id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">客户名称</td>
    <td>
      <input type="text" value="<%=cust_name %>" readonly="readonly">
	</td>
  </tr>
  <tr>
    <td scope="row">客户类别</td>
    <td><input type="text"  value="<%=cust_type %>" readonly="readonly"></td>
  </tr>
  <tr>
    <td scope="row">授信额度</td>
    <td><input name="credit" type="text"  value="<%=credit %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">授信开始时间</td>
    <td>
    <input class="text" id="start_date" name="start_date" type="text" readonly  value="<%=start_date %>">
	<img onClick="openCalendar(start_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	<span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <td scope="row">授信结束时间</td>
    <td>
    <input class="text" id="end_date" name="end_date" type="text" readonly  value="<%=end_date %>">
	<img onClick="openCalendar(end_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	<span class="biTian">*</span>
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
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
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


