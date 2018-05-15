<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
String systemDate = getSystemDate(0);

String sqlstr="";
int flag=0;
String message="";

String stype =  getStr( request.getParameter("savetype") );
//添加到真实的交易结构表
if ( stype.equals("bh") ){  //驳回时
	//得到收款单号的集合
	String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );
	sqlstr=" update apply_info set status='已驳回',is_sub='未提交' where glide_id in ("+sql_bh_ids+") ";
	flag=db.executeUpdate(sqlstr);
	message="驳回网银资金收款";
}
if(flag!=0){
%>
<script>
	window.close();
	opener.alert("<%=message%>成功!");
	opener.location.reload();	
</script>
<%
}else{
%>
<script>
	window.close();
	opener.alert("<%=message%>失败!");
	opener.location.reload();
</script>
<%}db.close();%>
</body></html>
