<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目资料 - CD交接</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
	doc_id = "JS999999900_HT11_22_33";
}
//先初始化加载项目资料清单
ProjMaterService.flowInitContractData(contract_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- 资金计划数据 -->
<div style="margin-top: 20px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		项目资料清单</td>
	</tr>
</table> 
</div>
<!-- end cwTop -->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>资料大类</th>
     <th>资料小类</th>
     <th>文本是否归档</th>
     <th>电子版是否归档</th>
     <th>备注</th>
   </tr>
   
   <tbody>
<%
String col_str="id,contract_id,doc_id,document_id,doc_title,doc_par_title,text_status,electron_status,remark";

sqlstr = "select "+col_str+" from vi_contract_document_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("text_status")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("electron_status")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</div>

</body>
</html>
