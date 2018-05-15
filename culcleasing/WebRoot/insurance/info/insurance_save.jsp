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

String contract_id = getStr( request.getParameter("contract_id") );
String equip_sn = getStr( request.getParameter("equip_sn") );
String insurance_date = getStr( request.getParameter("insurance_date") );
String insurance_enddate = getStr( request.getParameter("insurance_enddate") );
String insurance_no = getStr( request.getParameter("insurance_no") );
String give_insurance = getStr( request.getParameter("give_insurance") );
String insurance_type = getStr( request.getParameter("insurance_type") );
String get_date = getStr( request.getParameter("get_date") );
String pay_date = getStr( request.getParameter("pay_date") );
String pay_no = getStr( request.getParameter("pay_no") );
String is_special = getStr( request.getParameter("is_special") );
String check_info = getStr( request.getParameter("check_info") );
String claims_note = getStr( request.getParameter("claims_note") );
String finallyclaims_money = getStr( request.getParameter("finallyclaims_money") );
String surrender_note = getStr( request.getParameter("surrender_note") );
String surrender_object = getStr( request.getParameter("surrender_object") );
String surrender_money = getStr( request.getParameter("surrender_money") );
String note = getStr( request.getParameter("note") );
String insurance_account = getStr( request.getParameter("insurance_account") );

String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from insurance_info where contract_id = '"+contract_id+"'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
message = "同一合同不可重复添加";
if ( rs.next() == false) {
	sqlstr="insert into insurance_info (contract_id,equip_sn,insurance_date,insurance_enddate,insurance_no,give_insurance,get_date,pay_date,pay_no,is_special,check_info,claims_note,finallyclaims_money,surrender_note,surrender_object,surrender_money,note,insurance_account) values('"+contract_id+"','"+equip_sn+"','"+insurance_date+"','"+insurance_enddate+"','"+insurance_no+"','"+give_insurance+"','"+get_date+"','"+pay_date+"','"+pay_no+"','"+is_special+"','"+check_info+"','"+claims_note+"','"+finallyclaims_money+"','"+surrender_note+"','"+surrender_object+"','"+surrender_money+"','"+note+"','"+insurance_account+"')";
    System.out.println("sqlstr======================"+sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="添加保险清单信息";
}
}
if ( stype.equals("mod") ){ 
sqlstr = "select * from insurance_info where contract_id = '"+contract_id+"'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
if ( rs.next()) {
	sqlstr="update insurance_info set equip_sn='"+equip_sn+"',insurance_date='"+insurance_date+"',insurance_enddate='"+insurance_enddate+"',insurance_no='"+insurance_no+"',give_insurance='"+give_insurance+"',get_date='"+get_date+"',pay_date='"+pay_date+"',pay_no='"+pay_no+"',is_special='"+is_special+"',check_info='"+check_info+"',claims_note='"+claims_note+"',finallyclaims_money='"+finallyclaims_money+"',surrender_note='"+surrender_note+"',surrender_object='"+surrender_object+"',surrender_money='"+surrender_money+"',note='"+note+"',insurance_account='"+insurance_account+"' where contract_id = '"+czid+"'";
    System.out.println("sqlstr======================"+sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="修改保险清单信息";
}else{
		sqlstr="insert into insurance_info (contract_id,equip_sn,insurance_date,insurance_enddate,insurance_no,give_insurance,get_date,pay_date,pay_no,is_special,check_info,claims_note,finallyclaims_money,surrender_note,surrender_object,surrender_money,note,insurance_account) values('"+contract_id+"','"+equip_sn+"','"+insurance_date+"','"+insurance_enddate+"','"+insurance_no+"','"+give_insurance+"','"+get_date+"','"+pay_date+"','"+pay_no+"','"+is_special+"','"+check_info+"','"+claims_note+"','"+finallyclaims_money+"','"+surrender_note+"','"+surrender_object+"','"+surrender_money+"','"+note+"','"+insurance_account+"')";
    System.out.println("sqlstr======================"+sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="添加保险清单信息";
}
}
if ( stype.equals("del") ){ 
sqlstr="delete from insurance_info where insurance_id = "+czid;
    System.out.println("sqlstr======================"+sqlstr);
    flag = db.executeUpdate(sqlstr);
message="删除保险清单信息";
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