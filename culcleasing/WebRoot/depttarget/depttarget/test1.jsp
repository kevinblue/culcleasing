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
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
                                                       
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
ResultSet rs;
ResultSet rs1;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String target_id = getStr( request.getParameter("target_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String evaluation_type = getStr( request.getParameter("evaluation_type") );
response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=1.xls");
String path = pageContext.getServletContext().getRealPath("/");

int i;
int j;
int n;
HSSFRow templateRow;           
HSSFCell cell;
//HSSFCellStyle style;
HSSFFont font;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\func\\test.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); 
//��ʽ-����
//style = wb.createCellStyle();
font = wb.createFont();
font.setFontName("����");
short color = HSSFColor.RED.index;
font.setColor(color);

//style.setFont(font);


i=2;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("����������");

i=4;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ַ/��ϵ�˼��绰��");

i=6;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("���������ƣ�");

i=8;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ַ/��ϵ�˼��绰��");

i=10;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��Ӧ��/���������ƣ�");

i=12;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ַ/��ϵ�˼��绰��");

i=14;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("���������ƣ�");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�������ͣ�");

i=16;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ַ/��ϵ�˼��绰��");

i=18;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�豸����");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��Ч���ޣ�");

i=20;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�ڲ���ҵ����");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("2008-09-02");

i=22;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ҵ�ǼǺ���:");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("����֧����ʽ��");

i=24;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��Ʒ���ͣ�");

i=26;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("���������");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�豸���룺");

i=28;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�����ʶ� / LTV%��");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�����涨��");

i=30;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ǰ���ճ���:");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("IRR / ROE% / ROA%:");

i=32;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�����˺ϼƷ��ճ���:");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("����:");

i=34;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("����/�����ܶ�/�Ⱥ�");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("��ǰ/�����������:");

i=36;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("�ر��ļ�Ҫ��");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("���׷���������");

i=58;
j=0;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("���������ƣ�����������");
/**
//�ڶ�����
int start_i;
start_i=60;//���ֿ�ʼ
int add_i=0;//����
String item_id="";
String item="";
String standard="";
List l_standard = new ArrayList();
String weighting_score="";
sqlstr="select item_id,item,standard,weighting_score from base_evaluation_score where doc_id='"+doc_id+"' order by order_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	item_id=getDBStr( rs.getString("item_id") );
	item=getDBStr( rs.getString("item") );
	standard=getDBStr( rs.getString("standard") );
	weighting_score=getDBStr( rs.getString("weighting_score") );
	
	l_standard.clear();
	sqlstr="select standard from base_evaluation_standard where item_id='"+item_id+"' order by order_number";
	rs1=db1.executeQuery(sqlstr);
	while(rs1.next()){
		l_standard.add(getDBStr( rs1.getString("standard") ) );
	}rs1.close();
	
	add_i++;add_i++;
	i=start_i+add_i;
	
	templateRow=templateSheet.createRow(i);
	
	cell=templateRow.createCell((short)0);
	cell.setCellValue(item);
	
	cell=templateRow.createCell((short)1);
	cell.setCellValue(standard);
	//System.out.println("l_standard==============="+l_standard);
	for(n=0;n<l_standard.size();n++){
		cell=templateRow.createCell((short)(2+n));
		cell.setCellValue(l_standard.get(n).toString());
	}
	
	cell=templateRow.createCell((short)7);
	cell.setCellValue(weighting_score);
	
}rs.close();


String base_score="";
sqlstr="select isnull(sum(weighting_score),0) as base_score from base_evaluation_score where doc_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	base_score=getDBStr( rs.getString("base_score") );
}rs.close();

start_i=79;//
i=start_i+add_i;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)7);
cell.setCellValue(base_score);

//��������
start_i=81;//
String other_condition="";
String comment="";
String score_adjust="";

sqlstr="select other_condition,comment,score_adjust from base_evaluation_adjust_score where evaluation_type='"+evaluation_type+"' and target_id='"+target_id+"' and doc_id='"+doc_id+"' order by order_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	other_condition=getDBStr( rs.getString("other_condition") );
	comment=getDBStr( rs.getString("comment") );
	score_adjust=getDBStr( rs.getString("score_adjust") );
	i=start_i+add_i;
	templateRow=templateSheet.createRow(i);
	
	cell=templateRow.createCell((short)0);
	cell.setCellValue(other_condition);
	cell=templateRow.createCell((short)2);
	cell.setCellValue(comment);
	cell=templateRow.createCell((short)5);
	cell.setCellValue(score_adjust);
	add_i++;
}rs.close();

//���Ĳ���
i=118+add_i;
sqlstr="select proj_equip.eqip_name,proj_equip.model,proj_equip.equip_num,proj_equip.equip_price,proj_equip.total_price from proj_equip where proj_id='"+target_id+"'";
rs=db.executeQuery(sqlstr);

int m;
while(rs.next()){
	n=0;
	m=0;
	templateRow=templateSheet.getRow(i);
	for(n=0;n<=5;n++){
	m++;
		if(n!=1){
			cell=templateRow.getCell((short)n);
			cell.setCellValue(getDBStr(rs.getString(m)));
		}else{
			m=n;
		}
		
	}
	i++;
}rs.close();
**/
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
//stream.close();
//System.out.println("loopcellHead==================================="+loopcellHead.toString());
db1.close();
db.close();
%>