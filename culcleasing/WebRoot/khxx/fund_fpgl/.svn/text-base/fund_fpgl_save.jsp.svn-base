<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 
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
String invoice_number="";
String invoice_total="";
String invoice_date="";
String invoice_name="";
String fp_method= getStr( request.getParameter("fp_method") );
String systemDate = getSystemDate(0);
	String plan_id = getStr( request.getParameter("plan_id") );
	System.out.println("plan==="+plan_id);
	
	//票据号
	 invoice_number=getStr(request.getParameter("invoice_number"));
	//票据总额
	 invoice_total=getStr(request.getParameter("invoice_total"));
	//票据开据日期
	 invoice_date=getStr(request.getParameter("invoice_date"));
	 //票据抬头
	 invoice_name=getStr(request.getParameter("invoice_name"));
	System.out.println("invoice_number=+"+invoice_number);
	System.out.println("invoice_total=+"+invoice_total);
    System.out.println("invoice_date=+"+invoice_date);
    System.out.println("invoice_name=+"+invoice_name);
String sqlstr="";
ResultSet rs;
int flag=0;
String message="";
String stype =  getStr( request.getParameter("savetype") );

int flag1=0;
if(stype.equals("mod")){
System.out.println("id==%%%%%%=");
String id = getStr( request.getParameter("id") );
//票据号
	 invoice_number=getStr(request.getParameter("invoice_number"));
	//票据总额
	 invoice_total=getStr(request.getParameter("invoice_total"));
	//票据开据日期
	 invoice_date=getStr(request.getParameter("invoice_date"));
	 System.out.println("invoice_number888="+invoice_number);
	 System.out.println("invoice_total$$="+invoice_total);
	 System.out.println("invoice_date%%="+invoice_date);
System.out.println("id=%%=="+id);
String sqlst;
sqlst="update proj_invoice set invoice_number='"+invoice_number+"',invoice_date='"+invoice_date+"',creator='"+dqczy+"',create_date='"+systemDate+"',modificator='"+dqczy+"',modify_date='"+systemDate+"' where id='"+id+"'";
flag1=db.executeUpdate(sqlst);
System.out.println("sqlst="+sqlst);
}


if ( stype.equals("add") ){ 

sqlstr="insert into proj_invoice(invoice_number,invoice_name,invoice_total,invoice_date,creator,create_date,modificator,modify_date,fp_method,invoice_method) values('"+invoice_number+"','"+invoice_name+"','"+invoice_total+"','"+invoice_date+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"','"+fp_method+"','非租金')";

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
message="添加票据";
} 
if(flag!=0){
	
%>

<script>
			 	///window.location.href = "fpgl_list.jsp?plan_id=<%=plan_id%>";
		///alert("<%=message%>成功!");
		///opener.location.reload();
		
		///window.location.href = "frkh.jsp?
		///alert("<%=message%>成功!");
		///opener.location.reload();
		opener.window.location.href = "fund_fpgl_list.jsp";
		alert("<%=message%>成功!");
		this.close();
				
</script>


<%
}else{
%>

<%
}
 %>
<%
if(flag1!=0){
 %>
 <script>
			 	
		opener.window.location.href = "fund_fpgl_list.jsp";
		alert("修改成功!");
		this.close();
				
</script>
 <%
 }
  %>
<%
db1.close();
db.close();


%>