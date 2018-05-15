<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保费修订</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

//点击新增资金计划
function addNew(){
	document.addNewFundForm.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id
String contract_id = getStr( request.getParameter("contract_id") );
String insur_type = getStr( request.getParameter("insur_type") );
String insur_start_date=getStr( request.getParameter("insur_start_date") );
String insur_end_date=getStr( request.getParameter("insur_end_date") );

//模拟赋值
if( contract_id==null || "".equals(contract_id) ){
	contract_id="11D0111387_01";
}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- 保费计划数据 -->
<div style="margin-top: 20px;">
<div id="fund_plan" style="margin-top: 10px;">

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>款项名称</th>
     <th>收/付款人</th>
     <th>收/付款人银行</th>
     <th>收/付款人账号</th>
     <th>收/支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>计划收/付开户银行</th>
     <th>计划收/付银行账号</th>
     <th>结算方式</th>
     <th>收/支备注</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_bxf where contract_id='"+contract_id+"' order by id";

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
     	<a href='bfxd_upd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该保费计划？")){
					window.open('bfxd_save.jsp?type=del&item_id='+obj );
				}
			}
		</script>
	  <!--  <a href="Javascript: delItem('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>-->
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</div><!-- 结束资金计划div -->
</body>
</html>
