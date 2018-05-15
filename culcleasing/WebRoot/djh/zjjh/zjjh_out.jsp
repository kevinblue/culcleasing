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
//读取相关数据
int size=0;
ResultSet rs;
String sqlstr="select count(id) as s from fund_rent_income";
rs = db.executeQuery(sqlstr); 
if(rs.next()){
	size=rs.getInt("s");
}
rs.close();
sqlstr = "select inm.id,dbo.getcustnamebycontractid(inm.contract_id) as cust_name,inm.contract_id,dbo.getmodelbyid(info.device_type) as device_type,inm.ebank_number,inm.plan_list,inm.hire_list,inm.hire_type,inm.balance_mode,inm.hire_date,inm.invoice_no,inm.rent,inm.corpus,inm.interest,inm.penalty,inm.rent_adjust,inm.corpus_adjust,inm.interest_adjust,inm.penalty_adjust,inm.hire_source,inm.hire_object,inm.hire_bank,inm.hire_account,inm.hire_number,inm.accounting_date,inm.instead_flag,inm.memo from fund_rent_income as inm left join contract_equip as info  on (info.contract_id=inm.contract_id) where invoice_no=null order by id desc"; 
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
int i=0;
String tempdate[][]=new String[size][27];
while (rs.next()){
tempdate[i][0]=getDBStr( rs.getString("id") );
tempdate[i][1]=getDBStr( rs.getString("cust_name") );
tempdate[i][2]=getDBStr( rs.getString("contract_id") ) ;
tempdate[i][3]=getDBStr( rs.getString("device_type") ) ;
tempdate[i][4]=getDBStr( rs.getString("ebank_number") ) ;
tempdate[i][5]=getDBStr( rs.getString("plan_list") ) ;
tempdate[i][6]=getDBStr( rs.getString("hire_list") ) ;
tempdate[i][7]=getDBStr( rs.getString("hire_type") ) ;
tempdate[i][8]=getDBStr( rs.getString("balance_mode") ) ;
tempdate[i][9]=getDBDateStr( rs.getString("hire_date")) ;
tempdate[i][10]=getDBStr( rs.getString("rent")) ;
tempdate[i][11]=getDBStr( rs.getString("corpus") ) ;
tempdate[i][12]=getDBStr( rs.getString("interest")) ;
tempdate[i][13]=getDBStr( rs.getString("penalty")) ;
tempdate[i][14]=getDBStr( rs.getString("rent_adjust")) ;
tempdate[i][15]=getDBStr( rs.getString("corpus_adjust") ) ;
tempdate[i][16]=getDBStr( rs.getString("interest_adjust")) ;
tempdate[i][17]=getDBStr( rs.getString("penalty_adjust")) ;
tempdate[i][18]=getDBStr( rs.getString("hire_source") ) ;
tempdate[i][19]=getDBStr( rs.getString("hire_object") ) ;
tempdate[i][20]=getDBStr( rs.getString("hire_bank") ) ;
tempdate[i][21]=getDBStr( rs.getString("hire_account") );
tempdate[i][22]=getDBStr( rs.getString("hire_number") );
tempdate[i][23]=getDBDateStr( rs.getString("accounting_date") );
tempdate[i][24]=getDBStr( rs.getString("instead_flag") );
tempdate[i][25]=getDBStr( rs.getString("memo") );
tempdate[i][26]=getDBStr( rs.getString("invoice_no") );
i++;
}
rs.close();
db.close();
//获取execl模板
response.reset();
response.setContentType("application/x-msexcel;charset=gbk"); 
response.setHeader("Content-disposition","attachment; filename=zjjh_out.xls");
String path = pageContext.getServletContext().getRealPath("/");
HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\zjjh_out.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄

for (int j=0;j<size;j++){
	for (int k=0;k<27;k++){
		templateRow=templateSheet.createRow(j+1);
		cell=templateRow.createCell((short)k);
		System.out.println(tempdate[j][k]);
		cell.setCellValue(tempdate[j][k]);
	}
}
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
%>
<script>window.close();</script>