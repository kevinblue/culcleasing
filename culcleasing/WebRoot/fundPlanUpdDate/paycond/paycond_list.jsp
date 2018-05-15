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
<script type="text/javascript">
//提交保存资料状态
function deleteFundSave(){
	if(confirm("确认此次暂不上报该资金计划？")){
		dataNav.action="paycond_fundSave_bat.jsp";
		dataNav.target="_blank"
		dataNav.submit();
		dataNav.action="paycond_list.jsp";
		dataNav.target="_self"
	}
} 
//是否全选
function SelectAll(){

	var checkboxs=document.getElementsByName("list");
	var all=document.getElementsByName("all");
	all.checked=!all.checked;
	for (var i=0;i<checkboxs.length;i++) {
		var e=checkboxs[i];
		e.checked=!e.checked;
	}
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id,proj_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if(contract_id==null || "".equals(contract_id)){
	contract_id = "11CULC010403L82";
	doc_id = "990088shjshd4545452222";
}

//先将 未核销的资金计划 拷贝到临时表操作
FundChargeOperationService.initContractFundDataZJJHSB(contract_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="paycond_list.jsp" name="dataNav"  method="post">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<!-- 资金计划数据 -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	资金计划&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">	
	<input type="button" value="暂不上报" onclick="return deleteFundSave();">
</div> 

<div id="fund_plan" style="margin-top: 10px;">

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th align="center"><input type="checkbox" name="all" id="all" style="border:0px;" onclick="SelectAll()">全/反选</th>
     <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>款项名称</th>
     <th>收/付款人</th>
     <th>收/付款人开户名称</th>
	 <th>收/付款人银行</th>
     <th>收/付款人账号</th>
     <th>收/支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>计划收/付开户银行</th>
     <th>计划收/付银行账号</th>
     <th>结算方式</th>
     <th>是否已上报</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody>
<% 
String col_str="id,payment_id,contract_id,doc_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_bank_name,plan_bank_name,plan_bank_no,pay_way,is_sb,fpnote";

sqlstr = "select "+col_str+",(select top 1 account  from  vi_cust_account where acc_number=vi_contract_fund_fund_charge_plan_temp.pay_bank_no) pay_account  from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by pay_way";
//sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where 1=1 order by payment_id";
System.out.println("ceshi ======"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("payment_id"))%>"></td>
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
     	<td align="center">
     	<a href='paycond_updFund.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
		|
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认此次暂不上报该资金计划？")){
					window.open('paycond_fundSave.jsp?type=del&doc_id=<%=doc_id %>&item_id='+obj );
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">暂不上报</a>
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
</form>


<!-- 资金作扣计划 -->
<div style="margin-top: 50px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	资金坐扣&nbsp;
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
     <th>支付方式</th>
     <th>作扣款项</th>
     <th>操作</th>
   </tr>
   <tbody>
<% 
String col_str_2="payment_id,doc_id,contract_id,fee_type_name,fee_num,fee_name,pay_type_name,[dbo].[GetFundZKName_T](payment_id,doc_id) as zk_fee_name";
sqlstr = "select "+col_str_2+" from vi_contract_fund_fund_charge_plan_temp where pay_type_name='直接坐扣' and contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by payment_id";
rs = db.executeQuery(sqlstr);
System.out.println("sssssssss"+sqlstr);
while ( rs.next() ) {
	
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("zk_fee_name")) %></td>
	
		<td align="center">
     	<a href='paycond_addFundCond.jsp?doc_id=<%=doc_id %>&item_id=<%=getDBStr(rs.getString("payment_id"))%>&contract_id=<%=getDBStr(rs.getString("contract_id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">设置</a>
		|
     	 <script type="text/javascript">
			function delItem1(obj){
				if(confirm("确认取消坐扣关系？")){
					window.open('paycond_QX.jsp?item_id='+obj+'&doc_id=<%=doc_id %>&');
				}
			}
		</script>
	    <a href="Javascript: delItem1('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">取消坐扣关系</a>
     	</td>
     </tr>
<%}
rs.close();
%></tbody>
</table>
</div>
</div>

</div><!-- 资金作扣计划 -->

</body>
</html>
<%if(null != db){db.close();}%>