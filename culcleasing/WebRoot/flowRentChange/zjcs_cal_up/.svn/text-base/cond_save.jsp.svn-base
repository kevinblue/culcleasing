<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

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
	int flag = 0;
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
	//新增
	String fact_irr = getZeroStr(getStr(request.getParameter("fact_irr")));//实际IRR
	String begin_order_index = getZeroStr(getStr(request.getParameter("begin_order_index")));//实际IRR
	
	//1.1.4其他参数
	String assets_value = getStr(request.getParameter("assets_value"));// 资产余值
	String ratio_param = getStr(request.getParameter("ratio_param"));// 本金公比、租金公比、本金公差、租金公差
	String is_open = getStr(request.getParameter("is_open"));// 对外公开利率
	String plan_bank_name = getStr(request.getParameter("plan_bank_name"));// 计划收款银行
	String plan_bank_no = getStr(request.getParameter("plan_bank_no"));// 计划收款账号
	String invoice_type = getStr(request.getParameter("invoice_type"));// 租金开票方式
	//sys2012-2-3
	String factoring=getStr(request.getParameter("factoring"));

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
	BeginInfoBean beginInfoBean = new BeginInfoBean(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,actual_fund,assets_value,
			income_number,income_number_year,lease_term,settle_method,period_type,rate_float_type,rate_float_amt,
			year_rate,pena_rate,start_date,income_day,end_date,plan_irr,free_defa_inter_day,adjust_style,
			into_batch,ratio_param,rent_start_date,is_open,plan_bank_name,plan_bank_no,creator,create_date,modify_date,modificator);
	beginInfoBean.setInvoice_type(invoice_type);
	beginInfoBean.setFact_irr(fact_irr);
	beginInfoBean.setBegin_order_index(begin_order_index);
	beginInfoBean.setFactoring(factoring);
	
	LogWriter.logDebug(request, beginInfoBean.getContract_id()+"起租信息保存之前操作，封转BeginInfoBean。。。。"+saveType);
	
	//================2.保存BeginInfo?insert:update================
	flag = BeginService.saveBeginBeanIntoTemp(beginInfoBean, saveType);
	LogWriter.logDebug(request, "租金变更-商务信息数据保存成功！");
	
	//2012-03-28 jaffe新增  NewIrr  OldIrr
	String old_irr = getZeroStr(getStr(request.getParameter("old_irr")));//老IRR
	String new_irr = getZeroStr(getStr(request.getParameter("new_irr")));//新IRR
	//1.删除 begin_rent_change_irr 数据  2.插入新的Irr数据
	String sqlStr = "Delete from begin_rent_change_irr where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlStr);
	//2
	sqlStr = "Insert into begin_rent_change_irr(begin_id,old_irr,new_irr,doc_id,flag_val,creator,create_date)";
	sqlStr +=" Values('"+begin_id+"','"+old_irr+"','"+new_irr+"','"+doc_id+"',0,'"+creator+"','"+create_date+"')";
	db.executeUpdate(sqlStr);
	
//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("数据更新成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("数据更新失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
<%if(null != db){db.close();}%>