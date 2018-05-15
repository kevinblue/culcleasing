<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 

<%@ page import="dbconn.*"%>
<%@ page import="com.tenwa.culc.util.*"%>
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
String uuid=CommonTool.getUUID();
String is_exec = getStr( request.getParameter("is_exec") );
String wh_modificator = getStr( request.getParameter("wh_modificator") );
String wh_modify_date = getStr( request.getParameter("wh_modify_date") );
String stype = getStr( request.getParameter("savetype") );
String proj_id=getStr( request.getParameter("proj_id") );
String project_name=getStr( request.getParameter("project_name") );

String sqlstr="";
String sqlstr1="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

if ( stype.equals("mod") ){      //修改操作	
		sqlstr = "update proj_info set wh_status='未同步' , is_exec='"+is_exec+"' ,wh_modificator='"+wh_modificator+"',wh_modify_date='"+wh_modify_date+"'where id='" + id + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		
		sqlstr1 = "insert into proj_info_log_info";
		sqlstr1 += " values('"+id+"','"+proj_id+"','"+project_name+"',"+
		"'"+is_exec+"','"+wh_modificator+"','"+wh_modify_date+"')";
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
