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
//提取参数proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if("".equals(proj_id)){
	proj_id = "CULCTest022";
	doc_id = "JS999999900";
}

String state =request.getParameter("state");
if("0".equals(state)){
	response.sendRedirect("../../flowReadZQ/paycond_read/paycond_list.jsp?proj_id="+proj_id+"&doc_id="+doc_id);
}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 资金计划数据 -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	资金计划&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;height:50%;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>款项名称</th>
     <th>收/付款人</th>
     <th>收/付款人开户名称</th>
     <th>收/付款人开户银行</th>
     <th>收/付款人银行账号</th>
     <th>收/支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>计划收/付开户银行</th>
     <th>计划收/付银行账号</th>
     <th>结算方式</th>
     <th>备注</th>
	 <th>备注</th>
   </tr>
   <tbody id="data">
<%
String col_str="id,payment_id,measure_id,proj_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote";

sqlstr = "select "+col_str+",(select top 1 account  from  vi_cust_account where acc_number=vi_proj_fund_fund_charge_plan_temp.pay_bank_no) pay_account  from vi_proj_fund_fund_charge_plan_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by id";

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
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
		<td align="left"><a href="ssss">ss</a></td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>

</div><!-- 结束资金计划div -->

<!-- 资金付款前提 -->
<div style="margin-top: 50px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	资金付款前提&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项内容</th>
     <th>序号</th>
     <th>款项名称</th>
     <th>收支时间</th>
     <th>币种</th>
     <th>付款金额</th>
     <th>付款前提</th>
	 <th>操作</th>
   </tr>
   <tbody>
<%
String col_str_2="payment_id,measure_id,proj_id,pay_type_name,fee_type_name,fee_num,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_proj_fund_fund_charge_plan_temp where pay_way='付款' and proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by payment_id";

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
		<td align="center">
     	<a href='paycond_addFundCond.jsp?doc_id=<%=doc_id %>&item_id=<%=getDBStr(rs.getString("payment_id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">设置</a>
     	</td>

     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>

</div><!-- 结束资金付款前提div -->

</body>
</html>
<%if(null != db){db.close();}%><%if(null != db1){db1.close();}%>