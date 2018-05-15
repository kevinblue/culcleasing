<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.ebank.RentHire"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

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
RentHire rentHire = new RentHire();
//核销
flag = rentHire.hireRent( glide_id, up_id, "rent_Ebank_hire", dqczy);

//日志操作
String sqlLog = LogWriter.getSqlIntoDB(request, "租金投放管理", "网银租金收款", dqczy+"进行网银租金收款", 
		"无Sql， 收款单："+glide_id+"——网银上传编号："+up_id+" 核销结果："+flag+" 1表示全部核销完，2表示部分核销，3表示核销失败");
db.executeUpdate(sqlLog);

if(flag==1){// 全部核销
%>
<script>
	window.close();
	opener.alert("收款单：<%=glide_id %>租金已全部核销完成!");
	opener.location.reload();	
</script>
<%
}else if(flag==2){// 部分核销
%>
<script>
	window.close();
	opener.alert("收款单：<%=glide_id %>租金完成部分核销！");
	opener.location.reload();
</script>
<%}else if(flag==-1){// 核销失败
%>
<script>
	window.close();
	opener.alert("收款单：<%=glide_id %>租金核销失败，未有匹配网银数据!");
	opener.location.reload();
</script>
<%
}%>
</body></html>
<%if(null != db){db.close();}%>