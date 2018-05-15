<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="/public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>财务接口 -本金计税（增值税）</title>
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
 
	 String oper_id = getStr( request.getParameter("oper_id") );


%>
<body onload="public_onload(0);">

<form action="global_bjjs_details.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		财务接口&gt; 本金计税（增值税）</td>
	</tr>
	<input type="hidden" name="oper_id" value="<%=oper_id%>">
</table>
<!--标题结束-->

<%
wherestr = "";
if ( oper_id!=null && !"".equals(oper_id) ) {
	wherestr += " and oper_id = '" + oper_id + "'";
}

countSql = "Select count(id) as amount from FI_ERP_DATA_SYNC_INFO_NC where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->
	
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
		<th>操作日志Id</th>
        <th>主表id</th>
        <th>单据类型</th>
        <th>成功或者失败原因</th>
        <th>创建时间</th>      
      </tr>
      <tbody id="data">
<%
String col_str=" id,pri_id,para_2,case when CAST(para_5 AS VARCHAR ) = '0' then '成功' else para_5 end para_5,oper_id,create_date";

sqlstr = "select top "+ intPageSize +" "+col_str+" from FI_ERP_DATA_SYNC_INFO_NC where 1=1 and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from FI_ERP_DATA_SYNC_INFO_NC where 1=1 "+wherestr+" order by create_date desc,id ) "+wherestr ;
sqlstr += " order by create_date desc,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%=getDBStr( rs.getString("oper_id")) %></td>			
		<td align="center"><%=getDBStr( rs.getString("pri_id") )  %></td>		
		<td align="center"><%=getDBStr( rs.getString("para_2")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("para_5")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("create_date")) %></td>					
		
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
