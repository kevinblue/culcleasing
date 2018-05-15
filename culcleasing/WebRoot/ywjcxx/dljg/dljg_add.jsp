<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新增代理机构 - 代理机构</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="dljg_save.jsp" onSubmit="return chkForm(this);">

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
        <td id="cwCellTopTitTxt">新增代理机构</td>
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
    <th scope="row">代理机构编号</th>
    <td><input name="agent_number" type="text" size="30" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">代理机构名称</th>
    <td><input name="agent_name" type="text" size="30" Require="true"><span class="biTian">*</span></td>
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
