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
//点击自动生成资金计划
function autoIn(){
	if(confirm("自动生成资金计划，将清除原先数据，是否确认执行？")){
		document.autoInFund.submit();
		return true;
	}else{
		return false;
	}
}
//点击新增资金计划
function addNewFund(){
	document.addNewFundForm.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id,proj_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
//模拟赋值
if( contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
	LogWriter.logDebug(request, "contract_id:"+contract_id);
	proj_id = "CULCTest022";
	doc_id = "JS999999900_HT11";
	cust_id = "00007";
}

//初始化签约审批合同数据
FundChargeOperationService.flowInitContractApproveData(contract_id, proj_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- 自动生成、重新生成按钮 -->
<div style="margin-top: 10px;text-align: left;">
	<button name="btnAutoIn" type="button" onclick="return autoIn();">
	<img src="../../images/btn_rename.gif" align="bottom" border="0">自动/重新生成资金计划</button>
	<form action="autoInserFund.jsp" name="autoInFund" method="post" target="_blank">
		<input name="contract_id" type="hidden" value="<%=contract_id %>">
		<input name="doc_id" type="hidden" value="<%=doc_id %>">
		<input name="cust_id" type="hidden" value="<%=cust_id %>">
	</form>
</div><!-- 按钮区域结束 -->

<!-- 资金计划数据 -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	资金计划&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="fund_plan" style="margin-top: 10px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- 新增资金计划 -->
			<BUTTON class="btn_2" type="button" onclick="addNewFund();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="新增(Alt+N)">&nbsp;新增资金计划</button>
			<form action="paycond_addfund.jsp" name="addNewFundForm" method="post" target="_blank">
				<input name="contract_id" type="hidden" value="<%=contract_id %>">
				<input name="doc_id" type="hidden" value="<%=doc_id %>">
				<input name="cust_id" type="hidden" value="<%=cust_id %>">
			</form>
		</td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;">
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
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="id,payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,plan_status,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,make_contract_id";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by id";

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
     	<td align="center"><%=getDBStr(rs.getString("plan_status")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
     	<td>
     	<a href='paycond_updFund.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该资金计划及该计划付款前提？")){
					window.open('paycond_fundSave.jsp?type=del&doc_id=<%=doc_id %>&item_id='+obj );
				}
			}
		</script>
		<%
			if(getDBStr(rs.getString("plan_status")).equals("已核销")){
		 %>
		 |
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("payment_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>
	    <%} %>
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
<div style="margin-top: 50px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	资金付款前提&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="fund_qt" style="margin-top: 10px;">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;">
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
String col_str_2="payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where pay_way='付款' and contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by id";

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
				partSql += " as title,status from contract_fund_fund_charge_condition_temp pffcct where doc_id='"+doc_id+"' and payment_id='"+rs.getString("payment_id")+"' ";
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
</div>

</div><!-- 结束资金付款前提div -->

</body>
</html>
<%if(null != db){db.close();}%><%if(null != db1){db1.close();}%>