<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改代理机构 - 代理机构</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="dljg_save.jsp"  onSubmit="return chkForm(this);">


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
        <td id="cwCellTopTitTxt">修改代理机构</td>
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
String sqlstr;
ResultSet rs;

String czid = getStr( request.getParameter("czid") );

String agent_name = "";


sqlstr = "select base_agent.*,a.xm as djrxm,b.xm as gxrxm from base_agent left outer join jb_yhxx a on base_agent.creator=a.id left outer join jb_yhxx b on base_agent.creator=b.id where base_agent.agent_number='" + czid + "'"; 
rs = db.executeQuery(sqlstr); 
if ( rs.next() ) {
	agent_name = getDBStr( rs.getString("agent_name") );
%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th scope="row">代理机构编号</th>
    <td><input name="agent_number" type="text" size="30" Require="true" value="<%= czid %>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">代理机构名称</th>
    <td><input name="agent_name" type="text" size="30" Require="true" value="<%= agent_name %>"><span class="biTian">*</span></td>
  </tr>
</table>


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->

</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="submit" value="保存" type="submit">
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>


