<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="fxll_save.jsp" onSubmit="return Validator.Validate(this,3);">

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
        <td id="cwCellTopTitTxt">������Ϣ����</td>
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


<div id="cwCellContent" >

<input type="hidden" value="add" name="savetype">
<table   border="0" cellpadding="2" cellspacing="5" class="cwDataInput">
  
  <tr>
	<th scope="row">��ͬ���</th>
    <td><input type="text" name="contract_id" readonly Require="ture" size=20><input type="hidden" name="contract_id_data"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','��ͬ���','v_dw_contract','target_name','contract_id','target_name','target_name','asc','form1.contract_id_data','form1.contract_id');"><span class="biTian">*</span></td>
  </tr>
  <tr>
      <th scope="row">��Ϣ��������</th>
      <td><select name="pena_rate_type">
        <script>w(mSetOpt('',"�̶�|����"));</script>
        </select>
      <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>��Ϣ����</th>
    <td><input name="pena_rate" type="text" size="10" maxB="60" Require="ture">%%<span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>������ʼ����</th>
    <td><input name="ratestartdate" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"><img  onClick="openCalendar(ratestartdate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>���ʽ�������</th>
    <td><input name="rateenddate" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"><img  onClick="openCalendar(rateenddate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
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
