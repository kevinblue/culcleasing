<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��˾�ڲ��˻���ϸ - ��˾�ڲ��˻�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >��˾�ڲ��˻�</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">��˾�ڲ��˻���ϸ</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td><a href="gszh_mod.jsp?czid=<%= czid %>"  accesskey="m" title="�޸�(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > �޸�</a></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%
sqlstr = "SELECT jb_nbzhxx.*, jb_bankxx.yhmc FROM jb_nbzhxx LEFT OUTER JOIN jb_bankxx ON jb_nbzhxx.yhid=jb_bankxx.id where jb_nbzhxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">��������</th>
    <td width="84%" class="cwDDValue"><%=getDBStr(rs.getString("yhmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�ʻ�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�����ʺ�</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("khzh"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�ʻ�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhbz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�ʻ�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhxz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�ʻ�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhlx"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">������ַ</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("wydz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�绰���е绰</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("dhyhdh"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�绰���е�½��</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("dhyhdl"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">��ϵ��</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxr"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">��ϵ�˵绰</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxrdh"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">�ʻ�״̬</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhzt"))%></td>
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





<div id="cwToolbar">
<input class="btn" name="btnClose" value="�ر�" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
