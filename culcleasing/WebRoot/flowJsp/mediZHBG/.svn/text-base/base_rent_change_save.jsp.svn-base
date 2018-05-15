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
String contract_id = getStr(request.getParameter("change_contract_id"));
String is_floor = getStr(request.getParameter("is_floor"));
String floor_rent = getStr(request.getParameter("floor_rent"));
String sqlstr;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg = "";
	//update proj_info 修改proj_info
	sqlstr = "update begin_info_medi_temp set is_floor='"+is_floor+"',floor_rent='"+floor_rent+"' where contract_id='"+contract_id+"'";
	flag = db.executeUpdate(sqlstr);
	System.out.print("查看是否保底sql"+sqlstr);
	db.close();
	
	msg = "保底金额变更";

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
