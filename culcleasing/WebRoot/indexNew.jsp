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

  <a href="monitor/optionMonitorS/opinion_list.jsp" target="new">���˴���ʵ���</a> <br><br>

  <a href="projStartRent/currconfirm_subsidy/currconfirm_subsidy.jsp" target="new">����-���ڷִ�ȷ��</a> <br>
  <a href="projStartRent/interest_subsidy/interest_subsidy.jsp" target="new">����-��Ϣ����ȷ��</a> <br>

  <a href="projStartRent/caution_upd/fund_update.jsp" target="new">����-�޸ı�֤��ƻ�����</a> <br>
  <br><br>

  <a href="projCreate/paycond_cw/paycond_list.jsp" target="new">�������-�޸ļƻ�����</a> <br>
  <a href="projCreate/paycond_sw/paycond_list.jsp" target="new">��������-�޸ĸ���ǰ��</a> <br>

  <a href="flowEditZQ/paycond_cw/paycond_list.jsp" target="new">��ĿǩԼ����ǰ����-�޸ļƻ�����</a> <br>
  <a href="flowEditZQ/paycond_sw/paycond_list.jsp" target="new">��ĿǩԼ����ǰ����-�޸ĸ���ǰ��</a> <br>

  <a href="contractApprove/paycond_cw/paycond_list.jsp" target="new">��ĿǩԼ��������-�޸ļƻ�����</a> <br>
  <a href="contractApprove/paycond_sw/paycond_list.jsp" target="new">��ĿǩԼ��������-�޸ĸ���ǰ��</a> <br>

  <a href="flowEditZH/paycond_cw/paycond_list.jsp" target="new">��ĿǩԼ���������-�޸ļƻ�����</a> <br>
  <a href="flowEditZH/paycond_sw/paycond_list.jsp" target="new">��ĿǩԼ����������-�޸ĸ���ǰ��</a> <br>
<br>

  <br><br>
  <a href="flowJsp/exec_fund_upd/fund_exec_list.jsp" target="new">����-�����޸��ʽ�ƻ�</a> <br>
  
	<hr> ���������������� </hr> <br> <br>
 <a href="flowZXPGJsp/zjcs_cal_up_read/main.jsp" target="new">��������-ֻ��</a> <br>
 <a href="flowZXPGJsp/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ�-ֻ��</a> <br>
 <a href="flowZXPGJsp/proj_mater_read/proj_mater_list.jsp" target="new">��Ŀ����-ֻ��</a> <br>
   
	<hr> ҽ�ƹ��������������� </hr> <br> <br>
 <a href="flowZXPGMediJsp/zjcs_cal_read/main.jsp" target="new">��������-ֻ��</a> <br>
 <a href="flowZXPGMediJsp/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ�-ֻ��</a> <br>
 <a href="flowZXPGMediJsp/proj_mater_read/proj_mater_list.jsp" target="new">��Ŀ����-ֻ��</a> <br>
   

<hr><h2>����ģ��</h2></hr>
 <a href="financing/flowStart/financing_sxbg.jsp" target="new">���ű��-���</a> <br>
 <a href="financing/flowStart/financing_rzsb.jsp" target="new">�����걨-���</a> <br>
 <a href="financing/flowStart/financing_rzsx.jsp" target="new">��������-���</a> <br>
 <a href="financing/flowStart/financing_hk.jsp" target="new">����-���</a> <br>
 <a href="financing/flowStart/financing_dq.jsp" target="new">����-���</a> <br>


<hr><h2>���Ѹ����ʽ�ƻ��ƶ�</h2></hr>
 <a href="insur/insur_fund/insur_fund_list.jsp" target="new">�����ʽ�ƻ�-�༭</a> <br>
 <a href="insur/insur_fund_read/insur_fund_list.jsp" target="new">�����ʽ�ƻ�-ֻ��</a> <br>

<hr><h2>���ʻ���ƻ����-����</h2></hr>
 <a href="financing/refund_change/refund_list.jsp" target="new">���ʻ���ƻ����-�༭</a> <br>
 <a href="financing/refund_change_read/refund_list_read.jsp" target="new">���ʻ���ƻ����-ֻ��</a> <br>

<hr><h2>���ʻ���ƻ����-������Ϣ</h2></hr>
 <a href="financing/refund_tx/refund_list.jsp" target="new">���ʻ���ƻ����-����</a> <br>


<hr><h2>������������</h2></hr>
 <a href="projStartRent/zjcs_cal_up/main.jsp" target="new">���������������ƻ��ϴ�</a> <br>


<hr><h2>���չ���</h2></hr>
 <a href="insur/insur_payapp/insur_pay_apply.jsp" target="new">��������֧������</a> <br>
 <a href="insur/insur_payapp/insur_pay_apply_search.jsp" target="new">��������֧����ѯ</a> <br>

 <a href="insur/insur_payapp/leasing_flow.jsp?czid=11111" target="new">��������֧��-����</a><br>


<hr><h2>ҽ�ƹ���</h2></hr>
<a href="flowMediCashChange/cash_change/main.jsp" target="new">Ԥ���ֽ����޶�-�༭</a> <br>
<a href="flowMediCashChange/cash_change_read/main.jsp" target="new">Ԥ���ֽ����޶�-ֻ��</a> <br>

<hr><h2>CD����</h2></hr>
<a href="flowMediCashChange/cash_change/main.jsp" target="new">Ԥ���ֽ����޶�-�༭</a> <br>

<hr><h2>�ͻ�����</h2></hr>
<a href="khxx/khfr/frkh_list.jsp" target="new">���ŷ�������</a> <br>


 </body>
</html>
