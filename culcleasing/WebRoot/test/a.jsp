<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">    
<html xmlns="http://www.w3.org/1999/xhtml">    
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />    
<title>a.html文档</title>    
<script type="text/javascript">    
function openstr()    
{    
window.open("b.jsp","","modal=yes,width=500,height=500,resizable=no,scrollbars=no");    
}   
 
</script>    
</head>    
  
<body>    
<form id="form1" name="form1" method="post" action="">    
<label>    
<select name="txtselect" id="txtselect">    
</select>    
</label>    
<label>    
<input type="button" name="Submit" value="打开子窗口" onclick="openstr()" />    
</label>    
</form>    
</body>    
</html>   