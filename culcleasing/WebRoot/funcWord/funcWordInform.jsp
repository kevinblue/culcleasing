<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>支付通知书-中转界面</title>
</head>

<body onload="public_onload(0);">

<%
//获取相关参数
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String destUrl = "";//跳转URL地址
String deptName = getStr(request.getParameter("deptName"));//部门名称
String deptId = getStr(request.getParameter("deptId"));//部门编号
String inform_type = getStr(request.getParameter("inform_type"));//通知书类型

//判断通知书类型跳转不同Jsp 
if(inform_type!=null && "租金支付".equals(inform_type)){
	destUrl="wordInform/rent_word_dept.jsp?deptId="+deptId+"&dqczy="+dqczy;
}else if(inform_type!=null && "违约金明细".equals(inform_type)){
	destUrl="wordInform/penalty_word_dept.jsp?deptId="+deptId+"&dqczy="+dqczy;
}else if(inform_type!=null && "租金变更".equals(inform_type)){
	destUrl="wordInform/rent_modify_dept.jsp?deptId="+deptId+"&dqczy="+dqczy;
}else if(inform_type!=null && "非批量调息租金变更".equals(inform_type)){
	destUrl="wordInform/rent_modifyfpl_dept.jsp?deptId="+deptId+"&dqczy="+dqczy;
}else if(inform_type!=null && "合同结清".equals(inform_type)){
	destUrl="wordInform/contract_end_dept.jsp?deptId="+deptId+"&dqczy="+dqczy;
}else{
	inform_type = "租金支付";
	destUrl="wordInform/rent_word_dept.jsp?deptId="+deptId+"&dqczy="+dqczy;
}
System.out.println("跳转地址："+destUrl);
%>

<%
response.sendRedirect(destUrl);
%>

</body>
</html>
