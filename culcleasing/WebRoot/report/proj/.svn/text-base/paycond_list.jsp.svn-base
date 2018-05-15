<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划/付款前提</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id,proj_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );

System.out.print("ccccccccccccccccc"+ contract_id);

//模拟赋值
if("".equals(contract_id)){
	contract_id = "CULC_0022_T001";

}

%>

<body>
	   		
<div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
				四:资金收付信息&nbsp;
				<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
							style="cursor:hand" title="显示/隐藏内容">				 
</div>

					
<div>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>合同编号</th>
	 <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>款项名称</th>
     <th>收/付款人</th>
     <th>收/付款人开户银行</th>
     <th>收/付款人银行账号</th>
     <th>收/支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>计划收/付开户银行</th>
     <th>计划收/付银行账号</th>
     <th>结算方式</th>
	 <th>状态</th>
	 <th>票据类型</th>
     <th>备注</th>
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
	资金付款前提&nbsp;
	</td>
</tr> 


   <tr class="maintab_content_table_title">
     <th colspan="3">款项内容</th>
     <th colspan="2">序号</th>
     <th colspan="2">款项名称</th>
     <th colspan="2">收支时间</th>
     <th colspan="2">币种</th>
     <th colspan="3">付款金额</th>
     <th colspan="3">付款前提</th>
   </tr>

<%
String col_str_2="payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where pay_way='付款' and contract_id='"+contract_id+"' order by id";

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
     				<th>付款条件</th>
     				<th>状态</th>
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
   			无付款前提
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
