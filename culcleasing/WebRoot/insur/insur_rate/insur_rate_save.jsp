<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<BODY>
<%
	String savaType = getStr(request.getParameter("model"));
	String key_id = getStr(request.getParameter("key_id"));//央行基准利率基准表的主键
	int flag = 0;
	String message = "";
		//接参
	    String month_1 = getStr(request.getParameter("month_1")); 
	    String month_2 = getStr(request.getParameter("month_2")); 
		String month_3 = getStr(request.getParameter("month_3"));
		String month_4 = getStr(request.getParameter("month_4"));
		String month_5 = getStr(request.getParameter("month_5"));
		String month_6 = getStr(request.getParameter("month_6"));
		
		String month_7 = getStr(request.getParameter("month_7")); 
	    String month_8 = getStr(request.getParameter("month_8")); 
		String month_9 = getStr(request.getParameter("month_9"));
		String month_10 = getStr(request.getParameter("month_10"));
		String month_11 = getStr(request.getParameter("month_11"));
		String month_12 = getStr(request.getParameter("month_12"));
		String base_year_rate = getStr(request.getParameter("base_year_rate"));
		
		String cust_id = getStr(request.getParameter("cust_id"));//保险公司
		String insur_type = getStr(request.getParameter("insur_type"));//险种
		
	if(savaType.equals("add")){
		sqlstr="select id from base_insur_rate where cust_id='"+cust_id+"' and insur_type='"+insur_type+"'";
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			flag=-1;
		}else{
			sqlstr="insert into base_insur_rate(cust_id,insur_type,month_1,month_2,month_3,month_4,month_5,month_6,month_7,month_8,month_9,month_10,month_11,month_12,base_year_rate) values('"+cust_id+"','"+insur_type+"',"+month_1+","+month_2+","+month_3+","+month_4+","+month_5+","+month_6+","+month_7+","+month_8+","+month_9+","+month_10+","+month_11+","+month_12+",'"+base_year_rate+"')";
			//执行添加sql语句
			flag = db.executeUpdate(sqlstr);
			message="增加费率";
		}
		rs.close();
	} 
	//修改费率
	if(savaType.equals("mod")){
			   sqlstr="update base_insur_rate set cust_id='"+cust_id+"',insur_type='"+insur_type+"',month_1="+month_1+",month_2="+month_2+",month_3="+month_3+",month_4="+month_4+",month_5="+month_5+",month_6="+month_6+",month_7="+month_7+",month_8="+month_8+",month_9="+month_9+",month_10="+month_10+",month_11="+month_11+",month_12="+month_12+",base_year_rate='"+base_year_rate+"' where id="+key_id;
				flag = db.executeUpdate(sqlstr);
				
	
		message = "修改费率";
	}
	if(savaType.equals("del")){//删除
		
		sqlstr="delete from base_insur_rate where id="+key_id;
		flag=db.executeUpdate(sqlstr);
		message = "删除费率";
	}
	db.close();

		if(flag > 0){
%>
		        <script>
					alert("<%=message%>成功!");
					opener.location.reload();
					window.close();
				</script>
<%	}else if(flag<0){
				%>
	        <script>
				alert("数据存在，新增失败！");
				opener.location.reload();
				this.close();
			</script>
<%	
		}else{
%>
	        <script>
				alert("<%=message%>失败!");
				opener.location.reload();
				this.close();
			</script>
<%	
		
	}
	db.close();
%>