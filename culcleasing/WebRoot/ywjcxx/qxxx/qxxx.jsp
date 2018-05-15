<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>区县信息明细 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String id = getStr( request.getParameter("czid") );
String sqlstr;
ResultSet rs;
sqlstr = "select jb_qxxx.*,jb_csxx.id,jb_csxx.csmc,base_user.name from jb_qxxx left join jb_csxx on jb_qxxx.csid=jb_csxx.id left join base_user on jb_qxxx.czy=base_user.id where jb_qxxx.id='" + id+"'"; 
rs = db.executeQuery(sqlstr); 

String qxmc = "";
String csmc = "";
String csid = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	qxmc = getDBStr( rs.getString("qxmc") );
	csmc = getDBStr( rs.getString("csmc") );
	csid = getDBStr( rs.getString("csid") );
	gxrq = getDBDateStr( rs.getString("gxrq") );
	xm = getDBStr( rs.getString("name") );
}

rs.close();
db.close();
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">项目信息管理 &gt; 担保单位明细</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv"><!-- end cwTop -->









<!-- end cwCellTop -->





<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" class="cwDDLabel">城市</td>
    <td width="84%" height="30" class="cwDDValue"><%= csmc %></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">区县名称</td>
    <td height="30" class="cwDDValue"><%= qxmc %></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">最后更新日期</td>
    <td height="30" class="cwDDValue"><%= gxrq %></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%= xm %></td>
  </tr>
</table>



<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->




<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<form action="qxxx_mod.jsp?czid=<%=id%> " target="_self">
<input name="czid" value="<%=id%>" type="hidden">
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
    </form>
  
</div>
<!-- end cwMain -->
</body>
</html>


