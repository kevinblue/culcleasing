<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ���Ϣ���� - ������Ӧ�̹�����ҵ����֧�������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<%String project_id= getStr(request.getParameter("project_id")); %>
</head>
<body>
<form name="form1" method="post" action="glqyqk_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
������Ӧ�̹�����ҵ����֧������� &gt; �ͻ���Ϣ����
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="����"> ����</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="����"> ����</a>
    	
    	<input class="btn" name="btnSave" value="����" type="submit">
    	<input class="btn" name="btnReset" value="����" type="reset">
    	-->
    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="project_id" value="<%=project_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>��Ӧ��</td>
    <td><input name="vndr_name" type="text" size="40"  Require="true" readonly><input type="hidden" name="vndr_id" > <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','�ͻ�����','cust_info','cust_name','cust_id','cust_name','cust_name','asc','form1.vndr_name','form1.vndr_id');">
	<span class="biTian">*</span></td>

    <td>������ҵ</td>
    <td><input name="affiliatedco" type="text" size="40" maxB="50" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>����/����</td>
    <td><select name="individual_flag">
        <script>w(mSetOpt('0',"����|����","0|1"));</script>
        </select>
	<span class="biTian">*</span></td>

    <td>��֯��������/����֤��</td>
    <td><input name="id_number" type="text" size="40" maxB="20" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>������ϵ</td>
    <td><input name="relationship" type="text" size="40" maxB="100" Require="true">
	<span class="biTian">*</span></td>
    <td>��Ӫҵ��</td>
    <td><input name="primary_business" type="text" size="40" maxB="150" Require="true">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��ַ</td>
    <td><input name="address" type="text" size="40" maxB="100" Require="true"><span class="biTian">*</span></td>
  
    <td>���˴���</td>
    <td><input name="legal_representative" type="text" size="40" maxB="10" Require="true">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>ע���ʱ�</td>
    <td><input name="registered_capital" type="text" size="40" maxB="100" Require="true"><span class="biTian">*</span></td>
  
    <td>�ֹɱ���</td>
    <td><input name="equity_ratio" type="text" size="40" maxB="50" Require="true">
	<span class="biTian">*</span></td>
  </tr>
</table>
</div>

<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�

ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

</div>

</div>
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--���ӽ���-->


</form>

<!-- end cwMain -->
</body>
</html>