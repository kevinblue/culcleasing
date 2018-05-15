<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %><%@ page import="java.sql.*" %><%@ page import="dbconn.*" %><jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
String czid = getStr(request.getParameter("czid"));
String org_code = getStr(request.getParameter("org_code")) ;
String cust_name = getStr(request.getParameter("cust_name")) ;
String cust_id ="";
String create_dept = "";
String stype =  getStr(request.getParameter("savetype")) ;
String sqlstr="";
ResultSet rsOrg = null;
ResultSet rsName = null;
boolean bflag = true;
int flag=0;
String message="";
try{
	
	if (stype.equals("zz")){
            if (org_code.length()>0){

		sqlstr = "select count(*) from vi_cust_info where org_code='"+org_code+"'";
		if(czid!=null&&!czid.equals("")){
		sqlstr +=" and cust_id!="+czid;
		}
		System.out.println(sqlstr);
		rsOrg = db.executeQuery(sqlstr); 
		if(rsOrg.next()){
			if(rsOrg.getInt(1)>0){
				bflag = false;
			}else{
				bflag = true;
			}
		}
	    } 
		sqlstr = "select count(*) from vi_cust_info where cust_name='"+cust_name+"'";
		if(czid!=null&&!czid.equals("")){
		sqlstr +=" and cust_id!="+czid;
		}
		System.out.println(sqlstr);
		rsName = db.executeQuery(sqlstr); 
		if(rsName.next()){
			if(rsName.getInt(1)>0){
				bflag = false;
			}
		}
	}
	System.out.println(bflag);
	if(!bflag){ flag=-1;}else{flag=-2;}
	rsOrg.close();
	rsName.close();
	db.close();
}catch(Exception e){
	System.out.println(e);
}
if(flag==-1){
%>
<%="组织机构代码或客户名称重复" %>
<%
}else if(flag==-2){
%><%="" %><%
}
%>