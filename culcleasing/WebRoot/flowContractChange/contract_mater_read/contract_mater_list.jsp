<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���� - �����嵥</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����contract_id,proj_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//ģ�⸳ֵ
if( contract_id==null || "".equals(contract_id) ){
	contract_id = "CULC_0022_T001";
	proj_id = "CULCTest022";
	doc_id = "JS999999900_HT11";
}
//��ʼ��ǩԼ������ͬ����
ProjMaterService.flowInitContractApproveData(contract_id, proj_id, doc_id);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- �ʽ�ƻ����� -->
<div style="margin-top: 0px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��Ŀ�����嵥</td>
	</tr>
</table> 
</div>
<!-- end cwTop -->

<script type="text/javascript">
//������Ŀ����
function updMater(){

	window.open('contract_updmater.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>', 'newwindow', 'height=450, width=560, top=0, left=0,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no');

	//window.showModalDialog("proj_updmater.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>",obj,"dialogWidth=560px;dialogHeight=450px;center=yes;resizable=yes;");
	//window.showModelessDialog();
}
</script>

<table border="0" cellspacing="0" cellpadding="0" >    
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
    <th>������</th>
     <th>�ļ�����</th>
     <th>�ļ�</th>
     <th>�ı��Ƿ�鵵</th>
     <th>���Ӱ��Ƿ�鵵</th>
     <th>��ע</th>

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
</div><!-- �����ʽ�ƻ�div -->

</body>
</html>