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

<script type="text/javascript">
//����Զ������ʽ�ƻ�
function autoIn(){
	if(confirm("�Զ������ʽ�ƻ��������ԭ�����ݣ��Ƿ�ȷ��ִ�У�")){
		document.autoInFund.submit();
		return true;
	}else{
		return false;
	}
}
//��������ʽ�ƻ�
function addNewFund(){
	document.addNewFundForm.submit();
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
//ģ�⸳ֵ
if( proj_id==null || "".equals(proj_id) ){
	proj_id = "CULCTest022";
	doc_id = "JS9999999000_11";
	cust_id = "00007";
}
//�ȳ�ʼ��������Ŀ�����嵥
FundChargeOperationService.flowInitTableData(proj_id, doc_id);
//00007-03-02-2010-00162-00000
//F54FA93C6C6E0F0B4825780300334D18
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- �Զ����ɡ��������ɰ�ť -->
<div style="margin-top: 10px;text-align: left;">
	<button name="btnAutoIn" type="button" onclick="return autoIn();">
	<img src="../../images/btn_rename.gif" align="bottom" border="0">�Զ�/���������ʽ�ƻ�</button>
	<form action="autoInserFund.jsp" name="autoInFund" method="post" target="_blank">
		<input name="proj_id" type="hidden" value="<%=proj_id %>">
		<input name="doc_id" type="hidden" value="<%=doc_id %>">
		<input name="cust_id" type="hidden" value="<%=cust_id %>">
	</form>
</div><!-- ��ť������� -->

<!-- �ʽ�ƻ����� -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	�ʽ�ƻ�&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div id="fund_plan" style="margin-top: 10px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- �����ʽ�ƻ� -->
			<BUTTON class="btn_2" type="button" onclick="addNewFund();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="����(Alt+N)">&nbsp;�����ʽ�ƻ�</button>
			<form action="paycond_addfund.jsp" name="addNewFundForm" method="post" target="_blank">
				<input name="proj_id" type="hidden" value="<%=proj_id %>">
				<input name="doc_id" type="hidden" value="<%=doc_id %>">
				<input name="cust_id" type="hidden" value="<%=cust_id %>">
			</form>
		</td>
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>���ʽ</th>
     <th>��������</th>
     <th>���</th>
     <th>��������</th>
     <th>��/������</th>
     <th>��/����������</th>
     <th>��/�������˺�</th>
     <th>��/֧ʱ��</th>
     <th>����</th>
     <th>��/������</th>
     <th>�ƻ���/����������</th>
     <th>�ƻ���/�������˺�</th>
     <th>���㷽ʽ</th>
     <th>��/֧��ע</th>
     <th>����</th>
   </tr>
   <tbody id="data">
<%
String col_str="id,payment_id,measure_id,proj_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_proj_fund_fund_charge_plan_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("pay_way")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_obj_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_no")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
     	<td align="center">
     	<a href='paycond_updFund.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
     	|
     	<!-- ɾ����� -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("ȷ��ɾ�����ʽ�ƻ����üƻ�����ǰ�᣿")){
					window.open('paycond_fundSave.jsp?type=del&doc_id=<%=doc_id %>&item_id='+obj );
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">ɾ��</a>
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</div><!-- �����ʽ�ƻ�div -->

<!-- �ʽ𸶿�ǰ�� -->
<div style="margin-top: 50px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	�ʽ𸶿�ǰ��&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div id="fund_qt" style="margin-top: 10px;">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��������</th>
     <th>���</th>
     <th>��������</th>
     <th>��֧ʱ��</th>
     <th>����</th>
     <th>������</th>
     <th>����ǰ��</th>
     <th>����</th>
   </tr>
   <tbody>
<%
String col_str_2="payment_id,measure_id,proj_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_proj_fund_fund_charge_plan_temp where pay_way='����' and proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by payment_id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="left">
     	
     		<%
				String partSql = "select (select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')";
 				partSql += " as title,status from proj_fund_fund_charge_condition_temp pffcct where doc_id='"+doc_id+"' and payment_id='"+rs.getString("payment_id")+"' ";
 				ResultSet rs1 = db1.executeQuery(partSql);
				if(rs1.next()){
					rs1.beforeFirst();
     		%>
     		<!-- Ƕ��table -->
     		<table border="0" cellpadding="0" cellspacing="0">
     			<tr>
     				<th>��������</th>
     				<th>״̬</th>
     			</tr>
     			<%
	 				while(rs1.next()){ %>
						<tr>
							<td><%=getDBStr(rs1.getString("title")) %></td>
							<td><%=getDBStr(rs1.getString("status")) %></td>
						</tr>
				<%	}%>
     		</table>
   			<%
			}else{
   			%>
   			�޸���ǰ��
   			<%} %>
     	</td>
     	<td align="center">
     	<a href='paycond_addFundCond.jsp?doc_id=<%=doc_id %>&item_id=<%=getDBStr(rs.getString("payment_id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">����</a>
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>

</div><!-- �����ʽ𸶿�ǰ��div -->

</body>
</html>
<%if(null != db){db.close();}%><%if(null != db1){db1.close();}%>