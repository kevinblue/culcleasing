<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������ͷ���</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body>
<%
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">������Ϣ���� &gt; ɾ����������</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="fylx_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<!-- end cwCellTop -->

<%
sqlstr = " SELECT * FROM base_feetype where feetype_number='"+czid+"' "; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td width="16%" class="cwDDLabel">�������ͱ���</td>
    <td width="84%" class="cwDDValue"><%=getDBStr(rs.getString("feetype_number"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">��������</td>
    <td class="cwDDValue"><%=getDBStr(rs.getString("feetype_name"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">���ʽ</td>
    <td class="cwDDValue"><%=getDBStr(rs.getString("paytype"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">��Ӧ�������</td>
    <td class="cwDDValue"><%=getDBStr(rs.getString("finance_code"))%></td>
  </tr>
</table>
<%
}
else
{
   out.print("</center>������¼������!</center>");
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
<tr valign="top"><td>
<input class="btn3_mouseout" name="submit" value="ɾ��" type="submit"  onClick="return(confirm('ȷ��ɾ����?'))">
</td>
<td width=8 width="12">
<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
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