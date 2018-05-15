<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保费资金计划</title>
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
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if( contract_id==null || "".equals(contract_id) ){
	contract_id = "12CULC071481L28";
	doc_id = "JS999999900";
}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 保险计划数据 -->
<div style="margin-top: 0px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	保险计划&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="fund_plan" style="margin-top: 10px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
		</td>
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" 
	class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>合同编号</th>
     <th>险种</th>
     <th>投保支付周期</th>
     <th>投保金额</th>
     <th>投保期限</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select "+col_str+" from contract_insur_info where contract_id='"+contract_id+"' order by id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("insur_type")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("insur_period")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("insur_money")) %></td>
     	<td align="left"><%=CurrencyUtil.convertIntAmount(rs.getString("insur_indate")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("insur_remark")) %></td>
     	<td align="center">
     	<!-- 自动生成 -->
	    <script type="text/javascript">
			function autoItem(obj1,obj2){
				if(confirm("自动生成会清除原先生成的保费计划，是否确认执行？")){
					window.open('autoInserFund.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&item1='+obj1+"&item2="+obj2 );
				}
			}
		</script>
	    <a href="Javascript: autoItem('<%=getDBStr(rs.getString("insur_money"))%>','<%=getDBStr(rs.getString("insur_indate"))%>')">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">自动生成保费计划</a>
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

<!-- 资金付款前提 -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	保费计划&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="fund_qt" style="margin-top: 10px;">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
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
     <th>备注</th>
     <th>操作</th>
   </tr>
  <tbody>
<%
sqlstr = "select * from vi_contract_fund_fund_charge_plan_bxf_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by id";

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
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
     	<td align="center">
     	<a href='paycond_updFund.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	|
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该资金计划？")){
					window.open('paycond_fundSave.jsp?type=del&doc_id=<%=doc_id %>&item_id='+obj );
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>
     	</td>
     </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</div>

</div><!-- 结束保费计划 -->

</body>
</html>
