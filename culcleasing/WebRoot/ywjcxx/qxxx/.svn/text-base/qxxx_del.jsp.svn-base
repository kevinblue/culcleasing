<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>区县信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String id = getStr( request.getParameter("czid") );
String sqlstr;
ResultSet rs;
sqlstr = "select jb_qxxx.*,jb_yhxx.xm,jb_csxx.csmc from jb_qxxx left outer join jb_yhxx on jb_qxxx.czy=jb_yhxx.id left outer join jb_csxx on jb_qxxx.csid=jb_csxx.id where jb_qxxx.id=" + id; 
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
	xm = getDBStr( rs.getString("xm") );
}

rs.close();
db.close();

%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 删除区县信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="qxxx_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=id%>">
<!-- end cwCellTop -->


<div id="cwCellContent">


<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" class="cwDDLabel">城市</td>
    <td width="84%" class="cwDDValue"><%= csmc %></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">区县名称</td>
    <td class="cwDDValue"><%= qxmc %></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">最后更新日期</td>
    <td class="cwDDValue"><%= gxrq %></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">操作员</td>
    <td class="cwDDValue"><%= xm %></td>
  </tr>
</table>

<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input class="btn3_mouseout" name="submit" value="删除" type="submit"  onClick="return(confirm('确定删除吗?'))">
</td>
<td width=8 width="12">
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
