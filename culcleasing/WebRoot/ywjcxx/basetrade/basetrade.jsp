<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ڲ���ҵ��ϸ - ������Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String id = getStr( request.getParameter("czid") );

sqlstr = "select base_trade.*,base_user.name from dbo.base_trade left join base_user on base_trade.czy=base_user.id where base_trade.id='" + id+"'"; 
LogWriter.logDebug(request, "���sql:"+sqlstr);
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
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=left cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">������Ϣ���� &gt; �ڲ���ҵ��ϸ</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td  width="20%" height="30" class="cwDDLabel">�ڲ���ҵ���룺</td>
    <td height="30"  class="cwDDValue"><%=code %>&nbsp;</td>
  </tr>
 <tr>
    <td  width="20%" height="30" class="cwDDLabel">�ڲ���ҵ����</td>
    <td height="30" class="cwDDValue"><%=trade %>&nbsp;</td>
  </tr>
   <tr>
    <td  width="20%" height="30" class="cwDDLabel">����������</td>
    <td height="30" class="cwDDValue"><%=gxrq%>&nbsp;</td>
  </tr>
   <tr>
    <td  width="20%" height="30" class="cwDDLabel">����Ա</td>
    <td height="30" class="cwDDValue"><%=xm%>&nbsp;</td>
  </tr>
</table>
</div>


<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<form action="basetrade_mod.jsp?czid=<%=id%> " target="_self">
<input name="czid" value="<%=id%>" type="hidden">
<td>
<input name="btnMod" value="�޸�" type="submit" class="btn3_mouseout">
</td>
<td>&nbsp;&nbsp;
<input name="btnClose" value="�ر�" type="button" onClick="window.close()" class="btn3_mouseout">
</td>

</tr>
</table>
<!-- end cwToolbar -->
</form>
  
</div>
<!-- end cwMain -->
</body>
</html>



