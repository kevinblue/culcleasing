<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>预测现金流列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	
	//市场现金流
	sqlstr = " select plan_date,follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow";
	sqlstr +=" from fund_proj_plan_mark_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by plan_date"; 
	System.out.println("合同现金流 -- sqlstr查询sql语句==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
%>
 
<body  onload="public_onload(0);">

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th>期项</th>
	    <th>日期</th>
		<th>流入量</th>
		<th>流入量清单11</th>
		<th>流出量</th>
		<th>流出量清单</th>
		<th>净流量</th>   
      </tr>
<%	  
	int i = 1;
	while(rs.next()) {
%>
      <tr>
		<td nowrap align="center"><%=i%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("plan_date")).substring(0,7)%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_in")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_in_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_out")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_out_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("net_follow")),"#,##0.00")%></td>		
      </tr>
<%
		i++;
	}
rs.close(); 
db.close();
%>
	 <tr>
	  	<td nowrap align="left" colspan="7">
	  	<font color="red">
	  		项目编号为:<%=proj_id%>&nbsp;|&nbsp;文档编号为:<%=doc_id%>&nbsp;
	  	</font>
	  	</td>
	 </tr>
   </table>
</div>
</div>

</body>
</html>
