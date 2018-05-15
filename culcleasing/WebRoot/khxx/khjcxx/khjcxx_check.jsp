<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %><%@ page import="java.sql.*" %><%@ page import="dbconn.*" %><jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
String cust_id = getStr(request.getParameter("cust_id")) ;
String cust_name = getStr(request.getParameter("cust_name")) ;
String short_name = getStr(request.getParameter("short_name")) ;
String czid = getStr(request.getParameter("czid")) ;
String create_dept = "";
String stype =  getStr(request.getParameter("savetype")) ;
String sqlstr="";
ResultSet rsOrg = null;
ResultSet rsName = null;
ResultSet rsShort = null;
boolean bflag = true;
int flag=0;
String message="";
try{
	
	if (stype.equals("zz")){
		sqlstr = "select count(*) from inter_cust_info where cust_id='"+cust_id+"'";
		if(czid!=null&&!czid.equals("")){
		sqlstr +=" and cust_id<>'"+czid+"'";
		}
		System.out.println(sqlstr);
		rsOrg = db.executeQuery(sqlstr); 
		if(rsOrg.next()){
			if(rsOrg.getInt(1)>0){
				bflag = false;
				message = "客户编号重复";
			}
		}
		sqlstr = "select count(*) from inter_cust_info where cust_name='"+cust_name+"'";
		if(czid!=null&&!czid.equals("")){
			sqlstr +=" and cust_id<>'"+czid+"'";
		}
		System.out.println(sqlstr);
		rsName = db.executeQuery(sqlstr); 
		if(rsName.next()){
			if(rsName.getInt(1)>0){
				bflag = false;
				message = "客户名称重复";
			}
		}
		sqlstr = "select count(*) from inter_cust_info where short_name='"+short_name+"'";
		if(czid!=null&&!czid.equals("")){
			sqlstr +=" and cust_id<>'"+czid+"'";
		}
		System.out.println(sqlstr);
		rsShort = db.executeQuery(sqlstr); 
		if(rsShort.next()){
			if(rsShort.getInt(1)>0){
				bflag = false;
				message = "客户简称重复";
			}
		}
	}
	rsOrg.close();
	rsName.close();
	db.close();
}catch(Exception e){
	System.out.println(e);
}
%>
<%=message %>
