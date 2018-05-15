<%@ page contentType="text/html; charset=gbk" language="java"  %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 法人客户信息</title>
</head>

<body>
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
String czid = getStr(request.getParameter("custId"));
String cust_code = getStr(request.getParameter("cust_code"));
//System.out.println(czid+"czid-123");
System.out.println("客户id："+czid+" 客户类型："+cust_code);

if(cust_code.equals("法人")){
out.println("test");
//request.getRequestDispatcher(  request.getContextPath()+"/khxx/khfr/t.html?custId="+czid).forward(request, response);
//request.getRequestDispatcher(  request.getContextPath()+"/khxx/khfr/t.html").forward(request, response);
response.sendRedirect( request.getContextPath()+"/khxx/khfr/frkh.jsp?custId="+czid);
}
if(cust_code.equals("个人")){
response.sendRedirect(  request.getContextPath()+"/khxx/khzr/khzrxx.jsp?custId="+czid);
//.forward(request, response);
 //response.sendRedirect("khzrxx.jsp?custid="+czid);
}
%>
</body>
</html>
