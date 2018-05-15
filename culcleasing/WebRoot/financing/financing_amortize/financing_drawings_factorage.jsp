<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>摊销手续费明细</title>
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
//提取参数drawings_id
String drawings_id = getStr( request.getParameter("drawings_id") );
%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 提款费用摊销表 -->
<div style="margin-top: 10px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	摊销手续费明细&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<div id="refund_plan" style="margin-top: 10px;">
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="40%">
	<!--操作按钮开始-->
	<!-- <table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td>
				<BUTTON class="btn_2" type="button" onclick="uploadNewRefund();">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0" alt="上传(AltU)">&nbsp;上传摊销明细</BUTTON>
			</td>
	    </tr>
	</table> -->
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
     <th>提款标号</th>
     <th>手续费类型</th>
     <th>手续费金额</th>
     <th>手续费支付方式</th>
     <th>备注</th>
     <th>创建人</th>
     <th>创建时间</th>
   </tr>
   <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select "+col_str+" from financing_drawings_factorage where 1 = 1 and drawings_id ='"+drawings_id+"'  order by id ";
System.out.println("test="+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("drawings_id")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_type")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("factorage_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_paytype")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_remark")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("creator")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("create_date")) %></td>
     </tr>
<%}
db.close();
%>     
	</tbody>
</table>
</div>
</div>
</div><!-- 结束摊销明细div -->

</body>

<script type="text/javascript">
//点击上传分摊明细
<%-- function uploadNewRefund(){
	window.open("amortize_upload.jsp?drawings_id=<%=drawings_id %>");
} --%>
</script>

</html>
