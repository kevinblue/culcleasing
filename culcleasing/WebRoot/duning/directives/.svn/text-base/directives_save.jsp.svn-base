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
String id = getStr( request.getParameter("czid") );
String directive_date = getStr( request.getParameter("directive_date") );
String directive_info = getStr( request.getParameter("directive_info") );
String cust_id = getStr( request.getParameter("cust_id") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into dunning_directives (cust_id, directive_date, directive_info ,directiver) values ('" + cust_id + "','" + directive_date + "','" + directive_info + "','"  + dqczy  +"')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.parent.location.reload();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //修改操作
	String czid = getStr( request.getParameter("czid") );
	
		sqlstr = "update dunning_directives set directive_info='" + directive_info+ "' where directive_id='" + id + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.parent.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	String czid = getStr( request.getParameter("czid") );
	sqlstr = "delete from dunning_directives where directive_id='" + id + "'";
	db.executeUpdate(sqlstr); 
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.parent.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>
