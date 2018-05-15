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

String charge_off_flag = getStr( request.getParameter("charge_off_flag") );
String nia_flag = getStr( request.getParameter("nia_flag") );


String sqlstr;
ResultSet rs;
String charge_off_flag_old="";
String nia_flag_old="";
sqlstr="select charge_off_flag,nia_flag from contract_info where contract_id='"+czid+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	charge_off_flag_old=getDBStr( rs.getString("charge_off_flag") );
	nia_flag_old=getDBStr( rs.getString("nia_flag") );
}rs.close();
if(!charge_off_flag_old.equals("是") && charge_off_flag.equals("是")){
	sqlstr="insert into contract_change_his(contract_id,change_type,change_date,creator) select '"+czid+"','已注销','"+curr_date+"','"+dqczy+"'";
	db.executeUpdate(sqlstr);
}
if(!nia_flag_old.equals("是") && nia_flag.equals("是")){
	sqlstr="insert into contract_change_his(contract_id,change_type,change_date,creator) select '"+czid+"','不计息','"+curr_date+"','"+dqczy+"'";
	db.executeUpdate(sqlstr);
}
int flag=0;
String message="";
if ( stype.equals("add") ){ 
	
}
if ( stype.equals("mod") ){ 
	sqlstr="update contract_info set charge_off_flag='"+charge_off_flag+"',nia_flag='"+nia_flag+"' where contract_id='"+czid+"'";
	//System.out.println("sqlstr======================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="修改注销计息状态";
}
if ( stype.equals("del") ){ 

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