<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %>  
<%@ page import="java.math.BigDecimal" %>
<%@ page import="jxl.*"%> 
<%@ page import="jxl.write.*"%> 
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.format.VerticalAlignment"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Colour"%> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 

<% 
String sqldata = getStr( request.getParameter("sqldata") );//主键字段
String end_date = getStr(request.getParameter("end_date"));

String choiceType = getStr( request.getParameter("choiceType") );//判断是否全部操作
String datasqlstr = getStr( request.getParameter("datasqlstr") );

//===========
String sql_str ="";
String col_str = "";
col_str = " qymc 区域,dld 代理商,proj_id 项目编号,khmc 客户名称,prod_id 租赁物类型,manufacturer 制造商,model_id 机型,equip_sn 出厂编号,bodyno 车架号,equip_amount 台量,";
col_str+=" lx_date 申请日期,check_date 验收日期,qz_date 起租确认日期,lease_term 租赁期限,equip_amt 租赁物购买价款,lease_zl_money 融资租赁额,";
col_str+=" head_ratio 起租比例,first_payment 首期付款,total_amt 租金总额 ";
//=========
ResultSet rs = null;
ResultSet rs1 = null;

String partSql = "";
String projId = "";

int yhqs = 0;//已还租期数
double yhzj = 0f;//已还租金
int syzjqs = 0;//剩余租金期数
double syzj = 0f;//租金余额
double sybj = 0f;//租金本金
double yqzj = 0f;//逾期租金
int yqts = 0;//逾期天数
double wyjhj = 0f;//违约金合计
double yswyj = 0f;//已收违约金
double wswyj = 0f;//未收违约金
int yqqs = 0;//逾期期数
int ljyq = 0;//累计逾期
//----------------------

if( choiceType!=null && !"".equals(choiceType) && "allData".equals(choiceType) ){//全选
	sql_str = "select "+col_str+" from vi_sup_proj_his_base where 1=1 "+datasqlstr;
}else{
	sql_str = "select "+col_str+" from vi_sup_proj_his_base where id in("+sqldata+")";
}

System.out.println("super_his_sql"+sql_str);
rs=db.executeQuery(sql_str); 

ResultSetMetaData rsmd = rs.getMetaData();
int numberOfColumns = rsmd.getColumnCount();
short rownum = 2;
BigDecimal tempdec=new BigDecimal("0.00");

response.reset();
response.setContentType("application/vnd.ms-excel;charset=GB2312");
response.setHeader("Content-disposition","attachment; filename=super_history_"+getSystemDate(0)+".xls");
jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
jxl.write.WritableSheet ws = wwb.createSheet("Sheet1",0);

jxl.write.Label l=null;
jxl.write.Number n=null;
jxl.write.DateTime d=null; 


//预定义的一些字体和格式
WritableFont headerFont = new WritableFont(WritableFont.createFont("宋体"), 15, WritableFont.BOLD, false,jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.RED); 
WritableCellFormat headerFormat = new WritableCellFormat (headerFont); 
headerFormat.setAlignment(Alignment.CENTRE);//居中
headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
headerFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
headerFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);
//第二行
WritableFont twoRowFont = new WritableFont(WritableFont.createFont("宋体"), 12, WritableFont.BOLD, false,jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.TEAL); 
WritableCellFormat twoRowFormat = new WritableCellFormat (twoRowFont); 
twoRowFormat.setAlignment(Alignment.CENTRE);//居中
twoRowFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
twoRowFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
twoRowFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
twoRowFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
twoRowFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);

//标题样式
WritableFont titleFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK); 
WritableCellFormat titleFormat = new WritableCellFormat (titleFont); 
titleFormat.setAlignment(Alignment.CENTRE);
titleFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
titleFormat.setBorder(Border.TOP, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.BOTTOM, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.LEFT, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBorder(Border.RIGHT, BorderLineStyle.THIN, Colour.BLACK);
titleFormat.setBackground(Colour.YELLOW);

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
//合并区域
ws.mergeCells(0,0,numberOfColumns+12,0);
l=new jxl.write.Label(0,0,"超级表历史",headerFormat);
ws.addCell(l);
ws.mergeCells(0,1,numberOfColumns+12,1);
l=new jxl.write.Label(0,1,"查询日期："+end_date,twoRowFormat);
ws.addCell(l);
//序号列
l = new jxl.write.Label(0, 2, "序号", titleFormat);
ws.addCell(l);
for (cellnum = (short)1; cellnum <= numberOfColumns; cellnum++)
{
	//ws.setColumnView(cellnum, 10);   
	l = new jxl.write.Label(cellnum,2, rsmd.getColumnName(cellnum), titleFormat);
	ws.addCell(l);
}
l = new jxl.write.Label(numberOfColumns+1,2, "已还租期数", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+2,2, "已还租金", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+3,2, "剩余租金期数", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+4,2, "租金余额", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+5,2, "剩余本金", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+6,2, "逾期租金", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+7,2, "逾期天数", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+8,2, "违约金合计", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+9,2, "已收违约金", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+10,2, "未收违约金", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+11,2, "逾期期数", titleFormat);
ws.addCell(l);
l = new jxl.write.Label(numberOfColumns+12,2, "累计逾期", titleFormat);
ws.addCell(l);
//#####======数据内容=======######
while(rs.next())
{  rownum+=1;//为每一行附值
	//序号
	l = new jxl.write.Label(0,rownum, rownum+"", detFormat);
	ws.addCell(l);
	projId =rs.getString(3) ;
	System.out.println("===="+projId);
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
	//其他几列数据：已还租期数、已还租金、剩余租金期数、租金余额
    //剩余本金\逾期租金\逾期天数\违约金合计\已收违约金\未收违约金\逾期期数\累计逾期
	partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yhqs') as r1,";
	partSql+= "dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yhzj') as r2,dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','syzjqs') as r3,";
	partSql+= "dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','syzj') as r4,";
	partSql+= "dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','sybj') as r5,dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqzj') as r6,";
	partSql+= "dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqts') as r7,dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','wyjhj') as r8,";
	partSql+= "dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yswyj') as r9,dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqqs') as r10,";
	partSql+= "dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','ljyq') as r11";
	System.out.println("partSql====="+partSql);
	rs1 = db1.executeQuery(partSql);
	if(rs1.next()){
		yhqs = rs1.getInt("r1");
		yhzj = rs1.getDouble("r2");
		syzjqs = rs1.getInt("r3");
		syzj = rs1.getDouble("r4");
		sybj = rs1.getDouble("r5");
		yqzj = rs1.getDouble("r6");
		yqts = rs1.getInt("r7");
		wyjhj = rs1.getDouble("r8");
		yswyj = rs1.getDouble("r9");
		wswyj =wyjhj-yswyj ;
		yqqs = rs1.getInt("r10");
		ljyq = rs1.getInt("r11");
	}
	System.out.println("============"+yqzj);
	//添加--
	n = new jxl.write.Number(numberOfColumns+1,rownum, yhqs, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+2,rownum, yhzj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+3,rownum,syzjqs, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+4,rownum, syzj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+5,rownum, sybj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+6,rownum, yqzj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+7,rownum, yqts, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+8,rownum, wyjhj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+9,rownum, yswyj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+10,rownum, wswyj, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+11,rownum, yqqs, priceFormat);
	ws.addCell(n);
	n = new jxl.write.Number(numberOfColumns+12,rownum, ljyq, priceFormat);
	ws.addCell(n);
}

//更改数据

rs.close();

db.close();
db1.close();
wwb.write();
wwb.close();

response.reset();
response.setContentType("text/html; charset=gb2312");
%>
<script>
	window.close();
	opener.location.reload(true);
</script>