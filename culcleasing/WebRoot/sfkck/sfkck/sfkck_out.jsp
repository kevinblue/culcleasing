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
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("advance-sfkck-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//��ȡ�������
String end_date=request.getParameter("end_date");//��ֹ����
String cust_name="";// �ͻ�����
String contract_id="";//��ͬ���
String equip_sn="";//����� 
String sale_name="";//�ֹ�˾

String begin_payment="";//�����׸��ܶ�
String fact_money="";//ʵ�ս��

String pay_date="";//Ӧ������
String out_day="";//����������

String sqlstr = "select DISTINCT * from (select con.contract_id,equip_sn,cust_name,dbo.fk_getname(proj_dept) as sale_name,begin_payment,isnull((select sum(fact_money) from fund_fund_charge_lsm where contract_id=info.contract_id and (fee_type=11 or fee_type=15 or fee_type=13 )),0) as fact_money, dateadd(dd,isnull(special_date_number,0),out_time) as pay_date,isnull(datediff(dd,dateadd(dd,isnull(special_date_number,0),out_time),'"+end_date+"'),0) as out_day from contract_condition as con left join contract_info as info  on info.contract_id=con.contract_id left join contract_equip as equip on info.contract_id=equip.contract_id left join vi_cust_all_info as cust on info.cust_id=cust.cust_id left join fund_fund_charge_lsm as sm on info.contract_id=sm.contract_id left join fund_rent_advance as adv on info.contract_id=adv.contract_id ) as f where (f.begin_payment-f.fact_money)>0 and f.out_day>=0 and f.pay_date is not null order by out_day desc";
System.out.println("====="+sqlstr);
ResultSet rs;
//��ȡexeclģ��
response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=sfkck.xls");
String path = pageContext.getServletContext().getRealPath("/");
HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\execl\\sfkck.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); //��õ�һҳ������
rs=db.executeQuery(sqlstr); 
int i=1;
while(rs.next()){
	contract_id=getDBStr( rs.getString("contract_id") ) ;
	cust_name=getDBStr( rs.getString("cust_name") ) ;
	equip_sn=getDBStr( rs.getString("equip_sn") ) ;
	sale_name=getDBStr( rs.getString("sale_name") ) ;
	begin_payment=getDBStr( rs.getString("begin_payment") ) ;
	fact_money=getDBStr( rs.getString("fact_money") ) ;
	pay_date=getDBDateStr( rs.getString("pay_date") ) ;
	out_day=getDBStr( rs.getString("out_day") ) ;
	
templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)0);
cell.setCellValue(i);//���

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)1);
cell.setCellValue(equip_sn);//�����

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)2);
cell.setCellValue(cust_name);//�ͻ�

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)3);
cell.setCellValue(sale_name);//�ֹ�˾

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)4);
cell.setCellValue(begin_payment);//�����׸��ܶ�

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)5);
cell.setCellValue(fact_money);//ʵ�ս�����ϸ��

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)6);
cell.setCellValue(pay_date);//���ջ�������

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)7);
cell.setCellValue(end_date);//��ֹ����

templateRow=templateSheet.createRow(i);
cell=templateRow.createCell((short)8);
cell.setCellValue(out_day);//����������

i++;
}
rs.close();
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
rs.close();
db.close();	

%>