<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������������ - ���ʻ�����Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">���ʻ�����Ϣ����&gt; ������������</td>
</tr>
<tr>

<td align=center width=100% height=100% valign="top">

<form name="form1" method="post" action="insurance_company_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="add">
<div class="mydivtab" id="mydiv">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">���չ�˾����</td>
    <td scope="row">
      <input name="cust_name" type="text"  Require="ture"><span class="biTian">*����Ψһ</span>
	</td>
  </tr>
  <tr>
    <td scope="row">���չ�˾���</td>
    <td scope="row"><input name="cust_ename" type="text"  >
  </tr>
  <tr>
    <td scope="row">�ϱ��������</td>
    <td scope="row"><input name="finance_code" type="text"  Require="ture"><span class="biTian">*����Ψһ</span></td>
  </tr>
</table></div>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</td></tr></table>
<!-- end cwMain -->

</body>
</html>

