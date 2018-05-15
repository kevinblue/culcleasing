<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金偿还计划</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
	//租金计划
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));//合同编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号

	

	//查询租金本金利息的三个分别得总合
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	
	String query_count = "";
	query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan_temp where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	
	rs = db.executeQuery(query_count);
	if(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}
	rs.close();
 %>
 
<body onload="public_onload(0);">

<form action="plan_bank_upsave.jsp" name="form1" onSubmit="return goPage()">
<input type="hidden" name="begin_id" value="<%=begin_id%>">
<input type="hidden" name="doc_id" value="<%=doc_id%>">
	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
	<!--可折叠查询开始-->
	<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;批量修改
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
	</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>从:&nbsp;<input name="start_list"  type="text" size="13" ></td>
	<td>到:&nbsp;<input name="end_list"  type="text" size="13" ></td>
	<td scope="row" id="bj_4">计划收款银行账号修改为:</td>
    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" style="width: 100">
		    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)" >
			
   </td>
		    <td scope="row" id="bj_3">计划收款开户银行修改为:</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" style="width: 100" >
   </td>
   <td>
	<input type="button" value="确定" onclick="form1.submit();">
	&nbsp;&nbsp;
	<input type="button" value="清空" onclick="clearQuery();" >
	</td>
	</tr>
	</table>
	</fieldset>
	</div>
	<!--可折叠查询结束-->
	
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" 
	cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>期项</th>
		<th>应收日期</th>
        <th>租金</th>
        <th>本金</th>
        <th>利息</th>
        <th>状态</th>
        <th>本金余额</th>      
        <th>计划收款银行</th>      
        <th>计划收款账号</th>   
		<th>操作</th>
      </tr>
<%	  
	//---查询租金计划--
	sqlstr = "select id,rent_list,plan_date,rent,plan_status,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no from fund_rent_plan_temp ";
	sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' order by rent_list";
	LogWriter.logDebug(request, "起租 - 租金计划 -- sqlstr查询sql语句==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
	while(rs.next()) {
%>
      <tr class="maintab_content_table_title">
		<td><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td> 
		<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("rent")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("interest")) %></td> 
		<td><%=getDBStr(rs.getString("plan_status")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus_overage")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_name")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_no")) %></td> 
		<td>
		<%
		if(getDBStr(rs.getString("plan_status")).equals("未回笼")){
		%><a href='fund_rentUpd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
		<%}else{%>
		无操作
		<%}%>
		</td> 
      </tr>
<%
	}
db.close();
%>
	<tr class="maintab_content_table_title" > 
		<td colspan="">&nbsp;</td>
		<td colspan="">&nbsp;</td>
		<td colspan="">合计:<%=formatNumberStr( count_rent,"#,##0.00") %></td>
		<td colspan="">合计:<%=formatNumberStr( count_corpus,"#,##0.00") %></td>
		<td colspan="">合计:<%=formatNumberStr( count_interest,"#,##0.00") %></td>
		<td colspan="">&nbsp;</td>
	</tr>
   </table>
</div>
</div>
</form>
</body>
</html>
