<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划/保证金返还</title>
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
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
//模拟赋值
if(contract_id==null || "".equals(contract_id)){
	contract_id = "11CULC010403L82";
	doc_id = "CAE731715EA5E0D74825794F0016A66D";
	cust_id = "00007";
}

sqlstr="select id from contract_fund_fund_charge_plan_temp where contract_id='"+ contract_id + "' and doc_id='" + doc_id + "'";
rs=db.executeQuery(sqlstr);
if(rs.next()==false){

sqlstr="insert into contract_fund_fund_charge_plan_temp(payment_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,"+
		"plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,"+
		"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)"+
		"select payment_id,contract_id,'"+ doc_id+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,"+
		"plan_money,currency,pay_obj,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date"+
		" from contract_fund_fund_charge_plan where contract_id='" + contract_id + "' and plan_status='未核销' and fee_type in(30,23)";
db.executeUpdate(sqlstr);
System.out.println("输出sqlstr》》》》》》"+sqlstr);

}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	资金计划&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="fund_plan" style="margin-top: 10px;">

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
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
     <th>备注</th>
	 <th>状态</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="id,payment_id,doc_id,contract_id,pay_type_name,fee_type,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,plan_status";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";

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
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>

		<td align="left"><%=getDBStr(rs.getString("plan_status")) %></td>


     	<td align="center">
     	<a href='paycond_updFund.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
		</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
<!-- 结束资金计划div -->

</body>
</html>
<%if(null != db){db.close();}%>