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
<%@page import="com.tenwa.culc.financing.util.FinancingCashFlowUtil"%>
<%@ include file="common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<% 
String str = null;
String sql=getStr(request.getParameter("expsqlstr"));
String excel_name = getStr(request.getParameter("excel_name"));
//cash_flow参数
String cycle = getStr( request.getParameter("cycle") );
if("".equals(cycle) || null== cycle ){
	cycle= "year";
}
String refund_date_start = getStr( request.getParameter("refund_date_start") );
String refund_date_end = getStr( request.getParameter("refund_date_end") ); 

List<String> list ;
if(refund_date_start!=null && !"".equals(refund_date_start) && refund_date_end!=null && !"".equals(refund_date_end)){
	Map<String,String> timeArea = FinancingCashFlowUtil.checkTimeArea(refund_date_start,refund_date_end);
	refund_date_start =timeArea.get("start");
	refund_date_end =timeArea.get("end");
	list=FinancingCashFlowUtil.getTableExtHead( cycle,refund_date_start,refund_date_end);
}else{
	list = new ArrayList<String>();
} 

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
short count = 1;
for (cellnum = (short)1; cellnum <= numberOfColumns; cellnum++)
{
	//ws.setColumnView(cellnum, 10);   
	l = new jxl.write.Label(cellnum,0, rsmd.getColumnName(cellnum), titleFormat);
	ws.addCell(l);
	count++;//计数器
}
if(refund_date_start!=null && !"".equals(refund_date_start) && refund_date_end!=null && !"".equals(refund_date_end)){
	for(Iterator<String> iter = list.iterator();iter.hasNext();){
		String current = iter.next();
		l = new jxl.write.Label(count++,0, "本金偿还现金流（"+current+")", titleFormat);
		ws.addCell(l);
		l = new jxl.write.Label(count++,0, "利息偿还现金流（"+current+")", titleFormat);
		ws.addCell(l);

	}
} 

//#####======数据内容=======######
while(rs.next())
{
	rownum+=1;//为每一行附值
	//序号
	l = new jxl.write.Label(0,rownum, rownum+"", detFormat);
	ws.addCell(l);
	count= 1;//计数器
	String drawings = rs.getString("提款编号");
	//主数据
	for (cellnum = (short)1; cellnum <= numberOfColumns; cellnum++)
	{
		
	   if ( (rsmd.getColumnTypeName(cellnum).equals("float")) ||(rsmd.getColumnTypeName(cellnum).equals("money")) || (rsmd.getColumnTypeName(cellnum).equals("decimal")) )
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
	   count++;
	}
	System.out.println("---测试节点12---------------");
	 if(refund_date_start!=null && !"".equals(refund_date_start) && refund_date_end!=null && !"".equals(refund_date_end)){
    	for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			Map<String,Double> map =FinancingCashFlowUtil.getTableCashFlow(drawings,cycle,refund_date_start,refund_date_end,current);
			//System.out.println("current="+current);
			//System.out.println(map.get("refund_corpus")+"----------"+map.get("refund_interest"));
			n = new jxl.write.Number(count++,rownum, map.get("refund_corpus").doubleValue(), priceFormat);
			ws.addCell(n);
			n = new jxl.write.Number(count++,rownum, map.get("refund_interest").doubleValue(), priceFormat);
			ws.addCell(n); 
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

