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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'upremark.jsp' starting page</title>
    
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
			String re =getStr(request.getParameter("remark"));
			String sqlstr = "update contract_document_temp set remark ='"+re+"'where id="+id;
			num += db.executeUpdate(sqlstr);

			String msg = "添加备注";
		if (num != 0) {
		%>
		
		<script type="text/javascript">
			window.opener.alert("<%=msg %>成功!");
			window.opener.location.reload();

			if(window.opener){
				window.opener=null;window.open('','_self');
				window.close();} 
			 else{history.back()}
		</script>
		<%
			} else {
		%>
		<script type="text/javascript">
			window.opener.alert("<%=msg %>失败!");
			window.opener.location.reload();

			if(window.opener){
				window.opener=null;window.open('','_self');
				window.close();} 
			 else{history.back()}
		</script>
		<%
			}
			db.close();
		%>
		
  </body>
</html>
