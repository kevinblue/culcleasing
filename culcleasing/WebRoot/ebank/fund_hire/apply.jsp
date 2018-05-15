<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<%@ include file="../../func/common_simple.jsp"%>
<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>��ϸ - �����ʽ��տ�</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<body onload="public_onload(0);">
<form name="dataNav" method="post" action="apply.jsp">

<div id="bgDiv">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle">
	��ϸ - �����ʽ��տ�
	</td>
</tr>
<tr valign="top">
<td  align=center width=90% height=100%>
<table align=center width=90%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
  <tr>
	<td>
	<BUTTON class="btn_2" name="btnReset" value="�ر�" onclick="window.close();">
	<img src="../../images/hg.gif" align="absmiddle" border="0">�ر�</button>
	</td>
   </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="90%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">��ϸ��Ϣ</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="90%" height="2"></td></tr>
</table>


<center>
<script language="javascript">
ShowTabN(0);
</script>

<div id="divH" class="tabBody" style="background:#ffffff;width:90%;height:80%;overflow:auto;">
<div id="TD_tab_0">

<%
String sqlstr="";
ResultSet rs = null;
String czid = getStr( request.getParameter("czid") );

sqlstr =" select ai.*,bp.pay_type_name,subiter=dbo.GETUSERNAME(ai.creator) from apply_info ai ";
sqlstr+=" left join base_paytype bp on ai.pay_method=bp.pay_type_code where ai.glide_id='"+czid+"'";

String glide_id="";
String pay_method="";
String plan_date="";
String amt="";
String amount="";
String subiter = "";

rs=db.executeQuery(sqlstr); 
if (rs.next()) { 
	glide_id=getDBStr(rs.getString("glide_id"));
	subiter=getDBStr(rs.getString("subiter"));
	pay_method=getDBStr(rs.getString("pay_type_name"));
	
	plan_date=getDBDateStr(rs.getString("plan_date"));
	amt=CurrencyUtil.convertFinance(rs.getString("amt"));
	amount=CurrencyUtil.convertIntAmount(rs.getString("amount"));
}
%>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td scope="row">�տ��:&nbsp;&nbsp;<b style="color:#E46344;"><%=glide_id %></b></td>
    <td>&nbsp;</td>
	<td scope="row">�ύ��:&nbsp;&nbsp;<b style="color:#E46344;"><%=subiter %></b></td>
    <td>&nbsp;</td>
    <td scope="row">Ӧ������:&nbsp;&nbsp;<b style="color:#E46344;"><%=plan_date %></b></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td scope="row">�տ���:&nbsp;&nbsp;<b style="color:#E46344;"><%=amt %></b></td>
    <td>&nbsp;</td>
	<td scope="row">����:&nbsp;&nbsp;<b style="color:#E46344;"><%=amount %></b></td>
    <td>&nbsp; </td>
	<td scope="row"></td>
    <td>&nbsp; </td>
  </tr>
</table>

<!-- ����start -->
<div style="vertical-align:top;width:98%;overflow:auto;position: relative;" id="mydiv">				
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
	<tr class="maintab_content_table_title">
		 <th>��Ŀ����</th>
		 <th>��ͬ���</th>
		 <th>���ʽ</th>
	     <th>��������</th>
	     <th>���</th>
	     <th>������</th>
	     <th>�������˺�</th>
	     <th>�տ�����</th>
	     <th>����</th>
	     <th>�տ���</th>
	     <th>�ƻ��տ������</th>
	     <th>�ƻ��տ������˺�</th>
	     <th>��ע</th>
	</tr>
<tbody id="data">
<%
sqlstr = "select vefh.* from vi_ebank_fund_hire_detail vefh where vefh.id in( select plan_id from apply_info_detail where apply_id='"+czid+"' )order by contract_id";

rs = db.executeQuery(sqlstr); 
while (rs.next()){
%>
<tr>
	<td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>

	<td align="center"><%=getDBStr(rs.getString("pay_way")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("pay_obj_name")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("pay_bank_no")) %></td>
   	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
   	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
</tr>		
<%	} %>
</tbody>
</table>

</div>
</div>
</div>
<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�

ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

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
<%
rs.close(); 
db.close();
%>
</form>
<!-- end cwMain -->
</body>
</html>
