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
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );

String close_year = getStr( request.getParameter("close_year") );
String close_month = getStr( request.getParameter("close_month") );
String close_day = getStr( request.getParameter("close_day") );
String status = getStr( request.getParameter("status") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
String reFlag_add="";
String reFlag_mod="";
if ( stype.equals("add") ){ 
	sqlstr="select * from inter_finance_closeday where close_year='"+close_year+"' and close_month='"+close_month+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		reFlag_add="1";
	}rs.close();
	message="添加财务关帐日";
	if(reFlag_add.equals("")){
		sqlstr="insert into inter_finance_closeday (close_year,close_month,close_day,close_staff,create_date,status) values('"+close_year+"','"+close_month+"','"+close_day+"','"+dqczy+"','"+curr_date+"','"+status+"')";
		//System.out.println("sqlstr00======================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		sqlstr="exec create_evidence '"+close_day+"'";
		flag = db.executeUpdate(sqlstr);
	}else{
		%>
		<script>
			history.back(-1);
			alert("<%=message%>失败,财务关帐日不能重复!");
		</script>
		<%
	}

}
if ( stype.equals("mod") ){ 
	sqlstr="select * from inter_finance_closeday where close_day='"+close_day+"' and id<>"+czid;
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		reFlag_mod="1";
	}rs.close();
	message="修改财务关帐日";
	if(reFlag_mod.equals("")){
		sqlstr="update inter_finance_closeday set status='"+status+"' where id='"+czid+"'";
		//System.out.println("sqlstr======================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
	}else{
		%>
		<script>
			history.back(-1);
			alert("<%=message%>失败,财务关帐日不能重复!");
		</script>
		<%
	}

}
if ( stype.equals("del") ){ 
	sqlstr="delete from inter_finance_closeday where  id='"+czid+"'";
	flag = db.executeUpdate(sqlstr);
	message="删除权限模块";
}
//修改网银数据
//sqlstr="update fund_ebank_data set tempfact_flag='是' where arrive_date<='"+close_day+"'";
//System.out.println("sqlstr11======================"+sqlstr);
//db.executeUpdate(sqlstr);


db.close();
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
<%}%>