<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ɾ���ͻ����С�� - �ͻ���Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String czid;
czid=getStr(request.getParameter("czid"));
%>


<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ͻ���Ϣ���� &gt; ɾ���ͻ����С��</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="khlbxl_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<%
String sqlstr;
ResultSet rs;
sqlstr = "select kh_lbxl.*,kh_lbdl.lbdlmc,base_user.name from kh_lbxl left join kh_lbdl on kh_lbxl.ssdl=kh_lbdl.id left join base_user on kh_lbxl.czy=base_user.id where kh_lbxl.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="25%" height="30" class="cwDDLabel">�ͻ����С�����</td>
    <td width="75%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">�ͻ����С������</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("lbxlmc"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">����������</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("lbdlmc"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">����������</td>
    <td height="30" class="cwDDValue"><%=getDBDateStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">����Ա</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("name"))%></td>
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
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input class="btn3_mouseout" name="submit" value="ɾ��" type="submit"  onClick="return(confirm('ȷ��ɾ����?'))">
</td>

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