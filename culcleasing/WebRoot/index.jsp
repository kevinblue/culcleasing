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

<%
String s = "";

if(s=="20"){

}
%>
	<h1><a href="index_newAdd.jsp">2012-9-10���������޸�</a></h1>
	<hr color="yellow" size="5">
	<h1><a href="indexNew.jsp">2012-3-17���Ժ���������</a></h1>

<%-- 
<h1><%=request.getRequestURL() %></h1><br>
<% String url = request.getScheme()+"://"+ request.getServerName()+request.getRequestURI()+"?"+request.getQueryString(); %>
<h1><%=url  %></h1>
--%>


  <a href="report/financTC/cwtc_report_static.jsp" target="new">����ͷ�籨��</a> <br>
  <a href="report/T601financing/zjqxjg_report_static.jsp" target="new">����ͷ�籨��</a> <br>


	<h1><a href="indexReport.jsp">�����漰JSP</a></h1>

	<h1><a href="indexMedi.jsp">ҽ�ƹ����漰JSP</a></h1>
	
	<h2><a href="http://was.eleasing.com.cn:9080/report?uuid=ADMN-8GRBW4&relations=ADMN-8GRBW4,ADMN-8GT5CW,ADMN-8HQDRQ,ADMN-8HQDRX,ADMN-8HQDSH" target="_blank">������ʽ�����½</a></h2>
	<h2><a href="http://was.eleasing.com.cn:9080/report/" target="_blank">������ʽ����</a></h2>


	<h2><a href="http://192.168.100.78:9080/report/login.jsp?uuid=ADMN-7H7CV7&userid=Admin/CULC&username=&relations=ADMN-7HMC38,,ADMN-7QF8RV,ADMN-7H86CJ,ADMN-7H94TP,ADMN-7H7CV7" target="_blank">��������ʽ�����½</a></h2>
	<h2><a href="http://192.168.100.78:9080/report/" target="_blank">��������ʽ����</a></h2>


	<h2><a href="http://192.168.112.153:9080/report/login.jsp?uuid=ADMN-7H7CV7&userid=Admin/CULC&username=&relations=ADMN-7H995M,ADMN-7HJ8TP,ADMN-7H86CJ,ADMN-7H94TP,ADMN-7QF8RV,ADMN-7H7CV7" target="_blank">�����ϲ��Ա����½</a></h2>
	<h2><a href="http://192.168.112.153:9080/report/" target="_blank">�����ϲ��Ա���</a></h2>

  <a href="youlian/iulc/handling_charge_add.jsp" target="new">YLyao</a> <br>

   <a href="ywjcxx/basetrade/basetrade_list.jsp" target="new">�ڲ���ҵ</a> <br>
   <a href="zjcs/zjcs/main.jsp" target="new">������</a> <br>
	<a href="zjcs/zjcs2/main.jsp" target="new">������2</a> <br>
	<a href="zjcs/zjcs_cal/main.jsp" target="new">������3</a> <br>
<a href="zjcs/zjcs_cal_up/main.jsp" target="new">������4</a> <br>
	<a href="zjcs/zjcs_cal_read/main.jsp" target="new">������ֻ��</a> <br>
	<a href="cond/paycond/paycond_list_html.jsp" target="new">�ʽ�ƻ�html</a> <br>
	<a href="cond/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�jsp</a> <br>
	<a href="cond/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ�ֻ��jsp</a> <br>
	<a href="proj/proj_mater/proj_mater_list.jsp" target="new">��Ŀ����jsp</a> <br>	
	<a href="proj/proj_mater_read/proj_mater_list.jsp" target="new">��Ŀ����ֻ��jsp</a> <br>
	
	<a href="projStartRent/interest_subsidy/main.jsp" target="new"><h2>��Ϣ����</h2></a> <br>
<h3>���ʹ���</h3>	
<a href="financing/financing_refund_make/refund_list.jsp" target="new">����ƻ��ƶ�jsp</a> <br>
<a href="monitor/opinionMonitorRead/opinion_detail.jsp?proj_id=" target="new">������_ֻ��jsp</a> <br>


<h3>������</h3>	
<a href="monitor/opinionMonitor/opinion_detail.jsp?proj_id=" target="new">������jsp</a> <br>
<a href="monitor/opinionMonitorRead/opinion_detail.jsp?proj_id=" target="new">������_ֻ��jsp</a> <br>

<hr color="red" size="5">
<h2>��ĿǩԼ����ǰ������ֻ��jsp</h2>
<a href="flowReadZQ/proj_mater_read/proj_mater_list.jsp" target="new">��Ŀ����ֻ��jsp</a><br>
<a href="flowReadZQ/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ�ֻ��jsp</a> <br>
<a href="flowReadZQ/zjcs_cal_read/main.jsp" target="new">��������ֻ��jsp</a> <br>

<h2>��ĿǩԼ����ǰ�����ı༭jsp</h2>
<a href="flowEditZQ/proj_mater/proj_mater_list.jsp" target="new">��Ŀ����jsp</a><br>
<a href="flowEditZQ/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�jsp</a> <br>
<a href="flowEditZQ/zjcs_cal_up/main.jsp" target="new">��������jsp</a> <br>
<a href="flowEditZQ/zjcs_cal_up_cw/main.jsp" target="new">��������-����jsp</a> <br>

<h2>��Ŀ����CRM+ERP����ʹ��JSP</h2>
<a href="projCreate/zjcs_cal_up/main.jsp" target="new">��Ŀ����Erp-���������ƶ�</a> <br>
<a href="projCreate/zjcs_cal_up_cw/main.jsp" target="new">��Ŀ�������Erp-���������ƶ�</a> <br>
<a href="projCreate/zjcs_cal_up_cs/main.jsp" target="new">��Ŀ�������Erp-���������ƶ�</a> <br>
<a href="projCreate/proj_mater/proj_mater_list.jsp" target="new">��Ŀ����jsp</a> <br>	
<a href="projCreate/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�jsp</a> <br>
<a href="projCreate/paycond_cs/paycond_list.jsp" target="new">�ʽ�ƻ�_����jsp</a> <br>

<!-- 
<h2>��Ŀ����ERP����ʹ��JSP</h2>
<a href="projCreateERP/zjcs_cal_up/main.jsp" target="new">��Ŀ����Erp-���������ƶ�</a> <br>
<a href="projCreateERP/proj_mater/proj_mater_list.jsp" target="new">��Ŀ����jsp</a> <br>	
<a href="projCreateERP/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�jsp</a> <br>
-->

<hr color="red" size="5">
<h2 style="color: red;">ǩԼ��������ʹ��JSP</h2>
<a href="contractApprove/zjcs_cal_up/main.jsp" target="new">ǩԼ����-���������ƶ�</a> <br>
<a href="contractApprove/zjcs_cal_up_cw/main.jsp" target="new">ǩԼ����-���������ƶ�-����</a> <br>
<a href="contractApprove/paycond/paycond_list.jsp" target="new">ǩԼ����-�ʽ�ƻ�js</a> <br>
<a href="contractApprove/contract_mater/contract_mater_list.jsp" target="new">ǩԼ����-��Ŀ����jsp</a> <br>

<h2>��ĿǩԼ�����󹫹���ֻ��jsp</h2>
<a href="flowReadZH/contract_mater_read/contract_mater_list.jsp" target="new">��Ŀ����ֻ��jsp</a><br>
<a href="flowReadZH/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ�ֻ��jsp</a> <br>
<a href="flowReadZH/zjcs_cal_read/main.jsp" target="new">��������ֻ��jsp</a> <br>

<h2>��ĿǩԼ�����󹫹��ı༭jsp</h2>
<a href="flowEditZH/contract_mater/contract_mater_list.jsp" target="new">��Ŀ����jsp</a><br>
<a href="flowEditZH/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�jsp</a> <br>
<a href="flowEditZH/zjcs_cal_up/main.jsp" target="new">��������jsp</a> <br>
<a href="flowEditZH/zjcs_cal_up_cw/main.jsp" target="new">��������-����jsp</a> <br>

<hr color="red" size="5">

<h1>��������</h1>
<a href="projStartRent/begininfo_his/begininfo_list.jsp" target="new">��������-��ʷ������Ϣjsp</a> <br>

<a href="projStartRent/zjcs_cal_up/main.jsp" target="new">��������-��������jsp</a> <br>
<a href="projStartRent/zjcs_cal_up_cw/main.jsp" target="new">��������-��������-����jsp</a> <br>
<a href="projStartRent/zjcs_cal_read/main.jsp" target="new">��������-��������ֻ��jsp</a> <br>
<a href="projStartRent/zjcs_cal_up_one/main.jsp" target="new">��������-����������ֻ��jsp</a> <br>


<hr color="red" size="5">
<h2>CD��������ʹ��JSP</h2>
<a href="CDConnectFlow/proj_mater/proj_mater_list.jsp" target="new">CD����-��Ŀ���Ͻ���</a> <br>
<a href="CDConnectFlow/proj_mater_read/proj_mater_list.jsp" target="new">CD����-��Ŀ���Ͻ��ӣ�ֻ����</a> <br>

<h2>����CD��������ʹ��JSP</h2>
<a href="ECCDConnectFlow/proj_mater/proj_mater_list.jsp" target="new">����CD����-��Ŀ���Ͻ���</a> <br>
<a href="ECCDConnectFlow/proj_mater_read/proj_mater_list.jsp" target="new">����CD����-��Ŀ���Ͻ��ӣ�ֻ����</a> <br>

<h2>�ʽ�ƻ��ϱ�����ʹ��JSP</h2>
<a href="fundPlanUpdDate/paycond/paycond_list.jsp" target="new">�ʽ�ƻ��ϱ�-�ʽ�ƻ������޸�</a> <br>
<a href="fundPlanUpdDate/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ��ϱ�-�ʽ�ƻ������޸ģ�ֻ����</a> <br>

<h2>���񷽰��޶�����ʹ��JSP</h2>
<a href="fundPlanUpd/paycond/paycond_list.jsp" target="new">���񷽰��޶�-�ʽ��޸�</a> <br>
<a href="fundPlanUpd/paycond_read/paycond_list.jsp" target="new">���񷽰��޶�-�ʽ��޸ģ�ֻ����</a> <br>

<h2>����ʹ�ù���һ��Jsp</h2>
<a href="flowJsp/fundFundCharge/paycond_list.jsp" target="new">��ǰ��ͬ�ʽ�ƻ�һ��</a> <br>
<a href="flowJsp/fundFundCharge/paycondkx_list.jsp" target="new">��ǰ��ͬ�ʽ�ƻ�һ��(�޸���ǰ��)</a> <br>
<a href="flowJsp/fundFundCharge/paycondsk_list.jsp" target="new">��ǰ��ͬ�ʽ� �տ�һ��</a> <br>
<a href="flowJsp/fundFundCharge/paycondfk_list.jsp" target="new">��ǰ��ͬ�ʽ� ����һ��</a> <br>
<a href="flowJsp/fundFundCharge/paycondfkqt_list.jsp" target="new">��ǰ��ͬ�ʽ� ����ǰ��һ��</a> <br>
<br>

<h2>��ͬ���jsp- ��</h2>
<a href="contractChange/zjcs_cal_up/main.jsp" target="new">��ͬ���-���������ƶ�</a> <br>
<a href="contractChange/zjcs_cal_up_cw/main.jsp" target="new">��ͬ���-���� ���������ƶ�</a> <br>
<a href="contractChange/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�</a> <br>
<a href="contractChange/contract_mater/contract_mater_list.jsp" target="new">��Ŀ����</a> <br>
<br>

<h2>��ͬ���jsp- ��</h2>
<a href="flowContractChange/zjcs_cal_up/main.jsp" target="new">��ͬ���-���������ƶ�</a> <br>
<a href="flowContractChange/zjcs_cal_up_cw/main.jsp" target="new">��ͬ���-���� ���������ƶ�</a> <br>

<a href="flowContractChange/zjcs_cal_read/main.jsp" target="new">��ͬ���-ֻ��</a> <br>
<a href="flowContractChange/paycond/paycond_list.jsp" target="new">�ʽ�ƻ�</a> <br>
<a href="flowContractChange/paycond_read/paycond_list.jsp" target="new">�ʽ�ƻ�-ֻ��</a> <br>

<a href="flowContractChange/contract_mater/contract_mater_list.jsp" target="new">��Ŀ����</a> <br>
<a href="flowContractChange/contract_mater_read/contract_mater_list.jsp" target="new">��Ŀ����-ֻ��</a> <br>

<br>

<h2>���������ʹ��JSP</h2>
<a href="flowRentChange/zjcs_cal_up/main.jsp" target="new">�����������</a>  <br>
<a href="flowRentChange/zjcs_cal_read/main.jsp" target="new">�����������-ֻ��</a> <br>
<a href="flowRentChange/rent_change/main.jsp" target="new">���ƻ����</a>	<br>
<br>

<h2>��ǰϢȷ������JSP</h2>
<a href="flowRRBConfirm/rrb_confirm/main.jsp" target="new">����������Ϣ</a>  <br>
<a href="flowRRBConfirm/rrb_confirm_read/main.jsp" target="new">����������Ϣ-ֻ��</a>  <br>
<br>

<h2>�����㹤��</h2>
<a href="projTool/zjcs_cal_up/main.jsp" target="new">���߲���</a>  <br>
<br>

<h2>����</h2>
<a href="invoice/rent_invoice/rent_invoice_manage.jsp" target="new">���Ʊ����</a>  <br>
<a href="usersynchronism/synchronism/synchronism_list.jsp" target="new">crm-erpͬ��  </a>  <br>
<a href="newcity/xiu/gjxx_list.jsp" target="new">�޸Ĵ��� </a>  <br>

<br>


<h2 style="color: red;">
��������
</h2>
<a href="http://was.culc.com:9080/report/login.jsp?uuid=ADMN-8GRBW4&userid=Admin/UILC&username=Admin&relations=ADMN-8GRBW4,ADMN-8GT5CW,ADMN-8HQDRQ,ADMN-8HQDRX,ADMN-8HQDSH" target="new">�����½</a> <br>
<a href="http://was.culc.com:9080/report/" target="new">������ҳ</a> <br>
<a href="reportShow/contract/contract_data_list.jsp" target="new">��ͬ��Ϣ һ��</a> <br>
<a href="projCreate/zjcs_cal_up/test.jsp" target="new">����</a> <br>
<a href="report/T601financing/zjqxjg_report_static.jsp" target="new">����T601</a> <br>


<h2>��Ŀ�����ձ�</h2>
<a href="diary_log/diarylog.jsp" target="new">��Ŀ�����ձ� </a>  <br>
<a href="diary_log/showlist/main.jsp" target="new">��Ŀ�����ձ���ϸ </a>  <br>
<a href="diary_log/showlist/main.jsp" target="new">������Ŀ�����ձ���ϸ</a>  <br>
<br>



<br>
<h2 style="color: red;">
<a href="http://192.168.109.146:9080/tenwaleasing/zjxx/txcl/tx_list.jsp?czid=ADMN-7H7CV7" target="new">�����ϲ���ϵͳ-��Ϣ����</a> <br>
</h2>
<h2 style="color: red;">
<a href="zjcs/tx/tx_showMainList.jsp?czid=ADMN-7H7CV7" target="new">�����²���ϵͳ-��Ϣ����</a> <br>
</h2>

  <!-- 
    <a href="khxx/khfr/frkh_list.jsp" target="new">�ͻ�������xin��</a> <br>
    <a href="khxx/khmpxx/khmpxx_list.jsp" target="new">�ͻ������ˣ�</a> <br>
    <a href="khxx/khzrxx/khzrxx_list.jsp" target="new">�ͻ����Ƿ��ˣ�</a> <br>
  	<a href="jcxx/dfxx/dfxx_mod.jsp?czid=2&target_id=234" target="new">�ͻ�����</a> <br>
  	<a href="jcxx/dfxx/dfxx_list.jsp?czid=2&target_id=234" target="new">�ͻ��÷�</a> <br>
  	<a href="jcxx/pfmxlx/pfmxlx_list.jsp?czid=2&target_id=234" target="new">���ֿ�ά��</a> <br>
    <a href="gbjg/gysgbjg/gysgbjg_list.jsp" target="new">��Ӧ�̹ɱ�����</a> <br>
    <a href="gbjg/glqyqk/glqyqk_list.jsp" target="new">��Ӧ�̹�����ҵ</a> <br>
    <a href="gbjg/khgbjg/khgbjg_list.jsp?project_id=XM00002&cust_id=1090010000" target="new">�ͻ��ɱ�����</a> <br>
    <a href="gbjg/khglqy/khglqy_list.jsp?project_id=XM00002&cust_id=1090010000" target="new">�ͻ�������ҵ</a> <br>
    <a href="zjcs/zjcs/zjcs_frame.jsp?contract_id=RX00008" target="new">���ƻ�����</a> <br>
    <a href="zjcs/zjbcxm/zjbcxm_frame.jsp?project_id=XM00002" target="new">�����Ŀ���ƻ�</a> <br>
    <a href="zjcs/zjbcxm/zjbcxm_cond.jsp?project_id=XM00002" target="new">�����Ŀ���׽ṹ</a> <br>
    <a href="zjcs/zjbcht/zjbcht_frame.jsp?contract_id=M090059&doc_id=1234567" target="new">��Ӻ�ͬ���ƻ�</a> <br>
    <a href="zjcs/zjbcht/zjbcht_cond.jsp?contract_id=M090059&doc_id=1234567" target="new">��Ӻ�ͬ���׽ṹ</a> <br>
    <a href="zjcs/zjzq/zjzq_frame.jsp?contract_id=M090059&doc_id=1234567" target="new">չ��</a> <br>
    <a href="zjcs/tx/tx_frame.jsp?contract_id=L090095&doc_id=1234567" target="new">��Ϣ</a> <br>
    <a href="depttarget/depttarget/test.jsp?target_id=1090002001&evaluation_type=2" target="new">����execl���ֿ�</a> <br>
    <a href="pzxz/pzxz/pzxz_list.jsp" target="new">ƾ֤�б�</a> <br>
    <a href="servlet/DownloadServlet" target="new">�����ı�Servlet</a> <br>
    <a href="zjcsbg/zjcsbg/zjcsbg_frame.jsp" target="new">���ƻ�������</a> <br>
    <a href="zjcsbg/zjcsbgxm/zjcsbgxm_deal.jsp?proj_id=XM0020&doc_id=2345678&readonly=1" target="new">���ƻ���������Ŀ���׽ṹ</a> <br>
    <a href="zjcsbg/zjcsbgxm/zjcsbgxm_frame.jsp?proj_id=XM00201&doc_id=2345678&readonly=1" target="new">���ƻ���������Ŀ</a> <br>
    <a href="zjcsbg/zjcsbght/zjcsbght_frame.jsp?contract_id=H0900201&doc_id=3456789sda&proj_id=XM0020&readonly=1" target="new">���ƻ���������ͬ</a> <br>
	<a href="zjcsbg/zjcsbgqz/zjcsbgqz_frame.jsp?contract_id=H0900201&doc_id=3456789sda&proj_id=XM0020&readonly=1" target="new">���ƻ�����������</a> <br>
    <a href="zjcsbg/zjcsbght/zjcsbght_deal.jsp?contract_id=H090020&doc_id=3456789sda&proj_id=XM0020&readonly=1" target="new">���ƻ����������׽ṹ</a> <br>
    <a href="zjcsbg/zq/zq_frame.jsp?contract_id=L09A4007004&doc_id=5FA4704417B60C47482575D00027810B23&volume=10000&readonly=1" target="new">���ƻ�������չ��</a> <br>
    <a href="zjcsbg/tx/tx_frame.jsp?contract_id=L090095&doc_id=34567890" target="new">���ƻ���������Ϣ</a> <br>
    <a href="wyhx/wyhx/wyhx_loadlist.jsp" target="new">������������</a> <br>
    <a href="htxx/export/condition.jsp?contract_id=L09A4007004&doc_id=5FA4704417B60C47482575D00027810B23" target="new">�����ƻ�����</a> <br>
	  -->
    <%String userSno = request.getParameter("userSno");
    	session.setAttribute("czyid",userSno);
     %>
     <!-- 
     <table>
     <thead>
     	<tr><td>����</ttdh></tr>
     </thead>
     
     <tbody>
     	<tr><td>��˹��˽��п��ǵ�</td></tr>
     </tbody>
     
     <tfoot>
     <tr><td>ͳ��</td></tr>
     </tfoot>
     </table>
      -->
  </body>
</html>
