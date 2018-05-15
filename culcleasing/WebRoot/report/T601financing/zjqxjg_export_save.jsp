<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.xssf.usermodel.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.*"%>
<%@ page import="com.tenwa.culc.util.T601Export"%>
<%@ include file="../../func/common_simple.jsp"%>
<%
	String start_date = getStr(request.getParameter("start_date"));
	System.out.print("接收时间：--------" + start_date+"---------------------");
	XSSFWorkbook wb = new XSSFWorkbook();
	T601Export t=new T601Export();
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=rent_books_out.xlsx");
	String path = pageContext.getServletContext().getRealPath("/");
		//exportExcel.outputExcel("test",wb,response,pageContext);
		//System.out.println("shencg cr");
	System.out.print("路径：--------" + path);
	wb=t.export(start_date);
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();
	
	
	out.clear();
	out = pageContext.pushBody();
%>

