<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����������Ϸ���</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">������Ϣ���� &gt; �����������Ϸ���</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="jczl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="16%" scope="row">���������</td>
    <td  width="84%">
     <select name="sort"  class="select_css">
			<option value="�ɻ�">�ɻ�</option>
			<option value="����">����</option>
			<option value="ͨ���豸">ͨ���豸</option>
			<option value="ҽ��">ҽ��</option>
	        </select>
	</td> 
  </tr>
   <tr>
    <td scope="row">��������</td>
    <td><input name="mater_name" type="text" label="��������" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">�������</td>
    <td>
	<select name="mater_type"  class="select_css">
			<option value="�����ļ�">�����ļ�</option>
			<option value="�����˻����ļ�">�����˻����ļ�</option>
			<option value="���޺�ͬ��������ͬ">���޺�ͬ��������ͬ</option>
			<option value="��Ӧ�̺�ͬ">��Ӧ�̺�ͬ</option>
			<option value="��֤������">��֤������</option>
			<option value="���ޱ�����ļ�">���ޱ�����ļ�</option>
			<option value="��/��Ѻ��">��/��Ѻ��</option>
	        </select>
	</td>
  </tr>
</table>
</div>

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
</div>
<!-- end cwMain -->
</body>
</html>