<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>预测现金流变更-只读</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<%
    //合同号、起租编号、doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	
	//模拟赋值
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "11CULC020165L91";
		doc_id = "JS999999900_HT11_4455";
	}
	// 加载修订前数据
	sqlstr = "select * from fund_cash_medi_yc_con_temp where contract_id='"+contract_id+"' and remark='预测现金流修订前' and doc_id='"+doc_id+"'";
	rs = db.executeQuery(sqlstr);
	if(!rs.next()){
		sqlstr="insert into fund_cash_medi_yc_con_temp(doc_id,contract_id,yc_month,yc_hire_date,cash_money,remark)";
		sqlstr += "select '"+doc_id+"',contract_id,yc_month,yc_hire_date,cash_money,'预测现金流修订前' from fund_cash_medi_yc_con ";
		sqlstr += " where contract_id='"+contract_id+"'";
		db.executeUpdate(sqlstr);
		System.out.println("-----------"+sqlstr);
	}
	
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
    
   	
   	<div id="tablesub"> 
   		<!-- 展示租金计划数据 --> 
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
		src="cashChangeShow.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
   
</div>
</body>
</html>
<%if(null != db){db.close();}%>