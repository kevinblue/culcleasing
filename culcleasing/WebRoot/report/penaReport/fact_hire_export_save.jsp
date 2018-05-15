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
<%@page import="com.tenwa.culc.util.reportExp.FactHireGapExport"%>
<%@page import="sun.awt.windows.WWindowPeer"%>
<%@ include file="../../func/common_simple.jsp"%>

<%
	String start_date = getStr(request.getParameter("start_date"));
	String end_date = getStr(request.getParameter("end_date"));
	String project_name = getStr( request.getParameter("project_name") );
	String cust_name = getStr( request.getParameter("cust_name") );
	String board_name = getStr( request.getParameter("board_name") );
	String manage_name = getStr( request.getParameter("manage_name") );
	String dept_name = getStr( request.getParameter("dept_name") );
	//String wherestr=getStr( request.getParameter("str") );
	//System.out.println("wherestr£º--------" + wherestr);
	XSSFWorkbook wb = new XSSFWorkbook();
	FactHireGapExport t= new FactHireGapExport();
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition",
	"attachment; filename=fact_hire_gap.xlsx");
	String path = pageContext.getServletContext().getRealPath("/");
	//exportExcel.outputExcel("test",wb,response,pageContext);
	//System.out.println("shencg cr");
	System.out.println("Â·¾¶£º--------" + path);
	wb = t.export(start_date,end_date,project_name,cust_name,board_name,dept_name,manage_name);
	//System.out.println("wherestr£º--------" + wherestr);
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();

	out.clear();
	out = pageContext.pushBody();
%>

