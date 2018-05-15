<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银挂账 - 网银文件上传</title>
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
	if(document.ebank_upload_form.ebank_date.value==""){
		alert("请选择上传日期");
		return false;
	}
	if(document.ebank_upload_form.bank_name.value==""){
		alert("请选择到账银行账号");
		return false;
	}
	if(document.ebank_upload_form.ebankFile.value==""){
		alert("请选择上传文件");
		return false;
	}
	//上传文件类型是正确
	var bankFile = document.ebank_upload_form.ebankFile.value;
	var extType = bankFile.substr(bankFile.lastIndexOf(".")+1);
	if(extType!='xls'){
		alert("对不起，只允许上传xls文件！");
		document.ebank_upload_form.ebankFile.value = "";
		return false;
	}
		
	if(confirm("确认要上传网银文件"+bankFile)){
		document.forms[0].action="wyhx_save.jsp";
		document.getElementById("saveTd").innerHTML="文件上传中，请稍后";
		document.forms[0].submit();
	}
}
</script>
</head>

<body onload="public_onload(0);">

<div style="margin-left:30px;margin-top:30px;border:1px solid gray;width:80%;height:70%;">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top"><td  align=center width=100%>
		<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
			<tr><td><table border="0" cellspacing="0" cellpadding="0">    
			<tr class="maintab_dh">
				<td nowrap id="saveTd">
					<BUTTON class="btn_2" name="btnSave" type="button" onclick="fun_save()">
					<img src="../../images/sbtn_2Excel.gif" align="bottom" border="0">上传网银数据</button>
				</td>
			</tr>
		</table></td></tr>
	</table></td></tr>
</table>

<form name="ebank_upload_form" action="complaint_upload_save.jsp" enctype="multipart/form-data" method="post">
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:0px;height:500px;">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
		  <td align="right">上传日期：&nbsp;&nbsp;</td>
		  <td>
		  <input name="ebank_date" type="text" value="<%=getSystemDate(0) %>" size="15" readonly maxlength="10" dataType="Date"> 
	    	<img  onClick="openCalendar(ebank_date);return false" style="cursor:pointer; " 
	    	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			&nbsp;&nbsp;
		     <span style="color: red;">*</span>
		  </td>
	  </tr>
	  <tr>
		<td align="right">到账银行：&nbsp;&nbsp;</td>
		
	    <td>
	    <input style="width:150px;" name="bank_name" type="text" readonly="readonly">
	    <input style="width:150px;" name="bank_no" type="text" readonly="readonly">
	    
	    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('bank_info.jsp',250,350)">
	    </td>
	  </tr>
  
	  <tr>
		<td align="right">上传文件：&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="ebankFile" style="width:250px;">
			<span class="biTian">允许上传的文件类型.xls 最大8M</span>
		</td>
	  </tr>
	  <tr>
		<td colspan="2" align="center">
		<a href="../../template/ebank_upload_template.xls">下载模板文件</a>
		</td>
	  </tr>
	</table>
</div>

</form>
</body>
</html>
