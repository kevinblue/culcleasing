<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ڲ���ҵ��Ϣ - ɾ��</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String id = getStr( request.getParameter("czid") );
sqlstr = "select base_trade.*,base_user.name from dbo.base_trade left join base_user on base_trade.czy=base_user.id where base_trade.id='" + id+"'"; 
rs = db.executeQuery(sqlstr); 

String code = "";
String trade = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	code = getDBStr( rs.getString("code") );
	trade = getDBStr( rs.getString("trade") );
	gxrq = getDBDateStr( rs.getString("gxrq") );
	xm = getDBStr( rs.getString("name") );
}

rs.close();
db.close();
%>

<%--
//Ȩ���ж�
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ywjcxx_paytype_del",dqczy)>0) 
{
	canedit=1;
}
if (canedit==0) {
	response.sendRedirect("../../noright.jsp");
}
--%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<form name="form1" method="post" action="basetrade_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= id %>">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">������Ϣ���� &gt; �ڲ���ҵɾ��</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td height="30" scope="row">�ڲ���ҵ����</td>
    <td width="84%" height="30" class="cwDDValue"><%=code %></td>
  </tr>
  <tr>
    <td height="30" scope="row">�ڲ���ҵ����</td>
    <td height="30" class="cwDDValue"><%=trade %></td>
  </tr>
  <tr>
    <td height="30" scope="row">����������</td>
    <td height="30" class="cwDDValue"><%= gxrq %></td>
  </tr>
  <tr>
    <td height="30" scope="row">����Ա</td>
    <td height="30" class="cwDDValue"><%= xm %></td>
  </tr>
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btndel" value="ɾ��" type="submit" onClick="return(confirm('ȷ��ɾ����?'))" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</div>
</form>
<!-- end cwMain -->
</body>
</html>
  