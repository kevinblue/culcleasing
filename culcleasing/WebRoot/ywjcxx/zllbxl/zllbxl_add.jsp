<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����������С�� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zllbxl_save.jsp" onSubmit="return Validator.Validate(this,3);">

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
        <td id="cwCellTopTitTxt">�����������С��</td>
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
    <th width="117" scope="row">�������С�����</th>
    <td width="238">
      <input name="id" type="text" size="3" maxlength="3" label="" dataType="" Require="true"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <th scope="row">�������С������</th>
    <td><input name="lbxlmc" type="text" size="30" maxlength="30" label="" dataType="" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">�������ϴ���</th>
    <td>
<input type="text" name="ssdldata" readonly label="" Require="true"><input type="hidden" name="ssdl"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer"
 onclick="SimpleDataWindow('','','jb_zldl','lbdlmc','id','','','id','form1.ssdldata','form1.ssdl');"> <span class="biTian">*</span></td>
  </tr>
</table>



<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->




<div id="cwToolbar" >
<input class="btn" name="btnSave" value="����" type="submit"> <input class="btn" name="btnClose" value="ȡ��" type="button" onclick="window.close();"><input class="btn" name="btnReset" value="����" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
</div>
<!-- end cwMain -->
</body>
</html>
