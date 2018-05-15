<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
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
String stype = getStr( request.getParameter("savetype") );

String base_rate = getStr( request.getParameter("base_rate") );
String base_adjust_rate = getStr( request.getParameter("base_adjust_rate") );
String base_date = getStr( request.getParameter("base_date") );
String start_date = getStr( request.getParameter("start_date") );
String rate_limit = getStr( request.getParameter("rate_limit") );
String adjust_flag = getStr( request.getParameter("adjust_flag") );

String yh_adjust_rate = getStr( request.getParameter("yh_adjust_rate") );
String nx = getStr( request.getParameter("nx") );

String sqlstr;
ResultSet rs;
//-----------------判断重复--------------
String repeat_flag="";
if(stype.equals("add")){
	sqlstr="select * from base_adjust_interest where start_date='"+start_date+"' or adjust_flag='否'";//or adjust_flag='否'
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="10";
	}rs.close();
}else if(stype.equals("mod")){
//	sqlstr="select * from base_adjust_interest where (start_date='"+start_date+"' and id<>'"+czid+"') or adjust_flag='是'";
//	rs=db.executeQuery(sqlstr);
//	if(rs.next()){
//		repeat_flag="2";
//	}rs.close();
	if(repeat_flag.equals("")){
		sqlstr="select * from adjust_interest_proj where adjust_id='"+czid+"' and adjust_flag='否'";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			repeat_flag="3";
		}rs.close();
	}
}else{
	sqlstr="select * from adjust_interest_proj where adjust_id='"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="4";
	}rs.close();
}
if(repeat_flag.equals("1")){
%>
<script>
	alert("很抱歉不能添加,系统中还有没有处理完的调息或您添加的调息时间系统中已经存在!");
	window.history.back(-1);
</script>
<%
	return;
}else if(repeat_flag.equals("2")){
%>
<script>
	alert("很抱歉不能修改，“该条调息记录已经处理完” 或 “系统中已存在您需要修改调息时间”!");
	window.history.back(-1);
</script>
<%
	return;
}else if(repeat_flag.equals("3")){
%>
<script>
	alert("该条调息记录还关联未调息的项目，不能修改!");
	window.history.back(-1);
</script>
<%
	return;
}else if(repeat_flag.equals("4")){
%>
<script>
	alert("该条调息记录已经关联项目不能删除!");
	window.history.back(-1);
</script>
<%
	return;
}

String message="";
if(stype.equals("add")){
	sqlstr="insert into base_adjust_interest(base_rate,base_adjust_rate,base_date,start_date,rate_limit,adjust_flag,creator,create_date,yh_adjust_rate,nx) select "+base_rate+","+base_adjust_rate+",'"+base_date+"','"+start_date+"',"+rate_limit+",'否','"+dqczy+"','"+curr_date+"','"+yh_adjust_rate+"','"+nx+"'";
	db.executeUpdate(sqlstr);
	message="添加";
}
if ( stype.equals("mod") ){ 
	sqlstr="update base_adjust_interest set base_rate="+base_rate+",base_adjust_rate="+base_adjust_rate+",base_date='"+base_date+"',start_date='"+start_date+"',rate_limit="+rate_limit+",adjust_flag='"+adjust_flag+"',modificator='"+dqczy+"',modify_date='"+curr_date+"',yh_adjust_rate='"+yh_adjust_rate+"',nx='"+nx+"' where id='"+czid+"'";
	db.executeUpdate(sqlstr);
	message="修改";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from base_adjust_interest where  id='"+czid+"'";
	db.executeUpdate(sqlstr);
	message="删除";
}
db.close();
%>
<script>
	window.close();
	opener.alert("<%=message%>成功!");
	opener.location.reload();
</script>
		