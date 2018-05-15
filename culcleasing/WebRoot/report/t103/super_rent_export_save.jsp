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
String sqldata = getStr( request.getParameter("sqldata") );//主键字段

String choiceType = getStr( request.getParameter("choiceType") );//判断是否全部操作
String datasqlstr = getStr( request.getParameter("datasqlstr") );


String excel_name = "super_proj";
String sql_str =" ";
String col_str = "";
col_str =" qy 区域,dld 代理商,proj_id 项目编号,khmc 客户名称,cust_id 客户编号,card_id 身份证,";
col_str+=" prod_id 租赁物类型,manufacturer 制造商,method 项目类型,model_id 机型,equip_sn 出厂编号,";
col_str+=" cast(equip_amount as decimal) 数量,lx_date 申请日期,proj_pz_date 信审批准日期,proj_qy_date 签约日期,check_date 验收日期,";
col_str+=" proj_qzconfirm_date 起租确认日期,cast(lease_term as decimal)租赁期限,end_leasing_date 租赁到期日,equip_amt 租赁物购买价款,";
col_str+=" lease_zl_money 融资租赁额,head_ratio 起租比例,lease_money 融资金额,head_amt '1起租租金',";
col_str+=" caution_money '2保证金',every_rent '3第一期租金',insurance_lessor '4保险费',handling_charge '5手续费',";
col_str+=" lessee_caution_money '6担保费',nominalprice '7留购价款',first_payment '首期付款合计',sale_caution_money '8DB保证金',";
col_str+=" supervision_fee '9管理服务费',first_paytype 首付方式,total_rent 租金总额,cast((lease_term-un_received_amount) as decimal) 已还租期数,";
col_str+=" (total_rent-left_rent) 已还租金,cast(un_received_amount as decimal)剩余租金期数,left_rent 剩余租金,left_corpus 剩余本金,overdue_sum 逾期租金,overdue_day 逾期天数,";
col_str+=" total_penalty 违约金合计,paid_penalty 已收违约金,(total_penalty-paid_penalty) 未收违约金,cast(overdue_amount as decimal) 连续逾期,bank 开户银行,";
col_str+=" account 开户账号,status_name 状态 ";

if( choiceType!=null && !"".equals(choiceType) && "allData".equals(choiceType) ){//全选
	sql_str = "select "+col_str+" from vi_proj_simple_detail_info where 1=1 "+datasqlstr;
}else{
	sql_str = "select "+col_str+" from vi_proj_simple_detail_info where id in("+sqldata+")";
}

ResultSet rs=db.executeQuery(sql_str); 

ResultSetMetaData rsmd = rs.getMetaData();
int numberOfColumns = rsmd.getColumnCount();
short rownum = 0;
BigDecimal tempdec=new BigDecimal("0.00");

response.reset();
response.setContentType("application/vnd.ms-excel;charset=GB2312");
response.setHeader("Content-disposition","attachment; filename="+excel_name+getSystemDate(3)+".xls");
jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
jxl.write.WritableSheet ws = wwb.createSheet("Sheet1",0);

jxl.write.Label l=null;
jxl.write.Number n=null;
jxl.write.DateTime d=null; 

//预定义的一些字体和格式
WritableFont headerFont = new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD, false,jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLUE); 
WritableCellFormat headerFormat = new WritableCellFormat (headerFont); 
headerFormat.setAlignment(Alignment.CENTRE);//居中
headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
headerFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//标题样式
WritableFont titleFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.RED); 
WritableCellFormat titleFormat = new WritableCellFormat (titleFont); 
titleFormat.setAlignment(Alignment.CENTRE);
titleFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
titleFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//普通文本样式
WritableFont detFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.NO_BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK); 
WritableCellFormat detFormat = new WritableCellFormat (detFont);
detFormat.setAlignment(Alignment.CENTRE);
detFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
detFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
detFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
detFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//number样式
jxl.write.NumberFormat nf=new jxl.write.NumberFormat("#.######");  //用于Number的格式
WritableCellFormat priceFormat = new WritableCellFormat (detFont, nf); 
priceFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
priceFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
priceFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
priceFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

jxl.write.DateFormat df=new jxl.write.DateFormat("yyyy-MM-dd");//用于日期的
WritableCellFormat dateFormat = new WritableCellFormat (detFont, df); 
dateFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
dateFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
dateFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
dateFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//#####======标题行=======######
short cellnum;
//序号列
l = new jxl.write.Label(0, 0, "序号", titleFormat);
ws.addCell(l);
for (cellnum = (short)1; cellnum <= numberOfColumns; cellnum++)
{
	//ws.setColumnView(cellnum, 10);   
	l = new jxl.write.Label(cellnum,0, rsmd.getColumnName(cellnum), titleFormat);
	ws.addCell(l);
}

//#####======数据内容=======######
while(rs.next())
{
	rownum+=1;//为每一行附值
	//序号
	l = new jxl.write.Label(0,rownum, rownum+"", detFormat);
	ws.addCell(l);
	//主数据
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

