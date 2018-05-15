<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="org.apache.poi.hssf.util.*"%> 
<%@ page import="org.apache.poi.poifs.filesystem.*"%> 
<%@ page import="java.io.*"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %>    
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-list-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>         
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//读取相关数据
String id = getStr( request.getParameter("id") );
String machine_type = "";
String machine_no="";
String sim_no="";
String gps_terminal_type = "";
String gps_index_type= "";
String install_date="";
String cust_name="";
String lease_term="";
String service_mouth="";
String car_group="";
ResultSet rs;
String sqlstr = "select install_date,cust_name,lease_term,datediff(mm,service_begindate,isnull(renewals_enddate2,isnull(renewals_enddate1,service_enddate))) as service_mouth,gps_terminal_type,gps_index_type,machine_no,machine_type,sim_no,car_group from vi_examine_info where gpsinfo_id='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
  service_mouth = getDBStr( rs.getString("service_mouth") );
  gps_terminal_type = getDBStr( rs.getString("gps_terminal_type") );
  gps_index_type = getDBStr( rs.getString("gps_index_type") );
  machine_type = getDBStr( rs.getString("machine_type") );
  machine_no = getDBStr( rs.getString("machine_no") );
  sim_no = getDBStr( rs.getString("sim_no") );
  car_group = getDBStr( rs.getString("car_group") );	
  install_date = getDBDateStr( rs.getString("install_date") );		
  lease_term=rs.getString("lease_term");
  cust_name=rs.getString("cust_name");
}
rs.close();
db.close();

//获取execl模板
response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=gps_out.xls");
String path = pageContext.getServletContext().getRealPath("/");
HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\gps_out.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄
HSSFCellStyle   style   =   wb.createCellStyle();
HSSFFont   font   =   wb.createFont();
style.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);//   下边框   
style.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);//   左边框   
style.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);//   右边框   
style.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);//   上边框
String temp="";
//安装日期
templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)0);
temp=install_date;
String[] temp_date=temp.split("-");
temp="安装日期：  "+temp_date[0]+"年  "+temp_date[1]+"月 "+temp_date[2]+"日";
cell.setCellStyle(style);
cell.setCellValue(temp);
//NO
templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)7);
cell.setCellStyle(style);
cell.setCellValue(id);
//客户名称
templateRow=templateSheet.createRow(6);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(cust_name);
//租赁期限
templateRow=templateSheet.createRow(6);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue("共"+lease_term+"个月");
//GPS服务年限
templateRow=templateSheet.createRow(6);
cell=templateRow.createCell((short)7);
cell.setCellStyle(style);
cell.setCellValue("共 "+service_mouth+"个月");
//GPS车载终端型号（版本号）b8
templateRow=templateSheet.createRow(7);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(gps_terminal_type);
//GPS车载终端型号（序列号)D10
templateRow=templateSheet.createRow(9);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(gps_index_type);
//机编号D8
templateRow=templateSheet.createRow(7);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(machine_no);
//型号B10
templateRow=templateSheet.createRow(9);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(machine_type);
//SIM卡号
templateRow=templateSheet.createRow(11);
cell=templateRow.createCell((short)1);
cell.setCellStyle(style);
cell.setCellValue(sim_no);
//车载终端分组
templateRow=templateSheet.createRow(10);
if(car_group.equals("CCFL组")){
	cell=templateRow.createCell((short)1);
	temp="1．CCFL组(√)";
}else if(car_group.equals("LSHM")){
	cell=templateRow.createCell((short)3);
	temp="2．自编组□ LSHM(√) Hap Seng( ) CMB( )";
}else if(car_group.equals("Hap Seng")){
	cell=templateRow.createCell((short)3);
	temp="2．自编组□ LSHM( ) Hap Seng(√) CMB( )";
}else if(car_group.equals("CMB")){
	cell=templateRow.createCell((short)3);
	temp="2．自编组□ LSHM( ) Hap Seng( ) CMB(√)";
}
cell.setCellStyle(style);
cell.setCellValue(temp);

OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
db.close();
%>