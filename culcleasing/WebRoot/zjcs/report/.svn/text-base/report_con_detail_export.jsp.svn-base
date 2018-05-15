<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
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
	String query_sql2 = getStr(request.getParameter("query_sql2"));
	 System.out.println("query_sql="+query_sql);
	String savaType = "dao";//getStr(request.getParameter("savetype"));
	String dqczy = (String) session.getAttribute("czyid");
	ResultSet rs;
	ResultSet rs1;
	
	System.out.println("*********");
	List l_date_list=new ArrayList();
	rs =db.executeQuery(query_sql2);
	while (rs.next()){
		l_date_list.add(getDBStr(rs.getString("plan_date")));
	
	}
	rs.close();

if(savaType.equals("dao")){
	int flag=0;
	String message="";
 String sqlstr = query_sql;
	System.out.println("*********");
 %>
<%
	
	//      表头
	//------------取数据------end-----------
	List list = new ArrayList();
		list.add("分公司");
	    list.add("合同编号");
	    list.add("设备款金额");
	   for(int m=0;m<l_date_list.size();m++){
	   
	   list.add(l_date_list.get(m)+"租金");
	   list.add("本金");
	   list.add("利息");
	   }
	System.out.println("list长度==============="+list.size());
	
	
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=rent_con_detial_out.xls");
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
			if(i<3){
			cell=templateRow.createCell((short)i);
			cell.setCellValue(rs.getString(i+1));
			}else if(i%3==0){//3,6,9,12
			String sql2="select dbo.bb_getMonthRent('"+getDBStr(rs.getString("contract_id"))+"','"+l_date_list.get(i/3-1)+"',2) as total_rent";
			System.out.println("sql2_rent======"+sql2);
			rs1 =db1.executeQuery(sql2);
			if(rs1.next()){
			 cell=templateRow.createCell((short)i);
			 cell.setCellValue(rs1.getString("total_rent"));
			}
			rs1.close();
			}else if(i%3==1){//4,7,10.....
			String sql2="select dbo.bb_getMonthCorpus('"+getDBStr(rs.getString("contract_id"))+"','"+l_date_list.get(i/3-1)+"',2) as total_corpus ";
			System.out.println("sql2_corpus======"+sql2);
			rs1 =db1.executeQuery(sql2);
			if(rs1.next()){
			 cell=templateRow.createCell((short)i);
			 cell.setCellValue(rs1.getString("total_corpus"));
			}
			rs1.close();
			}else if(i%3==2){
			String sql2="select dbo.bb_getMonthInterest('"+getDBStr(rs.getString("contract_id"))+"','"+l_date_list.get(i/3-1)+"',2) as total_interest";
			System.out.println("sql2_interest======"+sql2);
			rs1 =db1.executeQuery(sql2);
			if(rs1.next()){
			 cell=templateRow.createCell((short)i);
			 cell.setCellValue(rs1.getString("total_interest"));
			}
			rs1.close();
			 }
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
<%if(null != db1){db1.close();}%>