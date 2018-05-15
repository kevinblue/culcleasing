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
    
    <title>My JSP 'index.jsp' starting page</title>
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
   <a href="khxx/khfr/frkh_list.jsp" target="new">客户（法人xin）</a> <br>
   <a href="khxx/khzr/khzrxx_list.jsp" target="new">客户（自然人xin）</a> <br>
  <a href="khxx/khyj/khyj_list.jsp" target="new">客户移交xin</a> <br>
 <a href="khxx/fpgl/fk_add.jsp" target="new">发票管理xin</a> <br>
    <a href="khxx/khmpxx/khmpxx_list.jsp" target="new">客户（法人）</a> <br>
  <a href="khxx/khzrxx/khzrxx_list.jsp" target="new">客户（非法人）</a> <br>
  	<a href="jcxx/dfxx/dfxx_mod.jsp?czid=2&target_id=234" target="new">客户评分</a> <br>
  	<a href="jcxx/dfxx/dfxx_list.jsp?czid=2&target_id=234" target="new">客户得分</a> <br>
  	<a href="jcxx/pfmxlx/pfmxlx_list.jsp?czid=2&target_id=234" target="new">评分卡维护</a> <br>
    <a href="gbjg/gysgbjg/gysgbjg_list.jsp" target="new">供应商股本机构</a> <br>
    <a href="gbjg/glqyqk/glqyqk_list.jsp" target="new">供应商关联企业</a> <br>
    <a href="gbjg/khgbjg/khgbjg_list.jsp?project_id=XM00002&cust_id=1090010000" target="new">客户股本机构</a> <br>
    <a href="gbjg/khglqy/khglqy_list.jsp?project_id=XM00002&cust_id=1090010000" target="new">客户关联企业</a> <br>
    <a href="zjcs/zjcs/zjcs_frame.jsp?contract_id=RX00008" target="new">租金计划测算</a> <br>
    <a href="zjcs/zjbcxm/zjbcxm_frame.jsp?project_id=XM00002" target="new">添加项目租金计划</a> <br>
    <a href="zjcs/zjbcxm/zjbcxm_cond.jsp?project_id=XM00002" target="new">添加项目交易结构</a> <br>
    <a href="zjcs/zjbcht/zjbcht_frame.jsp?contract_id=M090059&doc_id=1234567" target="new">添加合同租金计划</a> <br>
    <a href="zjcs/zjbcht/zjbcht_cond.jsp?contract_id=M090059&doc_id=1234567" target="new">添加合同交易结构</a> <br>
    <a href="zjcs/zjzq/zjzq_frame.jsp?contract_id=M090059&doc_id=1234567" target="new">展期</a> <br>
    <a href="zjcs/tx/tx_frame.jsp?contract_id=L090095&doc_id=1234567" target="new">调息</a> <br>
    <a href="depttarget/depttarget/test.jsp?target_id=1090002001&evaluation_type=2" target="new">导出execl评分卡</a> <br>
    <a href="pzxz/pzxz/pzxz_list.jsp" target="new">凭证列表</a> <br>
    <a href="servlet/DownloadServlet" target="new">导出文本Servlet</a> <br>
    <a href="zjcsbg/zjcsbg/zjcsbg_frame.jsp" target="new">租金计划测算变更</a> <br>
    <a href="zjcsbg/zjcsbgxm/zjcsbgxm_deal.jsp?proj_id=XM0020&doc_id=2345678&readonly=1" target="new">租金计划测算变更项目交易结构</a> <br>
    <a href="zjcsbg/zjcsbgxm/zjcsbgxm_frame.jsp?proj_id=XM00201&doc_id=2345678&readonly=1" target="new">租金计划测算变更项目</a> <br>
    <a href="zjcsbg/zjcsbght/zjcsbght_frame.jsp?contract_id=H0900201&doc_id=3456789sda&proj_id=XM0020&readonly=1" target="new">租金计划测算变更合同</a> <br>
	<a href="zjcsbg/zjcsbgqz/zjcsbgqz_frame.jsp?contract_id=H0900201&doc_id=3456789sda&proj_id=XM0020&readonly=1" target="new">租金计划测算变更起租</a> <br>
    <a href="zjcsbg/zjcsbght/zjcsbght_deal.jsp?contract_id=H090020&doc_id=3456789sda&proj_id=XM0020&readonly=1" target="new">租金计划测算变更交易结构</a> <br>
    <a href="zjcsbg/zq/zq_frame.jsp?contract_id=L09A4007004&doc_id=5FA4704417B60C47482575D00027810B23&volume=10000&readonly=1" target="new">租金计划测算变更展期</a> <br>
    <a href="zjcsbg/tx/tx_frame.jsp?contract_id=L090095&doc_id=34567890" target="new">租金计划测算变更调息</a> <br>
    <a href="wyhx/wyhx/wyhx_loadlist.jsp" target="new">网银核销数据</a> <br>
    <a href="htxx/export/condition.jsp?contract_id=L09A4007004&doc_id=5FA4704417B60C47482575D00027810B23" target="new">回笼计划下载</a> <br>
     <%String userSno = request.getParameter("userSno");
    	session.setAttribute("czyid","ADMN-84XDH3");
     %>
  }
  </body>
</html>
