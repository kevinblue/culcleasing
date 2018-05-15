<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="org.apache.poi.hssf.util.*"%> 
<%@ page import="org.apache.poi.poifs.filesystem.*"%> 
<%@ page import="java.io.*"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %>    
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="com.*" %> 


<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 项目收付款明细表</title>
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
	    list.add("合同号");
	    list.add("项目名称");
        list.add("计划日期");
	    list.add("期次");
	    list.add("租金");
	
	    list.add("本金");
    	list.add("利息");
	    list.add("剩余本金");
	    list.add("租息");
	    list.add("手续费");
	    list.add("其它收入");
	    list.add("其它支出");
	 
	    
	
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=contract_out.xls");
	String path = pageContext.getServletContext().getRealPath("/");
	
	HSSFRow templateRow;
	HSSFCell cell;
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet templateSheet = wb.createSheet("sheet1"); 
	
	templateRow=templateSheet.createRow(0);
	for(int i=0;i<list.size();i++){
		cell=templateRow.createCell((short)i);
		cell.setCellValue((String)list.get(i));
		
	}
	System.out.println("start###################################################");
	
	
	rs =db.executeQuery(sqlstr);
	int j=0;
	while (rs.next()) {
		templateRow=templateSheet.createRow(j+1);
		for(int i=0;i<list.size();i++){
			cell=templateRow.createCell((short)i);
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
