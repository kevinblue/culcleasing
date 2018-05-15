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
String vndr_id = getStr( request.getParameter("vndr_id") );
String shareholder = getStr( request.getParameter("shareholder") );
String individual_flag = getStr( request.getParameter("individual_flag") );
String id_number = getStr( request.getParameter("id_number") );
String primary_business = getStr( request.getParameter("primary_business") );
String address = getStr( request.getParameter("address") );
String legal_representative = getStr( request.getParameter("legal_representative") );
String registered_capital = getStr( request.getParameter("registered_capital") );
String equity_ratio = getStr( request.getParameter("equity_ratio") );
String datestr = getSystemDate(0); //获取系统时间
String stype = getStr( request.getParameter("savetype") );
String project_id= getStr(request.getParameter("project_id")); 
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into mproj_vndr_capital_struct (vndr_id,proj_id,shareholder,individual_flag,id_number,primary_business,address,legal_representative,registered_capital,equity_ratio,creator,create_date) values (";
if(vndr_id!=null&&!vndr_id.equals("")){
	sqlstr+="'"+vndr_id+"',";
}else{
	sqlstr+="null,";
}
if(project_id!=null&&!project_id.equals("")){
	sqlstr+="'"+project_id+"',";
}else{
	sqlstr+="null,";
}
if(shareholder!=null&&!shareholder.equals("")){
	sqlstr+="'"+shareholder+"',";
}else{
	sqlstr+="null,";
}
if(individual_flag!=null&&!individual_flag.equals("")){
	sqlstr+="'"+individual_flag+"',";
}else{
	sqlstr+="null,";
}
if(id_number!=null&&!id_number.equals("")){
	sqlstr+="'"+id_number+"',";
}else{
	sqlstr+="null,";
}

if(primary_business!=null&&!primary_business.equals("")){
	sqlstr+="'"+primary_business+"',";
}else{
	sqlstr+="null,";
}
if(address!=null&&!address.equals("")){
	sqlstr+="'"+address+"',";
}else{
	sqlstr+="null,";
}
if(legal_representative!=null&&!legal_representative.equals("")){
	sqlstr+="'"+legal_representative+"',";
}else{
	sqlstr+="null,";
}
if(registered_capital!=null&&!registered_capital.equals("")){
	sqlstr+="'"+registered_capital+"',";
}else{
	sqlstr+="null,";
}
if(equity_ratio!=null&&!equity_ratio.equals("")){
	sqlstr+="'"+equity_ratio+"',";
}else{
	sqlstr+="null,";
}
if(dqczy!=null&&!dqczy.equals("")){
	sqlstr+="'"+dqczy+"',";
}else{
	sqlstr+="null,";
}
if(datestr!=null&&!datestr.equals("")){
	sqlstr+="'"+datestr+"'";
}else{
	sqlstr+="null";
}
sqlstr+=")";
flag = db.executeUpdate(sqlstr);
message="添加承租客户企业股本结构";
}
if ( stype.equals("mod") ){ 
sqlstr="update mproj_vndr_capital_struct set ";
if(vndr_id!=null&&!vndr_id.equals("")){
	sqlstr+="vndr_id='"+vndr_id+"',";
}else{
	sqlstr+="vndr_id=null,";
}
if(shareholder!=null&&!shareholder.equals("")){
	sqlstr+="shareholder='"+shareholder+"',";
}else{
	sqlstr+="shareholder=null,";
}
if(individual_flag!=null&&!individual_flag.equals("")){
	sqlstr+="individual_flag='"+individual_flag+"',";
}else{
	sqlstr+="individual_flag=null,";
}
if(id_number!=null&&!id_number.equals("")){
	sqlstr+="id_number='"+id_number+"',";
}else{
	sqlstr+="id_number=null,";
}

if(primary_business!=null&&!primary_business.equals("")){
	sqlstr+="primary_business='"+primary_business+"',";
}else{
	sqlstr+="primary_business=null,";
}
if(address!=null&&!address.equals("")){
	sqlstr+="address='"+address+"',";
}else{
	sqlstr+="address=null,";
}
if(legal_representative!=null&&!legal_representative.equals("")){
	sqlstr+="legal_representative='"+legal_representative+"',";
}else{
	sqlstr+="legal_representative=null,";
}
if(registered_capital!=null&&!registered_capital.equals("")){
	sqlstr+="registered_capital='"+registered_capital+"',";
}else{
	sqlstr+="registered_capital=null,";
}
if(equity_ratio!=null&&!equity_ratio.equals("")){
	sqlstr+="equity_ratio='"+equity_ratio+"',";
}else{
	sqlstr+="equity_ratio=null,";
}
if(dqczy!=null&&!dqczy.equals("")){
	sqlstr+="modificator='"+dqczy+"',";
}else{
	sqlstr+="modificator=null,";
}
if(datestr!=null&&!datestr.equals("")){
	sqlstr+="modify_date='"+datestr+"'";
}else{
	sqlstr+="modify_date=null";
}
sqlstr+=" where id="+czid;
flag = db.executeUpdate(sqlstr);
message="修改承租客户企业股本结构";
}
if ( stype.equals("del") ){ 
sqlstr="delete from mproj_vndr_capital_struct where  id="+czid;
flag = db.executeUpdate(sqlstr);
message="删除承租客户企业股本结构";
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
