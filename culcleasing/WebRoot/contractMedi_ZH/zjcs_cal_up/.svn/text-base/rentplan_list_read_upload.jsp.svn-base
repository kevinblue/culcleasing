<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商务条件 - 文件上传</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script src="../../js/comm.js"></script>

<style type="text/css">
body {
	font-family: Tahoma,Arial,Helvetica,Sans-Serif; 
	background: #DDE4EA; 
	margin: 0px; 
	padding: 0px;
	text-align:center;
}
img {
	border: none; 
	vertical-align: middle;
}
</style>

<script type="text/javascript">
function upload_file(){
	var uploadFileVal = $("input[name='uploadFile']").val();
	var extType = uploadFileVal.substr(uploadFileVal.lastIndexOf(".")+1);
	
	if(document.upload_form.uploadFile.value==""){
		alert("请选择上传文件");
		return false;
	}
	
	//上传文件类型是正确
	if(extType!='xls'){
		alert("对不起，只允许上传xls文件！");
		$("input[name='uploadFile']").val("");
		return false;
	}
		
	if(confirm("确认要上传文件"+uploadFileVal+"?")){
		document.getElementById("saveTd").innerHTML="<img src='../../images/ajax-loader-bk.gif' align='bottom' border='0'>文件上传中，请稍后...";
		document.upload_form.submit();
	}
}
</script>
</head>

<%
//提取参数contract_id,doc_id
String contract_id = getStr(request.getParameter("contract_id"));
String doc_id = getStr(request.getParameter("doc_id"));

%>

<body onload="public_onload(0);">
<div style="margin-left:30px;margin-top:30px;border:1px solid gray;width:80%;height:70%;">
<form name="upload_form" action="rentplan_list_read_upload_save.jsp" enctype="multipart/form-data" method="post">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top"><td  align=center width=100%>
		<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
			<tr><td>
			<table border="0" cellspacing="0" cellpadding="0">    
			<tr class="maintab_dh">
				<td nowrap id="saveTd">
					<BUTTON class="btn_2" type="button" id="saveTd" onclick="return upload_file()">
					<img src="../../images/sbtn_2Excel.gif" align="bottom" border="0">上传文件</button>
				</td>
			</tr>
		</table></td></tr>
	</table></td></tr>
</table>
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:0px;height:500px;">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
		<td align="right">上传文件：&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="uploadFile" style="width:250px;" onchange="showFileName()">
			<span class="biTian">允许上传的文件类型.xls 最大8M</span>
		</td>
	  </tr>
	</table>
</div>
</form>
</div>
</body>
</html>
