<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>还款类型 - 融资基础信息管理</title>
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
String czid=getDBStr(request.getParameter("czid"));
 %>
<body onLoad="public_onload(0)">

<form action="baseconfig.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			融资基础信息管理&gt;还款类型</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->



<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <td nowrap>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </td>

		
		<!-- 翻页控制 -->
		<td align="right" width="100%" nowrap>
		<%
		
			sqlstr = "Select financing_config_refundtype.*,dbo.GETUSERNAME(financing_config_refundtype.creator) as oper_name,financing_config_loantype.loan_name from financing_config_refundtype left join financing_config_loantype on financing_config_loantype.code=financing_config_refundtype.loan_code where loan_code="+czid+" order by id asc"; 
			LogWriter.logDebug(request, "输出sql:"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
	
</table>
<input type="hidden" name="czid" value="<%=czid %>">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     
     <th>还款方式编号</th>
     <th>还款方式名称</th>
     <th>贷款方式</th>
     <th>最后更新日期</th>
     <th>操作员</th>
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
	  <td align="center"><%=getDBStr(rs.getString("code"))%></td>
	  <td align="center"><%=getDBStr(rs.getString("refund_name"))%></td>
      <td align="center"><%=getDBStr(rs.getString("loan_name"))%></td>
      <td align="center"><%=getDBDateStr(rs.getString("modify_date"))%></td>
      <td align="center"><%=getDBStr(rs.getString("oper_name"))%></td>
    </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>

</form>
</body>
</html>
