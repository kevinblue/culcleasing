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

String card_id="";
String cust_name="";
String account="";
String plan_money="";
String memo="";
String i_row="0";
List l_card_id = new ArrayList();
List l_cust_name = new ArrayList();
List l_account = new ArrayList();
List l_plan_money = new ArrayList();
List l_memo = new ArrayList();
List l_i_row = new ArrayList();

rs=db.executeQuery(sqlstr);
System.out.println("sql===="+sqlstr);
while(rs.next()){
	i_row=String.valueOf(Integer.parseInt(i_row)+1);
	card_id=getDBStr( rs.getString("card_id") );
	cust_name=getDBStr( rs.getString("cust_name") );
	account=getDBStr( rs.getString("account") );
	plan_money=getDBStr( rs.getString("plan_money") );
	memo=getDBStr( rs.getString("memo") );
	l_i_row.add(i_row);
	l_card_id.add(card_id);
	l_cust_name.add(cust_name);
	l_account.add(account);
	l_plan_money.add(plan_money);
	l_memo.add(memo);
}rs.close();

//导出的项目不能再导出
String sqlstr_1="update fund_fund_charge_plan set export_flag='1' where proj_id in (select memo from ("+sqlstr+")a)";
db.executeUpdate(sqlstr_1);

//取得导出流水号
String no="";
sqlstr="select count(*)+1 as no from export_no where export_type='资金' and export_date='"+curr_date+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	no=getDBStr( rs.getString("no") );
}rs.close();
if(no.length()==1){
	no="0"+no;
}
sqlstr="insert into export_no select '资金','"+curr_date+"','"+no+"'";
db.executeUpdate(sqlstr);

db.close();

//------------取数据------end-----------
List list = new ArrayList();
list.add("序号");
list.add("客户身份证号");
list.add("客户姓名");
list.add("客户帐号");
list.add("金额");
list.add("备注(项目编号)");
list.add("成功/不成功");

String partFileName=curr_date.replaceAll("-","")+no;

response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
String header="attachment; filename=income"+partFileName+".xls";
response.setHeader("Content-disposition",header);
String path = pageContext.getServletContext().getRealPath("/");

HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet templateSheet = wb.createSheet("sheet1"); 
templateSheet.setColumnWidth((short)0,(short)1000);
templateSheet.setColumnWidth((short)1,(short)5000);
templateSheet.setColumnWidth((short)2,(short)7000);
templateSheet.setColumnWidth((short)3,(short)6000);
templateSheet.setColumnWidth((short)4,(short)5000);
templateSheet.setColumnWidth((short)5,(short)5000);
templateSheet.setColumnWidth((short)6,(short)2000);

//加入生成excel表头
//templateRow=templateSheet.createRow(0);
//for(int i=0;i<list.size();i++){
	//cell=templateRow.createCell((short)i);
	//cell.setCellValue((String)list.get(i));
//}

//System.out.println("start###################################################");
for(int i=0;i<l_i_row.size();i++){
	templateRow=templateSheet.createRow(i);
	list.clear();
	list.add(l_i_row.get(i));
	list.add(l_card_id.get(i));
	list.add(l_cust_name.get(i));
	list.add(l_account.get(i));
	list.add(l_plan_money.get(i));
	list.add(l_memo.get(i));
	for(int ii=0;ii<list.size();ii++){
		cell=templateRow.createCell((short)ii);
		cell.setCellValue((String)list.get(ii));
	}
}
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();


out.clear();
out = pageContext.pushBody();
db.close();
%>
<script>
alert("asdasdsa");
window.close();
</script>
