<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����������������� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>

<body scroll=auto>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjzzs_save.jsp"  onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">������Ϣ����</td>
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
        <td id="cwCellTopTitTxt">�����������������</td>
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
    <th width="79" scope="row">����������</th>
    <td><input name="zzsmc" type="text" size="50" maxlength="100" maxB="100" label="����������"  Require="true"> 
    <span class="biTian">*</span></td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="btnSave" value="����" type="submit"><input class="btn" name="btnClose" value="ȡ��" type="button" onClick="window.close()"><input class="btn" name="btnReset" value="����" type="reset">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
