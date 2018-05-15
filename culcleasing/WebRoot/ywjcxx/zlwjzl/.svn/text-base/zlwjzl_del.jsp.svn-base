<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租赁物件总类信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjzl_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >租赁物件总类信息</td>
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
        <td id="cwCellTopTitTxt">租赁物件总类信息</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td>&nbsp;</td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->


<div id="cwCellContent">

<%
sqlstr = "select JB_zlwjlb.*,v_yhxx.xm from v_yhxx right outer join JB_zlwjlb on v_yhxx.id = JB_zlwjlb.czy where JB_zlwjlb.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">租赁物件总类代码</th>
    <td width="84%" class="cwDDValue"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">租赁物件总类名称</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxmc"))%></td>
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
  <input class="btn" name="submit" value="删除" type="submit"  onClick="return(confirm('确定删除吗?'))">
  <input class="btn" name="btnClose" value="取消" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
