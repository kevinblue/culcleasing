<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�׸������ - DownpaymentList</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="/tenwa/js/publicEvent.js"></script>
<script src="/dict/js/js_dictionary.js"></script>


</head>
<body onLoad="fun_winMax();">
<form name="form1" method="post" action="downpayment_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�׸������ &gt; DownpaymentList
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
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
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
    <td>�����</td>
    <td><input name="equip_sn" type="text"  size="20" maxB="50" readonly Require="true"><input type="hidden" name="contract_id"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','�����',  'downpayment_view','equip_sn','contract_id|device_type|cust_name|leas_mode|stock_place|sale_name|peroid_payment|factmoney|fact_info|equals|insurance_flag|insurance|csa_cost|VouchNo','equip_sn','','','form1.equip_sn','form1.contract_id|form1.device_type|form1.cust_name|form1.leas_mode|form1.stock_place|form1.sale_name|form1.peroid_payment|form1.factmoney|form1.fact_info|form1.equals|form1.insurance_flag|form1.insurance|form1.csa_cost|form1.VouchNo');">
	<span class="biTian">*</span></td>
    <td>����</td>
    <td><input name="device_type" type="text" size="20" maxB="50" readonly></td>
    <td>�ͻ�����</td>
    <td><input name="cust_name" type="text" size="20" maxB="50"  readonly> </td>
   </tr>
   <tr>
    <td>����ģʽ</td>
    <td><input name="leas_mode" type="text" size="20" maxB="50" readonly></td>
    <td>���</td>
    <td><input name="stock_place" type="text" size="20" maxB="50" readonly></td>
    <td>�ֹ�˾</td>
    <td><input name="sale_name" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>�����׸��ܶ�</td>
    <td><input name="peroid_payment" type="text" size="20" maxB="50" readonly></td>
    <td>ʵ�ս��</td>
    <td><input name="factmoney" type="text" size="20" maxB="50" readonly ></td>
    <td>ʵ�����</td>
    <td><input name="fact_info" type="text" size="20" maxB="500" readonly></td>
  </tr>
  <tr>
    <td>�׸����</td>
    <td><input name="equals"  type="text" size="15" maxlength="10" readonly>
    <td>�Ƿ�������</td>
    <td><input name="insurance_flag" type="text" size="20" maxB="50" readonly></td>
    <td>���ս��</td>
    <td><input name="insurance" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>CSA</td>
    <td><input name="csa_cost"  type="text" size="15" maxlength="10" readonly>
     <td>VouchNo</td>
    <td><input name="VouchNo" type="text" size="20" maxB="50" readonly></td>
    <td></td>
    <td></td>
    
  </tr>
   <tr>
    <td>��ע</td>
    <td colspan="3"><textarea name="remark" cols="20" rows="5" maxb="100" style="width:536px"></textarea></td><td></td><td></td>
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
