<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.service.FundChargeOperationService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划修订</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
//点击新增资金计划
function updFund(){
	//判断是否有选中
	var priId = $(":input[name='itemselect']:checked").val();
	if(	priId==undefined || priId==""){
		alert("请选择本次需修订的资金计划！");
	}else{
		document.updForm.submit();
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
//先将 未核销的资金计划、付款前提 拷贝到临时表操作 商务方案修订
FundChargeOperationService.initContractFundDataSWFAXD(contract_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="paycond_qrxd.jsp" name="updForm" method="post">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- 资金计划数据 -->
<div style="margin-top: 20px;">



<div id="fund_plan" style="margin-top: 10px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- 新增资金计划 -->
			<BUTTON class="btn_2" type="button" onclick="updFund();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="新增(Alt+N)">&nbsp;参与修订</button>
				<input name="contract_id" type="hidden" value="<%=contract_id %>">
				<input name="doc_id" type="hidden" value="<%=doc_id %>">
				<input name="updType" type="hidden" value="qrxd">
		</td>
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:300px;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
	 <th width="1%"></th>
     <th>合同编号</th>
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
     <th>备注</th>
   </tr>
   <tbody id="data">
<%
String col_str="make_contract_id,id,payment_id,doc_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_bank_name,plan_bank_name,plan_bank_no,pay_way,fpnote";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and oth_remark is null and isnull(flag,0) <>1 order by fee_type_name,fee_num";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
	    <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") ) %>"/></td>
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
</body>
</html>
<%if(null != db){db.close();}%>