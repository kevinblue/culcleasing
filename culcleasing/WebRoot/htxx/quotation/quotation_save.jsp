<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//������
System.out.println("dqczy"+dqczy);
String czid = getStr( request.getParameter("czid") );//id
String systemDate = getSystemDate(0);
String sqlstr="";
ResultSet rs;
int flag=0;
String message="";
int flag1=0;
String id = getStr( request.getParameter("id") );
System.out.println("id==%%%%%%="+id);
String plan_bj=getStr(request.getParameter("plan_bj"));
String plan_bjirr=getStr(request.getParameter("plan_bjirr"));
String memo = getStr(request.getParameter("memo"));

sqlstr = "update mproj_quotation_info set plan_bj='"+plan_bj+"',plan_bjirr='" + plan_bjirr + "',modificator='"+dqczy+"',modify_date='"+systemDate+"',memo='"+memo+"' where id='" + id + "'";
System.out.println("sqlst="+sqlstr);
 flag1=db.executeUpdate(sqlstr);
 message="�޸���������Ϣ";



 
if(flag!=0){
	
%>

<script>
			 	
		///alert("<%=message%>�ɹ�!");
		///opener.location.reload();
		
		///window.location.href = "frkh.jsp?
		///alert("<%=message%>�ɹ�!");
		///opener.location.reload();
		opener.window.location.href = "quotation_list.jsp";
		alert("<%=message%>�ɹ�!");
		this.close();
				
</script>


<%
}else{
%>

<%
}
 %>
<%
if(flag1!=0){
 %>
 <script>
			 	
		opener.window.location.href = "quotation_list.jsp";
		alert("�޸ĳɹ�!");
		this.close();
				
</script>
 <%
 }
  %>
<%
db.close();


%>