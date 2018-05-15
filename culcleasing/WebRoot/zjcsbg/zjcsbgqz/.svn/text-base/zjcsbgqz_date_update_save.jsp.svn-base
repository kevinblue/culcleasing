<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="gcns" scope="page"
	class="com.service.GeneContractNetFlowService" />
<%@ include file="../../func/common.jsp"%>

<%
	int flag = 0;
	//程序执行的类型
	String stype = getStr(request.getParameter("savetype"));
	String dqczy = (String) session.getAttribute("czyid");

	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String rent_list = getStr(request.getParameter("rent_list"));
	String charge_date = getStr(request.getParameter("charge_date"));

	if ("mod".equals(stype)) {
		StringBuffer sql = new StringBuffer();
		//    contract_id
		sql.append("update fund_rent_plan_temp set plan_date='");
		sql.append(charge_date);
		sql.append("' where measure_id='");
		sql.append(doc_id);
		sql.append("' and rent_list=");
		sql.append(rent_list);
		
		sql.append(" and contract_id='");
		sql.append(contract_id);
		sql.append("'");

		System.out.println(sql.toString());
		db.executeUpdate(sql.toString());
		//插入合同日程表(临时)
		gcns.GeneContractNetFlow(contract_id, doc_id, dqczy);
		db.close();
		flag = 1;

	} else {
	}

	if (flag != 0) {
%>

<script>
			window.close();
			opener.alert("请款日期修改成功!");
			opener.location.reload();
</script>
<%
} else {
%>
<script>
			window.close();
			opener.alert("请款日期修改失败!");
			opener.location.reload();
</script>


<%
}
%>

