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
String sqlstr="select count(id) as s from fund_fund_charge_hap";
rs = db.executeQuery(sqlstr); 
if(rs.next()){
	size=rs.getInt("s");
}
rs.close();
sqlstr = "select hap.id,hap.contract_id,dbo.getcustnamebycontractid(hap.contract_id) as cust_name,dbo.getmodelbyid(info.device_type) as device_type,ebank_number,charge_list,type.feetype_name,dbo.fk_getname(settle_method) as settle_method,fact_date,fact_money,fee_adjust,dbo.fk_getname(currency) as currency,fact_object,account_bank,account,acc_number,client_bank,client_account,client_accnumber,accounting_date,item_method,invoice_no,memo from fund_fund_charge_hap as hap left join contract_equip as info  on (hap.contract_id=info.contract_id)left join base_feetype as type on (type.feetype_number=fee_type)  where invoice_no=null  order by id desc"; 
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
int i=0;
String tempdate[][]=new String[size][23];
while (rs.next()){
tempdate[i][0]=getDBStr( rs.getString("id") );
tempdate[i][1]=getDBStr( rs.getString("contract_id") );
tempdate[i][2]=getDBStr( rs.getString("cust_name") ) ;
tempdate[i][3]=getDBStr( rs.getString("device_type") ) ;
tempdate[i][4]=getDBStr( rs.getString("ebank_number") ) ;
tempdate[i][5]=getDBStr( rs.getString("charge_list") ) ;
tempdate[i][6]=getDBStr( rs.getString("feetype_name") ) ;
tempdate[i][7]=getDBStr( rs.getString("settle_method") ) ;
tempdate[i][8]=getDBDateStr( rs.getString("fact_date") ) ;
tempdate[i][9]=formatNumberStr( rs.getString("fact_money") ,"#,##0.00") ;
tempdate[i][10]=getDBStr( rs.getString("fee_adjust") ) ;
tempdate[i][11]=getDBStr( rs.getString("currency") ) ;
tempdate[i][12]=getDBStr( rs.getString("fact_object") ) ;
tempdate[i][13]=getDBStr( rs.getString("account_bank") ) ;
tempdate[i][14]=getDBStr( rs.getString("account") ) ;
tempdate[i][15]=getDBStr( rs.getString("acc_number") ) ;
tempdate[i][16]=getDBStr( rs.getString("client_bank") ) ;
tempdate[i][17]=getDBStr( rs.getString("client_account") ) ;
tempdate[i][18]=getDBStr( rs.getString("client_accnumber") ) ;
tempdate[i][19]=getDBDateStr( rs.getString("accounting_date") ) ;
tempdate[i][20]=getDBStr( rs.getString("item_method") ) ;
tempdate[i][21]=getDBStr( rs.getString("memo") ) ;
tempdate[i][22]=getDBStr( rs.getString("invoice_no") );
i++;
}
rs.close();
db.close();

//获取execl模板
response.reset();
response.setContentType("application/x-msexcel;charset=gbk"); 
response.setHeader("Content-disposition","attachment; filename=zjsz_out.xls");
String path = pageContext.getServletContext().getRealPath("/");
HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\zjsz_out.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //获得第一页工作薄

for (int j=0;j<size;j++){
	for (int k=0;k<23;k++){
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
<script>alert();window.close();</script>