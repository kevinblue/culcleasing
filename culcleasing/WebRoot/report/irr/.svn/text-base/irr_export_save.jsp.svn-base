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
<%@page import="com.tenwa.culc.util.cwtcExport"%>
<%@ include file="../../func/common_simple.jsp"%>
<%
	String start_date = getStr(request.getParameter("start_date"));
	String end_date = getStr(request.getParameter("end_date"));

	String if_hire = getStr(request.getParameter("if_hire"));
	String dept_no = getStr(request.getParameter("dept_no"));
	System.out.println("²âÊÔ" + dept_no);
	String proj_manage = getStr(request.getParameter("proj_manage"));
	String proj_industry = getStr(request.getParameter("proj_industry"));
	XSSFWorkbook wb = new XSSFWorkbook();
	cwtcExport t= new cwtcExport();
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition",
			"attachment; filename=rent_books_out.xlsx");
	String path = pageContext.getServletContext().getRealPath("/");
	//exportExcel.outputExcel("test",wb,response,pageContext);
	//System.out.println("shencg cr");
	System.out.print("Â·¾¶£º--------" + path);
	wb = t.export(start_date,end_date,if_hire,dept_no,proj_manage,proj_industry);
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();

	out.clear();
	out = pageContext.pushBody();
%>

