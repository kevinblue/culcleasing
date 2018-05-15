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
String plan_id=getStr(request.getParameter("plan_id"));
System.out.println("plan_id^^^^^^^^^^^^^^^^^^^^^"+plan_id);
System.out.println("czid&&&&&&&&&&&&&&&&&&&&&&"+czid);

String factoring = getStr(request.getParameter("factoring") );
String factoring_pringcipal = getStr(request.getParameter("factoring_pringcipal") );
String factoring_rantal=getStr(request.getParameter("factoring_rantal"));

String stype = getStr( request.getParameter("savetype") );
String systemDate = getSystemDate(0);



String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into fund_rent_plan (factoring,factoring_pringcipal,factoring_rantal) values ('" + factoring + "','" + factoring_pringcipal + "','" + factoring_rantal + "')";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		
<%
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
	//String czid = getStr( request.getParameter("id") );
	sqlstr="update fund_rent_plan set factoring='"+factoring+"',factoring_pringcipal='"+factoring_pringcipal+"',factoring_rantal='"+factoring_rantal+"' where id='"+czid+"'";
		
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		
<%
		db.executeUpdate(sqlstr);
%>
		<script>

opener.window.location.href = "factoring.jsp";
		alert("修改成功!");
		this.close();
		
				//window.close();
			//opener.alert("修改成功!");
		
			//opener.location.reload();
			
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	
	sqlstr = "delete from fund_rent_plan where id='" + czid + "'";
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

