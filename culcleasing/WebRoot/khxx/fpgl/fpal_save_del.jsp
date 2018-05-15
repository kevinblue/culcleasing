<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		
	</head>

	<BODY>
		<%
			String dqczy = (String) session.getAttribute("czyid");
	        System.out.print("join@2"+dqczy);
			

String invoice_number= getStr( request.getParameter("invoice_number") );
String invoice_total= getStr( request.getParameter("invoice_total") );
String invoice_date = getStr( request.getParameter("invoice_date") );
			String stype = getStr(request.getParameter("savetype"));
			if (stype.equals("del")) {
			
				sqlstr = "delete from dbo.proj_invoice  where id='" + id+ "'";
				System.out.println(sqlstr);
				flag = db.executeUpdate(sqlstr);
				
				db.close();
				message = "删除发票信息";
			}
		if(flag>0){
		String hrefStr="";
		if(stype.equals("del")){
%>
        <script>
		opener.window.location.href = "fpgl_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		window.location.href = "khzrxx.jsp?custId=<%=custId%>";
		alert("<%=message%>成功!");
		opener.location.reload();
		</script>
<%
		}
	}else{
%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
<%	
	}
	db.close();
%>