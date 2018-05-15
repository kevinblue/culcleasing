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
if (right.CheckRight("zdkk-zdkk-down",dqczy)>0) canedit=1;
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
String name =(String)session.getAttribute("zdkk_name");
String date =(String)session.getAttribute("zdkk_date");
if(name==null||name.equals("")||name=="null"){
	name="";
}
if(date==null){
	date=getSystemDate(0);
}
boolean bfag=true;
ResultSet rs;
String sqlstr="select top 1  type,addr  from rent_list order by createdate desc ";
rs = db.executeQuery(sqlstr); 
if(rs.next()){
	String type_temp=rs.getString("type");
	String addr=rs.getString("addr");
	if(type_temp.equals("1")){
		bfag=false;
		%>
<script>
alert("您已经导出过一次扣款文件(文件名为:<%=addr%>)!请先上传一次相关的回盘文件!");
window.history.go(-1);
</script>
<%
	}
}
if(bfag){
sqlstr ="select * from table_zdkk('"+date+"','"+name+"')"; 
rs = db.executeQuery(sqlstr); 

//获取execl模板
/*response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=zdkk_out.xls");*/
String path = pageContext.getServletContext().getRealPath("/");
HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\zdkk_out.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄
String temp="";
double rent_temp=0;
int i=1;
while (rs.next()){
  temp = getDBStr( rs.getString("cust_name") );
  templateRow=templateSheet.createRow(i);
  cell=templateRow.createCell((short)0);
  cell.setCellValue(temp);
  
  temp = getDBStr( rs.getString("client_acc_number") );
  templateRow=templateSheet.createRow(i);
  cell=templateRow.createCell((short)1);
  cell.setCellValue(temp);
  
  rent_temp=rs.getDouble("all_rent");
  rent_temp=rent_temp<0?0:rent_temp;
  templateRow=templateSheet.createRow(i);
  cell=templateRow.createCell((short)2);
  cell.setCellValue(rent_temp);
  
  rent_temp=rs.getDouble("rent");
  rent_temp=rent_temp<0?0:rent_temp;
  templateRow=templateSheet.createRow(i);
  cell=templateRow.createCell((short)3);
  cell.setCellValue(rent_temp);
  
  rent_temp=rs.getDouble("fx");
  rent_temp=rent_temp<0?0:rent_temp;
  templateRow=templateSheet.createRow(i);
  cell=templateRow.createCell((short)4);
  cell.setCellValue(rent_temp);
  
  rent_temp=rs.getDouble("fx");
  rent_temp=rent_temp<0?0:rent_temp;
  templateRow=templateSheet.createRow(i);
  cell=templateRow.createCell((short)5);
  cell.setCellValue(date);
  i++;
}
rs.close();
//保存记录
String filename=new Date().getTime()+".xls";
File fs=new File(path+"\\upload\\zdkk\\down\\"+filename);
fs.createNewFile();
OutputStream osf=new FileOutputStream(path+"\\upload\\zdkk\\down\\"+filename);
wb.write(osf);
osf.close();
String czyid=(String)session.getAttribute("czyid");
sqlstr="insert into rent_list (type,creator,createdate,addr,is_verification) values ('1','"+czyid+"',getdate(),'"+filename+"','3')";
db.executeUpdate(sqlstr);
db.close();
/*
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();*/
%>
<script>
alert("文件以成功保存到服务器,该文件名为: <%=filename%> 。(您可以在  主动扣款导入导出记录  功能模块中下载该文件!)");
window.history.go(-1);
</script>
<%
}
%>