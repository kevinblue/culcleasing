<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@ page import="java.sql.*" %> 
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

String penalty_limit = getStr( request.getParameter("penalty_limit") );

String sqlstr = "";
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;

if ( stype.equals("mod") ){        //添加操作
	//先判断数据库里是否存在
	sqlstr = "update SYS_Penalty_Limit set penalty_limit='"+penalty_limit+"',";
	sqlstr+= "modificator='"+dqczy+"',modify_date='"+datestr+"'";

	flag = db.executeUpdate(sqlstr);
	//不存在则insert
	if(flag<=0){
		sqlstr = "insert into SYS_Penalty_Limit(penalty_limit,flag,creator,create_date,modificator,modify_date)";
		sqlstr += " values('"+penalty_limit+"','有效','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
		flag = db.executeUpdate(sqlstr);
	}
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "系统信息维护", "罚息额度维护", "修改罚息额度为："+penalty_limit+" 修改用户Id："+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("罚息额度修改成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("罚息额度修改失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
