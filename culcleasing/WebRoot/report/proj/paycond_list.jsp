<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

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

System.out.print("ccccccccccccccccc"+ contract_id);

//ģ�⸳ֵ
if("".equals(contract_id)){
	contract_id = "CULC_0022_T001";

}

%>

<body>
	   		
<div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
				��:�ʽ��ո���Ϣ&nbsp;
				<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
							style="cursor:hand" title="��ʾ/��������">				 
</div>

					
<div>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��ͬ���</th>
	 <th>���ʽ</th>
     <th>��������</th>
     <th>���</th>
     <th>��������</th>
     <th>��/������</th>
     <th>��/�����˿�������</th>
     <th>��/�����������˺�</th>
     <th>��/֧ʱ��</th>
     <th>����</th>
     <th>��/������</th>
     <th>�ƻ���/����������</th>
     <th>�ƻ���/�������˺�</th>
     <th>���㷽ʽ</th>
	 <th>״̬</th>
	 <th>Ʊ������</th>
     <th>��ע</th>
   </tr>
  
<%
String col_str="id,payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,make_contract_id,plan_status,tax_type_invoice";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' order by id";

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
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_no")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("plan_status")) %></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
     </tr>
<%}
rs.close();
%>     


<tr id="tabletit">
<td>&nbsp;  
	�ʽ𸶿�ǰ��&nbsp;
	</td>
</tr> 


   <tr class="maintab_content_table_title">
     <th colspan="3">��������</th>
     <th colspan="2">���</th>
     <th colspan="2">��������</th>
     <th colspan="2">��֧ʱ��</th>
     <th colspan="2">����</th>
     <th colspan="3">������</th>
     <th colspan="3">����ǰ��</th>
   </tr>

<%
String col_str_2="payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where pay_way='����' and contract_id='"+contract_id+"' order by id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td  colspan="3" align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td  colspan="2" align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td  colspan="2" align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td  colspan="2" align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td  colspan="2" align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td  colspan="3" align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td  colspan="3" align="left">
     		<%
     		String partSql = "select (select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')";
				partSql += " as title,status from contract_fund_fund_charge_condition_temp pffcct where  payment_id='"+rs.getString("payment_id")+"' ";
				ResultSet rs1 = db1.executeQuery(partSql);
				if(rs1.next()){
					rs1.beforeFirst();
     		%>
     		
     		
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
     		
   			<%
			}else{
   			%>
   			�޸���ǰ��
   			<%} %>
     	</td>
     </tr>
<%}
rs.close();
%>     
     
</table>
</div>


</div>
</body>
</html>
