<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.bean.ConditionBean"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.bean.RentPlanBean"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.calc.zjcs.RentInfoDBOperation"%>
<%@page import="com.tenwa.culc.bean.RentInfoBox"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" class="dbconn.Conn" ></jsp:useBean>


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
   
	//新增字段
	String irr = getZeroStr(getStr(request.getParameter("irr")));//实际IRR
	String invoice_type=getStr(request.getParameter("invoice_type"));//租金开票方式
	String insure_type = getStr(request.getParameter("insure_type"));//投保方式
	String insur_pay_type=getStr(request.getParameter("insure_pay_type")); //保险收取方式
	
	//1.1.5基础参数
	String creator = user_id;//登记人
	String create_date = sysDate;//登记时间
    String modify_date = sysDate;//更新日期
	String modificator = user_id;//更新人

	int res = 0;
	//1.2==创建对象，属性赋值
	ConditionBean conditionBean = new ConditionBean();
	
	conditionBean.setContract_id(contract_id);
	conditionBean.setIrr(irr);
	conditionBean.setDoc_id(doc_id);
	conditionBean.setProj_id("");
	conditionBean.setModificator(modificator);
	conditionBean.setModify_date(modify_date);
	conditionBean.setCreator(creator);
	conditionBean.setCreate_date(create_date);
	
	
	
	LogWriter.logDebug(request, conditionBean.getProj_id()+"保存之前操作，封转Bean。。。。"+saveType);
	//================2.保存ConditionBean?insert:update================
	String sqlstr="update contract_condition_temp set irr='"+irr+"',invoice_type='"+invoice_type+"',insure_type='"+insure_type+"',insure_pay_type='"+insur_pay_type+"'";
	sqlstr += " where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	res=db.executeUpdate(sqlstr);
	System.out.println(sqlstr);
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
<%if(null != db){db.close();}%>