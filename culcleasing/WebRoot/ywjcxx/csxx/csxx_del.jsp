<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ɾ��������Ϣ - ������Ϣ</title>
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
<td class="tree_title_txt"  height=26 valign="middle" align="left">������Ϣ���� &gt; ɾ��������Ϣ</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="csxx_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<%
String sqlstr;
ResultSet rs;
sqlstr = "select jb_csxx.*,jb_ssxx.id,jb_ssxx.sfmc,jb_qyxx.qyid,jb_qyxx.qymc,jb_gjxx.id,jb_gjxx.gjmc,base_user.name from dbo.jb_csxx left join jb_ssxx on jb_csxx.sfid=jb_ssxx.id left join jb_qyxx on jb_ssxx.qyid=jb_qyxx.qyid left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id left join base_user on jb_csxx.czy=base_user.id  where jb_csxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
   <tr>
    <td width="16%" height="30" class="cwDDLabel">��������</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("gjmc"))%></td>
  </tr>
     <tr>
    <td width="16%" height="30" class="cwDDLabel">���ڵ���</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("qymc"))%></td>
  </tr>
   <tr>
    <td width="16%" height="30" class="cwDDLabel">ʡ/ֱϽ��</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("sfmc"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">���д���</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">����</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("csmc"))%></td>
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
<input name="btndel" value="ɾ��" type="submit" onClick="return(confirm('ȷ��ɾ����?'))" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close()" class="btn3_mouseout">
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
