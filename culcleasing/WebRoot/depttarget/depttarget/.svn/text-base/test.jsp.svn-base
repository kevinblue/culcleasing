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
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db3" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db4" scope="page" class="dbconn.Conn" /> 
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
ResultSet rs1;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String target_id = getStr( request.getParameter("target_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String evaluation_type = getStr( request.getParameter("evaluation_type") );
response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=1.xls");
String path = pageContext.getServletContext().getRealPath("/");

int i;
int j;
int n;
HSSFRow templateRow;
HSSFCell cell;
//HSSFCellStyle style;
HSSFFont font;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\func\\test_rx.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); 
//格式-字体
//style = wb.createCellStyle();
//font = wb.createFont();
//font.setFontName("黑体");
//short color = HSSFColor.RED.index;
//font.setColor(color);

//style.setFont(font);


i=2;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("承租人名称：");

i=4;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("地址/联系人及电话：");

i=6;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("生产商名称：");

i=8;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("地址/联系人及电话：");

i=10;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("供应商/代理商名称：");

i=12;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("地址/联系人及电话：");

i=14;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("担保人名称：");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("担保类型：");

i=16;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("地址/联系人及电话：");

i=18;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("设备代码");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("有效期限：");

i=20;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("内部行业代码");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("2008-09-02");

i=22;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("商业登记号码:");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("货款支付方式：");

i=24;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("产品类型：");

i=26;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("现在申请金额：");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("设备代码：");

i=28;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("净融资额 / LTV%：");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("评估规定：");

i=30;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("当前风险敞口:");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("IRR / ROE% / ROA%:");

i=32;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("承租人合计风险敞口:");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("残余:");

i=34;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("租期/付款密度/先后付");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("当前/建议风险评级:");

i=36;
j=1;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("特别文件要求：");

j=5;
templateRow=templateSheet.getRow(i);
cell=templateRow.getCell((short)j);
cell.setCellValue("交易风险评级：");


//第二部分
	ResultSet rscount = null;
 	ResultSet rsScore = null;
	ResultSet rsSt = null;
 	boolean flag = false;
 	sqlstr = "select base_evaluation_model.item_id as m_item_id,base_evaluation_model.item as m_item,base_evaluation_model.weighting as m_weighting,base_evaluation_model.order_number as m_order_number from base_evaluation_model where evaluation_type=" + evaluation_type+" and his_flag='0'";
	System.out.println(sqlstr);
	rscount = db1.executeQuery(sqlstr); 
	double allscore = 0;
	boolean vote_flag = true;
	//插入开始行数
	int startRow = 61;
	while (rscount.next()){
		String item_id = getDBStr(rscount.getString("m_item_id"));
		String item = getDBStr(rscount.getString("m_item"));
		String weighting = getDBStr(rscount.getString("m_weighting"));
		
		sqlstr = "select base_evaluation_model.item_id as m_item_id,base_evaluation_model.item as m_item,base_evaluation_model.weighting as m_weighting,base_evaluation_model.order_number as m_order_number,base_evaluation_score.* from base_evaluation_model full outer join base_evaluation_score on base_evaluation_model.item_id = base_evaluation_score.item_id where his_flag='0'";
		sqlstr+=" and base_evaluation_model.evaluation_type=" + evaluation_type+" and target_id='"+target_id+"' ";
		if(doc_id!=null&&!("").equals(doc_id)){
			sqlstr+=" and base_evaluation_score.doc_id='"+doc_id+"'";
		}
		sqlstr += " and base_evaluation_score.item_id="+item_id;
		sqlstr+=" order by order_number"; 
		System.out.println(sqlstr);
		rsScore = null;
		rsScore = db2.executeQuery(sqlstr);
		String weighting_score = "";
		String vote = "";
		String weight = "";
		String a_standard = "";
		if (rsScore.next()){
			weighting_score = getDBStr(rsScore.getString("weighting_score"));
	    	vote = getDBStr(rsScore.getString("veto_flag"));
	    	weight = getDBStr(rsScore.getString("weighting"));
	    	a_standard = getDBStr(rsScore.getString("standard"));
	    	if(vote.equals("-1")){
	    		vote_flag =false;
	    	}
	    	allscore+=Double.parseDouble(weighting_score);
	    }
	    
	    HSSFRow createRow = null; 
	    HSSFCell createCell = null;
	    createRow=templateSheet.createRow(startRow);
	    //客户条件
		createCell=createRow.createCell((short)0);
		createCell.setCellValue(item);
		//实际情况
		createCell=createRow.createCell((short)1);
		createCell.setCellValue(a_standard);
		//评分
		createCell=createRow.createCell((short)7);
		createCell.setCellValue(weighting_score);
		//评分范围
		int sflag=2;
	    sqlstr="select * from base_evaluation_standard where base_evaluation_standard.item_id="+item_id+" and base_evaluation_standard.his_flag='0'  order by base_evaluation_standard.order_number";
   		System.out.println(sqlstr);
   		rsSt = null;
   		rsSt = db3.executeQuery(sqlstr);
   		String standard = "";
   		while(rsSt.next()){
   			standard = rsSt.getString("standard");
   			createCell=createRow.createCell((short)sflag);
			createCell.setCellValue(standard);
			sflag++;
   		}
		startRow++;startRow++;
	}
	//基本评分
	int allRow = 79;
	templateRow=templateSheet.createRow(allRow);
	cell=templateRow.createCell((short)7);
	cell.setCellValue(allscore);
	//第三部分
	ResultSet rsAdjust = null;
	sqlstr = "select * from base_evaluation_adjust where evaluation_type='"+evaluation_type+"' and his_flag='0'";
	System.out.println(sqlstr);
	rsAdjust = db.executeQuery(sqlstr);
	//评分调整开始项
	startRow = 81;
	String adjust_item_id = "";
	while(rsAdjust.next()){
		adjust_item_id = getDBStr(rsAdjust.getString("adjust_item_id"));
		sqlstr = "select * from base_evaluation_adjust_score where evaluation_type='"+evaluation_type+"' and target_id='"+target_id+"'";
		if(doc_id!=null&&!("").equals(doc_id)){
			sqlstr+=" and doc_id='"+doc_id+"'";
		}
		sqlstr+=" and adjust_item_id="+adjust_item_id;
		sqlstr+=" order by order_number";
		System.out.println(sqlstr);
		ResultSet rsAdSc = null;
		rsAdSc = db4.executeQuery(sqlstr);
		String other_condition = "";
		String comment = "";
		String score_adjust = "";
		double dscore_adjust = 0;
		if(rsAdSc.next()){
			other_condition = getDBStr(rsAdSc.getString("other_condition"));
			comment = getDBStr(rsAdSc.getString("comment"));
			score_adjust = getDBStr(rsAdSc.getString("score_adjust"));
			if(score_adjust!=null&&!score_adjust.equals("")){
			dscore_adjust = Double.parseDouble(score_adjust);
			}
			allscore+=dscore_adjust;
		}
		rsAdSc.close();
		//其他条件
		templateRow=templateSheet.createRow(startRow);
		cell=templateRow.createCell((short)0);
		cell.setCellValue(other_condition);
		//评论
		cell=templateRow.createCell((short)2);
		cell.setCellValue(comment);
		//评分调整
		cell=templateRow.createCell((short)5);
		cell.setCellValue(score_adjust);
		//建议风险评分
		startRow++;
		
	}
	rsAdjust.close();
	//建议风险评分
	startRow=89;
	templateRow=templateSheet.createRow(startRow);
	cell=templateRow.createCell((short)5);
	cell.setCellValue(allscore);
	
	
	
	
OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
//stream.close();
//System.out.println("loopcellHead==================================="+loopcellHead.toString());
db1.close();
db2.close();
db3.close();
db4.close();
db.close();
%>