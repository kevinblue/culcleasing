<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'wyhx_upflag.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>

	<body>
		<%
		int num =0;
			//外参数传递过来
			int id = Integer.parseInt(getStr(request.getParameter("id")));
			String sqlstr = "update fund_ebank_imp set flag=1 where id=" + id;
			num += db.executeUpdate(sqlstr);

			String message = "修改成功";
		if (num != 0) {
		%>
		<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
		<%
			} else {
		%>
		<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
		<%
			}
			db.close();
		%>

	</body>
</html>
