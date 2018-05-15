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
<title>资产管理 - 发票管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<BODY>

<%

	String id = getStr(request.getParameter("id"));
	 System.out.println("id="+id);
	String savaType=getStr(request.getParameter("savetype"));
	String dqczy = (String) session.getAttribute("czyid");
	System.out.println("*********");

if(savaType.equals("dao")){
	int flag=0;
	String message="";
	//String wherestr=getStr( request.getParameter("where_str") );
 String sqlstr = "select vi_fund_invoice.id,vi_fund_invoice.project_name,vi_fund_invoice.contract_id,vi_fund_invoice.cust_name,vi_fund_invoice.feetype_name,vi_fund_invoice.plan_list,vi_fund_invoice.plan_money,vi_fund_invoice.plan_date from proj_invoice left join proj_invoice_detail on proj_invoice.id=proj_invoice_detail.proj_invoice_id left join vi_fund_invoice on vi_fund_invoice.id=proj_invoice_detail.plan_id where  proj_invoice.id="+id+"";
	System.out.println("*********");
 %>
<%
ResultSet rs;

//      
//------------取数据------end-----------
List list = new ArrayList();
list.add("序号");
list.add("项目名称");

list.add("合同编号");

list.add("发票抬头");
list.add("款项名称");
list.add("期数 ");
list.add("金额 ");
list.add("计划收款日期 ");



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
