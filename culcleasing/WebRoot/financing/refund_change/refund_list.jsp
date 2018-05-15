<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资还款计划变更</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数drawings_id,doc_id
String drawings_id = getStr( request.getParameter("drawings_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if( drawings_id==null || "".equals(drawings_id) ){
	drawings_id = "120316SDBBG0303";
	doc_id = "95BFC1F97E54D891482579C3001F465822";
}
//1.判断temp表数据jsp
sqlstr="select * from financing_refund_plan_temp where doc_id='"+doc_id+"' and drawings_id='"+drawings_id+"'";
//2.没有则插入
rs=db.executeQuery(sqlstr);
if(rs.next()==false){
	sqlstr="Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
	sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
	sqlstr+= "refund_subtotal,refund_status,remark)";
	sqlstr+="select '"+doc_id+"',drawings_id,refund_list,refund_plan_date, refund_rate,refund_corpus,refund_interest,"+
		"refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status,remark from financing_refund_plan where drawings_id='"+drawings_id+"'";
		System.out.println("没有插入"+sqlstr);
		db.executeUpdate(sqlstr);
}

//导出类型2--数据导出
String expsqlstr = "select refund_list 期数,refund_plan_date 还款日期,refund_corpus 还本金额,refund_interest 付息金额,refund_money 本息合计,"+
 "refund_otherfee_money 其他费用金额,refund_otherfee_type 其他费用类别,refund_subtotal 本次还款总计,remark 备注 from financing_refund_plan_temp where 1=1 and doc_id='"+doc_id+"' and drawings_id='"+drawings_id+"'";
 
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="fund_exec_list.jsp" name="dataNav" onSubmit="return goPage()">
<!-- 还款计划制定 -->
<div style="margin-top: 10px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	还款计划变更&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="refund_plan" style="margin-top: 10px;">
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="40%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			<td>
			<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
			<input name="excel_name" type="hidden" value="refund_list">
			
			<a href="#" accesskey="n" onclick="return validata_data_report('../../func/exp_report.jsp','refund_list.jsp');">
		    <img align="absmiddle"  src="../../images/action_down.gif" alt="导出" align="absmiddle">导出还款计划</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		
			<td>
			<a href="#" accesskey="n" onClick="uploadNewRefund()">
		    <img align="absmiddle"  src="../../images/action_up.gif" alt="导入" align="absmiddle">上传还款计划</a></td>
	    </tr>
	</table>
	<!--操作按钮结束-->
	</td>
	
	<td align="right" width="60%"><!--翻页控制开始-->
	</td>		 	
	<!--翻页控制结束-->	
 </tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>期数</th>
     <th>还款日期</th>
     <th>还本金额</th>
     <th>付息金额</th>
     <th>本息合计</th>
     <th>其他费用金额</th>
     <th>其他费用类别</th>
     <th>本次还款总计</th>
     <th>备注</th>
   </tr>
   <tbody id="data">
<%

String col_str="refund_plan_id,refund_list,refund_plan_date,refund_rate,refund_corpus";
col_str += ",refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,remark";

sqlstr = "select "+col_str+" from financing_refund_plan_temp where drawings_id='"+drawings_id+"' and doc_id='"+doc_id+"' order by refund_list";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("refund_list")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("refund_plan_date")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_corpus")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_interest")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_money")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_otherfee_money")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("refund_otherfee_type")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_subtotal")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     </tr>
<%}
db.close();
%>     
	</tbody>
</table>
</div>
</div>
</div><!-- 结束还款计划div -->
</form>
</body>

<script type="text/javascript">

//点击上传还款计划
function uploadNewRefund(){
	window.open("refund_upload.jsp?drawings_id=<%=drawings_id %>&doc_id=<%=doc_id %>");
}
</script>

</html>
