<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>删除满意度模型</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="mydmx_save.jsp">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >满意度模型</td>
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
        <td id="cwCellTopTitTxt">删除满意度模型</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select * from v_perf_satissurvey_model where id=" + czid; 
	ResultSet rs = db.executeQuery(sqlstr); 


	String bmmc = "";
	String dept_id = "";
	String item = "";
	String indicator_def = "";
	String standard = "";
	String frequency = "";
	String examiner = "";

	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";

	if ( rs.next() ) {
		bmmc = getDBStr( rs.getString("bmmc") );
		dept_id = getDBStr( rs.getString("dept_id") );
		item = getDBStr( rs.getString("item") );
		indicator_def = getDBStr( rs.getString("indicator_def") );
		standard = getDBStr( rs.getString("standard") );
		frequency = getDBStr( rs.getString("frequency") );
		examiner = getDBStr( rs.getString("examiner") );

		creator = getDBStr( rs.getString("djrxm") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("gxrxm") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close(); 
	db.close();
%>

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= czid %>">

<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">部门</th>
    <td class="cwDDValue"><%= bmmc %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">项目</th>
    <td class="cwDDValue"><%= item %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">指标定义</th>
    <td class="cwDDValue"><%= indicator_def %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">评价标准</th>
    <td class="cwDDValue"><%= standard %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">考核频度</th>
    <td class="cwDDValue"><%= frequency %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">评分人</th>
    <td class="cwDDValue"><%= examiner %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">登记人</th>
    <td class="cwDDValue"><%= creator %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">登记时间</th>
    <td class="cwDDValue"><%= create_date %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">修改人</th>
    <td class="cwDDValue"><%= modificator %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">修改时间</th>
    <td class="cwDDValue"><%= modify_date %></td>
  </tr>
</table>

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
