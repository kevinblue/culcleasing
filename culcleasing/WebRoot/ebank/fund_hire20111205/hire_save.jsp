<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.ebank.FundHire"%>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人

//获取参数
String glide_id = getStr( request.getParameter("glideId") );
String up_id = getStr( request.getParameter("priId") );
	
int flag=0;

FundHire fundHire = new FundHire();
//核销
flag = fundHire.hireFund( glide_id, up_id, "fund_Ebank_hire", dqczy);

if(flag==1){// 全部核销
%>
<script>
	window.close();
	opener.alert("收款单：<%=glide_id %>资金已全部核销完成!");
	opener.location.reload();	
</script>
<%
}else if(flag==2){// 部分核销
%>
<script>
	window.close();
	opener.alert("收款单：<%=glide_id %>资金部分核销，未核销成功数据在明细查询!");
	opener.location.reload();
</script>
<%}else if(flag==-1){// 核销失败
%>
<script>
	window.close();
	opener.alert("收款单：<%=glide_id %>资金核销失败，未有匹配网银数据!");
	opener.location.reload();
</script>
<%
}%>
</body></html>
