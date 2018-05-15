<html >    
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />    
<title>b.html文档</title>    
<script type="text/javascript">    
function ClickOk()    
{    
var t=document.Edit;    
var color=t.color.value;    
if(color==null||color=="填写颜色") return(false);    
var oOption = window.opener.document.createElement('OPTION');    
oOption.text=document.getElementById("color").value;    
oOption.value=document.getElementById("color").value;    
//检查浏览器类型   
var bname = navigator.appName;   
if (bname.search(/netscape/i) == 0)   
{   
window.opener.document.getElementById("txtselect").appendChild(oOption);    
}   
else if (bname.search(/microsoft/i) == 0)   
{   
window.opener.document.all.txtselect.add(oOption);    
}   
else  
{   
}   
window.close();    
}    
</script>    
</head>    
<body>    
<table border="0" cellpadding="0" cellspacing="2" align="center" width="300">    
<form name="Edit" id="Edit">    
<tr>    
<td width="30" align="right" height="30">color:</td>    
<td height="30"><input type="text" name="color" id="color" value="填写颜色" /></td>    
<td width="56" align="center" height="30"><input " type="button" name="bntOk" value="确认" onclick="ClickOk();" /> </td>    
</tr>    
</form>    
</table>    
</body>    
</html>  