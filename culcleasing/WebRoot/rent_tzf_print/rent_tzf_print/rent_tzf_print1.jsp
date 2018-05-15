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
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>
                                                       
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("rent-tzf-print1",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------

String sqlstr;
String sqlstr2;//由于sqlstr需要保存，故再定义一个变量
ResultSet rs;
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String wherestr = " where 1=1";
String wherestr2 = " where 1=1 and aa.deduRent>0 and aa.contract_id not in(select contract_id from contract_notsend union select contract_id from contract_info where contract_status in('103') or charge_off_flag='是' union select contract_id from contract_equip where equip_status in('equip_status3','equip_status4','equip_status5'))";
String s_date = getStr( request.getParameter("s_date") );	//开始日期
String e_date = getStr( request.getParameter("e_date") );	//结束日期
String bad_date = getStr( request.getParameter("bad_date") );	//逾期结算日期
//String print_flag= getStr( request.getParameter("print_flag") );//打印标志
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

List l_sale = new ArrayList();
Set set = new HashSet();
String sale_id="";
String post_code="";
String post_addr="";
String sale_name="";
String person="";
String person_phone="";

String contract_id="";
String cust_name="";
String plan_date="";
String rent_list="";
String rent="";
String badRent="";
String punishInterest="";
String recieve_rent="";

String deduList="";//保证金可抵扣期项
wherestr=wherestr+" and fund_rent_plan.plan_date>='"+s_date+"' and fund_rent_plan.plan_date<='"+e_date+"'";
if ( !searchFld.equals("") && !searchKey.equals("") ) {
	if ( searchFld.equals("aa.industry_name") && searchKey.equals("非建筑") ) {
		wherestr2 = wherestr2 + " and isnull(aa.industry_name,'')<>'建筑业'";
	}else{
		wherestr2 = wherestr2 + " and " + searchFld + " like '%" + searchKey + "%'";
	}
}
sqlstr = "select aa.* from (select ifelc_conf_dictionary.title as industry_name,contract_payment_notice.print_status,contract_condition.nominalprice,dbo.bb_getDeduList(vi_contract_info.contract_id) as deduList,dbo.bb_getDeduRent_tzf(fund_rent_plan.contract_id,fund_rent_plan.rent_list) as deduRent,vi_contract_info.sale_id, fund_rent_plan.rent_list, a.contract_id, vi_contract_info.cust_name, fund_rent_plan.rent, a.plan_date, dbo.bb_getBadRent('1970-01-01','"+bad_date+"',a.contract_id) as badRent, dbo.bb_getPunishInterest('1970-01-01','"+bad_date+"',a.contract_id) as punishInterest,isnull(fund_rent_plan.rent,0)+isnull(dbo.bb_getBadRent('1970-01-01','"+bad_date+"',a.contract_id),0)+isnull(dbo.bb_getPunishInterest('1970-01-01','"+bad_date+"',a.contract_id),0) as recieve_rent from ( select fund_rent_plan.contract_id,max(fund_rent_plan.plan_date) as plan_date from fund_rent_plan"+wherestr+" group by fund_rent_plan.contract_id )a inner join fund_rent_plan on a.contract_id=fund_rent_plan.contract_id and a.plan_date=fund_rent_plan.plan_date left join vi_contract_info on a.contract_id=vi_contract_info.contract_id left join contract_condition on fund_rent_plan.contract_id=contract_condition.contract_id left join ( 	select contract_payment_notice.* from contract_payment_notice where id in( 		select max(id) as id from contract_payment_notice group by contract_id,rent_list 	) )contract_payment_notice on fund_rent_plan.contract_id=contract_payment_notice.contract_id and fund_rent_plan.rent_list=contract_payment_notice.rent_list left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name)aa"+wherestr2;


//sqlstr = sqlstr+" and isnull(aa.print_status,'否')='否'";
System.out.println("sqlstr00================================================="+sqlstr);
rs=db.executeQuery(sqlstr);
while(rs.next()){
	l_sale.add(getDBStr(rs.getString("sale_id")));
}rs.close();
set.addAll(l_sale);
l_sale.clear();
l_sale.addAll(set);


String path = pageContext.getServletContext().getRealPath("/");
//System.out.println("相对："+request.getRequestURI());
//System.out.println("相对2："+request.getRealPath("/"));
//System.out.println("绝对："+pageContext.getServletContext().getRealPath("/"));

HSSFRow row;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet sheet = wb.createSheet();

sheet.setDefaultColumnWidth((short)11);
sheet.setAutobreaks(false);
sheet.setMargin(HSSFSheet.LeftMargin,0.1);
sheet.setMargin(HSSFSheet.RightMargin,0.1);
sheet.setHorizontallyCenter(true);
		 
HSSFCellStyle   style   =   wb.createCellStyle();
style.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
style.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
style.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框

HSSFFont font_10 = wb.createFont();
font_10.setFontName("宋体");
font_10.setFontHeightInPoints((short)10);
HSSFCellStyle style_10=wb.createCellStyle();//宋体，10
style_10.setFont(font_10);

HSSFFont font_10_side = wb.createFont();
font_10_side.setFontName("宋体");
font_10_side.setFontHeightInPoints((short)10);
HSSFCellStyle style_10_side=wb.createCellStyle();//宋体，10,带边框
style_10_side.setFont(font_10_side);
style_10_side.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
style_10_side.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
style_10_side.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
style_10_side.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框
style_10_side.setWrapText(true);
style_10_side.setAlignment(HSSFCellStyle.ALIGN_CENTER);

HSSFFont font_14b = wb.createFont();
font_14b.setFontName("宋体");
font_14b.setFontHeightInPoints((short)14);
font_14b.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
HSSFCellStyle style_14b=wb.createCellStyle();//宋体，14，黑体
style_14b.setFont(font_14b);
style_14b.setAlignment(HSSFCellStyle.ALIGN_CENTER);

HSSFFont font_10b = wb.createFont();
font_10b.setFontName("宋体");
font_10b.setFontHeightInPoints((short)10);
font_10b.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
HSSFCellStyle style_10b=wb.createCellStyle();//宋体，10，黑体
style_10b.setFont(font_10b);


HSSFCellStyle style_10b_gr=wb.createCellStyle();//宋体，10，黑体，背景
style_10b_gr.setFont(font_10b);
style_10b_gr.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
style_10b_gr.setFillForegroundColor(HSSFColor.BLUE_GREY.index); 
style_10b_gr.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
style_10b_gr.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
style_10b_gr.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
style_10b_gr.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框
style_10b_gr.setAlignment(HSSFCellStyle.ALIGN_CENTER);

HSSFCellStyle style_10blue_gr=wb.createCellStyle();//宋体，10，蓝色，背景
style_10blue_gr.setFont(font_10b);
style_10blue_gr.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
style_10blue_gr.setFillForegroundColor(HSSFColor.BLUE.index); 
style_10blue_gr.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
style_10blue_gr.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
style_10blue_gr.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
style_10blue_gr.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框
style_10blue_gr.setAlignment(HSSFCellStyle.ALIGN_CENTER);

HSSFFont font_10color = wb.createFont();
font_10color.setFontName("宋体");
font_10color.setFontHeightInPoints((short)10);
font_10color.setColor(HSSFFont.COLOR_RED);
HSSFCellStyle style_10color=wb.createCellStyle();//宋体，10，红字
style_10color.setFont(font_10color);

//int i;
//for(i=1;i<8;i++){
	//sheet.addMergedRegion(new Region(i,(short)1,i,(short)8));
	//row=sheet.createRow(i);
	//cell=row.createCell((short)1);
	//cell.setCellStyle(style_10color);
	//cell.setCellValue("江苏省 徐州 徐州市");
//}
int contract_num=0;//记录用去的ｅｘｃｅｌ行数
int first_i=0;//记录每一个代理商的合同数
int second_id=0;//记录每一个代理商需要显示名义货价的合同
List l_title=new ArrayList();
List l_value=new ArrayList();
List l_total=new ArrayList();
List l_nominalprice=new ArrayList();
l_title.add("合同号");l_title.add("承租人名称");l_title.add("支付日");l_title.add("期次");
l_title.add("当期租金");l_title.add("拖欠租金");l_title.add("逾期罚息");l_title.add("应付总金额");
l_total.add("合　计");l_total.add("");l_total.add("");l_total.add("");l_total.add("");l_total.add("");l_total.add("");
String total_recieve_rent="";
String nominalprice="";
String end_discr="";
for(int i=0;i<l_sale.size();i++){
	//初始化清空
	post_code="";
	post_addr="";
	sale_name="";
	person="";
	person_phone="";
	
	contract_id="";
	cust_name="";
	plan_date="";
	rent_list="";
	rent="";
	badRent="";
	punishInterest="";
	recieve_rent="";
	
	sale_id=l_sale.get(i).toString().trim();
	sqlstr2="select post_code,post_addr,cust_name from vi_cust_all_info where cust_id='"+sale_id+"'";
	rs=db.executeQuery(sqlstr2);
	if(rs.next()){
		post_code=getDBStr( rs.getString("post_code") );
		post_addr=getDBStr( rs.getString("post_addr") );
		sale_name=getDBStr( rs.getString("cust_name") );
	}rs.close();
	sqlstr2="select top 1 name,mobile_number from cust_person where main_person_flag='是' and cust_id='"+sale_id+"'";
	rs=db.executeQuery(sqlstr2);
	if(rs.next()){
		person=getDBStr( rs.getString("name") );
		person_phone=getDBStr( rs.getString("mobile_number") );
	}rs.close();
	//邮编
	sheet.addMergedRegion(new Region(1+contract_num,(short)0,1+contract_num,(short)7));
	row=sheet.createRow(1+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10b);
	cell.setCellValue(post_code);
	//通讯地址
	sheet.addMergedRegion(new Region(2+contract_num,(short)0,2+contract_num,(short)7));
	row=sheet.createRow(2+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10b);
	cell.setCellValue(post_addr);
	//代理商名称
	sheet.addMergedRegion(new Region(3+contract_num,(short)0,3+contract_num,(short)7));
	row=sheet.createRow(3+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10b);
	cell.setCellValue(sale_name);
	//联系人
	sheet.addMergedRegion(new Region(4+contract_num,(short)0,4+contract_num,(short)7));
	row=sheet.createRow(4+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10b);
	cell.setCellValue(person);
	//联系人电话
	sheet.addMergedRegion(new Region(5+contract_num,(short)0,5+contract_num,(short)7));
	row=sheet.createRow(5+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10b);
	cell.setCellValue(person_phone);
	//代理商名称居中
	sheet.addMergedRegion(new Region(8+contract_num,(short)0,8+contract_num,(short)7));
	row=sheet.createRow(8+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_14b);
	cell.setCellValue(sale_name);
	//备注
	sheet.addMergedRegion(new Region(10+contract_num,(short)0,10+contract_num,(short)7));
	row=sheet.createRow(10+contract_num);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10);
	cell.setCellValue("烦请与承租人联系，以便我公司在支付日内能够确认到帐");
	
	for(int tmp_i=0;tmp_i<8;tmp_i++){
		row=sheet.createRow(12+contract_num);
		cell=row.createCell((short)(tmp_i));
		cell.setCellStyle(style_10_side);
		cell.setCellValue(l_title.get(tmp_i).toString());
	}
	
	sqlstr2=sqlstr+" and aa.sale_id='"+sale_id+"'";
	rs=db.executeQuery(sqlstr2);
	System.out.println("sqlstr200============================================"+sqlstr2);
	first_i=0;
	total_recieve_rent="0";
	l_nominalprice.clear();
	while(rs.next()){
		first_i++;
		l_value.clear();
		contract_id=getDBStr( rs.getString("contract_id") );
		cust_name=getDBStr( rs.getString("cust_name") );
		plan_date=getDBDateStr( rs.getString("plan_date") );
		rent_list=getDBStr( rs.getString("rent_list") );
		rent=formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00");
		badRent=formatNumberStr(getDBStr( rs.getString("badRent") ),"#,##0.00");
		punishInterest=formatNumberStr(getDBStr( rs.getString("punishInterest") ),"#,##0.00");
		recieve_rent=formatNumberStr(getDBStr( rs.getString("recieve_rent") ),"#,##0.00");
		l_value.add(contract_id);
		l_value.add(cust_name);
		l_value.add(plan_date);
		l_value.add(rent_list);
		l_value.add(rent);
		l_value.add(badRent);
		l_value.add(punishInterest);
		l_value.add(recieve_rent);
		
		for(int tmp_i=0;tmp_i<8;tmp_i++){
			row=sheet.createRow(12+contract_num+first_i);
			cell=row.createCell((short)(tmp_i));
			cell.setCellStyle(style_10_side);
			cell.setCellValue(l_value.get(tmp_i).toString());
		}
		
		total_recieve_rent=formatNumberStr(String.valueOf(Double.parseDouble(total_recieve_rent.replace(",",""))+Double.parseDouble(getDBStr( rs.getString("recieve_rent") ))),"#,##0.00");
		deduList=getDBStr( rs.getString("deduList") );
		nominalprice=formatNumberStr(getDBStr( rs.getString("nominalprice") ),"#,##0.00");
		if(rent_list.equals(deduList)){
			end_discr="";
			end_discr=end_discr+"租赁合同"+contract_id+"约定于"+plan_date.substring(0,4)+"年"+plan_date.substring(5,7)+"月"+plan_date.substring(8,10)+"日结束，名义留购价为￥"+nominalprice+"元";
			l_nominalprice.add(end_discr);
		}
	}rs.close();

	if(first_i>0){
		first_i++;
		for(int tmp_i=0;tmp_i<7;tmp_i++){
			row=sheet.createRow(12+contract_num+first_i);
			cell=row.createCell((short)(tmp_i));
			cell.setCellStyle(style_10_side);
			cell.setCellValue(l_total.get(tmp_i).toString());
		}
		row=sheet.createRow(12+contract_num+first_i);
		cell=row.createCell((short)(7));
		cell.setCellStyle(style_10_side);
		cell.setCellValue(total_recieve_rent);
	}

	first_i++;
	sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)0,12+contract_num+first_i,(short)7));
	row=sheet.createRow(12+contract_num+first_i);
	cell=row.createCell((short)0);
	cell.setCellStyle(style_10b);
	cell.setCellValue("注：本清单所列逾期罚息为逾期起始日至打印日期所发生的逾期罚息。");

	first_i++;
	if(l_nominalprice.size()>0){
		first_i++;
		sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)0,12+contract_num+first_i,(short)7));
		row=sheet.createRow(12+contract_num+first_i);
		cell=row.createCell((short)0);
		cell.setCellStyle(style_10);
		cell.setCellValue("其中：");

		for(int tmp_i=0;tmp_i<l_nominalprice.size();tmp_i++){
			first_i++;
			sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)0,12+contract_num+first_i,(short)7));
			row=sheet.createRow(12+contract_num+first_i);
			cell=row.createCell((short)0);
			cell.setCellStyle(style_10);
			cell.setCellValue(l_nominalprice.get(tmp_i).toString());
		}

		first_i++;first_i++;
		sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)0,12+contract_num+first_i,(short)7));
		row=sheet.createRow(12+contract_num+first_i);
		cell=row.createCell((short)0);
		cell.setCellStyle(style_10);
		cell.setCellValue("请于约定日前支付以上名义留购价，并将保证金收据寄还至我公司，以便进行设备所有权转移手续。");
	}

	first_i++;first_i++;
	sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)5,12+contract_num+first_i,(short)7));
	row=sheet.createRow(12+contract_num+first_i);
	cell=row.createCell((short)5);
	cell.setCellStyle(style_10b);
	cell.setCellValue("恒信金融租赁有限公司");
	
	first_i++;
	sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)5,12+contract_num+first_i,(short)7));
	row=sheet.createRow(12+contract_num+first_i);
	cell=row.createCell((short)5);
	cell.setCellStyle(style_10b);
	cell.setCellValue(bad_date.substring(0,4)+"年"+bad_date.substring(5,7)+"月"+bad_date.substring(8,10)+"日");
	
	first_i++;first_i++;
	sheet.addMergedRegion(new Region(12+contract_num+first_i,(short)5,12+contract_num+first_i,(short)7));
	row=sheet.createRow(12+contract_num+first_i);
	cell=row.createCell((short)5);
	cell.setCellStyle(style_10b);
	cell.setCellValue("客服热线：800-820-6213");
	contract_num=contract_num+13+first_i;
	
	//分页
	sheet.setRowBreak(contract_num);
	contract_num++;
	
}

String filename="代理商租金通知书"+String.valueOf(System.currentTimeMillis())+".xls";
String filepath=path+"\\upload\\"+filename;
FileOutputStream fos = new FileOutputStream(new File(path+"\\upload\\"+filename));
wb.write(fos);
fos.close();
sqlstr2="insert into export_sale_tzf(export_date,file_name,file_path,creator) select '"+curr_date+"','"+filename+"','"+filepath+"','"+dqczy+"'";
db.executeUpdate(sqlstr2);
db.close();
%>
<script>
			window.close();
			opener.alert("已生成excel!");
		</script>