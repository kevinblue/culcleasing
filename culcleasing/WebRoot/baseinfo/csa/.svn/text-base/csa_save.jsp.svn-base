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

String model_id = getStr( request.getParameter("model_id") );
String csa_hours = getStr( request.getParameter("csa_hours") );
String csa_fees = getStr( request.getParameter("csa_fees") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from csa_fees where model_id='"+model_id+"' and csa_hours="+csa_hours;
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	message="该CSA价格重复,添加";
}
else
{
sqlstr="insert into csa_fees (model_id,csa_hours,csa_fees,updater,updatetime) values('"+model_id+"',"+csa_hours+","+csa_fees+",'"+dqczy+"','"+curr_date+"')";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="添加CSA价格";
}
rs.close();
}

if ( stype.equals("mod") ){ 
sqlstr = "select * from csa_fees where model_id='"+model_id+"' and csa_hours="+csa_hours+" and csafees_id<>'"+czid+"'";
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	message="该CSA价格重复,修改";
}
else
{
sqlstr="update csa_fees set model_id='"+model_id+"',csa_hours="+csa_hours+",csa_fees="+csa_fees+",updater='"+dqczy+"',updatetime='"+curr_date+"' where csafees_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改CSA价格";
}
rs.close();
}
if ( stype.equals("del") ){ 
sqlstr="delete from csa_fees where  csafees_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除CSA价格";
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