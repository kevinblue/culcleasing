<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common_simple.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加备注</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

  </head>
  
  <body>
    <%
		int num =0;
		//外参数传递过来
		int id = Integer.parseInt(getStr(request.getParameter("id")));
		String re =getStr(request.getParameter("remark"));
		String sqlstr = "update proj_document_temp set remark ='"+re+"'where id="+id;
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
