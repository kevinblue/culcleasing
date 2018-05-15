<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目资料 - 资料清单</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if( "".equals(proj_id) ){
	proj_id = "11D010406";
	doc_id = "JS999999900";
}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- 资金计划数据 -->
<div style="margin-top: 0px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		项目资料清单</td>
	</tr>
</table> 
</div>
<!-- end cwTop -->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>负责部门</th>
     <th>文件类型</th>
     <th>文件</th>
	 <th>文本是否归档</th>
     <th>电子版是否归档</th>
     <th>备注</th>
   </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select "+col_str+" from vi_proj_document where proj_id='"+proj_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_par_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
     	<td align="left" class="autoNewLine"><%=getDBStr(rs.getString("doc_title")) %></td>
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
