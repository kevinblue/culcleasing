<%@ page language="java" pageEncoding="gbk"  errorPage="/public/pageError.jsp" %>
<%@ page import="jxl.*"%> 
<%@ page import="jxl.write.*"%> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.math.BigDecimal" %> 
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.format.VerticalAlignment"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Colour"%> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<% 
String sqldata = getStr( request.getParameter("sqldata") );//�����ֶ�

String choiceType = getStr( request.getParameter("choiceType") );//�ж��Ƿ�ȫ������
String datasqlstr = getStr( request.getParameter("datasqlstr") );

//
String sql_str =" ";
String col_str = "";
col_str =" qy ����,dld ������,subcompany ��֧����,shortname ������˾,vt.proj_id ��Ŀ���,khmc �ͻ�����,cust_id �ͻ����,card_id ����֤��,phone ��ϵ��ʽ,";
col_str+=" prod_id ����������,manufacturer ������,method ���򸶿�,model_id ����,equip_sn �������,BodyNo ���ܺ�,";
col_str+=" cast(equip_amount as decimal) ̨��,lx_date ��������,proj_pz_date ������׼����,proj_qy_date ǩԼ����,check_date ��������,";
col_str+=" proj_qzconfirm_date ����ȷ������,cast(lease_term as decimal)��������,end_leasing_date ���޵�����,equip_delivery_place �����ص�,";
col_str+=" case when vpf.zlwfk_fact_date is null then '0%' else cast(isnull(fk_ratio1,100)+isnull(fk_ratio2,0) as varchar(10))+'%' end �ſ����, ";
col_str+=" case when vpf.zlwfk_fact_date is null then '��' else '��' end �Ƿ�ſ�,vpf.zlwfk_plan_date �ƻ��ſ�����,vpf.zlwfk_fact_date ʵ�ʷſ�����,equip_amt �����ﹺ��ۿ�,";
col_str+=" lease_zl_money �������޶�,head_ratio �������,lease_money ���ʽ��,head_amt '1�������',";
col_str+=" caution_money '2��֤��',every_rent '3��һ�����',insurance_lessor '4���շ�',handling_charge '5������',";
col_str+=" lessee_caution_money '6������',nominalprice '7�����ۿ�',first_payment '���ڸ���ϼ�',sale_caution_money '8DB��֤��',zdb_bzj תDB��֤��,";
col_str+=" supervision_fee '9���������',first_paytype �׸���ʽ,rent_paytype ���ʽ,sfk_plan_date �ƻ����ڸ�����,sfk_fact_date ʵ�����ڸ�����,";
col_str+=" total_rent ����ܶ�,total_interest ��Ϣ�ܼ�,cast((lease_term-un_received_amount) as decimal) �ѻ�������,";
col_str+=" (total_rent-left_rent) �ѻ����,cast(un_received_amount as decimal)ʣ���������,left_rent ������,left_corpus ʣ�౾��,left_interest ʣ����Ϣ,overdue_sum �������,";
col_str+=" overdue_day ��������,total_penalty ΥԼ��ϼ�,paid_penalty ����ΥԼ��,(total_penalty-paid_penalty) δ��ΥԼ��,cast(overdue_amount as decimal) ��������,";
col_str+=" (select cast(lj_overdue_amount as decimal) from v_overdue_info where proj_id=vt.proj_id) �ۼ�����,";
col_str+=" bank ��������, account �����˺�,js_status ������ʽ,status_name ״̬ ";

if( choiceType!=null && !"".equals(choiceType) && "allData".equals(choiceType) ){//ȫѡ
	sql_str = "select "+col_str+" from vi_report_super_proj vt left join vi_proj_fk vpf on vpf.proj_id=vt.proj_id where 1=1 "+datasqlstr;
}else{
	sql_str = "select "+col_str+" from vi_report_super_proj vt left join vi_proj_fk vpf on vpf.proj_id=vt.proj_id where id in("+sqldata+")";
}

ResultSet rs=db.executeQuery(sql_str); 

ResultSetMetaData rsmd = rs.getMetaData();
int numberOfColumns = rsmd.getColumnCount();
short rownum = 0;
BigDecimal tempdec=new BigDecimal("0.00");

response.reset();
response.setContentType("application/vnd.ms-excel;charset=GB2312");
response.setHeader("Content-disposition","attachment; filename=super_proj_"+getSystemDate(3)+".xls");
jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
jxl.write.WritableSheet ws = wwb.createSheet("Sheet1",0);

jxl.write.Label l=null;
jxl.write.Number n=null;
jxl.write.DateTime d=null; 

//Ԥ�����һЩ����͸�ʽ
WritableFont headerFont = new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD, false,jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLUE); 
WritableCellFormat headerFormat = new WritableCellFormat (headerFont); 
headerFormat.setAlignment(Alignment.CENTRE);//����
headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
headerFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//������ʽ
WritableFont titleFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.RED); 
WritableCellFormat titleFormat = new WritableCellFormat (titleFont); 
titleFormat.setAlignment(Alignment.CENTRE);
titleFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
titleFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//��ͨ�ı���ʽ
WritableFont detFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.NO_BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK); 
WritableCellFormat detFormat = new WritableCellFormat (detFont);
detFormat.setAlignment(Alignment.CENTRE);
detFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
detFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
detFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
detFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//number��ʽ
jxl.write.NumberFormat nf=new jxl.write.NumberFormat("#.######");  //����Number�ĸ�ʽ
WritableCellFormat priceFormat = new WritableCellFormat (detFont, nf); 
priceFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
priceFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
priceFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
priceFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

jxl.write.DateFormat df=new jxl.write.DateFormat("yyyy-MM-dd");//�������ڵ�
WritableCellFormat dateFormat = new WritableCellFormat (detFont, df); 
dateFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
dateFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
dateFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
dateFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//#####======������=======######
short cellnum;
//�����
l = new jxl.write.Label(0, 0, "���", titleFormat);
ws.addCell(l);
for (cellnum = (short)1; cellnum <= numberOfColumns; cellnum++)
{
	//ws.setColumnView(cellnum, 10);   
	l = new jxl.write.Label(cellnum,0, rsmd.getColumnName(cellnum), titleFormat);
	ws.addCell(l);
}

//#####======��������=======######
while(rs.next())
{
	rownum+=1;//Ϊÿһ�и�ֵ
	//���
	l = new jxl.write.Label(0,rownum, rownum+"", detFormat);
	ws.addCell(l);
	//������
	for (cellnum = (short)1; cellnum <= numberOfColumns; cellnum++)
	{
	   if ( (rsmd.getColumnTypeName(cellnum).equals("money")) || (rsmd.getColumnTypeName(cellnum).equals("decimal")) )
	   {
			tempdec=rs.getBigDecimal(cellnum,4);
			if ((tempdec==null) || (tempdec.equals("")))
			{
				tempdec=new BigDecimal("0.0000");
			}
			n = new jxl.write.Number(cellnum,rownum, rs.getDouble(cellnum), priceFormat);
			ws.addCell(n);
	   }else if( rsmd.getColumnTypeName(cellnum).equals("datetime") && rs.getDate(cellnum)!=null ){
		    d = new jxl.write.DateTime(cellnum,rownum, rs.getDate(cellnum), dateFormat);
			ws.addCell(d);
	   }
	   else
	   {
			l = new jxl.write.Label(cellnum,rownum, rs.getString(cellnum), detFormat);
			ws.addCell(l);
	   }						
	}
}

rs.close();
db.close(); 
wwb.write();
wwb.close();

response.reset();
response.setContentType("text/html; charset=gb2312");
%>
