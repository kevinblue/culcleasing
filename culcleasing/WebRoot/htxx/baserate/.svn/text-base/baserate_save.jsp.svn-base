<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);

String start_date = getStr( request.getParameter("start_date") );
String rate_half = getStr( request.getParameter("rate_half") );
String rate_one = getStr( request.getParameter("rate_one") );
String rate_three = getStr( request.getParameter("rate_three") );
String rate_five = getStr( request.getParameter("rate_five") );
String rate_abovefive = getStr( request.getParameter("rate_abovefive") );
String base_rate_half = getStr( request.getParameter("base_rate_half") );
String base_rate_one = getStr( request.getParameter("base_rate_one") );
String base_rate_three = getStr( request.getParameter("base_rate_three") );
String base_rate_five = getStr( request.getParameter("base_rate_five") );
String base_rate_abovefive = getStr( request.getParameter("base_rate_abovefive") );

String stype = getStr( request.getParameter("savetype") );

String str_flag="";
if ( stype.equals("del") || stype.equals("")){
	sqlstr="select * from fund_standard_interest where 1=0";
}else if ( stype.equals("add") ){ 
	sqlstr="select * from fund_standard_interest where start_date='"+start_date+"'";
	
}else{ 
	sqlstr="select * from fund_standard_interest where start_date='"+start_date+"' and id<>'"+czid+"'";
}
rs=db.executeQuery(sqlstr);
if(rs.next()){
	str_flag="1";
}rs.close();


int flag=0;
String message="";
if ( stype.equals("add")){ 
	if(str_flag.equals("")){
		sqlstr="insert into fund_standard_interest (start_date,rate_half,rate_one,rate_three,rate_five,rate_abovefive,base_rate_half,base_rate_one,base_rate_three,base_rate_five,base_rate_abovefive,creator,create_date) values('"+start_date+"',"+rate_half+","+rate_one+","+rate_three+","+rate_five+","+rate_abovefive+","+base_rate_half+","+base_rate_one+","+base_rate_three+","+base_rate_five+","+base_rate_abovefive+",'"+dqczy+"','"+curr_date+"')";
		flag = db.executeUpdate(sqlstr);
	}
	message="添加央行基准利率";
}
if ( stype.equals("mod")){ 
	if(str_flag.equals("")){
		sqlstr="update fund_standard_interest set start_date='"+start_date+"',rate_half="+rate_half+",rate_one="+rate_one+",rate_three="+rate_three+",rate_five="+rate_five+",rate_abovefive="+rate_abovefive+",base_rate_half="+base_rate_half+",base_rate_one="+base_rate_one+",base_rate_three="+base_rate_three+",base_rate_five="+base_rate_five+",base_rate_abovefive="+base_rate_abovefive+",modificator='"+dqczy+"',modify_date='"+curr_date+"' where id="+czid;
		flag = db.executeUpdate(sqlstr);
	}
	message="修改央行基准利率";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from fund_standard_interest where  id="+czid;
	flag = db.executeUpdate(sqlstr);
	message="删除央行基准利率";
}

if ( str_flag.equals("1")){

%>
<script>
			window.close();
			opener.alert("调息日期已经存在！");
			opener.location.reload();
		</script>
<%
}


if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
<%}db.close();%>