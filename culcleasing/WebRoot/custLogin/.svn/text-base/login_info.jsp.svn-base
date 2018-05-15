<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<%
  String sqlstr="";

  String user_name = request.getParameter("username");
  String password=request.getParameter("password");
  System.out.println("===userId--send--==:"+user_name);
//查询数据库
  boolean flag = false;
  String sql="select * from base_cust_user where user_name='"+user_name+"' and password='"+password+"'";
  System.out.println("-----:"+sql);
  String cust_id="";
  int cust_person_id=0;
  ResultSet rs=db.executeQuery(sql);
  if(rs.next()){
	  cust_id=rs.getString("cust_id");
	  cust_person_id=rs.getInt("cust_person_id");
	  %>
  
	<script>
	 //alert("aaaa");
	 window.open('index.jsp?cust_id=<%=cust_id%>&user_name=<%=user_name%>&password=<%=password%>&cust_person_id=<%=cust_person_id%>');
    </script>
	<%}else{%>
	<script>
		alert("密码或用户名错误！请重新登陆！");
		history.go(-1);
	</script>
	<%
  }
  
  //插入登陆日志
	sqlstr +="insert into sys_login_logInfo(login_date,login_user_id)";
	sqlstr +="values(getdate(),'"+user_name+"')";
	db.executeUpdate(sqlstr);
	db.close();
%>
