<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);

String xmidstr = getStr( request.getParameter("xmidstr") );

String sqlstr = "";
//-----------------判断重复--------------
String proj_arr[];
String proj_id;
proj_arr=xmidstr.split(",");
for(int i=0;i<proj_arr.length;i++){
	proj_id=proj_arr[i];
	sqlstr="insert into adjust_interest_proj(adjust_id,proj_id,adjust_flag,creator,create_date,method) select '"+czid+"','"+proj_id+"','否','"+dqczy+"','"+curr_date+"','是'";
	db.executeUpdate(sqlstr);
}
%>
<script>
	window.close();
	opener.alert("成功!");
	opener.parent.location.reload();
</script>

		