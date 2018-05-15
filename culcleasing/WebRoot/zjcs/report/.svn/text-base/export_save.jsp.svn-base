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
                                                       
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%

String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);

String sqlstr;
ResultSet rs;
sqlstr = getStr(request.getParameter("sqlstr"));

String i_row="0";
String card_id="";
String cust_name="";
String account="";
String show_amt="";
String memo="";

List l_i_row = new ArrayList();
List l_card_id = new ArrayList();
List l_cust_name = new ArrayList();
List l_account = new ArrayList();
List l_show_amt = new ArrayList();
List l_memo = new ArrayList();

//System.out.println("sqlstr000=================================="+sqlstr);
rs=db.executeQuery(sqlstr);
while(rs.next()){
	i_row=String.valueOf(Integer.parseInt(i_row)+1);
	card_id=getDBStr( rs.getString("card_id") );
	cust_name=getDBStr( rs.getString("cust_name") );
	account=getDBStr( rs.getString("account") );
	show_amt=getDBStr( rs.getString("show_amt") );
	memo=getDBStr( rs.getString("memo") );
	l_i_row.add(i_row);
	l_card_id.add(card_id);
	l_cust_name.add(cust_name);
	l_account.add(account);
	l_show_amt.add(show_amt);
	l_memo.add(memo);
}rs.close();


db.close();

//------------取数据------end-----------
List list = new ArrayList();
list.add("序号");
list.add("客户身份证号");
list.add("客户姓名");
list.add("客户帐号");
list.add("金额");
list.add("备注");

list.add("扣款标志");
list.add("余额");

response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=ebank_rent"+curr_date+".xls");
String path = pageContext.getServletContext().getRealPath("/");

HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet templateSheet = wb.createSheet("sheet1"); 
//样式,格式//begining
HSSFCellStyle cellStyle;
HSSFDataFormat df;
HSSFFont font;
cellStyle=wb.createCellStyle();
df=wb.createDataFormat();
font=wb.createFont();

cellStyle.setDataFormat(df.getFormat("#,##0.00"));
font.setFontHeightInPoints((short)9); 
font.setFontName("宋体"); 
templateSheet.setColumnWidth((short)0,(short)2000);
templateSheet.setColumnWidth((short)1,(short)5000);
templateSheet.setColumnWidth((short)2,(short)6000);
templateSheet.setColumnWidth((short)3,(short)6000);
templateSheet.setColumnWidth((short)4,(short)5000);
templateSheet.setColumnWidth((short)5,(short)7000);



//excel导出表头
//templateRow=templateSheet.createRow(0);
//for(int i=0;i<list.size();i++){
	//cell=templateRow.createCell((short)i);
	//cell.setCellValue((String)list.get(i));
//}

for(int i=0;i<l_i_row.size();i++){
	templateRow=templateSheet.createRow(i);
	list.clear();
	list.add(l_i_row.get(i));
	list.add(l_card_id.get(i));
	list.add(l_cust_name.get(i));
	list.add(l_account.get(i));
	list.add(l_show_amt.get(i));
	list.add(l_memo.get(i));
	for(int ii=0;ii<list.size();ii++){
		cell=templateRow.createCell((short)ii);
		
		if(ii==4){
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC); 
			cell.setCellStyle(cellStyle);
		}
		cell.setCellValue((String)list.get(ii));
	}
}

OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
db.close();
%>
