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
String cust_id = getStr( request.getParameter("cust_id") );
String att_level = getStr( request.getParameter("att_level") );
String end_date = getStr( request.getParameter("end_date") );
String memo = getStr( request.getParameter("memo") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into cust_attention (cust_id,att_level,end_date,creator,create_date,memo ) values ('" + cust_id+"','"+att_level + "','" + end_date +  "','"+ dqczy + "'," + datestr +",'" + memo +  "')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.location.reload();
		</script>
<%
	
}else if ( stype.equals("mod") ){      //修改操作
	//String czid = getStr( request.getParameter("id") );
	
		sqlstr = "update cust_attention set att_level='" + att_level + "',end_date='" + end_date +"',memo='" + memo + "',modificator='" + dqczy  + "',modify_date=" + datestr + " where id='" + czid + "'";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
	
}else if ( stype.equals("del") ){         //删除操作
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from cust_attention where id='" + czid + "'";
	db.executeUpdate(sqlstr); 
%>
<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
	</script>
    <% }
	db.close();%>
</BODY>
</HTML>

