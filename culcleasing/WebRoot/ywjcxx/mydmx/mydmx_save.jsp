<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");


String dept_id = getStr( request.getParameter("dept_id") );
String item = getStr( request.getParameter("item") );
String indicator_def = getStr( request.getParameter("indicator_def") );
String standard = getStr( request.getParameter("standard") );
String frequency = getStr( request.getParameter("frequency") );
String examiner = getStr( request.getParameter("examiner") );

String stype = getStr( request.getParameter("savetype") );

String sqlstr;
ResultSet rs;
String id;
String datestr = getSystemDate(0); //获取系统时间

//System.out.println("stype=="+stype);
if ( stype.equals("add") ){        //添加操作
//System.out.println("111==");
		sqlstr = "insert into perf_satissurvey_model ( dept_id ,item ,indicator_def ,standard ,frequency ,examiner ,creator ,create_date ,modificator ,modify_date ) values ('" + dept_id + "','" + item  + "','" + indicator_def  + "','" + standard  + "','" + frequency  + "','" + examiner  + "','" + dqczy + "','" + datestr + "','" + dqczy + "','" + datestr + "')";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 
%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //修改操作
	id = getStr( request.getParameter("id") );

	sqlstr = "update perf_satissurvey_model set dept_id='" + dept_id + "',item='" + item  + "',indicator_def='" + indicator_def  + "',standard='" + standard  + "',frequency='" + frequency  + "',examiner='" + examiner + "',modificator='" + dqczy + "',modify_date='" + datestr + "' where id='" + id + "'";
	//System.out.println("sqlstrsqlstr=="+sqlstr);
	db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	id = getStr( request.getParameter("id") );
	sqlstr = "delete from perf_satissurvey_model where id='" + id + "'";
	db.executeUpdate(sqlstr);
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>
