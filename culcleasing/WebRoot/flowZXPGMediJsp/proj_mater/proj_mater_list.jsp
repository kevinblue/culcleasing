<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>

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
if( proj_id ==null || "".equals(proj_id) ){
	proj_id = "11D010403";
	doc_id = "JS999999900_11";
}
//先初始化加载项目资料清单
//ProjMaterService.flowInitTableData(proj_id, doc_id);
//sqlstr="select proj_id,'"+ doc_id+ "',document_id,text_status,electron_status,remark from proj_document"+
	//" where proj_id='" + proj_id + "'";
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

<script type="text/javascript">
//设置项目资料
function updMater(){

	window.open('proj_updmater.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>', 'newwindow', 'height=450, width=560, top=0, left=0,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no');

	//window.showModalDialog("proj_updmater.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>",obj,"dialogWidth=560px;dialogHeight=450px;center=yes;resizable=yes;");
	//window.showModelessDialog();
}
</script>

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- 新增资金计划 -->
			<BUTTON class="btn_2" type="button" onclick="updMater();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="修改(Alt+N)">&nbsp;修改资料</button>
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
     <th>文本是否归档</th>
     <th>电子版是否归档</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="id,proj_id,document_id,doc_title,doc_par_title,text_status,electron_status,remark";

sqlstr = "select "+col_str+" from vi_proj_document where proj_id='"+proj_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("text_status")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("electron_status")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     	<td align="center">
     	<!-- 添加 备注-->
     	<a href="proj_mater_list_addremark.jsp?id=<%=getDBStr(rs.getString("id")) %>&proj_id=<%=getDBStr(rs.getString("proj_id")) %>&doc_id=<%=getDBStr(rs.getString("doc_id")) %>" target="_blank">
     	<img src="../../images/btn_edit.gif" align="bottom" border="0">添加备注</a>
     	
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
