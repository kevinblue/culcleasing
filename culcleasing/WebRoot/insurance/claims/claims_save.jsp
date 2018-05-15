<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String equip_sn = getStr( request.getParameter("equip_sn") );
String contract_id = getStr( request.getParameter("contract_id") );
String claims_date = getStr( request.getParameter("claims_date") );
String claims_name = getStr( request.getParameter("claims_name") );
String claims_money = getStr( request.getParameter("claims_money") );
String repair_delaydate = getStr( request.getParameter("repair_delaydate") );
String repair_delaymoney = getStr( request.getParameter("repair_delaymoney") );
String financing_delaydate = getStr( request.getParameter("financing_delaydate") );
String financing_delaymoney = getStr( request.getParameter("financing_delaymoney") );



String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from insurance_claims where contract_id = '"+contract_id+"'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
message = "同一合同不可重复添加";
if ( rs.next() == false) {
	sqlstr="insert into insurance_claims (contract_id,equip_sn,claims_date,claims_name,claims_money,repair_delaydate,repair_delaymoney,financing_delaydate,financing_delaymoney) values('"+contract_id+"','"+equip_sn+"','"+claims_date+"','"+claims_name+"','"+claims_money+"','"+repair_delaydate+"','"+repair_delaymoney+"','"+financing_delaydate+"','"+financing_delaymoney+"')";
    flag = db.executeUpdate(sqlstr);
    message="添加理赔信息";
}
}
if ( stype.equals("mod") ){ 
sqlstr="update insurance_claims set equip_sn='"+equip_sn+"',claims_date='"+claims_date+"',claims_name='"+claims_name+"',claims_money='"+claims_money+"',repair_delaydate='"+repair_delaydate+"',repair_delaymoney='"+repair_delaymoney+"',financing_delaydate='"+financing_delaydate+"',financing_delaymoney='"+financing_delaymoney+"' where claims_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改赔款信息";
}
if ( stype.equals("del") ){ 
sqlstr="delete from  insurance_claims where claims_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="删除赔款信息";
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
<%}
		db.close();%>