<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>代理机构明细 - 代理机构</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>



<%
String sqlstr;
ResultSet rs;

String czid = getStr( request.getParameter("czid") );

String agent_name = "";
String eas_used = "";

sqlstr = "select base_agent.*,a.xm as djrxm,b.xm as gxrxm from base_agent left outer join jb_yhxx a on base_agent.creator=a.id left outer join jb_yhxx b on base_agent.creator=b.id where base_agent.agent_number='" + czid + "'"; 
rs = db.executeQuery(sqlstr); 
while ( rs.next() ) {
	agent_name = getDBStr( rs.getString("agent_name") );
	eas_used = getDBStr( rs.getString("eas_used") );
} rs.close();

if (eas_used.equals("1"))
{
%>
		<script>
			window.close();
			opener.alert("该公司帐户数据EAS系统已引用,不能删除!");
		</script>
<%
}
%>
<div id="cwMain" >
<form name="form1" method="post" action="dljg_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%= czid %>">



<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >代理机构</td>
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
        <td id="cwCellTopTitTxt">代理机构明细</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

	<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
		  <tr>
			<td >&nbsp;</td>
		  </tr>
	</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">

<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">代理机构编号</th>
    <td width="84%" class="cwDDValue"><%= czid %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">代理机构名称</th>
    <td class="cwDDValue"><%= agent_name %></td>
  </tr>
</table>

<%
db.close();
%>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div id="cwToolbar">
<input class="btn" name="submit" value="删除" type="submit"  onClick="return(confirm('确定删除吗?'))">
<input class="btn" name="btnClose" value="关闭" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>