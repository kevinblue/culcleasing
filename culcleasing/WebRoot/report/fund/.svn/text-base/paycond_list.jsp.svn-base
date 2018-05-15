<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.service.FundChargeOperationService"%>

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
String payment_id = getStr( request.getParameter("payment_id") );

%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 资金付款前提 -->
<div style="margin-top: 50px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	资金付款前提&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="fund_qt" style="margin-top: 10px;">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项内容</th>
     <th>序号</th>
     <th>款项名称</th>
     <th>收支时间</th>
     <th>币种</th>
     <th>付款金额</th>
     <th>付款前提</th>
   
   </tr>
   <tbody>
<%
String col_str_2="payment_id,contract_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_way,fpnote";

sqlstr = "select "+col_str_2+" from vi_contract_fund_fund_charge_plan where pay_way='付款' and payment_id='"+payment_id+"'";

rs = db.executeQuery(sqlstr);
int flag = 0;
if ( rs.next() ) {
	flag = 1;
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
				partSql += " as title,status from contract_fund_fund_charge_condition pffcct where payment_id='"+payment_id+"' ";
				ResultSet rs1 = db1.executeQuery(partSql);
				if(rs1.next()){
					rs1.beforeFirst();
     		%>
     		<!-- 嵌套table -->
     		<table border="0" cellpadding="0" cellspacing="0">
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
     		</table>
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

<%
if(flag==0){
col_str_2="payment_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_way,fpnote";

sqlstr = "select "+col_str_2+" from vi_proj_fund_fund_charge_plan where pay_way='付款' and payment_id='"+payment_id+"'";

rs = db.executeQuery(sqlstr);
if ( rs.next() ) {
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
				partSql += " as title,status from proj_fund_fund_charge_condition pffcct where payment_id='"+payment_id+"' ";
				ResultSet rs1 = db1.executeQuery(partSql);
				if(rs1.next()){
					rs1.beforeFirst();
     		%>
     		<!-- 嵌套table -->
     		<table border="0" cellpadding="0" cellspacing="0">
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
     		</table>
   			<%
			}else{
   			%>
   			无付款前提
   			<%} %>
     	</td>
     </tr>
<%}}
rs.close();
db.close();
%>     

     </tbody>
</table>
</div>
</div>

</div><!-- 结束资金付款前提div -->

</body>
</html>
<%if(null != db1){db1.close();}%>