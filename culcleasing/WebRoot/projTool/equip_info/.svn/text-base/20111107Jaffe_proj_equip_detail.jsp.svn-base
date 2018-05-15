<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租赁物件明细</title>
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
//提取参数priId,contractId
String priId = getStr( request.getParameter("priId") );
String contractId = getStr( request.getParameter("contractId") );

%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 还款计划制定 -->
<div style="margin-top: 10px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	租赁物件明细&nbsp;
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
			    <BUTTON class="btn_2" type="button" onclick="addNewEquip();">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="新增(Alt+N)">&nbsp;新增租赁物件</BUTTON>
				&nbsp;&nbsp;&nbsp;
				<BUTTON class="btn_2" type="button" onclick="uploadNewEquip();">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0" alt="上传(AltU)">&nbsp;上传租赁物件</BUTTON>
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
     <th>设备编号</th>
     <th>设备名乐</th>
     <th>设备型号</th>
     <th>制造商</th>
     <th>数量</th>
     <th>单价</th>
     <th>总额</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str=" * ";
String table_type="";

sqlstr = "select "+col_str+" from vi_contract_equip_all_info where contract_id='"+contractId+"' order by equip_name";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
table_type = getDBStr(rs.getString("table_type"));
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("equip_id")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("equip_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("equip_model")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("equip_manufacturer")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_price")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_num")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("total_price")) %></td>
     	<td align="center">
     	<a href='refund_upd.jsp?contract_id=<%=contractId %>&equip_id=<%=getDBStr(rs.getString("equip_id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	|
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该租赁物件吗？")){
					window.open('refund_save.jsp?savetype=delRefund&equip_id=<%=getDBStr(rs.getString("equip_id")) %>&table_type=<%=table_type%>'  );
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("equip_id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>
     	</td>
     </tr>
<%}
db.close();
%>     
	</tbody>
</table>
</div>
</div>
</div><!-- 结束还款计划div -->

</body>

<script type="text/javascript">
//点击新增还款计划
function addNewRefund(){
	window.open("refund_add.jsp?contract_id=<%=contractId%>");
}
//点击上传还款计划
function uploadNewRefund(){
	window.open("refund_upload.jsp?contract_id=<%=contractId%>");
}
</script>

</html>
