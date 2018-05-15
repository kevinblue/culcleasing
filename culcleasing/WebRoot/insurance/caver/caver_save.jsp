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
String insurance_state = getStr( request.getParameter("insurance_state") );
String insurance_result = getStr( request.getParameter("insurance_result") );
String contract_id = getStr( request.getParameter("contract_id") );
String equip_sn = getStr( request.getParameter("equip_sn") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from insurance_caver where contract_id = '"+contract_id+"'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
message = "同一合同不可重复添加";
if ( rs.next() == false) {
sqlstr="insert into  insurance_caver (contract_id,equip_sn,insurance_state,insurance_result) values('"+contract_id+"','"+equip_sn+"','"+insurance_state+"','"+insurance_result+"')";
flag = db.executeUpdate(sqlstr);
message="保险日覆盖添加";
}
}
if ( stype.equals("mod") ){ 
	sqlstr = "select * from insurance_caver where contract_id = '"+contract_id+"'";
	System.out.println(sqlstr);
	rs = db.executeQuery(sqlstr); 
	if ( rs.next() ) {
		sqlstr="update insurance_caver set equip_sn='"+equip_sn+"',insurance_state='"+insurance_state+"',insurance_result='"+insurance_result+"' where contract_id='"+czid+"'";
		flag = db.executeUpdate(sqlstr);
		message="保险日覆盖修改";
	}else{
		sqlstr="insert into  insurance_caver (contract_id,equip_sn,insurance_state,insurance_result) values('"+contract_id+"','"+equip_sn+"','"+insurance_state+"','"+insurance_result+"')";
		flag = db.executeUpdate(sqlstr);
		message="保险日覆盖添加";

	}
}
if ( stype.equals("del") ){ 
sqlstr="delete from  insurance_caver where caver_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="保险日覆盖删除";
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