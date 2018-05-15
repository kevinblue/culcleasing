<%@ page contentType="text/html; charset=gbk" language="java"  %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>session过期</title>
   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
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
   	<div style="width:600px;height:450px;border:1px solid green;margin-top:30px;text-align:center;background-color:#f0f7fd;font-size:13px;padding-top:50px;color:#808080;">
	<div>
	非常抱歉， 会话已过期，请重新登录！</div><br/><br/><br/>
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
				relogin();
			}
		}
		setInterval(fnGo,1000);
	</script>
    <meta http-equiv='refresh' content='5;url=JavaScript:relogin();'><label id='l1'>05</label>秒后跳转界面，请稍等... 
    <script type="text/javascript">
    function relogin(){
    	window.parent.parent.location.replace("http://domino.culc.com/");
    }
    </script>
	<br/><br/><br/><br/>
	<p align="center"> 如果您的浏览器不支持跳转,
	<a style="text-decoration: none" href="http://domino.culc.com/"><font color="#FF0000">请点这里</font></a>.</p>

   	</div>
  </body>
</html>