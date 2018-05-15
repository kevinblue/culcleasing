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
<%@page import="com.tenwa.culc.util.reportExp.FactHireGapDetailExport"%>
<%@ include file="../../func/common_simple.jsp"%>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<%
	String project_name = getStr( request.getParameter("project_name") );
	String cust_name = getStr( request.getParameter("cust_name") );
	String board_name = getStr( request.getParameter("board_name") );
	String manage_name = getStr( request.getParameter("manage_name") );
	String dept_name = getStr( request.getParameter("dept_name") );
	
	String min_ljqs=getStr( request.getParameter("min_ljqs") );
	String max_ljqs=getStr( request.getParameter("max_ljqs") );
	String min_ljts=getStr( request.getParameter("min_ljts") );
	String max_ljts=getStr( request.getParameter("max_ljts") );
	
	String min_zzqs=getStr( request.getParameter("min_zzqs") );
	String max_zzqs=getStr( request.getParameter("max_zzqs") );
	String min_zzts=getStr( request.getParameter("min_zzts") );
	String max_zzts=getStr( request.getParameter("max_zzts") );
	
	
	//拼接查询
	if(project_name!=null && !"".equals(project_name)){
		wherestr+=" and project_name like '%"+project_name+"%'";
	}
	if(cust_name!=null && !"".equals(cust_name)){
		wherestr+=" and cust_name like '%"+cust_name+"%'";
	}
	if(board_name!=null && !"".equals(board_name)){
		wherestr+=" and board_name like '%"+board_name+"%'";
	}
	if(manage_name!=null && !"".equals(manage_name)){
		wherestr+=" and manage_name like '%"+manage_name+"%'";
	}
	if(dept_name!=null && !"".equals(dept_name)){
		wherestr+=" and dept_name like '%"+dept_name+"%'";
	}
	if(min_ljqs!=null && !"".equals(min_ljqs) && max_ljqs!=null && !"".equals(max_ljqs)){
		wherestr+=" and ljqs>="+min_ljqs+" and ljqs<="+max_ljqs;
	}
	if(min_ljts!=null && !"".equals(min_ljts) && max_ljts!=null && !"".equals(max_ljts)){
		wherestr+=" and ljts>="+min_ljts+" and ljts<="+max_ljts;
	}
	if(min_zzqs!=null && !"".equals(min_zzqs) && max_zzqs!=null && !"".equals(max_zzqs)){
		wherestr+=" and zzqs>="+min_zzqs+" and zzts<="+max_zzqs;
	}
	if(min_zzts!=null && !"".equals(min_zzts) && max_zzts!=null && !"".equals(max_zzts)){
		wherestr+=" and zzts>="+min_zzts+" and zzts<="+max_zzts;
	}
	
	//列出所有项目不受时间影响
	wherestr += " and exists(select id from fund_rent_income where begin_id=vi_report_penal_gap_d.begin_id)";
	System.out.println("wherestr：--------" + wherestr);
		
	XSSFWorkbook wb = new XSSFWorkbook();
	FactHireGapDetailExport t= new FactHireGapDetailExport();
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition",
	"attachment; filename=fact_hire_gap.xlsx");
	String path = pageContext.getServletContext().getRealPath("/");
	//exportExcel.outputExcel("test",wb,response,pageContext);
	//System.out.println("shencg cr");
	System.out.println("路径：--------" + path);
	wb = t.export(wherestr);
	//System.out.println("wherestr：--------" + wherestr);
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();

	out.clear();
	out = pageContext.pushBody();
%>

