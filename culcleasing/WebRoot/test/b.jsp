<html >    
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />    
<title>b.html�ĵ�</title>    
<script type="text/javascript">    
function ClickOk()    
{    
var t=document.Edit;    
var color=t.color.value;    
if(color==null||color=="��д��ɫ") return(false);    
var oOption = window.opener.document.createElement('OPTION');    
oOption.text=document.getElementById("color").value;    
oOption.value=document.getElementById("color").value;    
//������������   
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
<td height="30"><input type="text" name="color" id="color" value="��д��ɫ" /></td>    
<td width="56" align="center" height="30"><input " type="button" name="bntOk" value="ȷ��" onclick="ClickOk();" /> </td>    
</tr>    
</form>    
</table>    
</body>    
</html>  