<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����ͻ����ձ� - �ͻ����ձ�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata.js"></script>
</head>
<%

String dqczy=(String) session.getAttribute("czyid");
//if ((dqczy==null) || (dqczy.equals("")))
//{
//  dqczy="����֤";
//  response.sendRedirect("../../noright.jsp");
//}
int canedit=0;
if (right.CheckRight("gszh_add",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ͻ���Ϣά�� &gt; �����ͻ�����</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="fyxx_save.jsp" onSubmit="return Validator.Validate(this,3);">


<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="120" height="30" scope="row">��������</td>
    <td height="30" >
     <input class="text" name="feetype_number" accesskey="s" type="text" size="20" style="width: 133px" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','������','base_feetype','feetype_name','feetype_number','feetype_name','feetype_name','asc','form1.feetype_number','form1.feetype_number');"><span class="biTian">*</span>
	</td>
  </tr>
   <tr>
    <td height="30" scope="row">��ĿID</td>
    <td height="30"><input name="subject_number" type="text" label="��ĿID"  Require="ture"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td height="30" scope="row">ժҪ</td>
    <td height="30"><input name="cdigest" type="text" label="ժҪ"  Require="ture"><span class="biTian">*</span></td>
  </tr>
  
<tr>
    <td height="30" scope="row">��������</td>
    
    <td height="30">
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account1" value="1">���ź���
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account2" value="2">�ͻ�����
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account3" value="3" onclick="check(this.id);">��Ŀ����
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account4" value="4" onclick="check(this.id);">�ʻ�����
    </td>
  </tr>
    <tr>
    <td height="30" scope="row">������</td>
    <td height="30"><input name="flow_name" type="text"  label="������" Require="true"> <span class="biTian">*</span></td>
  </tr>
    <tr>
    <td height="30" scope="row">��/��</td>
    <td height="30">
    <select class="text" name="handle_flag" style="width: 40px"><script>w(mSetOpt("","|��|��"));</script></select>
     <span class="biTian">*</span></td>
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
<script type="text/javascript">
 function check(id){
 	if(id=='auxiliary_account3'){
 		document.getElementById('auxiliary_account4').checked = false;
 	} else if(id=='auxiliary_account4'){
 		document.getElementById('auxiliary_account3').checked = false;
 	}
 }
</script>
<!-- end cwMain -->
</body>
</html>