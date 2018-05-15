<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.service.FundChargeOperationService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ�ƻ�/����ǰ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����contract_id,proj_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//ģ�⸳ֵ
if(contract_id==null || "".equals(contract_id)){
	contract_id = "11CULC010403L82";
	doc_id = "990088shjshd4545452222";
}

//�Ƚ� δ�������ʽ�ƻ� ��������ʱ�����
FundChargeOperationService.initContractFundDataZJJHSB(contract_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- �ʽ�ƻ����� -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	�ʽ�ƻ�&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div id="fund_plan" style="margin-top: 10px;">

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>���ʽ</th>
     <th>��������</th>
     <th>���</th>
     <th>��������</th>
     <th>��/������</th>
     <th>��/�����˿�������</th>
	 <th>��/����������</th>
     <th>��/�������˺�</th>
     <th>��/֧ʱ��</th>
     <th>����</th>
     <th>��/������</th>
     <th>�ƻ���/����������</th>
     <th>�ƻ���/�������˺�</th>
     <th>���㷽ʽ</th>
	 <th>�Ƿ����ϱ�</th>
     <th>��ע</th>

   </tr>
   <tbody>
<%
String col_str="id,payment_id,contract_id,doc_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_bank_name,plan_bank_name,plan_bank_no,pay_way,fpnote,is_sb";

sqlstr = "select "+col_str+",(select top 1 account  from  vi_cust_account where acc_number=vi_contract_fund_fund_charge_plan_temp.pay_bank_no) pay_account from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by pay_way";
//sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where 1=1 order by payment_id";
System.out.println("ceshi ======"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("pay_way")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_obj_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_account")) %></td>
		<td align="left"><%=getDBStr(rs.getString("pay_bank_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_no")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
		<td align="center"><%=getDBStr(rs.getString("is_sb")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
     	
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</div><!-- �����ʽ�ƻ�div -->



<!-- �ʽ����ۼƻ� -->
<div style="margin-top: 50px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	�ʽ�����&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div id="fund_qt" style="margin-top: 10px;">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��������</th>
     <th>���</th>
     <th>��������</th>
     <th>֧����ʽ</th>
     <th>���ۿ���</th>
    
   </tr>
   <tbody>
<% 
String col_str_2="payment_id,doc_id,contract_id,fee_type_name,fee_num,fee_name,pay_type_name,[dbo].[GetFundZKName_T](payment_id,doc_id) as zk_fee_name";
sqlstr = "select "+col_str_2+" from vi_contract_fund_fund_charge_plan_temp where pay_type_name='ֱ������' and contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by payment_id";
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("zk_fee_name")) %></td>
	
		
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>

</div><!-- �ʽ����ۼƻ� -->

</body>
</html>
<%if(null != db){db.close();}%>