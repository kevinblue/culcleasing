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

String rate = getStr( request.getParameter("rate") );

String sqlstr = "";
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;

if ( stype.equals("mod") ){        //添加操作
	//先判断数据库里是否存在
	sqlstr = "update financing_config_rate set rate='"+rate+"',";
	sqlstr+= "modificator='"+dqczy+"',modify_date='"+datestr+"'";

	flag = db.executeUpdate(sqlstr);
	//不存在则insert
	if(flag<=0){
		sqlstr = "insert into financing_config_rate(rate,creator,create_date,modificator,modify_date)";
		sqlstr += " values('"+rate+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
		flag = db.executeUpdate(sqlstr);
	}
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "系统信息维护", "利率维护", "修改利率为："+rate+" 修改用户Id："+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("更新当前利率成功!");
		opener.location.reload();
		//window.opener="";
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("更新当前利率失败!");
		opener.location.reload();
//		window.opener="";
	</script>
<%} %>
</BODY>
</HTML>
