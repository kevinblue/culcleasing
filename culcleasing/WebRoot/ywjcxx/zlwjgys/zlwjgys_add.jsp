<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新增租赁物件供应商情况 - 租赁物件供应商情况</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjgys_save.jsp" onSubmit="return chkForm(this);">


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





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">新增租赁物件供应商情况</td>
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

<input type="hidden" name="savetype" value="add">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th width="79" scope="row">租赁物件</th>
    <td><input name="wjid" type="text" size="20" maxlength="20">
	</td>
  </tr>
  <tr>
    <th scope="row">租赁物件供应商</th>
    <td><input name="gysid" type="text" size="20" maxlength="20">
    </td>
  </tr>
  <tr>
    <th scope="row">单价</th>
    <td><input name="dj" type="text" size="20" maxlength="20" label="单价" conttyp="double"></td>
  </tr>
  <tr>
    <th scope="row">币种</th>
    <td>
	<select name="bz">
<%
String sqlstr;
ResultSet rs;
sqlstr = "select id,bz from jb_bzxx order by id"; 
rs=db.executeQuery(sqlstr); 
while (rs.next())
{
%>
    <option value="<%=rs.getString("id")%>" selected="true"><%=rs.getString("bz")%></option>
<%
}
rs.close();
db.close();
%>
    </select>
    </td>
 <tr>
    <th scope="row">信息状态</th>
    <td>
	<select name=zt>
    <option>
    <option selected>
    </select>
    </td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="btnSave" value="保存" type="submit"><input class="btn" name="btnClose" value="取消" type="button"><input class="btn" name="btnReset" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
