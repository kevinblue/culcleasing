<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

//获取参数
String proj_id = getStr(request.getParameter("change_proj_id"));
String is_more = getStr(request.getParameter("is_more"));
String start_amount = getStr(request.getParameter("start_amount"));
String sqlstr;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg = "";
	//update proj_info 修改proj_info
	sqlstr = "update proj_info set is_more='"+is_more+"',start_amount='"+start_amount+"' where proj_id='"+proj_id+"'";
	flag = db.executeUpdate(sqlstr);
	db.close();
	
	msg = "项目多次签约控制";

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
