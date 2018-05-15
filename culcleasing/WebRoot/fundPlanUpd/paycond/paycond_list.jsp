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
//��������ʽ�ƻ�
function addNewFund(){
	document.addNewFundForm.submit();
}
//�޶�
function updFund(){
	document.updForm.submit();
}
</script>
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
	contract_id = "CULC_0022_T001";
	doc_id = "990088shjshd454545";
}
//�Ƚ� δ�������ʽ�ƻ�������ǰ�� ��������ʱ������ ���񷽰��޶�
FundChargeOperationService.initContractFundDataSWFAXD(contract_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

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
				<input name="contract_id" type="hidden" value="<%=contract_id %>">
				<input name="doc_id" type="hidden" value="<%=doc_id %>">
			</form>
		</td>
		<td>
			<!-- �޶��ʽ�ƻ� -->
			<BUTTON class="btn_2" type="button" onclick="updFund();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="����(Alt+N)">&nbsp;�޶��ʽ�ƻ�</button>
			<form action="paycond_xd.jsp" name="updForm" method="post" target="_blank">
				<input name="contract_id" type="hidden" value="<%=contract_id %>">
				<input name="doc_id" type="hidden" value="<%=doc_id %>">
			</form>
		</td>
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:300px;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��ͬ���</th>
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
	 <th>����</th>
     <th>��ע</th>
     <th>����</th>
   </tr>
   <tbody id="data">
<%
String col_str="make_contract_id,id,payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_bank_name,plan_bank_name,plan_bank_no,pay_way,fpnote,oth_remark";

sqlstr = "select "+col_str+",(select top 1 account  from  vi_cust_account where acc_number=vi_contract_fund_fund_charge_plan_temp.pay_bank_no) pay_account  from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and oth_remark in (1,2) order by fee_type_name,fee_num";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("make_contract_id")) %></td>
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
		<td align="left">
		<%if(rs.getInt("oth_remark")==1){%>
		����
		<%}else if(rs.getInt("oth_remark")==2){%>
		�޶�
		<%}%>
		</td>
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
     	<td align="left">
     	<a href='paycond_updFund.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
     	
		<%if(rs.getInt("oth_remark")==1){%>
		|
	    <script type="text/javascript">
			function delItem1(obj){
				if( confirm("ȷ��ɾ�����ʽ�ƻ����üƻ�����ǰ�᣿") ){
					window.open('paycond_fundSave.jsp?type=del&doc_id=<%=doc_id %>&item_id='+obj);
				}
			}
		</script>
	    <a href="Javascript: delItem1('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">ɾ��</a>
	  
		<%}else if(rs.getInt("oth_remark")==2){%>
		|
	    <script type="text/javascript">
			function delItem(obj){
				if( confirm("ȷ���ݲ��޶����ʽ�ƻ����üƻ�����ǰ�᣿") ){
					window.open('paycond_qrxd.jsp?updType=zbxd&itemselect='+obj);
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">�ݲ��޶�</a>
	  <%}%>
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
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
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
String col_str_2="payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_way,fpnote";

sqlstr = "select "+col_str_2+" from vi_contract_fund_fund_charge_plan_temp where pay_way='����' and contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and oth_remark in (1,2)  order by payment_id";

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
				partSql += " as title,status,id,remark from contract_fund_fund_charge_condition_temp pffcct where doc_id='"+doc_id+"' and payment_id='"+rs.getString("payment_id")+"' ";
				ResultSet rs1 = db1.executeQuery(partSql);
				if(rs1.next()){
					rs1.beforeFirst();
     		%>
     		<!-- Ƕ��table -->
     		<table border="0" cellpadding="0" cellspacing="0">
     			<tr>
     				<th>��������</th>
     				<th>״̬</th>
     				<th>��ע</th>
					<th>����</th>
     			</tr>
     			<tr><td colspan="100"><%=partSql %></td></tr>
     			<%
	 				while(rs1.next()){ %>
						<tr>
							<td><%=getDBStr(rs1.getString("title")) %></td>
							<td><%=getDBStr(rs1.getString("status")) %></td>
							<td><%=getDBStr(rs1.getString("remark")) %></td>
							<td><a href='cffcct_updShow.jsp?id=<%=getDBStr(rs1.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">���ӱ�ע</a></td>
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