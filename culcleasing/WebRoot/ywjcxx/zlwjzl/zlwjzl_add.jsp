<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������������Ϣ - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body >

<div id="cwMain" >

<form name="form1" method="post" action="zlwjzl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >������Ϣ����</td>
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
        <td id="cwCellTopTitTxt">�����������������Ϣ</td>
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
    <th width="120" scope="row">��������������</th>
    <td width="260">
      <input name="id" type="text" size="30" maxlength="10"  label=""  Require="true">
      <span class="biTian">*&nbsp;�������Ϊ4λ��</span>
  </td>
  </tr>
  <tr>
    <th scope="row">���������������</th>
    <td><input name="lxmc" type="text" size="30" maxlength="50" label=""  Require="true"> <span class="biTian">*</span></td>

   <tr>
    <th scope="row">������ҵ</th>
    <td> <select name="hy">
	  <script>w(mSetOpt("ҽ��","ҽ��|ӡˢ|����|����|����|IT|��ͨ|����|����|����|����|����|ˮ��|��Ϣ|ũҵ|�ɾ�|����|��Դ|����|����"));</script>
    </select></td>
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