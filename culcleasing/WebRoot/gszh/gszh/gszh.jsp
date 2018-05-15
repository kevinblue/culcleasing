<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>公司内部账户明细 - 公司内部账户</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >公司内部账户</td>
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
        <td id="cwCellTopTitTxt">公司内部账户明细</td>
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
        <td><a href="gszh_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > 修改</a></td>
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
    <th width="16%" class="cwDDLabel">开户银行</th>
    <td width="84%" class="cwDDValue"><%=getDBStr(rs.getString("yhmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">帐户名称</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">开户帐号</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("khzh"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">帐户币种</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhbz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">帐户性质</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhxz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">帐户类型</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhlx"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">网银地址</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("wydz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">电话银行电话</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("dhyhdh"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">电话银行登陆名</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("dhyhdl"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">联系人</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxr"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">联系人电话</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxrdh"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">帐户状态</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhzt"))%></td>
  </tr>
 
</table>

<%
}
else
{
   out.print("</center>该条记录不存在!</center>");
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
<input class="btn" name="btnClose" value="关闭" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
