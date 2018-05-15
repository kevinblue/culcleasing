<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %><%@ page import="java.sql.*" %><%@ page import="dbconn.*" %><jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
String cust_names = getStr(request.getParameter("cust_name"));
System.out.print("cust_names="+cust_names);
String id_card_no = getStr(request.getParameter("id_card_no")) ;
System.out.print("idid_card_no="+id_card_no);
String id = getStr(request.getParameter("cust_id")) ;
System.out.print("id="+id);
//String id_card_no = getStr(request.getParameter("id_card_no")) ;
//System.out.print("id_card_no="+id_card_no);
String stype =  getStr(request.getParameter("stype")) ;
System.out.print("stype="+stype);
String cust_name="";
String sqlstr="";
ResultSet rs = null;
 boolean bflag=true;
String message="";
try{
	sqlstr = "select cust_name from vi_cust_info where cust_name='"+cust_names+"' and cust_id<>'"+id+"'";
	System.out.println("khcode sqlstr"+sqlstr);
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
	out.print("5");
}else{
	if(stype.equals("5")){
		out.print(""+cust_name+" 重复!");
	}else{
		out.print("与已有客户名为:"+cust_name+"的 重复!");
	}
}
%>