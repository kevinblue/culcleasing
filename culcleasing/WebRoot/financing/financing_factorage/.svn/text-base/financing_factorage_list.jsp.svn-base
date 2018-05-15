<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>手续费维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

//点击新增资金计划
function addNew(){
	document.addNewFundForm.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id
String drawings_id = getStr( request.getParameter("drawings_id") );
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- 保费计划数据 -->
<div style="margin-top: 0px;">
<div id="fund_plan" style="margin-top: 10px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- 新增保费计划 -->
			<BUTTON class="btn_2" type="button" onclick="addNew();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="新增(Alt+N)">&nbsp;新增手续费</button>
			<form action="factorage_add.jsp" name="addNewFundForm" method="post" target="_blank">
				<input name="drawings_id" type="hidden" value="<%=drawings_id %>">
			</form>
		</td>
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>手续费类型</th>
     <th>手续费金额</th>
     <th>币种</th>
     <th>支付方式</th>
     <th>手续费日期</th>
     <th>操作人</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="*,(select name from base_user where id=financing_drawings_factorage.modifactor) modifactor_name ";

sqlstr = "select "+col_str+" from financing_drawings_factorage where drawings_id='"+drawings_id+"' order by drawings_id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("factorage_type")) %></td>
     	<td align="center"><%=CurrencyUtil.convertFinance(rs.getString("factorage_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_paytype")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_date")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("modifactor_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("factorage_remark")) %></td>
     	
     	<td align="center">
		<%
		if(rs.getString("doc_id")==null){
		%>
     	<a href='factorage_upd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	|
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该手续费？")){
					window.open('factorage_save.jsp?type=del&item_id='+obj );
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>
		<%}else{%>
			<a href='factorage_upd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	   		<img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
		<%}%>
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
</body>
</html>
<%if(null != db){db.close();}%>