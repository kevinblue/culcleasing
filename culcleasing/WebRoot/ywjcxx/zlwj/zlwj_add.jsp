<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����������� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body scroll=auto>

<div id="cwMain" >
<form name="form1" method="post" action="zlwj_save.jsp" onSubmit="return Validator.Validate(this,3);">

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
        <td id="cwCellTopTitTxt">�����������</td>
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
    <td><input name="id" type="text" size="13" maxlength="13" maxB="13" Require="true"> 
    <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th width="79" scope="row">�����������</th>
    <td><input name="wjmc" type="text" size="50" maxlength="100" maxB="100" Require="true"> 
    <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">����</th>
    <td>
<input type="text" name="wjlbdata" readonly size="50" ><input type="hidden" name="wjlb"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','jb_zlwjlb','lxmc','id','','','id','form1.wjlbdata','form1.wjlb');">
    </td>
  </tr>
  <tr>
    <th scope="row">��Ʒ����</th>
    <td>
<input type="text" name="wjlxdata" readonly size="50" ><input type="hidden" name="wjlx"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','jb_zlwjlx','lxmc','id','','','lxmc','form1.wjlxdata','form1.wjlx');">
    </td>
  </tr>
  <tr>
    <th scope="row">��Ʒ����</th>
    <td>
<input type="text" name="cptxdata" readonly size="50" ><input type="hidden" name="cptx"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','jb_zlwjcptx','lxmc','id','','','lxmc','form1.cptxdata','form1.cptx');">
    </td>
  </tr>

  <tr>
    <th scope="row">�Ƽ���λ����</th>
    <td><input name="jjdw" type="text" size="20" maxlength="20" maxB="20" ></td>
  </tr>
  <tr>
    <th scope="row">�ο���</th>
    <td><input name="ckj" type="text" size="9" maxlength="9"  dataType="Money"></td>
  </tr>
  <tr>
    <th scope="row">���</th>
    <td><textarea name="wjgg" maxB="500"></textarea>
	</td>
  </tr>
  <tr>
    <th scope="row">������</th>
    <td>
<input name="zzsdata" type="text" size="50" readonly><input name="zzs" type="hidden"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="SpecialDataWindow('������','jb_zlwjzzs','zzsmc','id','zzsmc','stringfld','zzsmc','form1.zzsdata','form1.zzs');">
</td>
  </tr>
  <tr>
    <th scope="row">�������</th>
    <td><input name="cd" type="text" size="9" maxlength="9" dataType="Double"> 
    ����</td>
  </tr>
  <tr>
    <th scope="row">������</th>
    <td><input name="kd" type="text" size="9" maxlength="9"  dataType="Double"> 
    ����</td>
  </tr>
  <tr>
    <th scope="row">����߶�</th>
    <td><input name="gd" type="text" size="9" maxlength="9"  dataType="Double"> 
    ����</td>
  </tr>
  <tr>
    <th scope="row">����ڲ���Ʒ����</th>
    <td><input name="nbcpbm" type="text" size="20" maxlength="20" maxB="20"></td>
  </tr>
  <tr>
    <th scope="row">ע��֤������</th>
  <td><input name="wjdqr" accesskey="r" type="text" size="9" dataType="Date"><img  onClick="openCalendar(wjdqr);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
  </tr>
  <tr>
    <th scope="row">�������</th>
    <td><input name="wjcd" type="text" size="30" maxlength="200" maxB="200"></td>
  </tr>
  <tr>
  <tr>
    <th scope="row">��Ϣ״̬</th>
    <td>
	<select name=zt>
<script>w(mSetOpt("",""))</script>
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
<input class="btn" name="btnSave" value="����" type="submit"><input class="btn" name="btnClose" value="ȡ��" type="button" onClick="window.close()"><input class="btn" name="btnReset" value="����" type="reset">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
