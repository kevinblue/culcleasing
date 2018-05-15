<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoMediBean"%>
<%@page import="com.tenwa.culc.service.BeginMediService"%>
<%@page import="com.tenwa.culc.bean.RentInfoBox"%>
<%@page import="com.tenwa.culc.calc.zjcs.RentInfoDBOperation"%>
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
    String contract_id = getStr(request.getParameter("contract_id")); //项目编号
    String begin_id =getStr(request.getParameter("begin_id"));

    //1.1.2参数
	String income_number_year = getStr(request.getParameter("income_number_year"));//付租方式income_number_year
	String income_number = getZeroStr(getStr(request.getParameter("income_number")));//还租次数income_number
	String lease_term = getStr(request.getParameter("lease_term"));//租赁期限(月)lease_term
	String income_day = getStr(request.getParameter("income_day"));//每月偿付日
	System.out.println("sss"+income_day);
	String start_date = getStr(request.getParameter("start_date"));//起租日start_date
	String rent_start_date = getStr(request.getParameter("start_date"));//预计起租日
		
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
	BeginInfoMediBean beginInfoMediBean = new BeginInfoMediBean();
	beginInfoMediBean.setDoc_id(doc_id);
	beginInfoMediBean.setContract_id(contract_id);
	beginInfoMediBean.setBegin_id(begin_id);
	beginInfoMediBean.setRent_start_date(rent_start_date);
	beginInfoMediBean.setStart_date(start_date);
	beginInfoMediBean.setIncome_day(income_day);
	beginInfoMediBean.setIncome_number(income_number);
	beginInfoMediBean.setIncome_number_year(income_number_year);
	beginInfoMediBean.setLease_term(lease_term);
	beginInfoMediBean.setBegin_order_index(begin_order_index);

	LogWriter.logDebug(request, beginInfoMediBean.getContract_id()+"起租信息保存之前操作，封转BeginInfoBean。。。。"+saveType);
	//================2.保存BeginInfo?insert:update================
	int flag = 0;
	flag = BeginMediService.saveBeginBeanIntoTemp(beginInfoMediBean, saveType);
	LogWriter.logDebug(request, "起租信息数据保存成功！");

	//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("起租信息保存成功!");
		window.parent.location.reload();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("起租信息保存失败!");
		window.parent.location.reload();
	</script>
<%	
}
%>
