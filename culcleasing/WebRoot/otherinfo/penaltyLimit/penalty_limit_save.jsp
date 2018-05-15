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
String flag_status = getStr( request.getParameter("flag") );
String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );
String penalty_limit = getStr( request.getParameter("penalty_limit") );
String czid=getStr( request.getParameter("czid") );
String sqlstr = "";
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg="";
if ( stype.equals("mod") ){        //添加操作
	//先判断数据库里是否存在
	sqlstr = "update SYS_Penalty_Limit set penalty_limit='"+penalty_limit+"',flag='"+flag_status+"',";
	sqlstr+= "modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+czid+"'";

	flag = db.executeUpdate(sqlstr);
	msg = "修改罚息额度";
	}else if(stype.equals("add")){
	//不存在则insert
		sqlstr = "select * from SYS_Penalty_Limit where (start_date<='"+start_date+"' and end_date>='"+start_date+"') or (start_date<='"+end_date+"' and end_date>='"+end_date+"')";
		int flag2 = 0;
		ResultSet rs=null;
		rs=db.executeQuery(sqlstr);
		if(!rs.next()){
		sqlstr = "insert into SYS_Penalty_Limit(penalty_limit,flag,start_date,end_date,creator,create_date,modificator,modify_date)";
		sqlstr += " values('"+penalty_limit+"','有效','"+start_date+"','"+end_date+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
		flag = db.executeUpdate(sqlstr);
		rs.close();
		msg = "新增罚息额度";
		}else{
		flag=0;
		msg = "时间段与其它发生交叉，新增罚息额度";
		}
	String sqlLog = LogWriter.getSqlIntoDB(request, "系统信息维护", "罚息额度维护", "修改罚息额度为："+penalty_limit+" 修改用户Id："+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
}else if(stype.equals("del")){
	sqlstr = "delete from SYS_Penalty_Limit where id='"+czid+"'";
	flag = db.executeUpdate(sqlstr);
	msg = "删除罚息额度";
}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert(<%= msg%>+"成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert(<%= msg%>+"失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
