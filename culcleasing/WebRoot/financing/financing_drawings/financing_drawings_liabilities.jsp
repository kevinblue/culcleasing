<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ page import="com.tenwa.culc.financing.util.FinancingReportUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>带息负债类别查询表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function onSumbit(){
	var dollar_currency_rate = document.getElementById("dollar_currency_rate").value;
	var hongKong_dollar_rate = document.getElementById("hongKong_dollar_rate").value;
	var rmb_rate = document.getElementById("rmb_rate").value;
	if(isNaN(dollar_currency_rate)){
		alert("美元汇率必须是数字！");
		return false;
	}
	if(isNaN(hongKong_dollar_rate)){
		alert("港元汇率必须是数字！");
		return false;
	}
	if(isNaN(rmb_rate)){
		alert("人民币汇率必须是数字！");
		return false;
	} 
	dataNav.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="financing_drawings_liabilities.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		带息负债类别查询表
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";

//本页查询参数
String drawings_date_end = getStr( request.getParameter("drawings_date_end") );
if(drawings_date_end==null || "".equals(drawings_date_end)){
	drawings_date_end=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
}
String dollar_currency_rate = getStr( request.getParameter("dollar_currency_rate") );
double dollar_currency_rate_d =1d;
try{
	dollar_currency_rate_d = Double.valueOf(dollar_currency_rate).doubleValue();
}
catch(Exception e){
	dollar_currency_rate_d =1d;
}
String hongKong_dollar_rate = getStr( request.getParameter("hongKong_dollar_rate") );
double hongKong_dollar_rate_d =1d;
try{
	hongKong_dollar_rate_d = Double.valueOf(hongKong_dollar_rate).doubleValue();
}
catch(Exception e){
	hongKong_dollar_rate_d =1d;
}
String rmb_rate = getStr( request.getParameter("rmb_rate") );
double rmb_rate_d =1d;
try{
	rmb_rate_d = Double.valueOf(rmb_rate).doubleValue();
}
catch(Exception e){
	rmb_rate_d =1d;
}

String leftCorpusFlag = getStr( request.getParameter("leftCorpusFlag") );
if("否".equals(leftCorpusFlag)){
	wherestr +=" and drawings_id in (select de.drawings_id from (select drawings_id ,isnull(SUM(refund_corpus),0) as sum_refund_corpus from financing_refund_plan where refund_plan_date > '"+drawings_date_end+"' group by drawings_id ) de where de.sum_refund_corpus <> 0 )";
	wherestr +=" and drawings_date <= '"+drawings_date_end+"' ";
}//时间判断
if("是".equals(leftCorpusFlag)){
	wherestr +=" and ( drawings_id not in (select de.drawings_id from (select drawings_id ,isnull(SUM(refund_corpus),0) as sum_refund_corpus from financing_refund_plan where refund_plan_date > '"+drawings_date_end+"' group by drawings_id ) de where de.sum_refund_corpus <> 0 ) ";
	wherestr +=" or drawings_date > '"+drawings_date_end+"' ) ";
}

countSql = "select count(id) as amount from vi_financing_drawings_detail where 1=1 "+wherestr;
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td scope="row">查询时间：
 <input type="text" id="drawings_date_end" name="drawings_date_end"
	 readonly="readonly" 
	value="<%=drawings_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
<td scope="row">
	美元汇率：<input type="text" id="dollar_currency_rate" name="dollar_currency_rate" value="<%=dollar_currency_rate %>" />
</td>
<td scope="row">
	港元汇率：<input type="text" id="hongKong_dollar_rate" name="hongKong_dollar_rate" value="<%=hongKong_dollar_rate %>" />
</td>
<td scope="row">
	人民币汇率：<input type="text" id="rmb_rate" name="rmb_rate" value="<%=rmb_rate %>" />
</td>
<td scope="row">剩余本金（原币）是否为0：
		<select name="leftCorpusFlag" style="width: 116">
    	<script type="text/javascript">
     	w(mSetOpt('<%=leftCorpusFlag%>',"|是|否","|是|否"));
    	</script>
		 </select>
	</td>
<td>
<input type="button" value="查询" onclick="onSumbit();">
&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->
		<input name="excel_name" type="hidden" value="financing_drawings_liabilities">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_liabilities.jsp','financing_drawings_liabilities.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	<th>查询时间</th>
      	<th>提款日期</th>
	    <th>提款编号</th>
		<th>授信单位</th>
		<th>贷款类型</th>
		<th>提款金额（原币）</th>
		<th>已还金额（原币）</th>
		<th>剩余本金（原币）</th>
		
		<th>即期剩余本金（原币）</th>
		<th>非即期剩余本金（原币）</th>
		
        <th>币种</th>
        <th>汇率</th>
        <th>剩余本金（人民币）</th>
        
        <th>即期剩余本金（人民币）</th>
		<th>非即期剩余本金（人民币）</th>
        
		<th>费用未摊销余额（人民币）</th>
		
		<th>即期费用未摊销余额（人民币）</th>
		<th>非即期费用未摊余额（人民币）</th>
		
        <th>带息负债余额</th>
        <th>即期带息负债</th>
        <th>非即期带息负债</th>
        <th>当前利率</th>
        <th>表内外分类</th>
        <th>贷款类别</th>
        <th>质押情况</th>
        <th>担保情况</th>   
        <th>境内外分类</th>
        <th>融资方式</th>
        <th>利率类型</th>
        <th>期限类型</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_financing_drawings_detail where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ) "+wherestr ;
sqlstr += " order by crediter,id ";
%>
 <%-- <tr><td colspan="100"><%=sqlstr %></td></tr>  --%>
<% 
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	String drawings_id=rs.getString("drawings_id");
%>
      <tr>
        <td align="center"><%=drawings_date_end %></td>
        <%
        	boolean flag =true;
        	String drawings_date =rs.getString("drawings_date");
        	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
        	java.util.Date drawings_date_end_date = df.parse(drawings_date_end);
        	java.util.Date drawings_date_date = df.parse(drawings_date);
        	if(drawings_date_end_date.before(drawings_date_date)){
        		flag=false;
        	}
        %>
        <td align="center"><%=getDBDateStr( drawings_date) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_type")) %></td>
		<%String drawings_money=rs.getString("drawings_money" );  %>
		<td align="center"><%= CurrencyUtil.convertFinance( drawings_money) %></td>
		<%
		double drawingsLeftCorpus =0.00d;
		double drawingsLeftCorpusSightAmount=0.00d;
		double drawingsLeftCorpusNoSightAmount=0.00d; 
			if(flag){
		%>
		<td align="center"><%=CurrencyUtil.convertFinance(FinancingReportUtil.getDrawingsRefundCorpus(drawings_id,drawings_date_end)) %></td>
		<%drawingsLeftCorpus = FinancingReportUtil.getDrawingsLeftCorpus(drawings_id,drawings_date_end); %>
		<td align="center"><%=CurrencyUtil.convertFinance(drawingsLeftCorpus) %></td>
		<%drawingsLeftCorpusSightAmount = FinancingReportUtil.getDrawingsLeftSightAmount(drawings_id, drawings_date_end); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftCorpusSightAmount) %></td>
		<%drawingsLeftCorpusNoSightAmount = FinancingReportUtil.getDrawingsLeftNoSightAmount(drawings_id, drawings_date_end); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftCorpusNoSightAmount) %></td>
		<%
			}else{
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
			}
		%>
		<td align="center"><%=getDBStr( rs.getString("currency")) %></td>
		<td align="center">
		<%
			String currency = getDBStr( rs.getString("currency"));
			double rate=1d;
			double rmbRate = 1d;
			if("人民币".equals(currency)){
				rate=rmb_rate_d;
				//rmbRate = FinancingReportUtil.getCurrentRate(drawings_id ,drawings_date_end);
			}
			if("美元".equals(currency)){
				rate=dollar_currency_rate_d;
			}
			if("港币".equals(currency)){
				rate=hongKong_dollar_rate_d;
			}
			%><%=rate %><%
		%>
		</td>
		
		<%
			if(flag){
		%>
		<%double drawingsLeftRMB = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpus,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMB) %></td>
		<%double drawingsLeftRMBSightAmount = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpusSightAmount,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBSightAmount) %></td>
		<%double drawingsLeftRMBNoSightAmount = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpusNoSightAmount,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBNoSightAmount) %></td>
		<%double nonAmortizationRMB = FinancingReportUtil.getNonAmortizationRMB(drawings_id,drawings_date_end,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( nonAmortizationRMB) %></td>
		<%double nonAmortizationRMBSightAmount = FinancingReportUtil.getNonAmortizationRMBSightAmount(drawings_id,drawings_date_end,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( nonAmortizationRMBSightAmount) %></td>
		<%double nonAmortizationRMBNoSightAmount = FinancingReportUtil.getNonAmortizationRMBNoSightAmount(drawings_id,drawings_date_end,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( nonAmortizationRMBNoSightAmount) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMB-nonAmortizationRMB) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBSightAmount-nonAmortizationRMBSightAmount) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBNoSightAmount-nonAmortizationRMBNoSightAmount) %></td>
		<% 
			}else{
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
			}
		%>
		<td align="center"><%=rmbRate %></td>
		<td align="center"><%=getDBStr( rs.getString("Table_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("loan_category")) %></td>
		<td align="center"><%=getDBStr( rs.getString("pawn_condition")) %></td>
        <td align="center"><%=getDBStr( rs.getString("assurer_condition")) %></td>
        <td align="center"><%=getDBStr( rs.getString("Abroad_domestic")) %></td>
        <td align="center"><%=getDBStr( rs.getString("Financing_Method")) %></td>
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_type")) %></td>
        <td align="center"><%=getDBStr( rs.getString("drawings_time_type")) %></td>	
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
