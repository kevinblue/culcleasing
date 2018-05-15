<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>汇率信息明细 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<%
String czid;
czid=getStr(request.getParameter("czid"));
%>


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">基础信息管理</td>
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
        <td id="cwCellTopTitTxt">汇率信息明细</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	



<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td><a href="hlxx_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > 修改</a></td>
      </tr>
</table>	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">

<%
String sqlstr;
String ksrq,jsrq;
ResultSet rs;
sqlstr = "SELECT jb_hlxx.*, jb_bzxx.bz, V_yhxx.xm FROM V_yhxx RIGHT OUTER JOIN jb_hlxx ON V_yhxx.id = jb_hlxx.czy LEFT OUTER JOIN jb_bzxx ON jb_hlxx.bzid = jb_bzxx.id where jb_hlxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
        ksrq=getDBStr(rs.getString("ksrq"));
        ksrq=ksrq.substring(0,10);
        jsrq=getDBStr(rs.getString("jsrq"));
        if (jsrq!="")
        jsrq=jsrq.substring(0,10);
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">币种</th>
    <td width="84%" class="cwDDValue"><%=getDBStr(rs.getString("bz"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">汇率</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("hl"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">开始执行日期</th>
    <td class="cwDDValue"><%=ksrq%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">执行截止日期</th>
    <td class="cwDDValue"><%=jsrq%></td>
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
