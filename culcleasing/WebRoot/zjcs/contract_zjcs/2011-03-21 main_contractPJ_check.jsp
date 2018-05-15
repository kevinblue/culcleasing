<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %><%@ page import="java.sql.*" %><%@ page import="dbconn.*" %><jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
	//ajax处理主报价协议
	int flag1 = 0;
	//第一步：接值 period_type,lt_value,main_proj_id
	String period_type = getStr(request.getParameter("period_type"));//付租类型   "期初|期末","1|0"
	String lease_term = getStr(request.getParameter("lease_term")) ;//租赁极限 12 24 36 
	String main_proj_id = getStr(request.getParameter("main_proj_id")) ;//主项目编号
	String income_number_year = getStr(request.getParameter("income_number_year")) ;//付租方式 "月付|双月付|季付|半年付|年付","1|2|3|6|12"
	//第二步：拼接查询报价年利率的sql
	StringBuffer sql = new StringBuffer();
	sql.append(" select * from mproj_quotation_info  ")
	   .append(" where proj_id = '"+main_proj_id+"' "); 
	   
	if("1".equals(period_type)){
		period_type = "期初";
	}else{
		period_type = "期末";
	}	 
	  
	if("1".equals(income_number_year)){
		income_number_year = "月付";
	}
	else if("1".equals(income_number_year)){
		income_number_year = "双月付";
	}
	else if("1".equals(income_number_year)){
		income_number_year = "季付";
	}
	else if("1".equals(income_number_year)){
		income_number_year = "半年付";
	}
	else{
		income_number_year = "年付";
	}	   
	   
	 sql.append(" and type = '"+period_type+"' ")//付租类型   期初、期末 
	   .append(" and  pay_type like '%"+income_number_year+"%'  ")//付租方式    
	   .append(" and plan_year = '"+lease_term+"' ")//租赁期限（月）
	   .append("  "); 
	System.out.println("查询主报价年利率-->"+sql);
	//第三步：执行查询
	String plan_bj = "";//报价年利率
	try{
		ResultSet rs = db.executeQuery(sql.toString());
		if(rs.next()){
			plan_bj = getDBStr(rs.getString("plan_bj"));
		}
		flag1 = -1;
		rs.close();
	}catch(Exception e){
		System.out.println(e);
	}
	db.close();
	if(flag1==-1){
%>
	<%=plan_bj%>
<%
	}else if(flag1==-2){
%>
	<%="0"%>
<%
	}else{
%>
	<%=""%>
<%
	}
%>