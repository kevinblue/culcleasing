<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ��Ѻ���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

</head>
<body onload="fun_winMax();">
<form name="form1" method="post" action="dywj_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("zjwjgl-dywj-add",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("��û�в���Ȩ�ޣ�");
}

</script>
<%
	String contract_id=getStr( request.getParameter("czid") );
 %>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ͬ��Ϣ &gt; ��ͬ��Ѻ���
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
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>��ͬ���</td>
    <td><input name="contract_id" type="text" size="20"  Require="true" readonly value="<%=contract_id %>"></td>
    <td>��Ѻ/��Ѻ</td>
    <td><select name="equip_guarantee_type"></select>
	<script language="javascript">dict_list("equip_guarantee_type","GuarantyType","","name");</script>
    </td>
  </tr>
  <tr>
    <td>����Ѻ������</td>
    <td><input name="eqip_name" type="text" size="20" maxB="300"></td>
    <td>����</td>
    <td><input name="equip_num" type="text" size="20" maxB="10" dataType="Integer" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>�۸�</td>
    <td><input name="total_price" type="text" size="20" dataType="Money" Require="true"><span class="biTian">*</span></td>
  	<td>��ŵص�</td>
    <td><textarea name="equip_place" maxB="300"></textarea></td>
  </tr>
  <tr>
    <td>�豸���к�</td>
    <td><textarea name="equip_sn" maxB="300"></textarea></td>
    <td>Ȩ���ļ�</td>
    <td><textarea name="ownership_document" maxB="300"></textarea></td>
  </tr>
  <tr>
    <td>��Ѻ/��Ѻ��</td>
    <td><textarea name="guarantor" maxB="300"></textarea></td>
    <td>�����г�״��</td>
    <td><textarea name="second_hand_market" maxB="300"></textarea></td>
  </tr>
  <tr>
    <td>����</td>
    <td><textarea name="memo" maxB="300"></textarea></td>
    <td>���״̬</td>
    <td><select name="equip_status"></select>
	<script language="javascript">dict_list("equip_status","equip_status","","name");</script>
    </td>
  </tr>
  <tr>
    <td>״̬����</td>
    <td colspan="3"><input name="status_date" type="text" size="10" readonly maxlength="10" dataType="Date"> <img  onClick="openCalendar(status_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
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
<!--��ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
<script language="javascript">
</script>
</form>

<!-- end cwMain -->
</body>
</html>
<%db.close();%>