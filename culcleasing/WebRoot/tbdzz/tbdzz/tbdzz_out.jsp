<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="org.apache.poi.hssf.util.*"%> 
<%@ page import="org.apache.poi.poifs.filesystem.*"%> 
<%@ page import="java.io.*"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.GregorianCalendar" %> 
<%@ page import="dbconn.*" %>    
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
                                                       
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//读取相关数据
String type=request.getParameter("type");//制作那个投保单
String contract_id=request.getParameter("contract_id");
String cust_name="";//投保人  客户名称
String cust_code="";//投保人  客户类别(法人或个人)
String mobile_number="";//投保人联系电话
String code="";//投保人身份证或组织结构ID
String addr="";//投保人地址;
String post_code="";//邮编

String eqip_name="";//保险设备名称 
String device_type="";//设备型号 
String model="";//设备类型 
String equip_sn="";//机编号 
String engine_code="";//发动机编号 

//contract_condition
String start_date="";//保险期限开始日期
String end_date="";//保险期限结束日期
String cust_insurance="";//客户承担的保险费
String lsh_insurance="";//LSH支付
String insurance="";//保险费
String insurer="";//保险公司
String insurance_type="";//险种
//
String dealer="";//经销商(利星行)
	
String manufacturer="";//生产厂商
String leave_date="";//出厂日期
String equip_amt="";//租赁物总价格
String lease_term="";//租赁期限(月)
String mouth="";//保险期限月份
String sqlstr="select * from vi_baoxian where contract_id='"+contract_id+"'";
ResultSet rs=db.executeQuery(sqlstr); 
if(rs.next()){
cust_name=rs.getString("cust_name");//投保人  客户名称
cust_code=rs.getString("cust_code");
mobile_number=rs.getString("mobile_number");//投保人联系电话
code=rs.getString("code");//投保人身份证或组织结构ID
addr=rs.getString("addr");//投保人地址;
post_code=rs.getString("post_code");//邮编

eqip_name=rs.getString("eqip_name");//保险设备名称 
device_type=rs.getString("device_type");//设备型号 
model=rs.getString("model");//设备型号 
equip_sn=rs.getString("equip_sn");//机编号 
engine_code=rs.getString("engine_code");//发动机编号 

//contract_condition
start_date=rs.getString("start_date");//保险期限开始日期
end_date=rs.getString("end_date");//保险期限结束日期
cust_insurance=rs.getString("cust_insurance");//客户承担的保险费
lsh_insurance=rs.getString("lsh_insurance");//LSH支付
insurance=rs.getString("insurance");//保险费
insurer=rs.getString("insurer");//保险公司
insurance_type=rs.getString("insurance_type");//险种
//
dealer=rs.getString("dealer");//经销商(利星行)	
manufacturer=rs.getString("manufacturer");//生产厂商
leave_date=rs.getString("leave_date");//出厂日期
equip_amt=rs.getString("equip_amt");//租赁物总价格
lease_term=rs.getString("lease_term");//租赁期限(月)
mouth=rs.getString("mouth");//保险期限月份
}


//获取execl模板
response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=tbdzz.xls");
String path = pageContext.getServletContext().getRealPath("/");
HSSFRow templateRow;
HSSFCell cell;
if(type.equals("pingan")){
//=========================================平安保险=========================================================================
File file = new File(path+"\\execl\\pingan.xls");
ByteArrayOutputStream bos = new ByteArrayOutputStream();
	            FileInputStream fis = new FileInputStream(file); 
	            byte[] bytes = new byte[512]; //file is object of java.io.File for which you want the byte array
	            int count;
	            while ((count = fis.read(bytes)) != -1)
	                bos.write(bytes, 0, count);
	            byte[] allBytes = bos.toByteArray();
	            InputStream byteIS = new ByteArrayInputStream(allBytes);
	      HSSFWorkbook     wb = new HSSFWorkbook(byteIS);
//HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\pingan.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄

HSSFCellStyle   style   =   wb.createCellStyle();
HSSFFont   font   =   wb.createFont();
style.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
//style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
//style.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
//style.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框

templateRow=templateSheet.createRow(8);
cell=templateRow.createCell((short)5);
cell.setCellStyle(style);
cell.setCellValue(equip_amt);//备投保价值人民币

templateRow=templateSheet.createRow(7);
cell=templateRow.createCell((short)6);
cell.setCellStyle(style);
cell.setCellValue(insurance);//总保险费

templateRow=templateSheet.createRow(16);
cell=templateRow.createCell((short)4);
cell.setCellStyle(style);
cell.setCellValue(cust_name);//投保人

templateRow=templateSheet.createRow(17);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(mobile_number);//电话

templateRow=templateSheet.createRow(17);
cell=templateRow.createCell((short)10);
cell.setCellStyle(style);
cell.setCellValue(code);//身份证

templateRow=templateSheet.createRow(18);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(addr+"    "+post_code);//地址及邮编

templateRow=templateSheet.createRow(19);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(dealer);//经销商

templateRow=templateSheet.createRow(20);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(eqip_name);//保险设备

templateRow=templateSheet.createRow(21);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(device_type);//设备型号

templateRow=templateSheet.createRow(21);
cell=templateRow.createCell((short)7);
cell.setCellStyle(style);
cell.setCellValue(equip_sn);//机编号

templateRow=templateSheet.createRow(21);
cell=templateRow.createCell((short)11);
cell.setCellStyle(style);
cell.setCellValue(engine_code);//发动机

templateRow=templateSheet.createRow(20);
cell=templateRow.createCell((short)9);
cell.setCellStyle(style);
cell.setCellValue(insurance);//投保金额

templateRow=templateSheet.createRow(22);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(start_date);//保险起始日

templateRow=templateSheet.createRow(22);
cell=templateRow.createCell((short)7);
cell.setCellStyle(style);
cell.setCellValue(end_date);//保险结束日

OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
db.close();
}else if(type.equals("zhonghua")){
//=========================================中华保险=========================================================================
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\zhonghua.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄
HSSFCellStyle   style   =   wb.createCellStyle();
HSSFFont   font   =   wb.createFont();
style.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);//   下边框  

templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(cust_name);//被保人

templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)6);
cell.setCellStyle(style);
cell.setCellValue(mobile_number);//电话

templateRow=templateSheet.createRow(4);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(addr);//地址

templateRow=templateSheet.createRow(4);
cell=templateRow.createCell((short)6);
cell.setCellStyle(style);
cell.setCellValue(cust_name);//联系人

templateRow=templateSheet.createRow(5);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(eqip_name);//设备名称

templateRow=templateSheet.createRow(5);
cell=templateRow.createCell((short)6);
cell.setCellStyle(style);
cell.setCellValue(device_type);//设备型号

templateRow=templateSheet.createRow(6);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(equip_sn);//机编号 设备编号

templateRow=templateSheet.createRow(6);
cell=templateRow.createCell((short)6);
cell.setCellValue(manufacturer);//生产厂商

templateRow=templateSheet.createRow(7);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(leave_date);//出厂日期

templateRow=templateSheet.createRow(8);
cell=templateRow.createCell((short)6);
cell.setCellStyle(style);
cell.setCellValue(model);//设备类型

templateRow=templateSheet.createRow(9);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(equip_amt);//租赁物总价格

templateRow=templateSheet.createRow(12);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(insurance);//保险费


templateRow=templateSheet.createRow(21);
cell=templateRow.createCell((short)0);
cell.setCellValue("保险期间：自 "+start_date+"零时起至"+end_date+"二十四时止，共"+mouth+"个月。");//保险期间

OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
db.close();	
}else{
//=========================================其他保险=========================================================================
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\other.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄

HSSFCellStyle   style   =   wb.createCellStyle();
HSSFFont   font   =   wb.createFont();
style.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框 
style.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框

templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(dealer);//经销商

templateRow=templateSheet.createRow(4);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(device_type);//设备型号

templateRow=templateSheet.createRow(5);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(equip_sn);//机编号

templateRow=templateSheet.createRow(6);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(engine_code);//发动机

templateRow=templateSheet.createRow(8);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(cust_name);//被保人

templateRow=templateSheet.createRow(12);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(mobile_number);//电话
if(cust_code.equals("个人")){
templateRow=templateSheet.createRow(9);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(code);//身份证
}else{
templateRow=templateSheet.createRow(10);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(code);//组织结构
}
templateRow=templateSheet.createRow(11);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(addr);//地址

templateRow=templateSheet.createRow(13);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(equip_amt);//整机价格

templateRow=templateSheet.createRow(21);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(start_date);//生效日期

templateRow=templateSheet.createRow(18);
cell=templateRow.createCell((short)4);
cell.setCellStyle(style);
cell.setCellValue(insurance);//保险总计

templateRow=templateSheet.createRow(19);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(insurer);//保险公司

templateRow=templateSheet.createRow(20);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(insurance_type);//险种

OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
db.close();	
}

%>