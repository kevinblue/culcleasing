<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@page import="com.condition.ZC_Package"%> 
<%@ include file="../../func/common.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>资产包管理--发票数据处理页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
  </head>
  <%
  	//根据后台类生成电信发票表的发票id
	ZC_Package zc_Package = new ZC_Package();
	String id = zc_Package.get_Id();
  	int flag = 0;
  	String message = "";
  	//第一步：接值
  	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
  	String model = getStr(request.getParameter("model"));// 
  	String Fp_tt = getStr(request.getParameter("Fp_tt"));//发票抬头
  	String Fp_rate = getStr(request.getParameter("Fp_rate"));//金额比例
  	
  	String Fp_countMoney = getStr(request.getParameter("Fp_countMoney"));//发票金额
  	String Fp_corpus = getStr(request.getParameter("Fp_corpus"));//本金
  	String Fp_interest = getStr(request.getParameter("Fp_interest"));//利息
  	String Kp_date = getStr(request.getParameter("Kp_date"));//开票时间
  	String Fp_num = getStr(request.getParameter("Fp_num"));//发票编号
  	String Zc_num = getStr(request.getParameter("Zc_num"));//
  	String key_id = getStr(request.getParameter("key_id"));//
	if(model.equals("add")){
	  	//第二步：电信发票表fund_ Assets_Invoice新增一条发票信息
	  	message = "新开发票";
	  	String ins_sql_toFAP = " INSERT INTO  fund_Assets_Invoice ";
	           ins_sql_toFAP = ins_sql_toFAP + "(id,Fp_tt ,Fp_num ,Fp_rate,Fp_countMoney,Fp_corpus,Fp_interest,Kp_date, ";
	           ins_sql_toFAP = ins_sql_toFAP + "Caertor ,Caertor_date  ";
	           ins_sql_toFAP = ins_sql_toFAP + ")  VALUES ( ";
	           ins_sql_toFAP = ins_sql_toFAP + " '"+id+"','"+Fp_tt+"' ,'"+Fp_num+"' ,'"+Fp_rate+"','"+Fp_countMoney+"','"+Fp_corpus+"','"+Fp_interest+"','"+Kp_date+"' ";
	           ins_sql_toFAP = ins_sql_toFAP + " ,'"+user_id+"' ,getdate() ) "; 
		System.out.println("电信发票表fund_ Assets_Invoice新增一条发票信息==>"+ins_sql_toFAP);
	    flag = db.executeUpdate(ins_sql_toFAP);
    }
    else if(model.equals("mod")){
	  	message = "发票编号修改";
    	String up_s = " update fund_Assets_Invoice set Fp_num = '"+Fp_num+"',Kp_date = '"+Kp_date+"' where id = '"+key_id+"' ";
    	flag = db.executeUpdate(up_s);
    	System.out.println("计划财务部修改发票编号==?>"+up_s);
    }
    
    if(flag > 0){
	  	//第三步：资产包与发票的对应表fund_Assets_Invoice_Corresponding新增多条选中的租金偿还信息
	  		StringBuffer sql = new StringBuffer();
	  			sql.append(" INSERT INTO  fund_Assets_Invoice_Corresponding  ")
				    .append("       (Zc_num ,Fp_id  ")
				    .append("         ,Caertor,Caertor_date  ")
				    .append("        )  VALUES ( ")
				    .append("         '"+Zc_num+"' ,'"+id+"' ")
				    .append("        ,'"+user_id+"' ,getdate()) ")
	  			   .append(" ; ");
	  		System.out.println("往资产包与发票的对应表==>"+sql);
	  		flag = db.executeUpdate(sql.toString());
    }
  	
  	//
  		if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("<%=message%>成功!");
					opener.parent.location.reload();
					window.close();
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
%>
</html>
<%if(null != db){db.close();}%>