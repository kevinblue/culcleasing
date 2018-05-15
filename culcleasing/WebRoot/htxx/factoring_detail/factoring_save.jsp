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
String factoring_backname="";
String factoring_num="";
String factoring_account="";
String factoring_start_date="";
String factoring_end_date="";
String factoring_rent="";
String factoring_corpus="";
String factoring_interest="";
String factoring_repay="";
String factoring_rate="";
String cust_name="";
String lease_money="";
String systemDate = getSystemDate(0);
	String plan_id = getStr( request.getParameter("plan_id") );
	String factoring_date = getStr( request.getParameter("factoring_date") );
	System.out.println("plan==="+plan_id);
	System.out.println("factoring_date==="+factoring_date);
	//保理银行
	String test= getStr(request.getParameter("test"));
	System.out.println("test===="+test);
	 factoring_backname=getStr(request.getParameter("factoring_backname"));
	//保理帐号
	 factoring_account=getStr(request.getParameter("factoring_account"));
	//保理开始时间
	 factoring_start_date=getStr(request.getParameter("factoring_start_date"));
	//保理结束时间
	 factoring_end_date=getStr(request.getParameter("factoring_end_date"));
	 //保理金额
	 factoring_rent=getStr(request.getParameter("factoring_rent"));
	 //保理本金
	 factoring_corpus=getStr(request.getParameter("factoring_corpus"));	
	 //保理利息
	 factoring_interest=getStr(request.getParameter("factoring_interest"));	
	 //偿还金额
	 factoring_repay=getStr(request.getParameter("factoring_repay"));	
	 //保理利率
	 factoring_rate=getStr(request.getParameter("factoring_rate"));	
	  //保理编号
	 factoring_num =getStr(request.getParameter("factoring_num"));
	 //融资金额
	 lease_money =getStr(request.getParameter("lease_money"));
	 
	cust_name = getStr(request.getParameter("cust_name"));
	System.out.println("factoring_backname="+factoring_backname);
	System.out.println("factoring_account="+factoring_account);
	System.out.println("factoring_date="+factoring_date);
	
	System.out.println("factoring_rent="+factoring_rent);
    System.out.println("factoring_corpus="+factoring_corpus);
    System.out.println("factoring_repay="+factoring_repay);
    System.out.println("factoring_rate="+factoring_rate);
    System.out.println("factoring_interest="+factoring_interest);
    
    
String sqlstr="";
ResultSet rs;
int flag=0;
String message="";
String stype =  getStr( request.getParameter("savetype") );

int flag1=0;
if(stype.equals("mod")){
System.out.println("id==%%%%%%=");
String id = getStr( request.getParameter("id") );
//发票号
	// invoice_number=getStr(request.getParameter("invoice_number"));
	//发票总额
	 //invoice_total=getStr(request.getParameter("invoice_total"));
	//发票开据日期
	// invoice_date=getStr(request.getParameter("invoice_date"));
	// System.out.println("invoice_number888="+invoice_number);
	// System.out.println("invoice_total$$="+invoice_total);
	// System.out.println("invoice_date%%="+invoice_date);
System.out.println("id=%%=="+id);
String sqlst;
sqlst="update factoring_contract_info set factoring_backname='"+factoring_backname+"',cust_name='"+cust_name+"',factoring_num='"+factoring_num+"',factoring_account='"+factoring_account+"',factoring_start_date='"+factoring_start_date+"',factoring_end_date='"+factoring_end_date+"',factoring_rent='"+factoring_rent+"',factoring_corpus='"+factoring_corpus+"',factoring_interest='"+factoring_interest+"',factoring_repay='"+factoring_repay+"',factoring_rate='"+factoring_rate+"',modificator='"+dqczy+"',modify_date='"+systemDate+"',lease_money='"+lease_money+"' where id='"+id+"'";
flag1=db.executeUpdate(sqlst);
System.out.println("sqlst="+sqlst);
}


if ( stype.equals("add") ){ 

sqlstr="insert into factoring_contract_info (lease_money,factoring_backname,cust_name,factoring_num,factoring_account,factoring_start_date,factoring_end_date,factoring_rent,factoring_corpus,factoring_interest,factoring_repay,factoring_rate,creator,create_date,modificator,modify_date) values('"+lease_money+"','"+factoring_backname+"','"+cust_name+"','"+factoring_num+"','"+factoring_account+"','"+factoring_start_date+"','"+factoring_end_date+"','"+factoring_rent+"','"+factoring_corpus+"','"+factoring_interest+"','"+factoring_repay+"','"+factoring_rate +"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";

System.out.println("1："+sqlstr);
//执行语句
flag = db.executeUpdate(sqlstr);
System.out.println("flag============================="+flag);


//查询出最大的申请id
int maxid=0;
String s="select max(id) as maxid from factoring_contract_info";
rs = db.executeQuery(s);

if (rs.next()) {
maxid=rs.getInt("maxid");
}
rs.close();
System.out.println(maxid);
//添加明细表记录
//先分解资金计划表的id
String [] sid = plan_id.split(",");
String [] sid2 = factoring_date.split(",");
System.out.println("plan_id:=="+plan_id);
System.out.println("sid++"+sid[0]);
System.out.println("sid++"+sid.length);
//得到要执行的sql语句
String sql="";
for (int i=0;i<sid.length;i++) {
sql+="insert into factoring_contract_Corresponding (contract_id,factoring_date,factoring_num ,creator,create_date,modificator,modify_date) values('"+sid[i]+"','"+sid2[i]+"','"+maxid+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
System.out.println("plan_id:=="+sid[0]);
System.out.println("i:=="+i);
}
System.out.println(sql);
//执行语句
flag = db1.executeUpdate(sql);
message="添加保理明细";
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
		opener.window.location.href = "factoring_list.jsp";
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
			 	
		opener.window.location.href = "factoring_list.jsp";
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