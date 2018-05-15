<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>导入 - 客户信息上传</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
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
</head>

<body>
<div style="margin-left:30px;margin-top:30px;border:1px solid gray;width:80%;height:70%;">
<form name="list" action="wyhx_save.jsp" enctype="multipart/form-data" method="post">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr><td>
					<table border="0" cellspacing="0" cellpadding="0">    
						<tr class="maintab_dh">
							<td nowrap id="saveTd">
								<BUTTON class="btn_2" name="btnSave" value="上传"  type="button" onclick="fun_save()">
								<img src="../../images/save.gif" align="absmiddle" border="0">上传</button>
							</td>
						</tr>
					</table>
				</td></tr>
			</table>
		</td>
	</tr>
</table>
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:0px;height:500px;">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>

	  </tr>
	  <tr>

	  </tr>
	  <tr>
		<td align="right">上传文件&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="dataFile" style="width:250px;">
			<span class="biTian">允许上传的文件类型.xls</span>
		</td>
	  </tr>
	</table>
</div>
</form>

</div>
</body>
</html>
<script language="javascript">
function fun_save(){


	if(document.forms[0].dataFile.value==""){
		alert("请选择上传文件");
		return false;
	}
	//判断核销银行与上传文件类型是否一致
	//var hxBank = document.forms[0].hxBank.value;
	var dataFile = document.forms[0].dataFile.value;
	var extType = dataFile.substr(dataFile.lastIndexOf(".")+1);
	//alert(extType);

	if(confirm("确认要上传用户信息文件"+document.forms[0].dataFile.value)){
		document.forms[0].action="khzrxx_upload_save.jsp";
		document.getElementById("saveTd").innerHTML="文件上传中，请稍后";
		document.forms[0].submit();
	}
}
</script>
