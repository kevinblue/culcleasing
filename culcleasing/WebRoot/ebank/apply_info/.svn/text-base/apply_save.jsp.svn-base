<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
String czid = getStr( request.getParameter("czid") );//id
String systemDate = getSystemDate(0);

String sqlIds = getStr( request.getParameter("sqlIds") );//选择项
//plan_id,id,
//dld_id,dld_name,pay_method,
///pay_date,pay_amt,proj_number,effe_date,
//status
//代理商信息
String dld_name = getStr( request.getParameter("dld_name") );
String dld_id = getStr( request.getParameter("dld_id") );
//付款信息
String pay_method = getStr( request.getParameter("pay_method") );
String pay_date = getStr( request.getParameter("pay_date") );
String pay_amt = getStr( request.getParameter("pay_amt") );
String proj_number = getStr( request.getParameter("proj_number") );
String effe_date = getStr( request.getParameter("effe_date") );
	
String sqlstr="";
ResultSet rs = null;
int flag=0;
String message="";

String stype =  getStr( request.getParameter("savetype") );

if( "addHeadPay".equals(stype) ){//添加首付款
	//插入申请信息
	sqlstr="insert into apply_info (dld_id,dld_name,pay_method,pay_date,pay_amt,proj_number,effe_date,pay_type,status,creator,create_date) ";
	sqlstr+="values(";
	//dld_id,dld_name,pay_method,pay_date,pay_amt,proj_number,effe_date
	sqlstr+="'"+dld_id+"','"+dld_name+"','"+pay_method+"','"+pay_date+"','"+pay_amt+"','"+proj_number+"','"+effe_date+"',";
	sqlstr+="'资金','未核销','"+dqczy+"','"+systemDate+"') ";

	LogWriter.logDebug(request, "新增付款单："+sqlstr);
	//执行语句
	flag = db.executeUpdate(sqlstr);
	LogWriter.operationLog(request, "租赁业务>资金计划>非网银首付款>添加付款单", flag, sqlstr);

	//查询出最大的申请id
	int maxid=0;
	String s="select max(id) as maxid from apply_info where dld_name='"+dld_name+"'";
	rs = db.executeQuery(s);
	if (rs.next()) {
		maxid=rs.getInt("maxid");
	}rs.close();

	//添加明细表记录
	String sql =" insert into apply_info_detail(plan_id,apply_id,creator,create_date,proj_id) ";
	sql+=" select id,"+maxid+",'"+dqczy+"','"+systemDate+"',proj_id from fund_fund_charge_plan ";
	sql+=" where funds_mode='收款' and funds_type<>'管理服务费' and funds_type<>'DB保证金' ";
	sql+=" and proj_id in("+sqlIds+") ";
	//执行语句
	flag = db.executeUpdate(sql);

	message="添加代理公司首期付款";
}else if ( stype.equals("del") ){ 
	sqlstr="delete apply_info where  id='"+czid+"'";
	System.out.println("sqlstr:"+sqlstr);
	flag += db.executeUpdate(sqlstr);

	sqlstr="delete apply_info_detail where  apply_id='"+czid+"'";
	System.out.println("sqlstr:"+sqlstr);
	flag += db.executeUpdate(sqlstr);

	message="删除代理公司首期付款";
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
</BODY>
</HTML>