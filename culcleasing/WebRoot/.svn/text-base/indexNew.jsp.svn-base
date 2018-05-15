<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<jsp:useBean id="fc" scope="page" class="com.filter.FilterCredit" /> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>CULC WAS Index</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>

  <a href="monitor/optionMonitorS/opinion_list.jsp" target="new">个人待落实意见</a> <br><br>

  <a href="projStartRent/currconfirm_subsidy/currconfirm_subsidy.jsp" target="new">财务-当期分次确认</a> <br>
  <a href="projStartRent/interest_subsidy/interest_subsidy.jsp" target="new">财务-利息补贴确认</a> <br>

  <a href="projStartRent/caution_upd/fund_update.jsp" target="new">财务-修改保证金计划日期</a> <br>
  <br><br>

  <a href="projCreate/paycond_cw/paycond_list.jsp" target="new">立项财务-修改计划日期</a> <br>
  <a href="projCreate/paycond_sw/paycond_list.jsp" target="new">立项商务-修改付款前提</a> <br>

  <a href="flowEditZQ/paycond_cw/paycond_list.jsp" target="new">项目签约审批前财务-修改计划日期</a> <br>
  <a href="flowEditZQ/paycond_sw/paycond_list.jsp" target="new">项目签约审批前商务-修改付款前提</a> <br>

  <a href="contractApprove/paycond_cw/paycond_list.jsp" target="new">项目签约审批财务-修改计划日期</a> <br>
  <a href="contractApprove/paycond_sw/paycond_list.jsp" target="new">项目签约审批商务-修改付款前提</a> <br>

  <a href="flowEditZH/paycond_cw/paycond_list.jsp" target="new">项目签约审批后财务-修改计划日期</a> <br>
  <a href="flowEditZH/paycond_sw/paycond_list.jsp" target="new">项目签约审批后商务-修改付款前提</a> <br>
<br>

  <br><br>
  <a href="flowJsp/exec_fund_upd/fund_exec_list.jsp" target="new">财务-批量修改资金计划</a> <br>
  
	<hr> 租赁资信评估流程 </hr> <br> <br>
 <a href="flowZXPGJsp/zjcs_cal_up_read/main.jsp" target="new">商务条件-只读</a> <br>
 <a href="flowZXPGJsp/paycond_read/paycond_list.jsp" target="new">资金计划-只读</a> <br>
 <a href="flowZXPGJsp/proj_mater_read/proj_mater_list.jsp" target="new">项目资料-只读</a> <br>
   
	<hr> 医疗管理资信评估流程 </hr> <br> <br>
 <a href="flowZXPGMediJsp/zjcs_cal_read/main.jsp" target="new">商务条件-只读</a> <br>
 <a href="flowZXPGMediJsp/paycond_read/paycond_list.jsp" target="new">资金计划-只读</a> <br>
 <a href="flowZXPGMediJsp/proj_mater_read/proj_mater_list.jsp" target="new">项目资料-只读</a> <br>
   

<hr><h2>融资模块</h2></hr>
 <a href="financing/flowStart/financing_sxbg.jsp" target="new">授信变更-快捷</a> <br>
 <a href="financing/flowStart/financing_rzsb.jsp" target="new">融资申报-快捷</a> <br>
 <a href="financing/flowStart/financing_rzsx.jsp" target="new">融资授信-快捷</a> <br>
 <a href="financing/flowStart/financing_hk.jsp" target="new">还款-快捷</a> <br>
 <a href="financing/flowStart/financing_dq.jsp" target="new">掉期-快捷</a> <br>


<hr><h2>保费付款资金计划制定</h2></hr>
 <a href="insur/insur_fund/insur_fund_list.jsp" target="new">保费资金计划-编辑</a> <br>
 <a href="insur/insur_fund_read/insur_fund_list.jsp" target="new">保费资金计划-只读</a> <br>

<hr><h2>融资还款计划变更-流程</h2></hr>
 <a href="financing/refund_change/refund_list.jsp" target="new">融资还款计划变更-编辑</a> <br>
 <a href="financing/refund_change_read/refund_list_read.jsp" target="new">融资还款计划变更-只读</a> <br>

<hr><h2>融资还款计划变更-批量调息</h2></hr>
 <a href="financing/refund_tx/refund_list.jsp" target="new">融资还款计划变更-批量</a> <br>


<hr><h2>融资租赁起租</h2></hr>
 <a href="projStartRent/zjcs_cal_up/main.jsp" target="new">起租新增特殊租金计划上传</a> <br>


<hr><h2>保险管理</h2></hr>
 <a href="insur/insur_payapp/insur_pay_apply.jsp" target="new">批量保费支付申请</a> <br>
 <a href="insur/insur_payapp/insur_pay_apply_search.jsp" target="new">批量保费支付查询</a> <br>

 <a href="insur/insur_payapp/leasing_flow.jsp?czid=11111" target="new">批量保费支付-流程</a><br>


<hr><h2>医疗管理</h2></hr>
<a href="flowMediCashChange/cash_change/main.jsp" target="new">预测现金流修订-编辑</a> <br>
<a href="flowMediCashChange/cash_change_read/main.jsp" target="new">预测现金流修订-只读</a> <br>

<hr><h2>CD交接</h2></hr>
<a href="flowMediCashChange/cash_change/main.jsp" target="new">预测现金流修订-编辑</a> <br>

<hr><h2>客户管理</h2></hr>
<a href="khxx/khfr/frkh_list.jsp" target="new">短信发送设置</a> <br>


 </body>
</html>
