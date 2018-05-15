<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增租赁物件产品名称 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjcpmc_save.jsp" onSubmit="return Validator.Validate(this,3);">

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

<%
String sqlstr;
String czid;
String zlmc="";
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "SELECT lxmc FROM jb_zlwjlb where id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
    zlmc=getDBStr(rs.getString("lxmc"));
}
rs.close();
db.close();
%>




<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">新增租赁物件产品名称</td>
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
<table width="439" height="106"  border="0" cellpadding="2" cellspacing="5" class="cwDataInput">
  <tr>
    <th width="98" scope="row">所属总类</th>
    <td width="318">
<input type="text" name="zliddata" readonly label="" dataType="" Require="true" value="<%=zlmc%>"><input type="hidden" name="zlid" value="<%=czid%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="popUpWindow('zlsel.jsp',250,350);"> <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <th scope="row">产品名称代码</th>
    <td><input name="id" type="text" size="30" maxlength="10"  label="" dataType="" Require="true"> <span class="biTian">*&nbsp;产品名称代码为2位数字</span></td>
  </tr>
  <tr>
    <th scope="row">产品名称</th>
    <td><input name="lxmc" type="text" size="30" maxlength="50" label="" dataType="" Require="true"> <span class="biTian">*</span></td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="btnSave" value="保存" type="submit"> <input class="btn" name="btnClose" value="取消" type="button" onclick="window.close();"><input class="btn" name="btnReset" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
</div>
<!-- end cwMain -->
</body>
</html>
