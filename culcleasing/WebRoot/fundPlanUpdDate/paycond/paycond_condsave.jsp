<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//资金计划付款前提
//===========================================

//获取基础参数
String type = getStr( request.getParameter("type") );
String item_id = getStr( request.getParameter("item_id") );
String doc_id = getStr( request.getParameter("doc_id") );

//基本变量
String sqlstr = "";
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
String msg = "";
 
if("add".equals(type)){//添加付款前提
	String[] cond_id = request.getParameterValues("cond"); 
	if(cond_id == null){
		cond_id = new String[0];
	}
	String ckAmount = getStr( request.getParameter("ckAmount") );

	//2.1先删除付款前提   (多余的部分)
	sqlstr = "delete from contract_fund_fund_charge_condition_temp where doc_id='"+doc_id+"' and payment_id='"+item_id+"'";
	if("0".equals(ckAmount)){
		sqlstr+= "";
	}else{
		sqlstr += " and  pay_condition not in ( ";
			for(int i=0;i<cond_id.length;i++){
				if(i == cond_id.length - 1){
					sqlstr += "'"+cond_id[i]+"'";
				}else{
					sqlstr += "'"+cond_id[i]+"',";
				}
			}
		sqlstr += ")";
	}
	db.executeUpdate(sqlstr);
	
	System.out.println("ckAmount选中付款前提数量"+ckAmount);
	//LogWriter.logDebug(request, ckAmount+"sadasdsad"+cond_id.length+"___"+cond_id[0]);
	//System.out.println("sadasdsad"+cond_id.length+"___"+cond_id[0]);
	//2.2插入新的付款前提
	String selectsql = "";
	String insertsql = "";
	if("0".equals(ckAmount)){
		sqlstr = "";
		flag = 111111;
	}else{
		
		for(int i=0;i<cond_id.length;i++){
			selectsql ="select id from contract_fund_fund_charge_condition_temp ";
			selectsql += " where payment_id = '"+item_id+"' and doc_id = '"+doc_id+"' and pay_condition = '"+cond_id[i]+"'";
			ResultSet rs1 = db1.executeQuery(selectsql);
			if(rs1.next()){
				flag +=1;
			}else{
				insertsql = " insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
				insertsql += " select '"+item_id+"','"+doc_id+"','"+cond_id[i]+"','未收',''";
				flag += db.executeUpdate(insertsql);
			}
			
		}
		
	}

	LogWriter.logDebug(request, "设置合同付款前提");
	
	msg = "设置合同付款前提";
}

//3返回判断
 if(flag>0){%>
<script type="text/javascript">
	opener.alert("<%=msg %>成功!");
	opener.location.reload();
	if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
</script>	
<%}else{
%>
	<script type="text/javascript">
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>
<%if(null != db1){db1.close();}%>