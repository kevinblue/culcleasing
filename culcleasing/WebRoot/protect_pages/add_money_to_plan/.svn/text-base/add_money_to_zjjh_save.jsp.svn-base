<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/calend.js"></script>
</head>

<BODY>
<%

String id = getStr( request.getParameter("id") );
String proj_id=getStr( request.getParameter("proj_id") );
String useid = (String) session.getAttribute("czyid");
String sqluser="select project_name from proj_info where proj_id='" + proj_id+"'";
ResultSet rsid = db.executeQuery(sqluser);
String project_name="";
if(rsid.next()){
	project_name=getDBStr(rsid.getString("project_name"));
}
String fee_name=getStr( request.getParameter("fee_name") );
String expect_money = getStr( request.getParameter("expect_money") );
String expect_put_time = getDBDateStr( request.getParameter("expect_put_time") );
String wh_modificator = getStr( request.getParameter("wh_modificator") );
String wh_modify_date = getStr( request.getParameter("wh_modify_date") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr="";
String sqlstr1="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

if ( stype.equals("mod") ){      //修改操作	
		sqlstr = "update proj_fund_fund_charge_plan set wh_status  ='未同步' ,expect_money='"+expect_money+"' ,expect_put_time='"+expect_put_time+"', wh_modificator='"+wh_modificator+"' ,wh_modify_date='"+wh_modify_date+"' where id='" + id + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		sqlstr1 = "insert into proj_fund_fund_charge_plan_log_info";
		sqlstr1 += " values('"+id+"','"+proj_id+"','"+project_name+"',"+
		"'"+fee_name+"','"+expect_money+"','"+expect_put_time+"','"+wh_modificator+"','"+wh_modify_date+"')";
		System.out.println("sqlstrsqlstr1=="+sqlstr1);
		int i=0;
		i=db.executeUpdate(sqlstr); 
		db.executeUpdate(sqlstr1); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("修改成功!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("修改失败!");
			window.history.go(-1);
		</script>
<%
		}
}
db.close();
%>


</BODY>
</HTML>
