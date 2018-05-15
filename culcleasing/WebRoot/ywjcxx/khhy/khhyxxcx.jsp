<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>行业信息查询 - 行业信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >行业信息查询</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
String sqlstr;
ResultSet rs;
%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">行业信息查询</td>
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

    <form name="list" method="post" action="khhyxxrst.jsp" target="_blank">
<br>
<br>
<br>
    <table class="cwDataList" width="80%"  border="0"  align="center" cellpadding="2" cellspacing="1" >	  
 <tr class="cwDLHead">
   <td colspan=4>请选择查询条件:</td>
 </tr>	  
<tr class="cwDLRow" >
<td>编号</td>
<td colspan="3"><input type="text" name="hybh"></td>
</tr>

<tr class="cwDLRow" >
<td>行业门类</td>
<td>
<select name="hyml">
<option select="true"></option>
<%
sqlstr="select hymlbh,hymlmc from kh_hyml_gb order by hymlmc asc";
rs=db.executeQuery(sqlstr);
while (rs.next())
{
%>
<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%
}
rs.close();
%>
</select>
</td>
<td>行业大类</td>
<td><input type="text" name="hydl">
</td>
</tr>

<tr class="cwDLRow" >
<td>行业中类</td>
<td><input type="text" name="hyzl">
</td>
<td>行业小类</td>
<td><input type="text" name="hyxl">
</td>
</tr>
 <tr class="cwDLRow">
   <td colspan=4 align="right"><input name="img" type="image" src="../../images/tbtn_searh_txt.gif" alt="查询" align="absmiddle"></td>
 </tr>	 
    </table>

</form>

<div id="cwDataNav" >

</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
<%if(null != db){db.close();}%>