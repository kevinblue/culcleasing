<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<script language="JavaScript" type="text/javascript">
<!-- 
self._domino_name = "_frameforweb";
// -->
</script>
</head>

<%!
public String getStr(String str) //request字符串中文处理
{
	try {
		String temp_p = str.trim();
		byte[] temp_t = temp_p.getBytes("ISO8859-1");
		String temp = new String(temp_t);
		return temp;
	} catch (Exception e) {

	}
	return "";
}
%>

<frameset frameborder="0" border="3" framespacing="3" cols="175,80%">
<frame frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" name="left" src="./admin2.jsp" target="main">

<frame frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" name="right" src="right1.jsp">
</frameset>
</html>