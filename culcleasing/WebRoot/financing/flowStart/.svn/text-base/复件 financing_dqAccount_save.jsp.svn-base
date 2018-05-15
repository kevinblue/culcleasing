<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.OperationUtil"%>
<%@page import="java.util.Date"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>融资管理  - 掉期时间保存</title>
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<BODY>
		<%
			String dqczy = (String) session.getAttribute("czyid");
			System.out.print("当前登录人"+dqczy);
					
			String savaType = getStr(request.getParameter("savetype"));
			int flag = 0;
			String message = "";
			String id = getStr(request.getParameter("id"));
			String swap_start_date_t = getStr(request.getParameter("swap_start_date_t"));
			String swap_delivery_date_t = getStr(request.getParameter("swap_delivery_date_t"));
			String swap_lib = getStr(request.getParameter("swap_lib"));
			String swap_nominal_money_t = getStr(request.getParameter("swap_nominal_money_t"));
			String swap_fix = getStr(request.getParameter("swap_fix"));
			String swap_rate_t = getStr(request.getParameter("swap_rate_t"));
			String rate_diff = getStr(request.getParameter("rate_diff"));
			String interest_day_amount = getStr(request.getParameter("interest_day_amount"));
			String interest_diff = getStr(request.getParameter("interest_diff"));
			String fact_bank_diff = getStr(request.getParameter("fact_bank_diff"));

		if (savaType.equals("add")) {
				//String sql2 = "insert into financing_change_date_info(proj_id,contract_id,insur_category,insur_type,insur_period,insur_money,insur_indate,insur_remark) values";
				//	   sql2 +="('"+proj_id+"','"+contract_id+"','"+insur_category+"','"+insur_type+"','"+insur_period+"',";
				//	   sql2 +="'"+insur_money+"','"+insur_indate+"','"+insur_remark+"')";
				//	   System.out.println("ssss+"+sql2);
				//flag += db.executeUpdate(sql2);
				//message = "掉期时间登记";
		}else if (savaType.equals("mod")) {
			String sql2 = "update financing_change_date_info set swap_start_date_t='"+swap_start_date_t+"'";
			sql2 +=",swap_delivery_date_t='"+swap_delivery_date_t+"',swap_nominal_money_t='"+swap_nominal_money_t+"',swap_fix='"+swap_fix+"',swap_lib='"+swap_lib+"',swap_rate_t="+swap_rate_t+",";
			sql2 +="rate_diff="+rate_diff+",interest_day_amount="+interest_day_amount+",interest_diff='"+interest_diff+"',fact_bank_diff='"+fact_bank_diff+"',modifactor='"+dqczy+"',modify_date=getDate() where id='"+id+"'";
			flag += db.executeUpdate(sql2);
			System.out.print("sql2====" + sql2);
			message = "修改掉期时间";
		}else if (savaType.equals("del")) {
			String sql2 = "delete from financing_change_date_info where id='"+id+"'";
			flag += db.executeUpdate(sql2);
			message = "删除掉期时间";
		}
		db.close();
	if (flag > 0) {
		if (savaType.equals("del")) {
%>
<script type="text/javascript">
opener.window.location.href = "financing_dqAccount_list.jsp";
alert("<%=message%>成功!");
this.close();
</script>
<%
} else if("mod".equals(savaType)){
%>
<script type="text/javascript">
//opener.window.location.href = "financing_dqAccount_list.jsp";
opener.location.reload()
alert("<%=message%>成功!");
this.close();
</script>
<%
	}else if("add".equals(savaType)){
%>
<script type="text/javascript">
opener.window.location.href = "financing_dqAccount_list.jsp";
alert("<%=message%>成功!");
this.close();
</script>
<%
	}} else {
%>
<script type="text/javascript">
alert("<%=message%>失败!");
opener.location.reload();
this.close();
</script>
<%
	}
%>
</BODY>
</html>
