<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目资料 - 资料清单</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
proj_id = "00007-03-02-2010-00162-00000";
doc_id = "F54FA93C6C6E0F0B4825780300334D18";

//00007-03-02-2010-00162-00000
//F54FA93C6C6E0F0B4825780300334D18
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

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

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- 新增资金计划 -->
			<BUTTON class="btn_2" type="button" onclick="Javascript:document.updMater.submit();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="修改(Alt+N)">&nbsp;修改资料</button>
			<form action="proj_updmater.jsp" name="updMater" method="post" target="_blank">
				<input name="proj_id" type="hidden" value="<%=proj_id %>">
				<input name="doc_id" type="hidden" value="<%=doc_id %>">
			</form>
		</td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>资料大类</th>
     <th>资料小类</th>
     <th>状态</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody>
<%
String col_str="id,proj_id,doc_id,document_id,doc_title,doc_par_title,status,remark";

sqlstr = "select "+col_str+" from vi_proj_document where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("status")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     	<td align="center">
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该项目资料？")){
					window.open('proj_matersave.jsp?type=del&item_id='+obj );
				}
			}
		</script>
	    <a href='Javascript: delItem(<%=getDBStr(rs.getString("id"))%>)'>
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>
     	</td>
     </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</div><!-- 结束资金计划div -->

</body>
</html>
