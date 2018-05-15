<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common_simple.jsp"%>

<%
String sqlstr="";
int flag=0;
	
String sql_bh_ids = getStr(request.getParameter("sql_bh_ids")) ;
try{
	sqlstr = " update fund_fund_charge_plan set export_flag=0 where item_method='ÍøÒø' and isnull(status,'0')<>'1' and funds_mode='ÊÕ¿î' and proj_id in ("+sql_bh_ids+")";
	db.executeUpdate(sqlstr);
	flag++; 
	db.close();
}catch(Exception e){
	System.out.println(e);
	flag=0;
}
if(flag>0){
%>
<%="-1" %>
<%
}else {
%>
<%="0" %>
<%
}
%>