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
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String path = pageContext.getServletContext().getRealPath("/");

int i;
int j;
int n;
HSSFRow templateRow;           
HSSFCell cell;
HSSFFont font;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\func\\租金首付款.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); 
List list = new ArrayList();
String contract_id="";
String tmp="";
String rent="";
String fin_date="";
String arr_date="";
String rent_arr[];
String fin_arr[];
String arr_arr[];

for(i=3;i<=2366;i++){
//for(i=10;i<=10;i++){
	templateRow=templateSheet.getRow(i);
	cell=templateRow.getCell((short)1);
	
	contract_id=cell.toString().trim();
	System.out.println("contract_id---------------------------------:::"+contract_id);
	if(contract_id.equals("")){
		continue;
	}
	for(j=1;j<=81;j++){
	//for(j=37;j<=39;j++){
		cell=templateRow.getCell((short)(j+26));
		if(null==cell){
			tmp="";
			list.add(tmp);
		}else{
			System.out.println("type---------------------------------:::"+cell.getCellType());
			
			
			if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING || cell.getCellType() == 3) {
				list.add(cell.getStringCellValue());
			} else {
				tmp = NumberFormat.getNumberInstance().format(cell.getNumericCellValue());
		        while(tmp.indexOf(",")>-1){
			        tmp = tmp.substring(0,tmp.indexOf(","))+tmp.substring(tmp.indexOf(",")+1);
			    }
				list.add(tmp);
			}
		}
		
		if(j%3==0){
			//System.out.println("list---------------------------------:::"+list);
			rent=list.get(0).toString().trim();
			fin_date=list.get(1).toString().trim();
			arr_date=list.get(2).toString().trim();
			
			System.out.println("rent:::"+rent);
			System.out.println("fin_date:::"+fin_date);
			System.out.println("arr_date:::"+arr_date);
			
			if(null!=rent && !"".equals(rent)&&null!=fin_date && !"".equals(fin_date)&&null!=arr_date && !"".equals(arr_date)){
				rent_arr=rent.split("/");
				fin_arr=fin_date.split("/");
				arr_arr=arr_date.split("/");
				if(rent_arr.length==fin_arr.length && rent_arr.length==arr_arr.length){
					for(n=0;n<rent_arr.length;n++){
						sqlstr="insert into etemp_fund_rent (contract_id,rent,fin_date,hire_date) select '"+contract_id+"',"+rent_arr[n]+",'"+fin_arr[n]+"','"+arr_arr[n]+"'";
						System.out.println("sqlstr:::"+sqlstr);
						db.executeUpdate(sqlstr);
					}
				}
			}else if((null==rent || "".equals(rent))&&(null==fin_date || "".equals(fin_date))&&(null==arr_date || "".equals(arr_date))){
				
			}else{
				
				sqlstr="insert into etemp_contract select '"+contract_id+"'";
				System.out.println("sqlstr:::"+sqlstr);
				db.executeUpdate(sqlstr);
			}
			list.clear();
		}
	}
}



db.close();
%>