<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("insurance-info-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���չ��� - �����嵥</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/validator.js"></script>
</head>
<%

	String czid = getStr( request.getParameter("czid") );
String sqlstr = "select info.contract_id,info.equip_sn,views.engine_code,info.insurance_date,views.insurance_enddate,views.cust_name,views.insurer,info.insurance_no,views.leas_mode operation_way,views.equip_amt,views.income_number,views.insurance,views.lsh_insurance,views.cust_insurance,views.insurance_flag,info.give_insurance,views.insurance_type,info.insurance_account,info.get_date,info.pay_date,info.pay_no,views.sale_name,info.is_special,info.check_info,info.claims_note,info.finallyclaims_money,info.surrender_note,info.surrender_object,info.surrender_money,info.note from insurance_info info left join  contract_view views on views.contract_id = info.contract_id left join insurance_claims claims on views.contract_id = claims.contract_id where info.insurance_id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr); 
	String	contract_id = "";
	String	equip_sn = "";
	String	engine_code = "";
	String	insurance_date = "";
	String	insurance_enddate = "";
	String	cust_name = "";
	String	insurer = "";
	String	insurance_no = "";
	String	operation_way = "";
	String	equip_amt = "";
	String	income_number = "";
	String	insurance = "";
	String	lsh_insurance = "";
	String	cust_insurance = "";
	String	insurance_flag = "";
	String	give_insurance = "";
	String	insurance_type = "";
	String	insurance_account = "";
	String	get_date = "";
	String	pay_date = "";
	String	pay_no = "";
	String	sale_name = "";
	String	is_special = "";
	String	check_info = "";
	String	claims_note = "";
	String	finallyclaims_money = "";
	String	surrender_note = "";
	String	surrender_object = "";
	String	surrender_money = "";
	String	note = "";
if ( rs.next() ) {
		contract_id = getDBStr( rs.getString("contract_id") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		engine_code = getDBStr( rs.getString("engine_code") );
		insurance_date = getDBDateStr( rs.getString("insurance_date") );
		insurance_enddate = getDBDateStr( rs.getString("insurance_enddate") );
		cust_name = getDBStr( rs.getString("cust_name") );
		insurer = getDBStr( rs.getString("insurer") );
		insurance_no = getDBStr( rs.getString("insurance_no") );
		operation_way = getDBStr( rs.getString("operation_way") );
		equip_amt = formatNumberStr( rs.getString("equip_amt") ,"#,##0.00" );
		income_number = getDBStr( rs.getString("income_number") );
		insurance = formatNumberStr( rs.getString("insurance") ,"#,##0.00" );
		lsh_insurance = formatNumberStr( rs.getString("lsh_insurance"),"#,##0.00"  );
		cust_insurance = formatNumberStr( rs.getString("cust_insurance"),"#,##0.00"  );
		insurance_flag = getDBStr( rs.getString("insurance_flag") );
		give_insurance = formatNumberStr( rs.getString("give_insurance"),"#,##0.00"  );
		insurance_type = getDBStr( rs.getString("insurance_type") );
		insurance_account = getDBStr( rs.getString("insurance_account") );
		get_date = getDBDateStr( rs.getString("get_date") );
		pay_date = getDBDateStr( rs.getString("pay_date") );
		pay_no = getDBStr( rs.getString("pay_no") );
		sale_name = getDBStr( rs.getString("sale_name") );
		is_special = getDBStr( rs.getString("is_special") );
		check_info = getDBStr( rs.getString("check_info") );
		claims_note = getDBStr( rs.getString("claims_note") );
		finallyclaims_money = formatNumberStr( rs.getString("finallyclaims_money"),"#,##0.00"  );
		surrender_note = getDBStr( rs.getString("surrender_note") );
		surrender_object = getDBStr( rs.getString("surrender_object") );
		surrender_money = formatNumberStr( rs.getString("surrender_money") ,"#,##0.00" );
		note = getDBStr( rs.getString("note") );
	}
	rs.close(); 
	db.close();
%>

<body onLoad="fun_winMax();">
<form name="form1" method="post" action="insurance_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
���չ��� &gt; �����嵥
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	  <td>
		<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">ɾ��</button>
	  	<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
		</td>
	  </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ϸ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>�����</td>
    <td><input name="equip_sn" type="text" size="20" maxB="50" readonly value="<%= equip_sn %>"></td>
    <td>��������</td>
    <td><input name="engine_code" type="text" size="20" maxB="50" readonly  value="<%= engine_code %>"></td>
    <td>Ͷ������</td>
    <td><input name="insurance_date" type="text" size="20" maxB="50" readonly dataType="Date"  value="<%= insurance_date %>"></td>
  </tr>
  <tr>
    <td>������ֹ����</td>
    <td><input name="insurance_enddate" type="text" size="20" maxB="50" readonly dataType="Date" value="<%= insurance_enddate %>"></td>
    <td>�ͻ���</td>
    <td><input name="cust_name" type="text" size="20" maxB="50" readonly value="<%= cust_name %>"></td>
    <td>���չ�˾</td>
    <td><input name="insurer" type="text" size="20" maxB="50" readonly value="<%= insurer %>"></td>
  </tr>
  <tr>
    <td>���յ���</td>
    <td><input name="insurance_no" type="text" size="20" maxB="50" readonly value="<%= insurance_no %>"></td>
    <td>������ʽ</td>
    <td><input name="operation_way" type="text" size="20" maxB="50" readonly value="<%= operation_way %>"></td>
    <td>����</td>
    <td><input name="equip_amt" type="text" size="20" maxB="50" readonly value="<%= equip_amt %>"></td>
  </tr>
  <tr>
    <td>����</td>
    <td><input name="income_number" type="text" size="20" maxB="50" readonly value="<%= income_number %>"></td>
    <td>���շ��ܶ�</td>
    <td><input name="insurance" type="text" size="20" maxB="50" readonly value="<%= insurance %>"></td>
    <td>������֧������(LSH)</td>
    <td><input name="lsh_insurance" type="text" size="20" maxB="50" readonly value="<%= lsh_insurance %>"></td>
  </tr>
  <tr>
    <td>���ʹ�˾���ͱ���(HS/CCI)</td>
    <td><input name="give_insurance" type="text" size="20" maxB="50" readonly value="<%= give_insurance %>"></td>
    <td>�ͻ��ֽ�֧������(�ͻ�)</td>
    <td><input name="cust_insurance" type="text" size="20" maxB="50" readonly value="<%= cust_insurance %>"></td>
    <td>���շ��Ƿ�����</td>
    <td><input name="insurance_flag" type="text" size="20" maxB="50" readonly value="<%= insurance_flag %>"> </td>
  </tr>
  <tr>
    <td>����</td>
    <td><input name="insurance_type" type="text" size="40" maxB="50" readonly value="<%= insurance_type %>"></td>
    <td>�����˻�</td>
    <td><input name="insurance_account" type="text" size="20" maxB="50" readonly value="<%= insurance_account %>"></td>
    <td>�ձ�������</td>
    <td><input name="get_date" type="text" size="20" maxB="50" readonly dataType="Date" value="<%= get_date %>"></td>
  </tr>
  <tr>
    <td>����������</td>
    <td><input name="pay_date" type="text" size="20" maxB="50" readonly dataType="Date" value="<%= pay_date %>"></td>
    <td>������</td>
    <td><input name="pay_no" type="text" size="20" maxB="50" readonly value="<%= pay_no %>"></td>
    <td>�ֹ�˾</td>
    <td><input name="sale_name" type="text" size="20" maxB="50" readonly value="<%= sale_name %>"></td>
  </tr>
  <tr>
    <td>�Ƿ����������</td>
    <td><input name="is_special" type="text" size="20" maxB="50" readonly value="<%= is_special %>"></td>
    <td>������Ϣ</td>
    <td><input name="check_info" type="text" size="20" maxB="50" readonly value="<%= check_info %>"></td>
    <td>����������־</td>
    <td><input name="claims_note" type="text" size="20" maxB="50" readonly value="<%= claims_note %>"></td>
  </tr>
  <tr>
    <td>�˱�����</td>
    <td><input name="surrender_object" type="text" size="20" maxB="50" readonly value="<%= surrender_object %>"></td>
    <td>�����⸶���</td>
    <td><input name="finallyclaims_money" type="text" size="20" maxB="50" readonly dataType="Money" value="<%= finallyclaims_money %>"></td>
    <td>�˱���־</td>
    <td><input name="surrender_note" type="text" size="20" maxB="50" readonly value="<%= surrender_note %>"></td>
  </tr>
  <tr>
    <td>�˱����</td>
    <td><input name="surrender_money" type="text" size="20" maxB="50" readonly dataType="Money" value="<%= surrender_money %>"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>��ע</td>
    <td colspan="3"><input name="note" type="text" size="20" maxB="50" readonly value="<%= claims_note %>"></td>
  </tr>
</table>
<br>
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
