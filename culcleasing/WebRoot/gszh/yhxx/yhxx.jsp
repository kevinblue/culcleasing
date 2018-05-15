<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>银行信息明细 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >基础信息管理</td>
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
        <td id="cwCellTopTitTxt">银行信息明细</td>
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
        <td><a href="yhxx_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > 修改</a></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%
sqlstr = "SELECT V_yhxx.xm, jb_bankxx.* FROM jb_bankxx LEFT OUTER JOIN V_yhxx ON jb_bankxx.czy = V_yhxx.id where jb_bankxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">银行名称</th>
    <td width="84%" class="cwDDValue"><%=getDBStr(rs.getString("yhmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">类型</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("yhlx"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">银行地址</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("yhdz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">备注</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("bz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">最后更新日期</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">操作员</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("xm"))%></td>
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
