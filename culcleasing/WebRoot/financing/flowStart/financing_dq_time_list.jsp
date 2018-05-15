<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>掉期时间信息</title>
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
//提取参数change_id
String doc_id = getStr( request.getParameter("doc_id") );
String drawings_id = getStr( request.getParameter("drawings_id") );
String isEdit = getStr( request.getParameter("isEdit") );
System.out.println("isEdit=="+isEdit);
//模拟赋值
if( doc_id==null || "".equals(doc_id) ){
	doc_id = "2014";
}

%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 掉期时间信息 -->
<div style="margin-top: 10px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	掉期时间信息&nbsp;
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
		    <% if("0".equals(isEdit)){ %>
				<BUTTON class="btn_2" type="button" onclick="uploadNewRefund();">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0" alt="上传(AltU)">&nbsp;上传掉期时间表</BUTTON>
		    <% 
		    } %>
			</td>
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
     <th>起息日</th>
     <th>交割日</th>
     <th>币种</th>
     <th>名义本金</th>
   </tr>
   <tbody id="data">
<%
String col_str="swap_start_date_t,swap_delivery_date_t,swap_currency_t,swap_nominal_money_t";

sqlstr = "select "+col_str+" from financing_change_date_info_temp where doc_id='"+doc_id+"' order by id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBDateStr(rs.getString("swap_start_date_t")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("swap_delivery_date_t")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("swap_currency_t")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("swap_nominal_money_t")) %></td>
     </tr>
<%}
db.close();
%>     
	</tbody>
</table>
</div>
</div>
</div><!-- 结束掉期时间信息div -->

</body>

<script type="text/javascript">
//点击上传掉期时间信息
function uploadNewRefund(){
	window.open("financing_dqReport_upload.jsp?doc_id=<%=doc_id %>&drawings_id=<%=drawings_id%>");
}
</script>

</html>
