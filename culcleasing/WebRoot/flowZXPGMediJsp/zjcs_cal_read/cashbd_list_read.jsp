<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保底现金流列表</title>
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
	sqlstr = " select * from fund_cash_medi_bd";
	sqlstr +=" where proj_id='"+proj_id+"' order by id"; 
	rs = db.executeQuery(sqlstr);
%>

<body  onload="public_onload(0);">

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<BUTTON class="btn_2" type="button" onclick="updData();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="上传(Alt+N)">&nbsp;上传保底现金流</button>
		</td>
		<td align="right" width="90%">
		</td>
	</tr>
</table>

<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th>期项</th>
	    <th>月份</th>
		<th>结算日</th>
		<th>净流量</th>   
      </tr>
<%	  
	int i = 1;
	while(rs.next()) {
%>
      <tr>
		<td nowrap align="center"><%=i%></td>
		<td align="center"><%=getDBStr(rs.getString("bd_month"))%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("bd_hire_date"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("cash_money")),"#,##0.00")%></td>		
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
<script type="text/javascript">
function updData(){
	window.open("cash_upload.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>&type=bd");
}
</script>
</html>
