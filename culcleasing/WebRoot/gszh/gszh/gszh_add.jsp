<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������˾�ڲ��˻� - ��˾�ڲ��˻�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="gszh_save.jsp" onSubmit="return chkForm(this);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >��˾�ڲ��˻�</td>
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
        <td id="cwCellTopTitTxt">������˾�ڲ��˻�</td>
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
    <th width="79" scope="row">��������</th>
    <td width="296">
<input name="yhiddata" type="text" size="30" readonly label="��������" conttyp="" isopt="0"><input type="hidden" name="yhid"><img src="../../images/sbtn_more.gif" alt="ѡ" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','jb_bankxx','yhmc','id','','','id','form1.yhiddata','form1.yhid');"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <th scope="row">�ʻ�����</th>
    <td><input name="zhmc" type="text" size="30" maxlength="30" label="�ʻ�����" isopt="0"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">�����ʺ�</th>
    <td><input name="khzh" type="text" size="30" maxlength="30" label="�����ʺ�" isopt="0"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>����</th>
    <td><input name="zhbzdata" type="text" size="20" maxlength="20" readonly ><input name="zhbz" type="hidden"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer"
 onclick="SpecialDataWindow('��������','jb_bzxx','bz','bz','bz','stringfld','id','form1.zhbzdata','form1.zhbz');">
	  </td>
  </tr>
  <tr>
    <th scope="row">�ʻ�����</th>
    <td><input name="zhxz" type="text" size="20" maxlength="20" maxB="20"></td>
  </tr>
  <tr>
    <th scope="row">�ʻ�����</th>
    <td>
    <input name="zhlxdata" type="text" size="30" readonly label="�ʻ�����" conttyp="" isopt="0"><input type="hidden" name="zhlx" ><img src="../../images/sbtn_more.gif" alt="ѡ" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','v_yhlx','yhlx','yhlx','','','yhlx','form1.zhlxdata','form1.zhlx');"> <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <th scope="row">������ַ</th>
    <td><input name="wydz" type="text" size="100" maxlength="100" maxB="100"></td>
  </tr>
  <tr>
    <th scope="row">�绰���е绰</th>
    <td><input name="dhyhdh" type="text" size="20" maxlength="20" maxB="20"></td>
  </tr>
   <tr>
    <th scope="row">�绰���е�½��</th>
    <td><input name="dhyhdl" type="text" size="50" maxlength="50" maxB="50"></td>
  </tr>
   <tr>
    <th scope="row">��ϵ��</th>
    <td><input name="lxr" type="text" size="50" maxlength="50" maxB="50"></td>
  </tr>
   <tr>
    <th scope="row">��ϵ�˵绰</th>
    <td><input name="lxrdh" type="text" size="20" maxlength="20" maxB="20"></td>
  </tr>
  <tr>
    <th scope="row">�ʻ�״̬</th>
    <td>
	<select name=zhzt>
    <option selected="true">����</option>
    <option>����</option>
    </select>
    </td>
  </tr>
  <tr >
    <th scope="row">��ȿ�ʼ����</th>
    <td><input name="edqsrq" type="text" size="10" maxlength="10" label="" dataType="Date" ><img  onClick="openCalendar(edqsrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr >
    <th scope="row">��Ƚ�������</th>
    <td><input name="edzzrq" type="text" size="10" maxlength="10" label="" dataType="Date" ><img  onClick="openCalendar(edzzrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr >
    <th scope="row">���Ž��</th>
    <td><input name="sxed" type="text" value="" size="20" maxlength="20" maxB="20">
    </td>
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
