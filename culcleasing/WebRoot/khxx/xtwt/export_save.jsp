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
<title>�ʲ����� - ��Ʊ����</title>
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
 String sqlstr = "select id,refer_date,xm=dbo.GETUSERNAME(refer_person),model,action,describe,type,degree,remark,manage_person,manage_opinion,manage_date,state from system_suggestion";
	System.out.println("*********");
 %>
<%
ResultSet rs;

//      
//------------ȡ����------end-----------
List list = new ArrayList();
list.add("���");
list.add("�ύ����");
list.add("�ύ��");

list.add("ģ��");

list.add("����");

list.add("���� ");
list.add("���� ");
list.add("�̶� ");
list.add("��ע");

list.add("������ ");
list.add("������� ");
list.add("����ʱ��");
list.add("����״̬ ");



response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=suggestion.xls");
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
