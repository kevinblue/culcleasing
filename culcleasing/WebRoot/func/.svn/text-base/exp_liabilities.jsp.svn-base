<%@ page language="java" import="java.net.URL,java.util.*" pageEncoding="gbk"  errorPage="/public/pageError.jsp" %>
<%@ page import="jxl.*"%> 
<%@ page import="jxl.write.*"%> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.math.BigDecimal" %> 
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.format.VerticalAlignment"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Colour"%> 
<%@ page import="com.tenwa.culc.financing.util.FinancingReportUtil"%>
<%@ include file="common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<% 
String str = null;
String wherestr=" where 1=1 ";

String excel_name = getStr(request.getParameter("excel_name"));
String drawings_date_end = getStr( request.getParameter("drawings_date_end") );
if(drawings_date_end==null || "".equals(drawings_date_end)){
	drawings_date_end=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
}
String dollar_currency_rate = getStr( request.getParameter("dollar_currency_rate") );
double dollar_currency_rate_d =1d;
try{
	dollar_currency_rate_d = Double.valueOf(dollar_currency_rate).doubleValue();
}
catch(Exception e){
	dollar_currency_rate_d =1d;
}
String hongKong_dollar_rate = getStr( request.getParameter("hongKong_dollar_rate") );
double hongKong_dollar_rate_d =1d;
try{
	hongKong_dollar_rate_d = Double.valueOf(hongKong_dollar_rate).doubleValue();
}
catch(Exception e){
	hongKong_dollar_rate_d =1d;
}
String rmb_rate = getStr( request.getParameter("rmb_rate") );
double rmb_rate_d =1d;
try{
	rmb_rate_d = Double.valueOf(rmb_rate).doubleValue();
}
catch(Exception e){
	rmb_rate_d =1d;
}

String leftCorpusFlag = getStr( request.getParameter("leftCorpusFlag") );
if("否".equals(leftCorpusFlag)){
	wherestr +=" and drawings_id in (select de.drawings_id from (select drawings_id ,isnull(SUM(refund_corpus),0) as sum_refund_corpus from financing_refund_plan where refund_plan_date > '"+drawings_date_end+"' group by drawings_id ) de where de.sum_refund_corpus <> 0 )";
	wherestr +=" and drawings_date <= '"+drawings_date_end+"' ";
}//时间判断
if("是".equals(leftCorpusFlag)){
	wherestr +=" and ( drawings_id not in (select de.drawings_id from (select drawings_id ,isnull(SUM(refund_corpus),0) as sum_refund_corpus from financing_refund_plan where refund_plan_date > '"+drawings_date_end+"' group by drawings_id ) de where de.sum_refund_corpus <> 0 ) ";
	wherestr +=" or drawings_date > '"+drawings_date_end+"' ) ";
}


String sql="select * from vi_financing_drawings_detail "+wherestr+" order by crediter,id ";
String curr_date = getSystemDate(3);
System.out.println("--数据导出Sql：--"+sql);
ResultSet rs=db.executeQuery(sql); 

ResultSetMetaData rsmd = rs.getMetaData();
int numberOfColumns = rsmd.getColumnCount();
short rownum = 0;
BigDecimal tempdec=new BigDecimal("0.00");

response.reset();
response.setContentType("application/vnd.ms-excel;charset=GB2312");
response.setHeader("Content-disposition","attachment; filename="+excel_name+"_"+curr_date+".xls");
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
String[] tableHead ={"查询日期","提款日期","提款编号","授信单位","贷款类型"
		,"提款金额（原币）","已还金额（原币）","剩余本金（原币)"
		,"即期剩余本金（原币）","非即期剩余本金（原币）"
		,"币种","汇率","剩余本金（人民币）"
		,"即期剩余本金（人民币）","非即期剩余本金（人民币）"
		,"费用未摊销余额（人民币）"
		,"即期费用未摊销余额（人民币）","非即期费用未摊销余额（人民币）"
		,"带息负债余额"
		,"即期带息负债","非即期带息负债"
		,"当前利率","表内外分类","贷款类别","质押情况","担保情况","境内外分类","融资方式","利率类型","期限类型"};
int i = 0;
for (cellnum = (short)1; cellnum <=tableHead.length; cellnum++)
{
	l = new jxl.write.Label(cellnum,0, tableHead[i++], titleFormat);
	ws.addCell(l);
}

//#####======数据内容=======######
java.text.DateFormat sdf= new java.text.SimpleDateFormat("yyyy-MM-dd");
while(rs.next())
{
	rownum+=1;//为每一行附值
	//序号
	l = new jxl.write.Label(0,rownum, rownum+"", detFormat);
	ws.addCell(l);
	//主数据
	cellnum = (short)1;
	String drawings_id=rs.getString("drawings_id");
	boolean flag =true;
	String drawings_date =rs.getString("drawings_date");
	java.util.Date drawings_date_end_date = sdf.parse(drawings_date_end);
	java.util.Date drawings_date_date = sdf.parse(drawings_date);
	if(drawings_date_end_date.before(drawings_date_date)){
		flag=false;
	}
	
	d = new jxl.write.DateTime(cellnum++,rownum, drawings_date_end_date, dateFormat);
	ws.addCell(d);
	d = new jxl.write.DateTime(cellnum++,rownum, drawings_date_date, dateFormat);
	ws.addCell(d);
	
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("drawings_id"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("crediter"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("drawings_type"), detFormat);
	ws.addCell(l);
	String drawings_money=rs.getString("drawings_money" );
	n = new jxl.write.Number(cellnum++,rownum, rs.getDouble("drawings_money"), priceFormat);
	ws.addCell(n);
	double drawingsRefundCorpus=0.00d;
	double drawingsLeftCorpus =0.00d;
	double drawingsLeftCorpusSightAmount=0.00d;
	double drawingsLeftCorpusNoSightAmount=0.00d;
	if(flag){
		drawingsRefundCorpus =FinancingReportUtil.getDrawingsRefundCorpus(drawings_id,drawings_date_end);
		n = new jxl.write.Number(cellnum++,rownum, drawingsRefundCorpus, priceFormat);
		ws.addCell(n);
		drawingsLeftCorpus = FinancingReportUtil.getDrawingsLeftCorpus(drawings_id,drawings_date_end);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftCorpus, priceFormat);
		ws.addCell(n);
		drawingsLeftCorpusSightAmount = FinancingReportUtil.getDrawingsLeftSightAmount(drawings_id,drawings_date_end);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftCorpusSightAmount, priceFormat);
		ws.addCell(n);
		drawingsLeftCorpusNoSightAmount = FinancingReportUtil.getDrawingsLeftNoSightAmount(drawings_id,drawings_date_end);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftCorpusNoSightAmount, priceFormat);
		ws.addCell(n);
	}else{
		n = new jxl.write.Number(cellnum++,rownum, drawingsRefundCorpus, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftCorpus, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftCorpusSightAmount, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftCorpusNoSightAmount, priceFormat);
		ws.addCell(n);
	}
	String currency = getDBStr( rs.getString("currency"));
	l = new jxl.write.Label(cellnum++,rownum, currency, detFormat);
	ws.addCell(l);
	double rate=1d;
	if("人民币".equals(currency)){
		rate=rmb_rate_d;
	}
	if("美元".equals(currency)){
		rate=dollar_currency_rate_d;
	}
	if("港币".equals(currency)){
		rate=hongKong_dollar_rate_d;
	}
	n = new jxl.write.Number(cellnum++,rownum, rate, priceFormat);
	ws.addCell(n);
	if(flag){
		double drawingsLeftRMB = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpus,rate);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMB, priceFormat);
		ws.addCell(n);
		double drawingsLeftRMBSightAmount = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpusSightAmount,rate);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMBSightAmount, priceFormat);
		ws.addCell(n);
		double drawingsLeftRMBNoSightAmount = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpusNoSightAmount,rate);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMBNoSightAmount, priceFormat);
		ws.addCell(n);
		double nonAmortizationRMB = FinancingReportUtil.getNonAmortizationRMB(drawings_id,drawings_date_end,rate);
		n = new jxl.write.Number(cellnum++,rownum, nonAmortizationRMB, priceFormat);
		ws.addCell(n);
		double nonAmortizationRMBSightAmount = FinancingReportUtil.getNonAmortizationRMBSightAmount(drawings_id,drawings_date_end,rate);
		n = new jxl.write.Number(cellnum++,rownum, nonAmortizationRMBSightAmount, priceFormat);
		ws.addCell(n);
		double nonAmortizationRMBNoSightAmount = FinancingReportUtil.getNonAmortizationRMBNoSightAmount(drawings_id,drawings_date_end,rate);
		n = new jxl.write.Number(cellnum++,rownum, nonAmortizationRMBNoSightAmount, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMB-nonAmortizationRMB, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMBSightAmount-nonAmortizationRMBSightAmount, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMBNoSightAmount-nonAmortizationRMBNoSightAmount, priceFormat);
		ws.addCell(n);
	}else{
		double drawingsLeftRMB = 0.00d;
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMB, priceFormat);
		ws.addCell(n);
		double drawingsLeftRMBSightAmount = 0.00d;
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMBSightAmount, priceFormat);
		ws.addCell(n);
		double drawingsLeftRMBNoSightAmount = 0.00d;
		n = new jxl.write.Number(cellnum++,rownum, drawingsLeftRMBNoSightAmount, priceFormat);
		ws.addCell(n);
		double nonAmortizationRMB = 0.00d;
		n = new jxl.write.Number(cellnum++,rownum, nonAmortizationRMB, priceFormat);
		ws.addCell(n);
		double nonAmortizationRMBSightAmount = 0.00d;
		n = new jxl.write.Number(cellnum++,rownum, nonAmortizationRMBSightAmount, priceFormat);
		ws.addCell(n);
		double nonAmortizationRMBNoSightAmount = 0.00d;
		n = new jxl.write.Number(cellnum++,rownum, nonAmortizationRMBNoSightAmount, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, 0.00d, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, 0.00d, priceFormat);
		ws.addCell(n);
		n = new jxl.write.Number(cellnum++,rownum, 0.00d, priceFormat);
		ws.addCell(n);
	}
	
	//n = new jxl.write.Number(cellnum++,rownum, FinancingReportUtil.getCurrentRate(drawings_id ,drawings_date_end), priceFormat);
	//ws.addCell(n);
	n = new jxl.write.Number(cellnum++,rownum, 0, priceFormat);
	ws.addCell(n);
	
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("Table_type"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("loan_category"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("pawn_condition"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("assurer_condition"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("Abroad_domestic"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("Financing_Method"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("drawings_rate_type"), detFormat);
	ws.addCell(l);
	l = new jxl.write.Label(cellnum++,rownum, rs.getString("drawings_time_type"), detFormat);
	ws.addCell(l);
}
rs.close();
db.close(); 
wwb.write();
wwb.close();
response.reset();
response.setContentType("text/html; charset=gb2312");
%>

