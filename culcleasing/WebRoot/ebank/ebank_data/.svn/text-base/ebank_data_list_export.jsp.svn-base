<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.ss.usermodel.*"%>
<%@ page import="org.apache.poi.xssf.usermodel.*"%>
 
<%@ page import="java.io.*"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %>    
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="com.*" %> 


<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银数据导出 - </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<BODY>

<%

	String query_sql = getStr(request.getParameter("query_sql"));
	 System.out.println("query_sql="+query_sql);
	String savaType = "dao";//getStr(request.getParameter("savetype"));
	String dqczy = (String) session.getAttribute("czyid");
	System.out.println("*********");

if(savaType.equals("dao")){
	int flag=0;
	String message="";
 String sqlstr = query_sql;
	System.out.println("*********");
 %>
<%
	ResultSet rs;
	
	//      表头
	//------------取数据------end-----------
	List list = new ArrayList();
		list.add("网银编号");
	    list.add("到账银行");
	    list.add("到账账号");
	    list.add("付款账号");
	    list.add("付款客户");
	    list.add("到账金额类型");
	    list.add("到帐时间");
	    list.add("到帐金额");
	    list.add("摘要");
	
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=ebank.xlsx");
	String path = pageContext.getServletContext().getRealPath("/");
	
	//HSSFRow templateRow;
	//HSSFCell cell;
	//HSSFWorkbook wb = new HSSFWorkbook();
	//HSSFSheet templateSheet = wb.createSheet("sheet1"); 
	XSSFRow  templateRow;
	XSSFCell cell;
	XSSFWorkbook wb = new XSSFWorkbook();
	XSSFSheet templateSheet = wb.createSheet("sheet1");
	
	templateRow=templateSheet.createRow(0);
	for(int i=0;i<list.size();i++){
		//cell=templateRow.createCell((short)i);
		//cell.setCellValue((String)list.get(i));
		cell=templateRow.createCell(i);
		cell.setCellValue((String)list.get(i));
		
	}
	System.out.println("start###################################################");
	
	
	rs =db.executeQuery(sqlstr);
	int j=0;
	while (rs.next()) {
		templateRow=templateSheet.createRow(j+1);
		for(int i=0;i<list.size();i++){
			//cell=templateRow.createCell((short)i);
			cell=templateRow.createCell(i);
			cell.setCellValue(rs.getString(i+1));
		}
		j++;
		}
		rs.close();
	
	
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();
	
	
	out.clear();
	out = pageContext.pushBody();
	
	}
	db.close();

 %>
