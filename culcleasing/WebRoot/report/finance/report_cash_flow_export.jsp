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
<title>报表 - 合同现金流量表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
</head>
<BODY>

<%

	String query_sql = getStr(request.getParameter("query_sql"));
	String query_sql2 = getStr(request.getParameter("query_sql2"));
	
	String savaType = "dao";//getStr(request.getParameter("savetype"));
	String dqczy = (String) session.getAttribute("czyid");
	ResultSet rs;
	ResultSet rs1;

	List l_date_list=new ArrayList();
	rs =db.executeQuery(query_sql2);
	while (rs.next()){
		l_date_list.add(getDBStr(rs.getString("diff_date")));
	}
	rs.close();

if(savaType.equals("dao")){
	int flag=0;
	String message="";
	String sqlstr = query_sql;
	
	//      表头
	//------------取数据------end-----------
	List list = new ArrayList();
	list.add("合同号");
	list.add("租赁期限");
	list.add("同期银行贷款利率");
	list.add("投放额");
	list.add("手续费");
	list.add("保证金");
	
    for(int m=0;m<l_date_list.size();m++){
	   list.add(l_date_list.get(m)+"");
    }
	System.out.println("list长度==============="+list.size());
	
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=rent_books_out.xls");
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
			if(i<6){
				cell=templateRow.createCell((short)i);
				cell.setCellValue(rs.getString(i+1));
			}else{//3,6,9,12
				String sql2 = "select net_follow from fund_contract_plan where contract_id='"+getDBStr(rs.getString("contract_id"))+"' and convert(varchar(7),plan_date,120)='"+l_date_list.get(i-6)+"'";

				rs1 =db1.executeQuery(sql2);
				if(rs1.next()){
				 cell=templateRow.createCell((short)i);
				 cell.setCellValue(rs1.getString("net_follow"));
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
	db.close();
	db1.close();	
}
%>
