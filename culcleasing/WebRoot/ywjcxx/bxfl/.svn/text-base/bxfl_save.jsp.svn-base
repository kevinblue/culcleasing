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


String bxgs_name = getStr( request.getParameter("bxgs_name") );
String bxfl = getStr( request.getParameter("bxfl") );
String rq = getStr( request.getParameter("rq") );

String stype = getStr( request.getParameter("savetype") );

String sqlstr;
ResultSet rs;
String id;
String datestr = getSystemDate(0); //获取系统时间
if ( stype.equals("add") ){        //添加操作
		sqlstr = "insert into base_bxfl ( bxgs_name ,bxfl ,rq ,djr ,djrq ,gxr ,gxrq ) values ('" + bxgs_name + "'," + bxfl  + ",'" + rq  + "','" + dqczy + "','" + datestr + "','" + dqczy + "','" + datestr + "')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
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

	sqlstr = "update base_bxfl set bxgs_name='" + bxgs_name + "',bxfl=" + bxfl  + ",rq='" + rq + "',gxr='" + dqczy + "',gxrq='" + datestr + "' where id='" + id + "'";
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
	sqlstr = "delete from base_bxfl where id='" + id + "'";
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
