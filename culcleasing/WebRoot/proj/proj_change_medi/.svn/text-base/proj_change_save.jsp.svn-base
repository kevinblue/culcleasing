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
String change_proj_id = getStr( request.getParameter("change_proj_id") );
String old_manager = getStr( request.getParameter("old_manager") );
String old_manage_assisant = getStr( request.getParameter("old_manage_assisant") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String proj_manage_id = getStr( request.getParameter("proj_manage_id") );
String proj_assisant_name = getStr( request.getParameter("proj_assisant_name") );
String proj_assisant_id = getStr( request.getParameter("proj_assisant_id") );
String transfer_date = getStr( request.getParameter("transfer_date") );
String ctmemo = getStr( request.getParameter("ctmemo") );

String sqlstr;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg = "";
if ( stype.equals("yj") ){        //项目移交
	//insert
	sqlstr = "insert into proj_transfer(proj_id,old_manager,now_manager,old_manage_assisant,new_manage_assisant,transfer_date,ctmemo,creator,create_date,modificator,modify_date)";
	sqlstr += " values('"+change_proj_id+"','"+old_manager+"','"+proj_manage_name+"','"+old_manage_assisant+"','"+proj_assisant_name+"','"+transfer_date+"','"+ctmemo+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
	//System.out.println(sqlstr);
	flag = db.executeUpdate(sqlstr);
	//update proj_info 修改proj_info里项目经理与项目助理
	sqlstr = "update proj_info set proj_manage='"+proj_manage_id+"',proj_assistant='"+proj_assisant_id+"' where proj_id='"+change_proj_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "项目移交", "项目id:"+change_proj_id+"由原项目经理"+old_manager+
			"转移给"+proj_manage_name+"由原项目助理"+old_manage_assisant+"转移给"+proj_assisant_name, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "项目移交";
}

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
