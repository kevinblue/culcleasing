<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %><%@ page import="java.sql.*" %><%@ page import="dbconn.*" %><jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
String code = getStr(request.getParameter("code"));
String id = getStr(request.getParameter("id")) ;
String stype =  getStr(request.getParameter("stype")) ;
String cust_name="";
String sqlstr="";
ResultSet rs = null;
String message="";
try{
	sqlstr = "select cust_name from vi_cust_all_info where code='"+code+"' and cust_id<>'"+id+"'";
	System.out.println(sqlstr);
	rs = db.executeQuery(sqlstr); 
	if(rs.next()){
		cust_name=getDBStr(rs.getString("cust_name"));
	}
	rs.close();
	db.close();
}catch(Exception e){
	System.out.println(e);
}
if(cust_name.equals("")){
	out.print("1");
}else{
	if(stype.equals("1")){
		out.print("���֤����:"+code+" �����пͻ�:"+cust_name+" �ظ�!");
	}else{
		out.print("��֯��������:"+code+" �����пͻ�:"+cust_name+" �ظ�!");
	}
}
%>