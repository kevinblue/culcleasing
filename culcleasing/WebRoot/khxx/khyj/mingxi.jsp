<%@ page contentType="text/html; charset=gbk" language="java"  %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ���Ϣ - ���˿ͻ���Ϣ</title>
</head>

<body>
<%!
public String getStr(String str) //request�ַ������Ĵ���
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
System.out.println("�ͻ�id��"+czid+" �ͻ����ͣ�"+cust_code);

if(cust_code.equals("����")){
out.println("test");
//request.getRequestDispatcher(  request.getContextPath()+"/khxx/khfr/t.html?custId="+czid).forward(request, response);
//request.getRequestDispatcher(  request.getContextPath()+"/khxx/khfr/t.html").forward(request, response);
response.sendRedirect( request.getContextPath()+"/khxx/khfr/frkh.jsp?custId="+czid);
}
if(cust_code.equals("����")){
response.sendRedirect(  request.getContextPath()+"/khxx/khzr/khzrxx.jsp?custId="+czid);
//.forward(request, response);
 //response.sendRedirect("khzrxx.jsp?custid="+czid);
}
%>
</body>
</html>
