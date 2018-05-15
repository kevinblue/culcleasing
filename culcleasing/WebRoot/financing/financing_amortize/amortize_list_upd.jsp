<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>提款费用摊销表</title>
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
	提款费用摊销&nbsp;
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
				<BUTTON class="btn_2" type="button" onclick="uploadNewRefund();">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0" alt="上传(AltU)">&nbsp;上传摊销明细</BUTTON>
			</td>
		    <td>
				<BUTTON class="btn_2" type="button" onclick="saveAmortize();">
				<img src="../../images/btn_save.gif" align="absmiddle" border="0" alt="保存(AltU)">&nbsp;保存摊销明细</BUTTON>
			</td>
			<td>
				<font style="font-weight:bold;"  color="red">（请注意保存修改的数据）</font>
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
     <th>提款标号</th>
     <th>授信单位</th>
     <th>序号</th>
     <th>摊销类型</th>
     <th>摊销日期</th>
     <th>摊销金额</th>
     <th>未摊销余额</th>
     <th>摊销方法</th>
     <th>创建人</th>
     <th>创建时间</th>
   </tr>
   <tbody id="data">
<%
String col_str=" fa.id,fa.drawings_id,fc.crediter,fa.amortize_date,fa.amortize_money,fa.non_amortization_balance,fa.amortize_method,fa.creator,fa.create_date,bu.name,fa.amortize_list,fa.amortize_type ";

sqlstr = "select "+col_str+" from financing_amortize_temp fa,financing_credit fc,financing_drawings fd,base_user bu where fa.creator = bu.id and fa.drawings_id = fd.drawings_id and fd.credit_id = fc.credit_id and fa.drawings_id='"+drawings_id+"'  order by fa.amortize_date";
System.out.println("test="+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("drawings_id")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("crediter")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("amortize_list")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("amortize_type")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("amortize_date")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("amortize_money")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("non_amortization_balance")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("amortize_method")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("name")) %></td>
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
function uploadNewRefund(){
	window.open("amortize_upload.jsp?drawings_id=<%=drawings_id %>");
}
//点击保存分摊明细
function saveAmortize(){
	window.open("amortize_save.jsp?drawings_id=<%=drawings_id %>");
}
</script>

</html>
