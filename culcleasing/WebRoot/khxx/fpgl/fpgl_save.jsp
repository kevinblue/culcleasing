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
String memo="";
String systemDate = getSystemDate(0);
	String plan_id = getStr( request.getParameter("plan_id") );
	String contract_id = getStr( request.getParameter("contract_id") );
	String rent_list = getStr( request.getParameter("rent_list") );
	String invoice_method = getStr( request.getParameter("invoice_method") );
	System.out.println("plan==="+plan_id);
	System.out.println("contract_id==="+contract_id);
	System.out.println("rent_list==="+rent_list);
	
	
	//发票号
	 invoice_number=getStr(request.getParameter("invoice_number"));
	//发票总额
	 invoice_total=getStr(request.getParameter("invoice_total"));
	//发票开据日期
	 invoice_date=getStr(request.getParameter("invoice_date"));
	 //发票抬头
	 invoice_name=getStr(request.getParameter("invoice_name"));
	 //备注
	 memo=getStr(request.getParameter("memo"));	 
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
//发票号
	 invoice_number=getStr(request.getParameter("invoice_number"));
	//发票总额
	 invoice_total=getStr(request.getParameter("invoice_total"));
	//发票开据日期
	 invoice_date=getStr(request.getParameter("invoice_date"));
	 System.out.println("invoice_number888="+invoice_number);
	 System.out.println("invoice_total$$="+invoice_total);
	 System.out.println("invoice_date%%="+invoice_date);
System.out.println("id=%%=="+id);
String sqlst;
sqlst="update proj_invoice set invoice_number='"+invoice_number+"',invoice_method='"+invoice_method+"',invoice_date='"+invoice_date+"',creator='"+dqczy+"',create_date='"+systemDate+"',modificator='"+dqczy+"',modify_date='"+systemDate+"',memo='"+memo+"' where id='"+id+"'";
flag1=db.executeUpdate(sqlst);
System.out.println("sqlst="+sqlst);
}


if ( stype.equals("add") ){ 

sqlstr="insert into proj_invoice(invoice_number,invoice_name,invoice_total,invoice_method,invoice_date,creator,create_date,modificator,modify_date,memo) values('"+invoice_number+"','"+invoice_name+"','"+invoice_total+"','"+invoice_method+"','"+invoice_date+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"','"+memo+"')";

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
String [] sid2 = contract_id.split(",");
String [] sid3 = rent_list.split(",");

System.out.println("plan_id:=="+plan_id);
System.out.println("sid++"+sid[0]);
System.out.println("sid++"+sid.length);
//得到要执行的sql语句
String sql="";
String sql2="";
for (int i=0;i<sid.length;i++) {
sql+="insert into proj_invoice_detail(plan_id,proj_invoice_id,creator,create_date,modificator,modify_date,contract_id,rent_list) values('"+sid[i]+"','"+maxid+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"','"+sid2[i]+"','"+sid3[i]+"')";
System.out.println("plan_id:=="+sid[0]);
System.out.println("i:=="+i);
sql2+=" update fund_rent_plan set is_fp='是'where contract_id='"+sid2[i]+"' and rent_list='"+sid3[i]+"' ";
}
System.out.println(sql);
//执行语句
flag = db1.executeUpdate(sql);
flag +=db1.executeUpdate(sql2);

message="添加发票";
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
		opener.window.location.href = "fpgl_list.jsp";
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
			 	
		opener.window.location.href = "fpgl_list.jsp";
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