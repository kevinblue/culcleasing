<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������Ϣ - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="hlxx_save.jsp" onSubmit="return chkInputDate(this)">


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
        <td id="cwCellTopTitTxt">����������Ϣ</td>
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
    <th width="79" scope="row">����</th>
    <td>
	<input type="text" name="bziddata" readonly label="����" conttyp="" isopt="0"><input type="hidden" name="bzid"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="SimpleDataWindow('','','jb_bzxx','bz','id','','','id','form1.bziddata','form1.bzid');"> <span class="biTian">*</span>



	</td>
  </tr>
  <tr>
    <th scope="row">����</th>
    <td><input name="hl" type="text" size="20" maxlength="20" label="����" conttyp="double" isopt="0"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">��ʼִ������</th>
    <td><input name="ksrq" type="text" size="10" maxlength="10" label="��ʼִ������" conttyp="date" isopt="0"><img  onClick="openCalendar(ksrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">ִ�н�ֹ����</th>
    <td><input name="jsrq" type="text" size="10" maxlength="10" label="ִ�н�ֹ����" conttyp="date"><img  onClick="openCalendar(jsrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
</table>

<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="btnSave" value="����" type="submit" onClick=""> <input class="btn" name="btnClose" value="ȡ��" type="button" onclick="window.close();"><input class="btn" name="btnReset" value="����" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
</div>
<!-- end cwMain -->
</body>
</html>
