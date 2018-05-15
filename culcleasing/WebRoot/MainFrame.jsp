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

<%
System.out.println("转移之前"+request.getParameter("inform_type"));

String inform_type = getStr(request.getParameter("inform_type"));

if(inform_type!=null && "1".equals(inform_type)){
	inform_type = "租金支付";
}else if( inform_type!=null && "2".equals(inform_type) ){
	inform_type = "违约金明细";
}else if( inform_type!=null && "3".equals(inform_type) ){
	inform_type = "租金变更";
}else if( inform_type!=null && "4".equals(inform_type) ){
	inform_type = "非批量调息租金变更";
}else if( inform_type!=null && "5".equals(inform_type) ){
	inform_type = "合同结清";
}else{
	inform_type = "租金支付";
}


System.out.println("转移之后"+inform_type);
%>

<frameset frameborder="0" border="3" framespacing="3" cols="175,80%">
<frame frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" name="left" src="./mainMenu.jsp?inform_type=<%=inform_type %>" target="main">

<frame frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" name="right" src="right.jsp">
</frameset>
</html>