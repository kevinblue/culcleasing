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


<!-- �������� -->
<%@ include file="../public/commonVariable.jsp"%>
<!-- �������� -->

<body>

<form  name="dataNav">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��Ŀ�����ձ���</td>
	</tr>
</table>
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>����</th>
		<th>�ύ��</th>
		<th>��Դ</th>
		<th>�ύʱ��</th>
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
</div><!--�������-->

</form>
</body>
</html>
