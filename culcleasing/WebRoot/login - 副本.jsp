<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>



<%@ page import="java.sql.*" %> 

<%
  String sqlstr="";
	int row=0;
  String userid = request.getParameter("uuid");
  String login_user_ip=request.getRemoteAddr();
  String loign_user_host=request.getRemoteHost();
  System.out.println("===userId--send--==:"+userid);
//ע��sessionId
  boolean flag = false;
  if(userid!=null&&!userid.equals("")){
  	session.setAttribute("czyid",userid);
  	System.out.println("===session_uid==:"+session.getAttribute("czyid").toString());
}
  	flag = true;
  
  //�����½��־
//	sqlstr +="insert into sys_login_logInfo(login_date,login_user_id,login_user_ip,login_user_hostname) ";
//	sqlstr +="values(getdate(),'"+userid+"','"+login_user_ip+"','"+loign_user_host+"')";
//	LogWriter.logDebug(request,"����Ҫ��"+sqlstr);
//	row=db.executeUpdate(sqlstr);

%>
