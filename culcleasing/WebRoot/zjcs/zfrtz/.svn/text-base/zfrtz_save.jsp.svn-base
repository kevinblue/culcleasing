<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
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
					handling_charge="0";
			//交易结构
			sqlstr = "delete from contract_condition_temp where contract_id='"
					+ contract_id + "' and measure_id='" + doc_id + "'";
			db.executeUpdate(sqlstr);
			sqlstr="insert into contract_condition_temp(measure_id, contract_id, lease_amt, period_type, equip_amt, machine_price, begin_payment, first_payment_ratio, first_payment, lease_money, insurance_flag, insurer, insurance, lsh_insurance, cust_insurance, csa_flag, csa_financing, csa_hours, csa_cost, gps_flag, gps_cost, income_number_year, start_date, actual_start_date, first_date, income_number, lease_term, income_day, year_rate, supervision_fee, handling_charge, caution_money, return_amt, tax, commision, nominalprice, pena_rate, irr, plan_irr, peroid_payment, creator, create_date, modify_date, modificator) select '"+doc_id+"',contract_id, lease_amt, period_type, equip_amt, machine_price, begin_payment, first_payment_ratio, first_payment, lease_money, insurance_flag, insurer, insurance, lsh_insurance, cust_insurance, csa_flag, csa_financing, csa_hours, csa_cost, gps_flag, gps_cost, income_number_year, start_date, actual_start_date, first_date, income_number, lease_term, income_day, year_rate, supervision_fee, handling_charge, caution_money, return_amt, tax, commision, nominalprice, pena_rate, irr, plan_irr, peroid_payment, creator, create_date, modify_date, modificator from contract_condition where contract_id='"+contract_id+"'";
			db.executeUpdate(sqlstr);
			//将偿还计划表中的数据插入临时表
			sqlstr = "delete from fund_rent_plan_temp where contract_id='"
					+ contract_id + "' and measure_id='" + doc_id + "'";
			db.executeUpdate(sqlstr);
			sqlstr = "insert into fund_rent_plan_temp(measure_id,contract_id, rent_list, plan_status, plan_date, rent_adjust, eptd_rent, rent, straight_interest, corpus, year_rate, interest, rent_overage, corpus_overage, interest_overage, penalty_overage, penalty, rent_type, creator, create_date, modificator, modify_date) select '"
					+ doc_id
					+ "', contract_id, rent_list, plan_status, plan_date, rent_adjust, eptd_rent, rent, straight_interest, corpus, year_rate, interest, rent_overage, corpus_overage, interest_overage, penalty_overage, penalty, rent_type, creator, create_date, modificator, modify_date from fund_rent_plan where contract_id='"
					+ contract_id + "'";
					
			db.executeUpdate(sqlstr);

			String _zfr_date;
			String month_adjust = "";
			sqlstr = "select datediff(month,fund_rent_plan.plan_date,'"
					+ zfr_date
					+ "') as month_adjust from fund_rent_plan where fund_rent_plan.contract_id='"
					+ contract_id + "' and fund_rent_plan.rent_list='"
					+ start_rent_list + "'";
					
			rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				month_adjust = getDBStr(rs.getString("month_adjust"));
			}
			rs.close();

			_zfr_date = zfr_date.substring(8, 10);

			sqlstr = "update fund_rent_plan_temp set plan_date=substring(convert(varchar(10),dateadd(month,"
					+ month_adjust
					+ ",plan_date),21),1,7)+'-"
					+ _zfr_date
					+ "' where contract_id='"
					+ contract_id
					+ "' and measure_id='"
					+ doc_id
					+ "' and rent_list>='"
					+ start_rent_list + "'";
			db.executeUpdate(sqlstr);
			
			sqlstr = "delete from fund_rent_adjust where contract_id='"+contract_id+"' and measure_id='" + doc_id
					+ "'";
			db.executeUpdate(sqlstr);
			sqlstr = "insert into fund_rent_adjust(measure_id,contract_id,adjust_type,start_list,payday_adjust,handling_charge,apply_flag) values('"
					+ doc_id
					+ "','"
					+ contract_id
					+ "','支付日调整',"
					+ start_rent_list
					+ ",'"
					+ zfr_date
					+ "',"
					+ handling_charge + ",'0')";
					
			db.executeUpdate(sqlstr);
			//irr
			
			Irr irr=new Irr();
			String i_rr=irr.getIRR(contract_id,doc_id);
			
			sqlstr="update contract_condition_temp set irr="+i_rr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			
			db.executeUpdate(sqlstr);
			
			db.close();
		%>
		<script>
			window.close();
			opener.alert("支付日调整成功");
			opener.location.reload();
</script>