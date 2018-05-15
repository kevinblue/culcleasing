<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.bean.ConditionBean"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.calc.zjcs.RentInfoDBOperation"%>
<%@page import="com.tenwa.culc.bean.RentInfoBox"%>
<%@ include file="../../func/common_simple.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 交易结构及租金处理</title>
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
    String contract_id = getStr(request.getParameter("contract_id")); //合同编号
    //1.1.1费用类参数
	String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//申请金额(设备金额)
	String currency = getStr(request.getParameter("currency"));//货币类型
	String first_payment = getZeroStr(getStr(request.getParameter("first_payment")));//首付款
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//租赁本金

	String actual_fund = getZeroStr(getStr(request.getParameter("actual_fund")));//净融资额
	String actual_fund_ratio = getZeroStr(getStr(request.getParameter("actual_fund_ratio")));//净融资额比例 

	String caution_money = getZeroStr(getStr(request.getParameter("caution_money")));//租赁保证金
	String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//手续费（经销商）
	String nominalprice = getZeroStr(getStr(request.getParameter("nominalprice")));//期末残值(或名义留购价)
	String return_amt = getZeroStr(getStr(request.getParameter("return_amt")));//厂商返利
	String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//租前息
	String before_interest_type = getZeroStr(getStr(request.getParameter("before_interest_type")));//租前息_是否算本

	String other_income = getZeroStr(getStr(request.getParameter("other_income")));//其他收入
	String other_expenditure = getZeroStr(getStr(request.getParameter("other_expenditure")));//其他支出
	String discount_rate = getZeroStr(getStr(request.getParameter("discount_rate")));//贴现息
	String rate_subsidy = getZeroStr(getStr(request.getParameter("rate_subsidy")));//利息补贴
	String insure_type = getStr(request.getParameter("insure_type"));//投保方式
	String insure_money = getZeroStr(getStr(request.getParameter("insure_money")));//保费金额
	String management_fee = getStr(request.getParameter("management_fee"));//管理费
	String consulting_fee_out = getZeroStr(getStr(request.getParameter("consulting_fee_out")));//咨询费支出
	String consulting_fee_in = getZeroStr(getStr(request.getParameter("consulting_fee_in")));//咨询费支入
	
	//1.1.2测算类参数
	String period_type = getStr(request.getParameter("period_type"));//付租类型 period_type 期初、期末
	String income_number_year = getStr(request.getParameter("income_number_year"));//付租方式
	String income_number = getZeroStr(getStr(request.getParameter("income_number")));//还租次数
	String lease_term = getStr(request.getParameter("lease_term"));//租赁期限(月)
	String income_day = getStr(request.getParameter("income_day"));//每月偿付日
	String start_date = getStr(request.getParameter("start_date"));//起租日
	String rent_start_date = getStr(request.getParameter("start_date"));//起租日
	
	String year_rate = getZeroStr(getStr(request.getParameter("year_rate")));//租赁年利率
	String rate_float_type = getStr(request.getParameter("rate_float_type"));//利率浮动类型
	String free_defa_inter_day = getStr(request.getParameter("free_defa_inter_day"));//逾期宽限日
	//1.1.3利率参数
	String pena_rate = getZeroStr(getStr(request.getParameter("pena_rate")));//罚息利率
	String rate_float_amt = getZeroStr(getStr(request.getParameter("rate_float_amt")));//利率调整值
	String plan_irr = getZeroStr(getStr(request.getParameter("plan_irr")));//计划IRR
	String settle_method = getStr(request.getParameter("settle_method"));//租金计算方法  
	String into_batch = getStr(request.getParameter("into_batch"));//是否批量调息
	String adjust_style = getStr(request.getParameter("adjust_style"));//调息方式
	
	//1.1.4其他参数
	String assets_value = getStr(request.getParameter("assets_value"));// 资产余值
	String assess_adjust = getStr(request.getParameter("assess_adjust"));// 考核调整
	String ratio_param = getStr(request.getParameter("ratio_param"));// 本金公比、租金公比、本金公差、租金公差
	//新增字段
	String irr = getZeroStr(getStr(request.getParameter("irr")));//实际IRR
	
	
	//sys新增参数 
	String invoice_type=getStr(request.getParameter("invoice_type"));
	String StandardF=getStr(request.getParameter("StandardF"));
	String StandardIrr=getStr(request.getParameter("StandardIrr"));	
	String insur_pay_type=getStr(request.getParameter("insure_pay_type")); //保险收取方式
	//2012-9-12 zhangqi新增税种
	String tax_type=getStr(request.getParameter("tax_type"));
	LogWriter.logDebug(request, "税种新增:"+tax_type);

	//2012-11-20 zhangqi新增增值税发票类型
	String tax_type_invoice=getStr(request.getParameter("tax_type_invoice"));
	LogWriter.logDebug(request, "新增增值税发票类型:"+tax_type_invoice);
	
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
	int res = 0;
	
	//1.2==创建对象，属性赋值
	ConditionBean conditionBean = new ConditionBean(doc_id,"",equip_amt,currency,lease_money,
			first_payment,caution_money,actual_fund,actual_fund_ratio,handling_charge,management_fee,nominalprice,return_amt,
			rate_subsidy,before_interest,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,
			income_number,income_number_year,lease_term,settle_method,period_type,rate_float_type,rate_float_amt,adjust_style,
			year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,plan_irr,free_defa_inter_day,
			insure_type,into_batch,insure_money,assets_value,assess_adjust,ratio_param,creator,create_date,modify_date,modificator);
	conditionBean.setContract_id(contract_id);
	conditionBean.setBefore_interest_type(before_interest_type);
	conditionBean.setIrr(irr);
	
	//sys新增字段
	conditionBean.setInvoice_type(invoice_type);
	conditionBean.setStandardF(StandardF);
	conditionBean.setStandardIrr(StandardIrr);
	conditionBean.setInsure_pay_type(insur_pay_type);
	conditionBean.setTax_type(tax_type);
	conditionBean.setTax_type_invoice(tax_type_invoice);
	
	LogWriter.logDebug(request, conditionBean.getProj_id()+"保存之前操作，封转Bean。。。。"+saveType);
	
	//================2.保存ConditionBean?insert:update================
	res += ConditionService.saveConditionContractBeanIntoTemp(conditionBean, saveType);

	res +=ConditionService1.flowUpdateTaxtypeToContractTemp(conditionBean);
	
	
	if("RentCalcType8".equals(settle_method) || "RentCalcType9".equals(settle_method) || "RentCalcType10".equals(settle_method)){
		//非标准测试无需测算
		LogWriter.logDebug(request, "项目立项 - 租金测算完成，非标准测算无需测算！");
	}else{
		//================3.通过BeginInfoBean测算结果（租金计划、现金流）================
		RentInfoBox rentInfoBox = RentPlanService.calcContractRentPlan(conditionBean);
			
		//================4.保存租金计划、现金流================
		res += RentInfoDBOperation.operContractRentInfoBox2DB(rentInfoBox, conditionBean);//保存
			
		LogWriter.logDebug(request, "签约审批 - 租金测算完成，保存租金计划、现金流成功！");
		
	}
	
int flag = res;
//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("租金测算成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("租金测算失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
