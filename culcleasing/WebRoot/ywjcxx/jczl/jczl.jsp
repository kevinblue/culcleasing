<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基础资料分类</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 基础资料明细</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->

<%
sqlstr = " SELECT * FROM base_material where id='"+czid+"' "; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
 
  <tr>
    <td class="cwDDLabel" scope="row">内容</td>
    <td width="84%" ><%=getDBStr(rs.getString("sort"))%></td>
  </tr>
   <tr>
    <td class="cwDDLabel" scope="row">资料名称</td>
    <td width="84%"><%=getDBStr(rs.getString("mater_name"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">资料类别</td>
    <td width="84%"><%=getDBStr(rs.getString("mater_type"))%></td>
  </tr>
 
 
</table>

<%
}
else
{
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>

<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<form action="jczl_mod.jsp?czid=<%=czid%> " target="_self">
<input name="czid" value="<%=czid%>" type="hidden">
<td>
<input name="btnMod" value="修改" type="submit" class="btn3_mouseout">
</td>
</form>
<td>
<input name="btnClose" value="关闭" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
