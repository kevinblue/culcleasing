<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="org.apache.poi.hssf.util.*"%> 
<%@ page import="org.apache.poi.poifs.filesystem.*"%> 
<%@ page import="java.io.*"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %>    
<%@ page import="java.math.BigDecimal" %> 
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
//读取相关数据
String czy = (String) session.getAttribute("czyid");
String path = pageContext.getServletContext().getRealPath("/");
String id = getStr( request.getParameter("id") );
ResultSet rs;
String sqlstr ="select type,addr from rent_list where id='"+id+"'"; 
rs = db.executeQuery(sqlstr); 
rs.next();
String addr= rs.getString("addr");
String type= rs.getString("type");
String allpath="";
if(type.equals("1")){
	allpath=path+"\\upload\\zdkk\\down\\"+addr;
}else{
	allpath=path+"\\upload\\zdkk\\up\\"+addr;
}
	sqlstr="select dbo.getusername('"+czy+"') as name";
	System.out.println(sqlstr);
	rs = db.executeQuery(sqlstr); 
	rs.next();
	String name= rs.getString("name");
	sqlstr="update rent_list set remark=isnull(remark,'')+'  ["+getSystemDate(0)+" "+name+" 下载该文件一次!]' where id='"+id+"'"; 
	db.executeUpdate(sqlstr);
	System.out.println(sqlstr);

//获取execl模板
response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename="+addr);
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(allpath)));
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
%>
<%if(null != db){db.close();}%>