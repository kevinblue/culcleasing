<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<jsp:useBean id="sms" scope="page" class="com.service.SMSThread" /> 
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("sms-smstest-send",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------
String searchKey = getStr(request.getParameter("searchKey"));
String searchType = getStr(request.getParameter("searchType"));
String searchDel = getStr(request.getParameter("searchDel"));
String searchPhone = getStr(request.getParameter("searchPhone"));
String searchAddTime = getStr(request.getParameter("searchAddTime"));
String searchActualTime = getStr(request.getParameter("searchActualTime"));
String searchPerformTime = getStr(request.getParameter("searchPerformTime"));
String searchAddTimeBegin = getStr(request.getParameter("searchAddTimeBegin"));
String searchActualTimeBegin = getStr(request.getParameter("searchActualTimeBegin"));
String searchPerformTimeBegin = getStr(request.getParameter("searchPerformTimeBegin"));
String searchAddTimeEnd = getStr(request.getParameter("searchAddTimeEnd"));
String searchActualTimeEnd = getStr(request.getParameter("searchActualTimeEnd"));
String searchPerformTimeEnd = getStr(request.getParameter("searchPerformTimeEnd"));
sms.setSearchKey(searchKey);
sms.setSearchType(searchType);
sms.setSearchDel(searchDel);
sms.setSearchPhone(searchPhone);
sms.setSearchAddTime(searchAddTime);
sms.setSearchActualTime(searchActualTime);
sms.setSearchPerformTime(searchPerformTime);
sms.setSearchAddTimeBegin(searchAddTimeBegin);
sms.setSearchActualTimeBegin(searchActualTimeBegin);
sms.setSearchPerformTimeBegin(searchPerformTimeBegin);
sms.setSearchAddTimeEnd(searchAddTimeEnd);
sms.setSearchActualTimeEnd(searchActualTimeEnd);
sms.setSearchPerformTimeEnd(searchPerformTimeEnd);
String count = sms.getCount();
double dcount = 0;
if(count!=null&&!count.equals("")){
	dcount = Double.parseDouble(count);
}


   sms.start();
   session.setAttribute("thread",sms);
    %>
<script>
			alert("请予<%=formatNumberDoubleZero((((dcount/2)+1)/60)+1)%>分钟后刷新页面，察看发送情况");
			window.location.href = "sms_list.jsp";
</script>
