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
    <h2><a href="flowJsp/zjcs_medi_read/main.jsp" target="new">正式商务条件只读jsp</a></h2>

	<h3>项目签约审批前公共的只读 jsp （医疗管理）</h3>
	<a href="flowMediReadZQ/zjcs_cal_read/main.jsp" target="new">商务条件只读jsp</a> <br>
	<h3>项目立项流程使用jsp（医疗管理）</h3>
		<a href="projCreateMedi/zjcs_cal_up/main.jsp" target="new">项目立项-商务条件制定</a> <br>
		<a href="projCreateMedi/paycond/paycond_list.jsp" target="new">资金计划</a> <br>
	<h3>项目签约审批前公共的编辑jsp （医疗管理）</h3>
		<a href="projCreateMedi_ZQ/zjcs_cal_up/main.jsp" target="new">商务条件</a> <br>
		<a href="projCreateMedi_ZQ/paycond/paycond_list.jsp" target="new">资金计划</a> <br>
--------------------------------------------------------------------------------------------------------
	<h3>签约审批流程使用jsp （医疗管理 ）</h3>
		<a href="contractMedi/zjcs_cal_up/main.jsp" target="new">签约审批-商务条件制定</a> <br>
		<a href="contractMedi/paycond/paycond_list.jsp" target="new">签约审批-资金计划</a> <br>
	<h3>项目签约审批后公共的只读jsp （医疗管理）</h3>
		<a href="flowMediReadZH/zjcs_cal_read/main.jsp" target="new">商务条件只读jsp</a> <br>

	<h3>项目签约审批后公共的编辑jsp （医疗管理）</h3>
		<a href="contractMedi_ZH/zjcs_cal_up/main.jsp" target="new">商务条件</a> <br>		
		<a href="contractMedi_ZH/paycond/paycond_list.jsp" target="new">资金计划</a> <br>
--------------------------------------------------------------------------------------------------------
	<h3>合同变更jsp 医疗管理）</h3>
		<a href="contractMedi_Change/zjcs_cal_up/main.jsp" target="new">合同变更-商务条件制定</a> <br>
		<a href="contractMedi_Change/zjcs_cal_read/main.jsp" target="new">合同变更-商务条件只读</a> <br>
		<a href="contractMedi_Change/paycond/paycond_list.jsp" target="new">资金计划</a> <br>
--------------------------------------------------------------------------------------------------------
	<h3>起租jsp 医疗管理）</h3>
		<a href="projMediStartRent/zjcs_cal_up/main.jsp" target="new">起租-商务条件制定</a> <br>
		<a href="projMediStartRent/zjcs_cal_read/main.jsp" target="new">起租-商务条件制定-只读</a> <br>
	
	<a href="projMediStartRent/interest_subsidy/interest_subsidy.jsp" target="new">起租-利息补贴 - 去掉</a> <br>
	<a href="projMediStartRent/caution_subsidy/interest_subsidy.jsp" target="new">起租-保证金收益 - 去掉</a> <br>

--------------------------------------------------------------------------------------------------------
	<h2><a href="projMediStartRent/zjcs_cal_up_floor_rent/main.jsp" target="new">租后-保底修改</a> <br></h2>

	<h3>或有租金修订 --  新</h3>
		<a href="huoyouzujin/huoyou/main.jsp" target="new">或有租金修订 </a> <br>
		<a href="huoyouzujin/huoyou/rent_plan.jsp" target="new">租金 </a> <br>
		<a href="huoyouzujin/huoyou/managefee_plan.jsp" target="new">管理服务费 </a> <br>
		<a href="huoyouzujin/huoyou/otherfee_plan.jsp" target="new">其他金额 </a> <br>

		<a href="huoyouzujin/huoyouread/main.jsp" target="new">或有租金修订-只读 </a> <br>
		<a href="huoyouzujin/huoyouread/rent_plan.jsp" target="new">租金-只读 </a> <br>
		<a href="huoyouzujin/huoyouread/managefee_plan.jsp" target="new">管理服务费-只读 </a> <br>
		<a href="huoyouzujin/huoyouread/otherfee_plan.jsp" target="new">其他金额 -只读</a> <br>


	<h3>或有租金修订 --  老</h3>
		<a href="huoyouzujin/huoyou_o/main.jsp" target="new">或有租金修订 </a> <br>
		<a href="huoyouzujin/huoyou_o/rent_plan.jsp" target="new">租金 </a> <br>
		<a href="huoyouzujin/huoyou_o/managefee_plan.jsp" target="new">管理服务费 </a> <br>
		<a href="huoyouzujin/huoyou_o/otherfee_plan.jsp" target="new">其他金额 </a> <br>

		<a href="huoyouzujin/huoyouread_o/main.jsp" target="new">或有租金修订-只读 </a> <br>
		<a href="huoyouzujin/huoyouread_o/rent_plan.jsp" target="new">租金-只读 </a> <br>
		<a href="huoyouzujin/huoyouread_o/managefee_plan.jsp" target="new">管理服务费-只读 </a> <br>
		<a href="huoyouzujin/huoyouread_o/otherfee_plan.jsp" target="new">其他金额 -只读</a> <br>
  </body>
</html>
