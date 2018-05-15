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
ResultSet rs1;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String proj_id = getStr( request.getParameter("proj_id") );

//------------取数据------start----------------
List l_first_bl=new ArrayList();
List l_first_amt=new ArrayList();
List l_second_bl=new ArrayList();
List l_second_amt=new ArrayList();

List l_first=new ArrayList();
List l_second=new ArrayList();
List l_three=new ArrayList();

String equip_amt="";
String insurance_lessor="";
String other_fee="";
String lease_money="";
String pure_financing="";
String insurance_lessee="";
String total_income="";
String equip_amt_bl="";
String insurance_lessor_bl="";
String other_fee_bl="";
String lease_money_bl="";
String pure_financing_bl="";
String insurance_lessee_bl="";
String total_income_bl="";

String first_payment="";
String lessee_caution_money="";
String handling_charge="";
String return_amt="";
String other_income="";
String nominalprice="";
String vndr_caution_money="";
String first_payment_bl="";
String lessee_caution_money_bl="";
String handling_charge_bl="";
String return_amt_bl="";
String other_income_bl="";
String nominalprice_bl="";
String vndr_caution_money_bl="";
//---------------------应收租金总额-----承租客户-----------
String plan_totalrent="";
sqlstr="select sum(rent) as plan_totalrent from fund_rent_plan_proj_temp where measure_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	plan_totalrent=formatNumberStr(getDBStr(rs.getString("plan_totalrent")),"#,##0.00");
}rs.close();
String cust_name="";
sqlstr="select vi_cust_all_info.cust_name as cust_name from proj_info left join vi_cust_all_info on proj_info.cust_id=vi_cust_all_info.cust_id where proj_info.proj_id='"+proj_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	cust_name=getDBStr(rs.getString("cust_name"));
}rs.close();
//-------------------下半段-----------------------------
String start_date="";
String return_method="";
String period_name="";
String per_rent="";

String per_rent_bl="";

String year_rate="";
String year_earn="";
String lease_term="";

String irr="";
String rough_earn="";
String cl="";//扣除风险成本后利差率

sqlstr="select proj_condition_temp.* from proj_condition_temp where proj_condition_temp.measure_id='"+doc_id+"'";

rs=db.executeQuery(sqlstr);
if(rs.next()){
	equip_amt=formatNumberStr(getDBStr(rs.getString("equip_amt")),"#,##0.00");
	insurance_lessor=formatNumberStr(getDBStr(rs.getString("insurance_lessor")),"#,##0.00");
	other_fee=formatNumberStr(getDBStr(rs.getString("other_fee")),"#,##0.00");
	first_payment=formatNumberStr(getDBStr(rs.getString("first_payment")),"#,##0.00");
	lessee_caution_money=formatNumberStr(getDBStr(rs.getString("lessee_caution_money")),"#,##0.00");//5
	handling_charge=formatNumberStr(getDBStr(rs.getString("handling_charge")),"#,##0.00");
	return_amt=formatNumberStr(getDBStr(rs.getString("return_amt")),"#,##0.00");
	other_income="0.00";//其它收入
	nominalprice=formatNumberStr(getDBStr(rs.getString("nominalprice")),"#,##0.00");
	vndr_caution_money=formatNumberStr(getDBStr(rs.getString("vndr_caution_money")),"#,##0.00");
	lease_money=formatNumberStr(getDBStr(rs.getString("lease_money")),"#,##0.00");
	if(equip_amt.equals("")){
		pure_financing="";
	}else if(Double.parseDouble(equip_amt.replaceAll(",",""))==0){
		pure_financing="";
	}else{
		pure_financing=formatNumberStr(String.valueOf(
		Double.parseDouble(equip_amt.replaceAll(",","").equals("")?"0":equip_amt.replaceAll(",",""))+Double.parseDouble(insurance_lessor.replaceAll(",","").equals("")?"0":insurance_lessor.replaceAll(",",""))+Double.parseDouble(other_fee.replaceAll(",","").equals("")?"0":other_fee.replaceAll(",",""))
		-Double.parseDouble(first_payment.replaceAll(",","").equals("")?"0":first_payment.replaceAll(",",""))-Double.parseDouble(lessee_caution_money.replaceAll(",","").equals("")?"0":lessee_caution_money.replaceAll(",",""))
		-Double.parseDouble(handling_charge.replaceAll(",","").equals("")?"0":handling_charge.replaceAll(",",""))-Double.parseDouble(return_amt.replaceAll(",","").equals("")?"0":return_amt.replaceAll(",",""))
		-Double.parseDouble(other_income.replaceAll(",","").equals("")?"0":other_income.replaceAll(",",""))-Double.parseDouble(vndr_caution_money.replaceAll(",","").equals("")?"0":vndr_caution_money.replaceAll(",",""))
		),"#,##0.00");
	}
	insurance_lessee=formatNumberStr(getDBStr(rs.getString("insurance_lessee")),"#,##0.00");
	total_income=formatNumberStr(String.valueOf(
		Double.parseDouble(first_payment.replaceAll(",","").equals("")?"0":first_payment.replaceAll(",",""))+Double.parseDouble(lessee_caution_money.replaceAll(",","").equals("")?"0":lessee_caution_money.replaceAll(",",""))
		+Double.parseDouble(handling_charge.replaceAll(",","").equals("")?"0":handling_charge.replaceAll(",",""))+Double.parseDouble(return_amt.replaceAll(",","").equals("")?"0":return_amt.replaceAll(",",""))
		+Double.parseDouble(other_income.replaceAll(",","").equals("")?"0":other_income.replaceAll(",",""))+Double.parseDouble(nominalprice.replaceAll(",","").equals("")?"0":nominalprice.replaceAll(",",""))
		+Double.parseDouble(vndr_caution_money.replaceAll(",","").equals("")?"0":vndr_caution_money.replaceAll(",",""))+Double.parseDouble(insurance_lessee.replaceAll(",","").equals("")?"0":insurance_lessee.replaceAll(",",""))
		+Double.parseDouble(plan_totalrent.replaceAll(",","").equals("")?"0":plan_totalrent.replaceAll(",",""))
		),"#,##0.00");
	//------------------处理%---------------------
	equip_amt_bl="100.000000%";
	if(equip_amt.equals("")){
		insurance_lessor_bl="";
		other_fee_bl="";
		nominalprice_bl="";
		lease_money_bl="";
		pure_financing_bl="";
		insurance_lessee_bl="";
		total_income_bl="";
	}else if(Double.parseDouble(equip_amt.replaceAll(",",""))==0){
		insurance_lessor_bl="";
		other_fee_bl="";
		nominalprice_bl="";
		lease_money_bl="";
		pure_financing_bl="";
		insurance_lessee_bl="";
		total_income_bl="";
	}else{
		insurance_lessor_bl=formatNumberStr(String.valueOf(Double.parseDouble(insurance_lessor.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
		other_fee_bl=formatNumberStr(String.valueOf(Double.parseDouble(other_fee.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
		nominalprice_bl=formatNumberStr(String.valueOf(Double.parseDouble(nominalprice.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
		lease_money_bl=formatNumberStr(String.valueOf(Double.parseDouble(lease_money.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
		pure_financing_bl=formatNumberStr(String.valueOf(Double.parseDouble(pure_financing.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
		insurance_lessee_bl=formatNumberStr(String.valueOf(Double.parseDouble(insurance_lessee.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
		total_income_bl=formatNumberStr(String.valueOf(Double.parseDouble(total_income.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
	}
	first_payment_bl=getDBStr(rs.getString("first_payment_ratio"))+"%";
	lessee_caution_money_bl=getDBStr(rs.getString("lessee_caution_ratio"))+"%";
	handling_charge_bl=getDBStr(rs.getString("handling_charge_ratio"))+"%";
	return_amt_bl=getDBStr(rs.getString("return_ratio"))+"%";
	other_income_bl="0.000000%";//其它收入
	vndr_caution_money_bl=getDBStr(rs.getString("vndr_caution_ratio"))+"%";
	
	//---------------------下半段----------------
	start_date=getDBDateStr(rs.getString("start_date"));
	return_method=getDBStr(rs.getString("income_number_year")).equals("12")?"月付":getDBStr(rs.getString("income_number_year")).equals("4")?"季付":getDBStr(rs.getString("income_number_year")).equals("2")?"半年付":getDBStr(rs.getString("income_number_year")).equals("1")?"年付":"";
	period_name=getDBStr(rs.getString("period_type")).equals("1")?"期初":getDBStr(rs.getString("period_type")).equals("0")?"期末":"";
	per_rent=formatNumberStr(getPMT(String.valueOf(Double.parseDouble(getDBStr(rs.getString("year_rate")).equals("")?"0":getDBStr(rs.getString("year_rate")))/100/12),getDBStr(rs.getString("lease_term")),"-"+(getDBStr(rs.getString("lease_money")).equals("")?"0":getDBStr(rs.getString("lease_money"))),"0",getDBStr(rs.getString("period_type"))),"#,##0.00");
	
	year_rate=getDBStr(rs.getString("year_rate"))+"%";
	year_earn=getDBStr(rs.getString("year_earn"))+"%";
	lease_term=getDBStr(rs.getString("lease_term"));
	
	irr=getDBStr(rs.getString("irr"))+"%";
	rough_earn=formatNumberStr(getDBStr(rs.getString("rough_earn")),"#,##0.00");
	//------------------处理%---------------------
	if(equip_amt.equals("")){//占比
		per_rent_bl="占比:";
	}else if(Double.parseDouble(equip_amt.replaceAll(",",""))==0){
		per_rent_bl="占比:";
	}else{
		per_rent_bl="占比:"+formatNumberStr(String.valueOf(Double.parseDouble(per_rent.replaceAll(",",""))/Double.parseDouble(equip_amt.replaceAll(",",""))*100),"#,##0.000000")+"%";
	}
}rs.close();
l_first_amt.add(equip_amt);
l_first_amt.add(insurance_lessor);
l_first_amt.add(other_fee);
l_first_amt.add(lease_money);
l_first_amt.add(pure_financing);
l_first_amt.add(insurance_lessee);
l_first_amt.add(total_income);
l_first_bl.add(equip_amt_bl);
l_first_bl.add(insurance_lessor_bl);
l_first_bl.add(other_fee_bl);
l_first_bl.add(lease_money_bl);
l_first_bl.add(pure_financing_bl);
l_first_bl.add(insurance_lessee_bl);
l_first_bl.add(total_income_bl);

l_second_amt.add(first_payment);
l_second_amt.add(lessee_caution_money);
l_second_amt.add(handling_charge);
l_second_amt.add(return_amt);
l_second_amt.add(other_income);
l_second_amt.add(nominalprice);
l_second_amt.add(vndr_caution_money);
l_second_bl.add(first_payment_bl);
l_second_bl.add(lessee_caution_money_bl);
l_second_bl.add(handling_charge_bl);
l_second_bl.add(return_amt_bl);
l_second_bl.add(other_income_bl);
l_second_bl.add(nominalprice_bl);
l_second_bl.add(vndr_caution_money_bl);

l_first.add(start_date);
l_first.add(return_method);
l_first.add(period_name);

l_second.add(year_rate);
l_second.add(year_earn);
l_second.add(lease_term);

l_three.add(irr);
l_three.add(rough_earn);
l_three.add(cl);
//------------取数据------end-----------

response.reset();
response.setContentType("application/x-msexcel;charset=gbk");
response.setHeader("Content-disposition","attachment; filename=1.xls");
String path = pageContext.getServletContext().getRealPath("/");

HSSFRow templateRow;
HSSFCell cell;
HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(path+"\\func\\condition.xls")));
HSSFSheet templateSheet = wb.getSheetAt(0); 
HSSFCellStyle   style   =   wb.createCellStyle();
HSSFFont   font   =   wb.createFont();
style.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
style.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
style.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框

templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)2);
cell.setCellStyle(style);
cell.setCellValue(cust_name);

templateRow=templateSheet.createRow(3);
cell=templateRow.createCell((short)9);
cell.setCellStyle(style);
cell.setCellValue(proj_id);

for(int i=0;i<l_first_amt.size();i++){
	templateRow=templateSheet.createRow(i+5);
	cell=templateRow.createCell((short)4);
	cell.setCellStyle(style);
	cell.setCellValue(l_first_bl.get(i).toString());
	cell=templateRow.createCell((short)5);
	cell.setCellStyle(style);
	cell.setCellValue(l_first_amt.get(i).toString());
	
	cell=templateRow.createCell((short)8);
	cell.setCellStyle(style);
	cell.setCellValue(l_second_bl.get(i).toString());
	cell=templateRow.createCell((short)9);
	cell.setCellStyle(style);
	cell.setCellValue(l_second_amt.get(i).toString());
}
for(int i=0;i<l_first.size();i++){
	templateRow=templateSheet.createRow(i+13);
	cell=templateRow.createCell((short)3);
	cell.setCellStyle(style);
	cell.setCellValue(l_first.get(i).toString());
	cell=templateRow.createCell((short)5);
	cell.setCellStyle(style);
	cell.setCellValue(l_second.get(i).toString());
	cell=templateRow.createCell((short)8);
	cell.setCellStyle(style);
	cell.setCellValue(l_three.get(i).toString());
}
templateRow=templateSheet.createRow(16);
cell=templateRow.createCell((short)3);
cell.setCellStyle(style);
cell.setCellValue(per_rent);
templateRow=templateSheet.createRow(16);
cell=templateRow.createCell((short)4);
cell.setCellStyle(style);
cell.setCellValue(per_rent_bl);

//[ADD] [ZHANGHF] [2009-06-15] [导出租金回笼计划] [START] 
String income_number = "";
String income_number_year = "";
String rate_float_type = "";
String period_type = "";
String settle_method = "";
String income_day = "";
String first_payment_ratio = "";
String caution_money_ratio = "";
String caution_money = "";
String lessee_caution_ratio = "";
String vndr_caution_ratio = "";
String sale_caution_ratio = "";
String sale_caution_money = "";
String caution_deduction_ratio = "";
String caution_deduction_money = "";
String handling_charge_ratio = "";
String return_ratio = "";
String supervision_fee_ratio = "";
String supervision_fee = "";
String consulting_fee = "";
String insurance_method = "";
String redressalk = "";
String pena_rate = "";
String total_amt = "";
String actual_fund = "";
String first_date = "";
String second_date = "";

	sqlstr = "select * from proj_condition_temp where proj_id='" + proj_id + "' and measure_id='"+doc_id+"'"; 
	System.out.println(sqlstr);
	ResultSet rsContract = db.executeQuery(sqlstr); 
	if(rsContract.next()){
		equip_amt = formatNumberDoubleTwo(getDBStr(rsContract.getString("equip_amt")));
		lease_money = formatNumberDoubleTwo(getDBStr(rsContract.getString("lease_money")));
		lease_term = formatNumberDoubleZero(getDBStr(rsContract.getString("lease_term")));
		income_number = formatNumberDoubleZero(getDBStr(rsContract.getString("income_number")));
		income_number_year = formatNumberDoubleZero(getDBStr(rsContract.getString("income_number_year")));
		year_rate = formatNumberDoubleSix(getDBStr(rsContract.getString("year_rate"))); 
		rate_float_type = getDBStr(rsContract.getString("rate_float_type"));
		period_type = getDBStr(rsContract.getString("period_type"));
		settle_method = getDBStr(rsContract.getString("settle_method"));
		income_day = formatNumberDoubleZero(getDBStr(rsContract.getString("income_day")));
		first_payment_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("first_payment_ratio")));
		first_payment = formatNumberDoubleTwo(getDBStr(rsContract.getString("first_payment")));
		caution_money_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("caution_money_ratio")));
		caution_money = formatNumberDoubleTwo(getDBStr(rsContract.getString("caution_money")));
		lessee_caution_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("lessee_caution_ratio")));
		lessee_caution_money = formatNumberDoubleTwo(getDBStr(rsContract.getString("lessee_caution_money")));
		vndr_caution_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("vndr_caution_ratio")));
		vndr_caution_money = formatNumberDoubleTwo(getDBStr(rsContract.getString("vndr_caution_money")));
		sale_caution_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("sale_caution_ratio")));
		sale_caution_money = formatNumberDoubleTwo(getDBStr(rsContract.getString("sale_caution_money")));
		caution_deduction_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("caution_deduction_ratio")));
		caution_deduction_money = formatNumberDoubleTwo(getDBStr(rsContract.getString("caution_deduction_money")));
		handling_charge_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("handling_charge_ratio")));
		handling_charge = formatNumberDoubleTwo(getDBStr(rsContract.getString("handling_charge")));
		return_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("return_ratio")));
		return_amt = formatNumberDoubleTwo(getDBStr(rsContract.getString("return_amt")));
		supervision_fee_ratio = formatNumberDoubleFour(getDBStr(rsContract.getString("supervision_fee_ratio")));
		supervision_fee = formatNumberDoubleTwo(getDBStr(rsContract.getString("supervision_fee")));
		consulting_fee = formatNumberDoubleTwo(getDBStr(rsContract.getString("consulting_fee")));
		other_fee = formatNumberDoubleTwo(getDBStr(rsContract.getString("other_fee")));
		nominalprice = formatNumberDoubleTwo(getDBStr(rsContract.getString("nominalprice")));
		insurance_method = getDBStr(rsContract.getString("insurance_method"));
		insurance_lessor = formatNumberDoubleTwo(getDBStr(rsContract.getString("insurance_lessor")));
		insurance_lessee = formatNumberDoubleTwo(getDBStr(rsContract.getString("insurance_lessee")));
		redressalk = formatNumberDoubleFour(getDBStr(rsContract.getString("redressalk")));
		pena_rate = formatNumberDoubleFour(getDBStr(rsContract.getString("pena_rate")));
		total_amt = formatNumberDoubleTwo(getDBStr(rsContract.getString("total_amt")));
		actual_fund = formatNumberDoubleTwo(getDBStr(rsContract.getString("actual_fund")));
		rough_earn = formatNumberDoubleTwo(getDBStr(rsContract.getString("rough_earn")));
		year_earn = formatNumberDoubleTwo(getDBStr(rsContract.getString("year_earn")));
		irr = formatNumberDoubleFour(getDBStr(rsContract.getString("irr")));
		first_date = getDBDateStr(rsContract.getString("first_date"));
		second_date = getDBDateStr(rsContract.getString("second_date"));
		start_date  = getDBDateStr(rsContract.getString("start_date"));
	}
	rsContract.close();	

	ResultSet rsOld = null;
	ArrayList alOld = new ArrayList();
	String sql = "select * from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsOld = db.executeQuery(sql);
	while(rsOld.next()){
		HashMap hm = new HashMap();
		double deptd_rent = 0;
		if(getDBStr(rsOld.getString("eptd_rent"))!=null&&!getDBStr(rsOld.getString("eptd_rent")).equals("")){
			deptd_rent = Double.parseDouble(getDBStr(rsOld.getString("eptd_rent")));
		}
		double dnowrent = 0;
		if(getDBStr(rsOld.getString("rent"))!=null&&!getDBStr(rsOld.getString("rent")).equals("")){
			dnowrent = Double.parseDouble(getDBStr(rsOld.getString("rent")));
		}
		hm.put("rent_date",getDBDateStr(rsOld.getString("plan_date")));
		hm.put("volume",getDBStr(rsOld.getString("rent_list")));
		hm.put("eptd_rent",String.valueOf(deptd_rent));
		hm.put("rent",String.valueOf(dnowrent));
		hm.put("corpus",getDBStr(rsOld.getString("corpus")));
		hm.put("year_rate",getDBStr(rsOld.getString("year_rate")));
		hm.put("interest",getDBStr(rsOld.getString("interest")));
		hm.put("otherinput","0");
		hm.put("otheroutput","0");
		hm.put("adjust_amount",String.valueOf(dnowrent-deptd_rent));
		alOld.add(hm);
	}
	rsOld.close();
	double dequip_amt = 0;
		if(equip_amt!=null&&!equip_amt.equals("")){
		dequip_amt = Double.parseDouble(equip_amt);   //-
		}
		double dfirst_payment = 0;
		if(first_payment!=null&&!first_payment.equals("")){
		dfirst_payment = Double.parseDouble(first_payment); //+
		}
		double dcaution_money = 0;
		if(caution_money!=null&&!caution_money.equals("")){
		dcaution_money =Double.parseDouble(caution_money);   //+
		}
		double dhandling_charge = 0;
		if(handling_charge!=null&&!handling_charge.equals("")){
		dhandling_charge = Double.parseDouble(handling_charge);   //+
		}
		double dreturn_amt = 0;
		if(return_amt!=null&&!return_amt.equals("")){
		dreturn_amt = Double.parseDouble(return_amt);           //-
		}
		double dsupervision_fee = 0;
		if(supervision_fee!=null&&!supervision_fee.equals("")){
		dsupervision_fee = Double.parseDouble(supervision_fee);   //-
		}
		double dconsulting_fee = 0;
		if(consulting_fee!=null&&!consulting_fee.equals("")){
		dconsulting_fee = Double.parseDouble(consulting_fee);     //-
		}
		double dother_fee = 0;
		if(other_fee!=null&&!other_fee.equals("")){
		dother_fee = Double.parseDouble(other_fee);              //-
		}
		double dnominalprice = 0;
		if(nominalprice!=null&&!nominalprice.equals("")){
		dnominalprice = Double.parseDouble(nominalprice);         //+
		}
		double dinsurance_lessor = 0;
		if(insurance_lessor!=null&&!insurance_lessor.equals("")){
		dinsurance_lessor = Double.parseDouble(insurance_lessor);  //-
		}
		double dcaution_deduction_money = 0;
		if(caution_deduction_money!=null&&!caution_deduction_money.equals("")){
			dcaution_deduction_money = Double.parseDouble(caution_deduction_money); 
		}
		
		double dinput=dfirst_payment+dcaution_money+dhandling_charge+dreturn_amt+dsupervision_fee;
		double doutput = dequip_amt+dconsulting_fee+dother_fee+dinsurance_lessor;
		double dendinput = dnominalprice;
		double dendoutput =  dcaution_money-dcaution_deduction_money;
		ArrayList alCash = new ArrayList();
		if(alOld!=null&&alOld.size()>0){
			ArrayList alput = new ArrayList();
			//保证金抵扣计算
			int dedu = 0;
			if(dedu==0){
				//抵扣
				double dsubCaution = -1;
				if(dcaution_deduction_money>=0){
					dsubCaution = dcaution_deduction_money;
				}
				//根据租金计划从后向前计算保证金抵扣情况
				for(int i=(alOld.size()-1);i>=0;i--){
					HashMap hmGetRent = (HashMap)alOld.get(i);
					String strGetRent = (String)hmGetRent.get("rent");
					double dGetRent = 0;
					if(strGetRent!=null&&!strGetRent.equals("")){
						dGetRent = Double.parseDouble(strGetRent);
					}
					//如果没有保证金抵扣放入合同结束时收入支出
					if(i==(alOld.size()-1)&&dsubCaution==-1){
						HashMap hmRentput = new HashMap();
						hmRentput.put("input",String.valueOf(dendinput));
						hmRentput.put("output",String.valueOf(dendoutput));
						hmRentput.put("caution_deduction","0");
						alput.add(hmRentput);
					}
					//如果有保证金抵扣
					if(dsubCaution >= 0){
						//如果保证金返还〉租金
						if(dsubCaution>=dGetRent){
							//加入租金抵扣，不保存合同结束时收入支出
							HashMap hmRentput = new HashMap();
							hmRentput.put("input","0");
							hmRentput.put("output","0");
							hmRentput.put("caution_deduction",String.valueOf(dGetRent));
							alput.add(hmRentput);
							dsubCaution-=dGetRent;
						}else if(dsubCaution<dGetRent&&dsubCaution>0){
							//如果保证金返还<租金 加入剩余保证金返还,当期标示最为最后一期，保存合同结束时收入支出
							HashMap hmRentput = new HashMap();
							hmRentput.put("input",String.valueOf(dendinput));
							hmRentput.put("output",String.valueOf(dendoutput));
							hmRentput.put("caution_deduction",String.valueOf(dsubCaution));
							alput.add(hmRentput);
							dsubCaution = -1;
						}else if(dsubCaution==0){
							//如果保证金返还==上一期租金  （全部抵完） 当期标示最为最后一期，保存合同结束时收入支出
							HashMap hmRentput = new HashMap();
							hmRentput.put("input",String.valueOf(dendinput));
							hmRentput.put("output",String.valueOf(dendoutput));
							hmRentput.put("caution_deduction","0");
							alput.add(hmRentput);
							dsubCaution = -1;
						}
					}else{
						HashMap hmRentput = new HashMap();
						hmRentput.put("input","0");
						hmRentput.put("output","0");
						hmRentput.put("caution_deduction","0");
						alput.add(hmRentput);
					}
				}
				if(period_type.equals("0")){
					HashMap hmput = new HashMap();
					hmput.put("input",String.valueOf(dinput));
					hmput.put("output",String.valueOf(doutput));
					hmput.put("caution_deduction","0");
					alput.add(hmput);
				}else{
					HashMap hmput = new HashMap();
					hmput.put("input",String.valueOf(dinput));
					hmput.put("output",String.valueOf(doutput));
					hmput.put("caution_deduction","0");
					alput.set((alput.size()-1),hmput);
				}
				alput = invertList(alput);
			}else{
				//非抵扣
				int j=1;
				HashMap hmput = new HashMap();
				hmput.put("input",String.valueOf(dinput));
				hmput.put("output",String.valueOf(doutput));
				hmput.put("caution_deduction","0");
				alput.add(hmput);
				if(period_type.equals("0")){
					//期末
					j=0;
				}
				for(int i=j;i<(alOld.size()-1);i++){
					HashMap hmRentput = new HashMap();
					hmRentput.put("input","0");
					hmRentput.put("output","0");
					hmRentput.put("caution_deduction","0");
					alput.add(hmRentput);
				}
				HashMap hmEndput = new HashMap();
				hmEndput.put("input",String.valueOf(dendinput));
				hmEndput.put("output",String.valueOf(dendoutput));
				hmput.put("caution_deduction","0");
				alput.add(hmEndput); 
			}
			for(int i=0;i<alput.size();i++){
				HashMap hm = (HashMap)alput.get(i);
				System.out.println("input:"+hm.get("input"));
				System.out.println("output:"+hm.get("output"));
				System.out.println("caution_deduction:"+hm.get("caution_deduction"));
			}
			alCash = getRentCashArray(alOld,alput,period_type,start_date,"0");
		}
		double dlease_money = 0;
		if(lease_money!=null&&!lease_money.equals("")){
			dlease_money = Double.parseDouble(lease_money);
		}
		if(alCash!=null){
			for(int i=0;i<alCash.size();i++){
				HashMap hm = (HashMap)alCash.get(i);
				String rent_list = (String)hm.get("volume");
				String rent_date = (String)hm.get("rent_date");
				String dept_rent = (String)hm.get("eptd_rent");
				String rent = (String)hm.get("rent");
				String corpus = (String)hm.get("corpus");
				String interest = (String)hm.get("interest");
				String net_flow = (String)hm.get("net_flow");
				String adjust = "";
				double dcorpus = 0;
				if(corpus!=null&&!corpus.equals("")){
					dcorpus = Double.parseDouble(corpus);
				}
				if(dept_rent!=null&&!dept_rent.equals("")&&rent!=null&&!rent.equals("")){
					adjust = String.valueOf(Double.parseDouble(rent)-Double.parseDouble(dept_rent));
				}
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);//   下边框   
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//   左边框   
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);//   右边框   
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);//   上边框
				
				font.setFontHeightInPoints((short)   10);   
  				font.setFontName("Arial");
  				style.setFont(font);
//  			short doubleFormat = HSSFDataFormat.getBuiltinFormat("##,##0.00");
// 				style.setDataFormat(doubleFormat);
//				HSSFDataFormat df = wb.createDataFormat();
//				style.setDataFormat(df.getFormat("##,##0.00"));
  				
//  			font.setFontHeightInPoints((short)   10);   
//  			font.setFontName("宋体");
// 				style.setFont(font);
				
				templateRow=templateSheet.createRow(i+19);
				cell=templateRow.createCell((short)1);
				cell.setCellStyle(style);
				cell.setCellValue(rent_list);
				cell=templateRow.createCell((short)2);
				cell.setCellStyle(style);
				cell.setCellValue(rent_date);
				cell=templateRow.createCell((short)3);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(dept_rent,"#,##0.00"));
				cell=templateRow.createCell((short)4);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(adjust,"#,##0.00"));
				cell=templateRow.createCell((short)5);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(rent,"#,##0.00"));
				cell=templateRow.createCell((short)6);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(corpus,"#,##0.00"));
				cell=templateRow.createCell((short)7);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(interest,"#,##0.00"));
				cell=templateRow.createCell((short)8);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(formatNumberDoubleTwo(dlease_money),"#,##0.00"));
				//少剩余本金
				cell=templateRow.createCell((short)9);
				cell.setCellStyle(style);
				cell.setCellValue(formatNumberStr(net_flow,"#,##0.00"));
				dlease_money -= dcorpus;;
			}
		}
//[ADD] [ZHANGHF] [2009-06-15] [导出租金回笼计划] [END]


OutputStream os = response.getOutputStream();
wb.write(os);
os.close();
db.close();
%>