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
 String sqlstr = "select vi_invoice.id,vi_invoice.project_name,vi_invoice.net_lease_money,vi_invoice.contract_id,vi_invoice.cust_name,vi_invoice.eptd_rent,vi_invoice.income_number,vi_invoice.rent,vi_invoice.plan_date,vi_invoice.corpus,vi_invoice.interest from proj_invoice left join proj_invoice_detail on proj_invoice.id=proj_invoice_detail.proj_invoice_id left join vi_invoice on vi_invoice.id=proj_invoice_detail.plan_id where  proj_invoice.id="+id+"";
	System.out.println("*********");
 %>
<%
ResultSet rs;

//      
//------------取数据------end-----------
List list = new ArrayList();
list.add("序号");
list.add("项目名称");
list.add("合同额");

list.add("合同编号");

list.add("发票抬头");

list.add("本期数 ");
list.add("总期数 ");
list.add("租金 ");
list.add("还款日期 ");
list.add("本金");
list.add("利息 ");



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
