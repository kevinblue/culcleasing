<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.bean.ConditionMediBean"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.ConditionMediService"%>
<%@ include file="../../func/common_simple.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商务信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
	//0.基础参数
	String user_id = (String)session.getAttribute("czyid");//当前登陆人
	String sysDate = getSystemDate(0);
	String saveType = getStr(request.getParameter("saveType")); //操作类型、insert、update
	
	//================1.封装ConditionBean================
	//1.1==获取参数
	String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
    String proj_id = getStr(request.getParameter("proj_id")); //项目编号
    //1.1.1费用类参数
	String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//申请金额(设备金额)equip_amt
	String currency = getStr(request.getParameter("currency"));//货币类型
	String first_payment = getZeroStr(getStr(request.getParameter("first_payment")));//首付款first_payment
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//租赁本金lease_money

	String actual_fund = getZeroStr(getStr(request.getParameter("actual_fund")));//净融资额actual_fund

	String caution_money = getZeroStr(getStr(request.getParameter("caution_money")));//租赁保证金caution_money
	String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//手续费（经销商）handling_charge
	String nominalprice = getZeroStr(getStr(request.getParameter("nominalprice")));//期末残值(或名义留购价)nominalprice
	String return_amt = getZeroStr(getStr(request.getParameter("return_amt")));//厂商返利return_amt
	String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//租前息before_interest
	String before_interest_type = getZeroStr(getStr(request.getParameter("before_interest_type")));//租前息类型-是否算本before_interest_type
	String other_income = getZeroStr(getStr(request.getParameter("other_income")));//其他收入other_income
	String other_expenditure = getZeroStr(getStr(request.getParameter("other_expenditure")));//其他支出other_expenditure
	String discount_rate = getZeroStr(getStr(request.getParameter("discount_rate")));//贴现息discount_rate
	String rate_subsidy = getZeroStr(getStr(request.getParameter("rate_subsidy")));//利息补贴rate_subsidy
	String insure_type = getStr(request.getParameter("insure_type"));//投保方式insure_type
	String insure_money = getZeroStr(getStr(request.getParameter("insure_money")));//保费金额insure_money
	String management_fee = getStr(request.getParameter("management_fee"));//管理费management_fee
	String consulting_fee_out = getZeroStr(getStr(request.getParameter("consulting_fee_out")));//咨询费支出consulting_fee_out
	String consulting_fee_in = getZeroStr(getStr(request.getParameter("consulting_fee_in")));//咨询费支入consulting_fee_in
	
	//1.1.2测算类参数
	String income_number_year = getStr(request.getParameter("income_number_year"));//付租方式income_number_year
	String income_number = getZeroStr(getStr(request.getParameter("income_number")));//还租次数income_number
	String lease_term = getStr(request.getParameter("lease_term"));//租赁期限(月)lease_term
	String income_day = getStr(request.getParameter("income_day"));//每月偿付日
	String start_date = getStr(request.getParameter("start_date"));//起租日start_date
	String rent_start_date = getStr(request.getParameter("start_date"));//预计起租日
	String free_defa_inter_day = getStr(request.getParameter("free_defa_inter_day"));//逾期宽限日free_defa_inter_day
	//1.1.3利率参数
	String pena_rate = getZeroStr(getStr(request.getParameter("pena_rate")));//罚息利率
	
	//1.1.4其他参数
	String manager_pay_type=getStr(request.getParameter("manager_pay_type"));//manager_pay_type
	String is_floor=getStr(request.getParameter("is_floor"));   //is_floor
	String floor_rent=getStr(request.getParameter("floor_rent")); //floor_rent
	String insure_pay_type=getStr(request.getParameter("insure_pay_type"));//insure_pay_type
	String actual_fund_ratio=getStr(request.getParameter("actual_fund_ratio"));
	String plan_bank_name =getStr(request.getParameter("plan_bank_name"));
	String plan_bank_no =getStr(request.getParameter("plan_bank_no"));
	
	//2012-3-12 Jaffe 新增参数
	String rate_float_type=getStr(request.getParameter("rate_float_type"));
	String rate_float_amt =getStr(request.getParameter("rate_float_amt"));
	String adjust_style =getStr(request.getParameter("adjust_style"));
	
	String into_batch=getStr(request.getParameter("into_batch"));
	String is_open =getStr(request.getParameter("is_open"));
	String settle_method =getStr(request.getParameter("settle_method"));
	String period_type =getStr(request.getParameter("period_type"));
	String year_rate =getStr(request.getParameter("year_rate"));
	System.out.println("获取吃撒大声："+year_rate);
	//1.1.5基础参数
	String creator = user_id;//登记人
	String create_date = sysDate;//登记时间
    String modify_date = sysDate;//更新日期
	String modificator = user_id;//更新人

	//起始日期、结束日期处理
	SimpleDateFormat simpledate = new SimpleDateFormat("yyyy-MM-dd");
	String now_start_date = start_date.substring(0,8)+income_day;//整合起租日和偿还日的日期
	start_date = simpledate.format(simpledate.parse(now_start_date));
	Calendar startCale = Calendar.getInstance();
	startCale.setTime(simpledate.parse(now_start_date));
	startCale.add(Calendar.MONTH, ConvertUtil.parseInt(lease_term, 0));
		
	String end_date = simpledate.format(startCale.getTime());
	
	//1.2==创建对象，属性赋值
	ConditionMediBean conditionMediBean = new ConditionMediBean(
	 doc_id,  proj_id,  equip_amt,currency,  lease_money,  first_payment,caution_money,  "",
	 actual_fund,  handling_charge,  management_fee,nominalprice,  return_amt,  rate_subsidy, before_interest, 
	 before_interest_type,discount_rate,  consulting_fee_out,consulting_fee_in,  other_income,
	 other_expenditure,  rent_start_date,  start_date,income_day, income_number,  income_number_year,
	 lease_term, pena_rate, free_defa_inter_day, insure_type,  insure_pay_type,  insure_money,
	 is_floor,  floor_rent,  manager_pay_type, creator,  create_date,  modify_date,modificator
	);
	conditionMediBean.setActual_fund_ratio(actual_fund_ratio);
	conditionMediBean.setPlan_bank_name(plan_bank_name);
	conditionMediBean.setPlan_bank_no(plan_bank_no);
	//2012-3-12 Jaffe 新增
	conditionMediBean.setRate_float_type(rate_float_type);
	conditionMediBean.setRate_float_amt(rate_float_amt);
	conditionMediBean.setAdjust_style(adjust_style);
	conditionMediBean.setInto_batch(into_batch);
	conditionMediBean.setIs_open(is_open);
	conditionMediBean.setSettle_method(settle_method);
	conditionMediBean.setPeriod_type(period_type);
	conditionMediBean.setYear_rate(year_rate);
	
	LogWriter.logDebug(request, conditionMediBean.getProj_id()+"保存之前操作，封转Bean。。。。"+saveType);
	
	//================2.保存ConditionBean?insert:update================
	int flag = 0;	
	flag = ConditionMediService.saveConditionBeanIntoTemp(conditionMediBean, saveType);

	//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
	if(flag>0){
%>
    <script type="text/javascript">
		alert("商务信息保存成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
	}else{
%>
    <script type="text/javascript">
		alert("商务信息保存失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
	}
%>
