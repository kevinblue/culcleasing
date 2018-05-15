<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>授信单位 - 融资基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String priId = getStr( request.getParameter("czid") );
sqlstr = "Select financing_config_unit.*,dbo.GETUSERNAME(creator) as oper_name from financing_config_unit where id='"+priId+"'"; 

rs = db.executeQuery(sqlstr); 

String unit_code = "";
String unit_name = "";
String unit_property = "";
String oper_name = "";

if ( rs.next() ) {
	unit_code = getDBStr( rs.getString("unit_code") );
	unit_name = getDBStr( rs.getString("unit_name") );
	unit_property = getDBStr( rs.getString("unit_property") );
	oper_name = getDBStr( rs.getString("oper_name") );
}

rs.close();
db.close();
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=left cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">融资基础信息管理&gt; 授信单位</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
 <tr>
    <td height="30" scope="row">授信单位英文简称</td>
    <td width="84%" height="30" class="cwDDValue"><%=unit_code %></td>
  </tr>
  <tr>
    <td height="30" scope="row">授信单位名称</td>
    <td height="30" class="cwDDValue"><%=unit_name %></td>
  </tr>
  <tr>
    <td height="30" scope="row">授信机构属性</td>
    <td height="30" class="cwDDValue"><%=unit_property %></td>
  </tr>
  <tr>
    <td height="30" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%=oper_name %></td>
  </tr>
</table>
</div>


<div  style="margin:12px;text-align:right;">
<form action="baseconfig_mod.jsp?czid=<%=priId %> " target="_self">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<input name="czid" value="<%=priId %>" type="hidden">
<td>
<input name="btnMod" value="修改" type="submit" class="btn3_mouseout">
</td>
<td>&nbsp;&nbsp;
<input name="btnClose" value="关闭" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</form>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>



