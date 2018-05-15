<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String czid = getStr(request.getParameter("czid"));
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
		
		sqlstr = "select count(*) from vi_cust_use_info where cust_name='"+cust_name+"'";
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
<%="客户名称重复" %>
<%
}else if(flag==-2){
%><%="" %><%
}
%>