<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %>
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

int flag=0;
String sqlstr="";
ResultSet rs = null;

//进入新增之后，插入申请单
String systemDate = getSystemDate(0);
String glide_id="";
sqlstr="select isnull(max(cast(no as int)),1)+1 as glide_id from GENERATE_NO where generate_type='增值税发票领取'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	glide_id=getDBStr( rs.getString("glide_id") );
}rs.close();
sqlstr="insert into generate_no select '增值税发票领取','"+systemDate+"','"+glide_id+"'";
db.executeUpdate(sqlstr);
glide_id = "FP"+systemDate+"-"+glide_id;
	
//插入申请信息 
sqlstr="insert into invoice_draw_info (glide_id,type,is_sub,flow_status,status,amt,amount_t,plan_date,creator,create_date) ";
sqlstr+="values(";
sqlstr+="'"+glide_id+"','增值税发票领取','未提交','未通过','未领取','0','0','"+systemDate+"',";
sqlstr+="'"+dqczy+"','"+systemDate+"') ";
LogWriter.logDebug(request, "增值税发票领取："+sqlstr);
//执行语句
flag = db.executeUpdate(sqlstr);

if(flag!=0){
%>
<script>
	window.close();
	opener.alert("增值税发票领取新增成功，请选择申请单[<%=glide_id %>]维护，选择资金、罚息、利息!");
	opener.location.reload();
</script>
<%
}else{
%>
<script>
	window.close();
	opener.alert("增值税发票领取新增失败!");
	opener.location.reload();
</script>
<%}
db.close();%>
</body>
</html>