<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@page import="com.tenwa.culc.service1.BeginService1"%>
<%@page import="com.tenwa.culc.bean.RentInfoBox"%>
<%@page import="com.tenwa.culc.calc.zjcs.RentInfoDBOperation"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
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
    String begin_id = getStr(request.getParameter("begin_id")); //起租编号
    //1.1.1费用类参数
	String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//申请金额(设备金额)
	String currency = getStr(request.getParameter("currency"));//货币类型
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//租赁本金
	String actual_fund = getZeroStr(getStr(request.getParameter("actual_fund")));//净融资额

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
	String ratio_param = getStr(request.getParameter("ratio_param"));// 本金公比、租金公比、本金公差、租金公差
	String is_open = getStr(request.getParameter("is_open"));// 对外公开利率
	String plan_bank_name = getStr(request.getParameter("plan_bank_name"));// 计划收款银行
	String plan_bank_no = getStr(request.getParameter("plan_bank_no"));// 计划收款账号
	String invoice_type = getStr(request.getParameter("invoice_type"));// 租金开票方式
	//新增
	String fact_irr = getZeroStr(getStr(request.getParameter("fact_irr")));//实际IRR
	//sys2012-2-3
	String factoring=getStr(request.getParameter("factoring"));
	//2012-9-12 zhangqi新增税种
	String tax_type=getStr(request.getParameter("tax_type"));
	LogWriter.logDebug(request, "税种新增:"+tax_type);

	//1.1.5基础参数
	String creator = user_id;//登记人
	String flowSysDate = getStr(request.getParameter("flowSysDate"));//流程启动时间
	String create_date = flowSysDate;//登记时间
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
	//新增20110929 起租序号
	String begin_order_index = getStr(request.getParameter("begin_order_index"));
	
	int res = 0;
	//1.2==创建对象，属性赋值
	BeginInfoBean beginInfoBean = new BeginInfoBean(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,actual_fund,assets_value,
			income_number,income_number_year,lease_term,settle_method,period_type,rate_float_type,rate_float_amt,
			year_rate,pena_rate,start_date,income_day,end_date,plan_irr,free_defa_inter_day,adjust_style,
			into_batch,ratio_param,rent_start_date,is_open,plan_bank_name,plan_bank_no,creator,create_date,modify_date,modificator);
	beginInfoBean.setInvoice_type(invoice_type);
	beginInfoBean.setBegin_order_index(begin_order_index);
	beginInfoBean.setFact_irr(fact_irr);
	beginInfoBean.setFactoring(factoring);
	beginInfoBean.setTax_type(tax_type);

	LogWriter.logDebug(request, beginInfoBean.getContract_id()+"起租信息保存之前操作，封转BeginInfoBean。。。。"+saveType);
	
	//================2.保存BeginInfo?insert:update================
	res += BeginService.saveBeginBeanIntoTemp(beginInfoBean, saveType);
	res+=BeginService1.flowUpdateTaxtypeToBeginTemp(beginInfoBean);
	//起租的同时更新交易结构表保持数据最新2012-10-10
	String sqlStr="update contract_condition set tax_type='"+tax_type+"' where contract_id='"+contract_id+"'";
	res+=db.executeUpdate(sqlStr);

	LogWriter.logDebug(request, "起租信息数据保存成功！");
	
	System.out.println("租金测算类型："+settle_method);
	
	if("RentCalcType8".equals(settle_method) || "RentCalcType9".equals(settle_method) || "RentCalcType10".equals(settle_method)){
		//非标准测试无需测算
		LogWriter.logDebug(request, "项目立项 - 租金测算完成，非标准测算无需测算！");
	}else{
		//================3.通过BeginInfoBean测算结果（租金计划、现金流）================
		RentInfoBox rentInfoBox = RentPlanService.calcBeginRentPlan(beginInfoBean);//将Begin_info_bean --> ConditionBean
			System.out.println("===============shifou shifou=================");
		//================4.保存租金计划、现金流================
		res += RentInfoDBOperation.operBeginRentInfoBox2DB(rentInfoBox, beginInfoBean);//保存
			
		LogWriter.logDebug(request, "起租租金测算完成，保存租金计划、现金流成功！");
	}
		
int flag = res;
//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		//1.进行生成文档
		//window.open("http://domino.culc.com/eleasing/homepage.nsf/Main_frame?openframeset");
		window.open("http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/CreateQZNotice2?openagent&fileno=111&contractid=<%=contract_id %>&docid=<%=doc_id %>&beginid=<%=begin_id %>","","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");

		//2.提示信息
		alert("租金测算成功!");
		window.parent.location.reload();
	    //window.close();
	    if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("租金测算失败!");
		window.parent.location.reload();
		//this.close();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%	
}
%>
<%if(null != db){db.close();}%>