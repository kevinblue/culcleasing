<%@ page contentType="text/html; charset=gbk" language="java" import="java.util.*" pageEncoding="gbk" isErrorPage="true" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>错误信息</title>
   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
	<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)"> 
	<style type="text/css">
	body {
		font-family: Tahoma,Arial,Helvetica,Sans-Serif; 
		background: #DDE4EA; 
		margin: 0px; 
		padding: 0px;
		text-align:center;
	}
	</style>
 </head>

  <body>
   	<h2><font color="red">失败信息</font></h2>
   	<div style="width:600px;height:450px;border:1px solid green;margin-top:30px;text-align:center;background-color:#f0f7fd;font-size:13px;padding-top:50px;color:#808080;">
	<div>
<!--
	<img src="/stleasing/images/500lerror.gif" />
-->
	非常抱歉，服务器内部错误，请通知管理员！</div><br>
   	<b>错误代号：<% out.println(exception); %></b>
   	<br><br><br><b><a href="JavaScript:history.back()">返回继续</a></b><br/><br/><br/>
   	<script language="javascript">
		var c=5;
		function fnGo()
		{
			if(c>1)
			{
				c--;
				l1.innerHTML=(c>=10?c:"0"+c);
			}else
			{
				history.back();
			}
		}
		setInterval(fnGo,1000);
	</script>
    <meta http-equiv='refresh'content='5;url=JavaScript:history.back()'><label id='l1'>05</label>秒后跳转界面，请稍等... 
	<br/><br/><br/><br/>
	<p align="center"> 如果您的浏览器不支持跳转,
	<a style="text-decoration: none" href="http://domino.culc.com/"><font color="#FF0000">请点这里</font></a>.</p>

   	</div>
  </body>
</html>