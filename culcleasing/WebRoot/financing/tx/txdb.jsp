<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息前后对比</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<body onload="public_onload(0);">
<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;margin-left: 10px;">
    <tr>
        <td style="color:#E46344;font-size: 16px;font-weight: bold">调息前后对比</td>
    </tr>
</table>
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;"  id="mydiv">
<%
	String drawings_id = getStr(request.getParameter("drawings_id"));
	String txid = getStr(request.getParameter("txid"));
	
	String sqlstr = "";
	ResultSet rs = null;
	
	String start_date="";
	String rent_list_start="";
	String before_rate="";
	String after_rate="";
	String adjust_type="";
	
	sqlstr = " Select faic.id,faic.drawings_id,faic.adjust_flag,faic.adjust_type,";
	sqlstr+= " faic.before_rate,faic.after_rate,faic.rent_list_start,fsi.start_date";
	sqlstr+= " from financing_adjust_interest_drawings faic";
	sqlstr+= " left join fund_standard_interest fsi on faic.adjust_id=fsi.id";
	sqlstr+= " Where faic.adjust_id='"+txid+"' and faic.drawings_id='"+drawings_id+"'";
	
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		start_date=getDBDateStr(rs.getString("start_date"));
		rent_list_start=getDBStr(rs.getString("rent_list_start"));
		before_rate=getDBStr(rs.getString("before_rate"));
		after_rate=getDBStr(rs.getString("after_rate"));
		adjust_type=getDBStr(rs.getString("adjust_type"));
	}rs.close();
%>

<form name="list">
	<table align="center" width="100%">
	  <tr><td colspan="2">
		<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
		  <tr height="2%">
			  <td width="50%">调息日期：<%=start_date%></td>
			  <td>调息开始期次：<%=rent_list_start%></td>
		  </tr>
		  <tr height="2%">
			  <td>调息前利率：<%=before_rate%></td>
			  <td>调息后利率：<%=after_rate%></td>
		  </tr>
		  <tr height="2%">
			  <td><a href="tx_record.jsp?drawings_id=<%=drawings_id %>" target="_blank">调息记录</a></td>
			  <td>调息方式：<%=adjust_type%></td>
		  </tr>
		  <tr height="2%">
			  <td>调息前偿还计划</td>
			  <td>调息后偿还计划</td>
		  </tr>
		</table>
		</td>
	  </tr>		
	  
      <tr>
		  <!-- $$$$$$$$$$$$$$- 调息前偿还计划 -$$$$$$$$$$$$$$ -->
		  <td width="50%">
		  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
		  class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>是否核销</th>
					<th>计划日期</th>
					<th>本息小计</th>
					<th>本金</th>
					<th>租息</th>
				  </tr>
				  <tbody id="data">
				  <%
				  	sqlstr="select * from financing_refund_plan_his where tx_id='"+txid+"' and drawings_id='"+drawings_id+"' and mod_status='前' and mod_reason='调息' order by refund_list";	  
				  	rs = db.executeQuery(sqlstr);
				  	while (rs.next()) {
				  %>
				  <tr class="cwDLRow" >
					<td><%=getDBStr(rs.getString("refund_list"))%></td>
					<td align="left"><%=getDBStr(rs.getString("refund_status"))%></td>
					<td align="left"><%=getDBDateStr(rs.getString("refund_plan_date"))%></td>
					<%--  <td align="left"><%=CurrencyUtil.formatNumberSix(rs.getString("year_rate"))%></td> --%>
					<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_money"))%></td>
					<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_corpus"))%></td>
					<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_interest"))%></td>
				  </tr>
				  <%}
				  	rs.close();
				  %>
				  </tbody>
			  </table>
		  </td>
		
		  <!-- $$$$$$$$$$$$$$- 调息后偿还计划 -$$$$$$$$$$$$$$ -->
		  <td width="50%">
		  	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
		  		class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>是否核销</th>
					<th>计划日期</th>
					<th>本息小计</th>
					<th>本金</th>
					<th>租息</th>
				  </tr>
				  <tbody id="data">
				  <%
				  	sqlstr="select * from financing_refund_plan_his where tx_id='"+txid+"' and drawings_id='"+drawings_id+"' and mod_status='后' and mod_reason='调息' order by refund_list";	  
				  	rs = db.executeQuery(sqlstr);
				  	while (rs.next()) {
				  %>
				  <tr class="cwDLRow" >
					<td><%=getDBStr(rs.getString("refund_list"))%></td>
					<td align="left"><%=getDBStr(rs.getString("refund_status"))%></td>
					<td align="left"><%=getDBDateStr(rs.getString("refund_plan_date"))%></td>
					<%--  <td align="left"><%=CurrencyUtil.formatNumberSix(rs.getString("year_rate"))%></td> --%>
					<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_money"))%></td>
					<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_corpus"))%></td>
					<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_interest"))%></td>
				  </tr>
				  <%
				  	}
				  	db.close();
				  %>
				  </tbody>
			  </table>
		  </td>
      </tr>
    </table>
</form>
</div>
</body>
</html>
