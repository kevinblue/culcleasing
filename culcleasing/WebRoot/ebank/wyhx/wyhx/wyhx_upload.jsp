<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销(首期付款) - 网银数据上传</title>
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
								<BUTTON class="btn_2" name="btnSave" value="网银核销"  type="button" onclick="fun_save()">
								<img src="../../images/save.gif" align="absmiddle" border="0">网银核销</button>
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
		<td align="right">到帐日期&nbsp;&nbsp;</td>
		<td><input name="fact_date" type="text" value="<%=getSystemDate(0) %>" style="width:120px;" readonly maxlength="10" dataType="Date"> <img  onClick="openCalendar(fact_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		</td>
	  </tr>
	  <tr>
	  <td align="right">核销银行&nbsp;&nbsp;</td>
	  <td>
		 <select name="hxBank" style="width:145px;">
			<option value=""></option>
			<option value="jsBank">建设银行</option>
			<option value="msBank">民生银行</option>
		 </select>
		</td>
	  </tr>
	  <tr>
		<td align="right">上传文件&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="bankFile" style="width:250px;">
			<span class="biTian">允许上传的文件类型.xls/.txt</span>
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
	if(document.forms[0].fact_date.value==""){
		alert("上传日期不能为空");
		return false;
	}
	if(document.forms[0].hxBank.value==""){
		alert("核销银行不能为空");
		return false;
	}
	if(document.forms[0].bankFile.value==""){
		alert("请选择上传文件");
		return false;
	}
	//判断核销银行与上传文件类型是否一致
	var hxBank = document.forms[0].hxBank.value;
	var bankFile = document.forms[0].bankFile.value;
	var extType = bankFile.substr(bankFile.lastIndexOf(".")+1);
	//alert(extType);
	if( hxBank=='jsBank' ){//建设银行只允许xls
		if(extType!='xls'){
			alert("对不起，建设银行只允许xls文件上传！");
			return false;
		}
	}else if( hxBank=='msBank' ){
		if(extType!='txt'){
			alert("对不起，民生银行只允许txt文件上传！");
			return false;
		}
	}
	
	if(confirm("确认要上传网银文件"+document.forms[0].bankFile.value)){
		document.forms[0].action="wyhx_save.jsp?hxBank="+document.forms[0].hxBank.value;
		document.getElementById("saveTd").innerHTML="文件上传中，请稍后";
		document.forms[0].submit();
	}
}
</script>
