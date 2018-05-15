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
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数contract_id,proj_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if( contract_id==null || "".equals(contract_id) ){
	contract_id = "CULC_0022_T001";
	proj_id = "CULCTest022";
	doc_id = "JS999999900_HT11";
}
//初始化签约审批合同数据
ProjMaterService.flowInitContractApproveData(contract_id, proj_id, doc_id);

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

	window.open('contract_updmater.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>', 'newwindow', 'height=450, width=560, top=0, left=0,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no');

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
      <th>负责部门</th>
     <th>文件类型</th>
     <th>文件</th>
     <th>文本是否归档</th>
     <th>电子版是否归档</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select "+col_str+" from vi_contract_document_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by cast(flag3 as int),cast(flag2 as int),cast(flag1 as int)";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_par_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
     	<td align="left" class="autoNewLine" width="300px"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("text_status")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("electron_status")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     	<td align="center">
     	<!-- 添加 备注-->
     	<a href="contract_mater_list_addremark.jsp?id=<%=getDBStr(rs.getString("id")) %>&contract_id=<%=getDBStr(rs.getString("contract_id")) %>&doc_id=<%=getDBStr(rs.getString("doc_id")) %>" target="_blank">
     	<img src="../../images/btn_edit.gif" align="bottom" border="0">添加备注</a>
     	<!-- 删除意见 -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("确认删除该项目资料？")){
					window.open('contract_matersave.jsp?type=del&item_id='+obj );
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
