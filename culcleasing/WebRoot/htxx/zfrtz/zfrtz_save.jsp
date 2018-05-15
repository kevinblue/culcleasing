<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="gcns" scope="page"
	class="com.service.GeneContractNetFlowService" />
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
	</head>

	<BODY>
		<%
			String sqlstr;
			ResultSet rs;
			String dqczy = (String) session.getAttribute("czyid");
			String curr_date = getSystemDate(0);
			String stype = getStr(request.getParameter("savetype"));

			String contract_id = getStr(request.getParameter("contract_id"));
			String doc_id = getStr(request.getParameter("doc_id"));
			String zfr_date = getStr(request.getParameter("zfr_date"));
			String start_rent_list = getStr(request
					.getParameter("start_rent_list"));
			String handling_charge = getStr(request
					.getParameter("handling_charge"));

			String _zfr_date;
			String month_adjust = "";
			sqlstr = "select datediff(month,fund_rent_plan.plan_date,'"
					+ zfr_date
					+ "') as month_adjust from fund_rent_plan where fund_rent_plan.contract_id='"
					+ contract_id + "' and fund_rent_plan.rent_list='"
					+ start_rent_list + "'";
			System.out
					.println("sqlstr0==========================================================="
					+ sqlstr);
			rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				month_adjust = getDBStr(rs.getString("month_adjust"));
			}
			rs.close();

			_zfr_date = zfr_date.substring(8, 10);
			String message = "";
			sqlstr = "delete from fund_rent_plan_temp where measure_id='"
					+ doc_id + "'";
			db.executeUpdate(sqlstr);
			sqlstr = "insert into fund_rent_plan_temp(measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date) select '"
					+ doc_id
					+ "','"
					+ curr_date
					+ "',contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"
					+ contract_id
					+ "' and rent_list<"
					+ start_rent_list
					+ " union select '"
					+ doc_id
					+ "','"
					+ curr_date
					+ "',contract_id,rent_list,plan_status,case when substring(convert(varchar(10),dateadd(month,"
					+ month_adjust
					+ ",plan_date),121),1,8)+'"
					+ _zfr_date
					+ "'>dbo.getMonthLastDay(dateadd(month,"
					+ month_adjust
					+ ",plan_date)) then dbo.getMonthLastDay(dateadd(month,"
					+ month_adjust
					+ ",plan_date)) else substring(convert(varchar(10),dateadd(month,"
					+ month_adjust
					+ ",plan_date),121),1,8)+'"
					+ _zfr_date
					+ "' end,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"
					+ contract_id + "' and rent_list>=" + start_rent_list;
			System.out
					.println("sqlstr1==========================================================="
					+ sqlstr);
			db.executeUpdate(sqlstr);
			sqlstr = "delete from fund_rent_adjust where measure_id='" + doc_id
					+ "'";
			db.executeUpdate(sqlstr);
			sqlstr = "insert into fund_rent_adjust(measure_id,contract_id,adjust_type,start_list,payday_adjust,handling_charge) values('"
					+ doc_id
					+ "','"
					+ contract_id
					+ "','支付日调整',"
					+ start_rent_list
					+ ",'"
					+ zfr_date
					+ "',"
					+ handling_charge + ")";
			db.executeUpdate(sqlstr);
			//插入合同日程表(临时)
			gcns.GeneContractNetFlow(contract_id, doc_id, dqczy);

			db.close();
		%>
		<script>
			window.close();
			opener.alert("支付日调整成功");
			opener.location.reload();
</script>
