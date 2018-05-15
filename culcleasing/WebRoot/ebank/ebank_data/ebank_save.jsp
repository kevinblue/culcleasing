<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %>
<%@page import="com.tenwa.log.LogWriter"%> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);

String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String business_flag = getStr( request.getParameter("business_flag") );
int flag=0;
String message="";

if ( stype.equals("mod") ){ 
	if("无关".equals(business_flag)){
		//修改标志
		sqlstr="update fund_ebank_data set business_flag='1',modificator='"+dqczy+"',modify_date='"+curr_date+"' where ebdata_id='"+czid+"'";
		flag = db.executeUpdate(sqlstr);
		
		//日志操作
		String sqlLog = LogWriter.getSqlIntoDB(request, "网银数据导入", "修改网银", "修改网银数据，网银编号为:"+czid, sqlstr);
		db.executeUpdate(sqlLog);
	}else{
		flag = 2;
	}
	message="网银数据修改";
}
db.close();
if(flag!=0){
%>
<script type="text/javascript">
	window.close();
	opener.alert("<%=message%>成功!");
	opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("<%=message%>失败!");
	opener.location.reload();
</script>
<%}%>
</body>
</html>
