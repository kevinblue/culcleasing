<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
System.out.println("dqczy"+dqczy);
String czid = getStr( request.getParameter("czid") );//id
String systemDate = getSystemDate(0);
	String plan_id = getStr( request.getParameter("plan_id") );
	System.out.println("plan==="+plan_id);
	//String plan_id1 = getStr( request.getParameter("id") );
	//System.out.println("plan1==="+plan_id1);
	//发票号
	String invoice_number=getStr(request.getParameter("invoice_number"));
	//发票总额
	String invoice_total=getStr(request.getParameter("invoice_total"));
	//发票开据日期
	String invoice_date=getStr(request.getParameter("invoice_date"));
	
	//String dld_name = getStr( request.getParameter("dld_name") );
	//String dld_id = getStr( request.getParameter("dld_id") );
	//String pay_method = getStr( request.getParameter("pay_method") );
	
	//String pay_date = getStr( request.getParameter("pay_date") );
	//String pay_amt = getStr( request.getParameter("pay_amt") );
	//String proj_number = getStr( request.getParameter("proj_number") );
	
	//String effe_date = getStr( request.getParameter("effe_date") );
	//String status = getStr( request.getParameter("status") );
	
String sqlstr="";
ResultSet rs;
int flag=0;
String message="";


String stype =  getStr( request.getParameter("savetype") );



if ( stype.equals("add") ){ 

sqlstr="insert into proj_invoice(invoice_number,invoice_total,invoice_date,creator,create_date,modificator,modify_date) values('"+invoice_number+"','"+invoice_total+"','"+invoice_date+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";

System.out.println("1："+sqlstr);
//执行语句
flag = db.executeUpdate(sqlstr);
System.out.println("flag============================="+flag);

//查询出最大的申请id
int maxid=0;
String s="select max(id) as maxid from proj_invoice";
rs = db.executeQuery(s);

if (rs.next()) {
maxid=rs.getInt("maxid");
}
rs.close();
System.out.println(maxid);
//添加明细表记录
//先分解资金计划表的id
String [] sid = plan_id.split(",");
System.out.println("plan_id:=="+plan_id);
System.out.println("sid++"+sid[0]);
System.out.println("sid++"+sid.length);
//得到要执行的sql语句
String sql="";
for (int i=0;i<sid.length;i++) {
sql+="insert into proj_invoice_detail(plan_id,proj_invoice_id,creator,create_date,modificator,modify_date) values('"+sid[i]+"','"+maxid+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
System.out.println("plan_id:=="+sid[0]);
System.out.println("i:=="+i);
}
System.out.println(sql);
//执行语句
flag = db1.executeUpdate(sql);
message="添加发票";
} 
if(flag!=0){
	
%>
<script>
			 	window.location.href = "kk.jsp?plan_id=<%=plan_id%>";
		alert("<%=message%>成功!");
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
db1.close();
db.close();%>