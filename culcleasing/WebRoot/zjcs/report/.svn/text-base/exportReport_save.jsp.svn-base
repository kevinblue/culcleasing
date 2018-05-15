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
<title>报表 - 电信项目收付款统计</title>
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
		list.add("合同编号");
	    list.add("项目名称");
	    list.add("电信公司名称");
	    list.add("租金总金额");
	    list.add("支付方式");
	    list.add("租期");
	    list.add("签约日");
	    list.add("起租日");
	    list.add("设备金额");
	    list.add("实际付款");
	    list.add("支付日期");
	    list.add("一月计划租金");
	    list.add("二月计划租金");
	    list.add("三月计划租金");
	    list.add("四月计划租金");
	    list.add("五月计划租金");
	    list.add("六月计划租金");
	    list.add("七月计划租金");
	    list.add("八月计划租金");
	    list.add("九月计划租金");
	    list.add("十月计划租金");
	    list.add("十一月计划租金");
	    list.add("十二月计划租金");
	    list.add("一月实收租金");
	    list.add("二月实收租金");
	    list.add("三月实收租金");
	    list.add("四月实收租金");
	    list.add("五月实收租金");
	    list.add("六月实收租金");
	    list.add("七月实收租金");
	    list.add("八月实收租金");
	    list.add("九月实收租金");
	    list.add("十月实收租金");
	    list.add("十一月实收租金");
	    list.add("十二月实收租金");
	
	
	
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=fpgl_out.xls");
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
