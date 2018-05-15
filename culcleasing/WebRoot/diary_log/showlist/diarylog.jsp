<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../js/jquery.js"></script>

<link href="../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body>

<form  name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		项目进程日报表</td>
	</tr>
</table>
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>主题</th>
		<th>提交人</th>
		<th>来源</th>
		<th>提交时间</th>
      </tr>
      <tbody id="data">
<%
sqlstr = "select * from SYS_diary_log";
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%=getDBStr( rs.getString("id")) %></td>	
		<td align="center"><a href="main.jsp?loadtime=<%=getDBDateStr( rs.getString("create_date")) %>"><%=getDBStr( rs.getString("title")) %></a></td>
		<td align="center"><%=getDBStr( rs.getString("source")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("create_date")) %></td>		
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
