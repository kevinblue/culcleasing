<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>删除保险费率</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="bxfl_save.jsp">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >保险费率</td>
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
        <td id="cwCellTopTitTxt">删除保险费率</td>
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
	String sqlstr = "SELECT base_bxfl.*, jb_yhxx_1.xm AS djrxm, jb_yhxx_2.xm AS gxrxm FROM base_bxfl LEFT OUTER JOIN       jb_yhxx jb_yhxx_2 ON base_bxfl.gxr = jb_yhxx_2.id LEFT OUTER JOIN       jb_yhxx jb_yhxx_1 ON base_bxfl.djr = jb_yhxx_1.id where base_bxfl.id=" + czid; 
	ResultSet rs = db.executeQuery(sqlstr); 


	String bxgs_name = "";
	String bxfl = "";
	String rq = "";

	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";

	if ( rs.next() ) {
		bxgs_name = getDBStr( rs.getString("bxgs_name") );
		bxfl = getDBDecStr( rs.getBigDecimal("bxfl",6) ).toString();
		rq = getDBDateStr( rs.getString("rq") );

		creator = getDBStr( rs.getString("djrxm") );
		create_date = getDBDateStr( rs.getString("djrq") );
		modificator = getDBStr( rs.getString("gxrxm") );
		modify_date = getDBDateStr( rs.getString("gxrq") );
	}
	rs.close(); 
	db.close();
%>

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= czid %>">

<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">保险公司</th>
    <td class="cwDDValue"><%= bxgs_name %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">保险费率</th>
    <td class="cwDDValue"><%= bxfl %>&nbsp;%</td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">开始日期</th>
    <td class="cwDDValue"><%= rq %></td>
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
