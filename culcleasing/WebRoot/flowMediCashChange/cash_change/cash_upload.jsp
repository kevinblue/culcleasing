<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ֽ����ϴ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

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

<script language="javascript">
function fun_save(){
	if(document.upload_form.uploadFile.value==""){
		alert("��ѡ���ϴ��ļ�");
		return false;
	}
	//�ϴ��ļ���������ȷ
	var uploadFile = document.upload_form.uploadFile.value;
	var extType = uploadFile.substr(uploadFile.lastIndexOf(".")+1);
	if(extType!='xls'){
		alert("�Բ���ֻ�����ϴ�xls�ļ���");
		document.upload_form.uploadFile.value = "";
		return false;
	}
		
	if(confirm("ȷ��Ҫ�ϴ��ļ�: "+uploadFile)){
		document.forms[0].action="cash_upload_save.jsp";
		document.getElementById("saveTd").innerHTML="�ļ��ϴ��У����Ժ�";
		document.forms[0].submit();
	}
}
</script>
</head>

<%
//��ȡ����contract_id,doc_id,type
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String type = getStr( request.getParameter("type") );
%>

<body onload="public_onload(0);">

<div style="margin-left:30px;margin-top:30px;border:1px solid gray;width:80%;height:70%;">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top"><td  align=center width=100%>
		<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
			<tr><td><table border="0" cellspacing="0" cellpadding="0">    
			<tr class="maintab_dh">
				<td nowrap id="saveTd">
					<BUTTON class="btn_2" name="btnSave" type="button" onclick="fun_save()">
					<img src="../../images/sbtn_2Excel.gif" align="bottom" border="0">�ϴ��ֽ���</button>
				</td>
			</tr>
		</table></td></tr>
	</table></td></tr>
</table>

<form name="upload_form" action="cash_upload_save.jsp" enctype="multipart/form-data" method="post">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="type" value="<%=type %>">
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:0px;height:500px;">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
		<td align="right">�ϴ��ļ���&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="uploadFile" style="width:250px;">
			<span class="biTian">�����ϴ����ļ�����.xls ���8M</span>
		</td>
	  </tr>
	  <tr>
		<td colspan="2" align="center">
		<%
		if(type.equals("yc")){
		%><a href="../../template/yccash_template.xls">����ģ���ļ�</a><%
		}else if(type.equals("bd")){
		%>
		<a href="../../template/bdcash_template.xls">����ģ���ļ�</a>
		<%
		}
		%>
		
		</td>
	  </tr>
	</table>
</div>

</form>
</div>
</body>
</html>
