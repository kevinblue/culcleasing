<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租赁物件供应商情况明细 - 租赁物件供应商情况</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >租赁物件供应商情况</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
String czid;
czid=getStr(request.getParameter("czid"));
%>



<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">租赁物件供应商情况明细</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td><a href="zlwjgys_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > 修改</a></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%
String sqlstr;
ResultSet rs;
sqlstr = "SELECT jb_zlwjxx.wjmc, V_yhxx.xm, jb_zlwjgys.*,jb_bzxx.bz as bzmc, kh_mpxx.khmc FROM jb_zlwjgys LEFT OUTER JOIN kh_mpxx ON jb_zlwjgys.gysid = kh_mpxx.khbh LEFT OUTER JOIN jb_bzxx ON jb_zlwjgys.bz = jb_bzxx.id LEFT OUTER JOIN V_yhxx ON jb_zlwjgys.czy = V_yhxx.id LEFT OUTER JOIN jb_zlwjxx ON jb_zlwjgys.wjid = jb_zlwjxx.id where jb_zlwjgys.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">租赁物件</th>
    <td width="84%" class="cwDDValue"><%=rs.getString("wjid")%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">租赁物件供应商</th>
    <td class="cwDDValue"><%=rs.getString("gysid")%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">单价</th>
    <td class="cwDDValue"><%=rs.getString("dj")%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">币种</th>
    <td class="cwDDValue"><%=rs.getString("bzmc")%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">最后更新日期</th>
    <td class="cwDDValue"><%=rs.getString("gxrq")%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">操作员</th>
    <td class="cwDDValue"><%=rs.getString("czy")%></td>
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
