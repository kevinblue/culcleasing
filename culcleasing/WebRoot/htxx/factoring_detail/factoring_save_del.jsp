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
			String id=getStr(request.getParameter("id"));
int flag=0;
String message="";

			String stype = getStr(request.getParameter("savetype"));
			if (stype.equals("del")) {
				String sqlstr = "delete from factoring_contract_info where id='" + id+ "'";
				System.out.println(sqlstr);
				flag = db.executeUpdate(sqlstr);
				
				db.close();
				 message = "ɾ��������ϸ��Ϣ";
			}
		if(flag>0){
		String hrefStr="";
		if(stype.equals("del")){
%>
        <script>
		opener.window.location.href = "factoring_list.jsp";
		alert("<%=message%>�ɹ�!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		//window.location.href = "fpgl_list.jsp";
		//alert("<%=message%>�ɹ�!");
		//opener.location.reload();
		</script>
<%
		}
	}else{
%>
        <script>
		alert("<%=message%>ʧ��!");
		opener.location.reload();
		this.close();
		</script>
<%	
	}
	db.close();
%>