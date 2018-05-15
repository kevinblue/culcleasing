<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<%
String fund_id = getStr(request.getParameter("fund_id"));
	String volume = getStr(request.getParameter("volume"));
	String zq = getStr(request.getParameter("zq"));
	String jg = getStr(request.getParameter("jg"));

	String charge_first_date = getStr(request.getParameter("charge_first_date"));
	String rent_first_date = getStr(request.getParameter("rent_first_date"));
	String lease_term = getStr(request.getParameter("lease_term"));
	String income_number =  getStr(request.getParameter("income_number"));
	String year_rate = getStr(request.getParameter("year_rate"));
	String lease_money = getStr(request.getParameter("lease_money"));
	String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
	String period_type = getStr(request.getParameter("period_type"));
	
	String equip_amt = getStr(request.getParameter("equip_amt"));
	String first_payment = getStr(request.getParameter("first_payment"));
	String caution_money = getStr(request.getParameter("caution_money"));
	String handling_charge = getStr(request.getParameter("handling_charge"));
	String return_amt = getStr(request.getParameter("return_amt"));
	String supervision_fee =  getStr(request.getParameter("supervision_fee"));
	String consulting_fee =  getStr(request.getParameter("consulting_fee"));
	String other_fee = getStr(request.getParameter("other_fee"));
	String nominalprice = getStr(request.getParameter("nominalprice"));
	String insurance_lessor = getStr(request.getParameter("insurance_lessor"));
	
	String project_id = getStr(request.getParameter("project_id"));
	String rate_float_type = getStr(request.getParameter("rate_float_type"));
	String settle_method = getStr(request.getParameter("settle_method"));
	String first_payment_ratio = getStr(request.getParameter("first_payment_ratio"));
	String caution_money_ratio = getStr(request.getParameter("caution_money_ratio"));
	String lessee_caution_ratio = getStr(request.getParameter("lessee_caution_ratio"));
	String lessee_caution_money = getStr(request.getParameter("lessee_caution_money"));
	String vndr_caution_ratio = getStr(request.getParameter("vndr_caution_ratio"));
	String vndr_caution_money = getStr(request.getParameter("vndr_caution_money"));
	String sale_caution_ratio = getStr(request.getParameter("sale_caution_ratio"));
	String sale_caution_money = getStr(request.getParameter("sale_caution_money"));
	String caution_deduction_ratio = getStr(request.getParameter("caution_deduction_ratio"));
	String handling_charge_ratio = getStr(request.getParameter("handling_charge_ratio"));
	String return_ratio = getStr(request.getParameter("return_ratio"));
	String supervision_fee_ratio = getStr(request.getParameter("supervision_fee_ratio"));
	String insurance_method = getStr(request.getParameter("insurance_method"));
	String insurance_lessee = getStr(request.getParameter("insurance_lessee"));
	String redressalk = getStr(request.getParameter("redressalk"));
	String pena_rate = getStr(request.getParameter("pena_rate"));
	String total_amt = getStr(request.getParameter("total_amt"));
	String actual_fund = getStr(request.getParameter("actual_fund"));
	String rough_earn = getStr(request.getParameter("rough_earn"));
	String year_earn = getStr(request.getParameter("year_earn"));
	String irr = getStr(request.getParameter("irr"));
	String income_day = getStr(request.getParameter("income_day"));
	
	String czyid = (String)session.getAttribute("czyid");
	String systemDate = getSystemDate(0);
	boolean flag = false;
	ResultSet rsCount = null;
	if(project_id!=null&&!project_id.equals("")){
	String sql = "select count(*) from proj_condition where proj_id='"+project_id+"'";
	System.out.println(sql);
	rsCount = db.executeQuery(sql);
	if(rsCount.next()){
		if(rsCount.getInt(1)>0){
			
		}else{
			flag = true;
		}
	}
	StringBuffer strSql = new StringBuffer();
	if(flag){
		strSql.append("insert into proj_condition (proj_id,equip_amt,lease_money,lease_term,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,creator,create_date,modificator,modify_date,first_date,second_date) values (");
		strSql.append("'").append(project_id).append("'")
		.append(",").append(equip_amt)
		.append(",").append(lease_money)
		.append(",").append(lease_term)
		.append(",").append(income_number)
		.append(",").append(year_rate)
		.append(",'").append(rate_float_type).append("'")
		.append(",'").append(period_type).append("'")
		.append(",'").append(settle_method).append("'")
		.append(",").append(income_day)
		.append(",").append(first_payment_ratio)
		.append(",").append(first_payment)
		.append(",").append(caution_money_ratio)
		.append(",").append(caution_money)
		.append(",").append(lessee_caution_ratio)
		.append(",").append(lessee_caution_money)
		.append(",").append(vndr_caution_ratio)
		.append(",").append(vndr_caution_money)
		.append(",").append(sale_caution_ratio)
		.append(",").append(sale_caution_money)
		.append(",").append(caution_deduction_ratio)
		.append(",").append(caution_deduction_money)
		.append(",").append(handling_charge_ratio)
		.append(",").append(handling_charge)
		.append(",").append(return_ratio)
		.append(",").append(return_amt)
		.append(",").append(supervision_fee_ratio)
		.append(",").append(supervision_fee)
		.append(",").append(consulting_fee)
		.append(",").append(other_fee)
		.append(",").append(nominalprice)
		.append(",'").append(insurance_method).append("'")
		.append(",").append(insurance_lessor)
		.append(",").append(insurance_lessee)
		.append(",").append(redressalk)
		.append(",").append(pena_rate)
		.append(",").append(total_amt)
		.append(",").append(actual_fund)
		.append(",").append(rough_earn)
		.append(",").append(year_earn)
		.append(",").append(irr)
		.append(",'").append(czyid).append("'")
		.append(",'").append(systemDate).append("'")
		.append(",'").append(czyid).append("'")
		.append(",'").append(systemDate).append("'")
		.append(",'").append(charge_first_date).append("'")
		.append(",'").append(rent_first_date).append("'")
		.append(")");
		
	}else{
		strSql.append(" update proj_condition set ")
		.append(" equip_amt=").append(equip_amt)
		.append(", lease_money=").append(lease_money)
		.append(", lease_term=").append(lease_term)
		.append(", income_number=").append(income_number)
		.append(", year_rate=").append(year_rate)
		.append(", rate_float_type='").append(rate_float_type).append("'")
		.append(", period_type='").append(period_type).append("'")
		.append(", settle_method='").append(settle_method).append("'")
		.append(", income_day=").append(income_day)
		.append(", first_payment_ratio=").append(first_payment_ratio)
		.append(", first_payment=").append(first_payment)
		.append(", caution_money_ratio=").append(caution_money_ratio)
		.append(", caution_money=").append(caution_money)
		.append(", lessee_caution_ratio=").append(lessee_caution_ratio)
		.append(", lessee_caution_money=").append(lessee_caution_money)
		.append(", vndr_caution_ratio=").append(vndr_caution_ratio)
		.append(", vndr_caution_money=").append(vndr_caution_money)
		.append(", sale_caution_ratio=").append(sale_caution_ratio)
		.append(", sale_caution_money=").append(sale_caution_money)
		.append(", caution_deduction_ratio=").append(caution_deduction_ratio)
		.append(", caution_deduction_money=").append(caution_deduction_money)
		.append(", handling_charge_ratio=").append(handling_charge_ratio)
		.append(", handling_charge=").append(handling_charge)
		.append(", return_ratio=").append(return_ratio)
		.append(", return_amt=").append(return_amt)
		.append(", supervision_fee_ratio=").append(supervision_fee_ratio)
		.append(", supervision_fee=").append(supervision_fee)
		.append(", consulting_fee=").append(consulting_fee)
		.append(", other_fee=").append(other_fee)
		.append(", nominalprice=").append(nominalprice)
		.append(", insurance_method='").append(insurance_method).append("'")
		.append(", insurance_lessor=").append(insurance_lessor)
		.append(", insurance_lessee=").append(insurance_lessee)
		.append(", redressalk=").append(redressalk)
		.append(", pena_rate=").append(pena_rate)
		.append(", total_amt=").append(total_amt)
		.append(", actual_fund=").append(actual_fund)
		.append(", rough_earn=").append(rough_earn)
		.append(", year_earn=").append(year_earn)
		.append(", irr=").append(irr)
		.append(", modificator='").append(czyid).append("'")
		.append(", modify_date='").append(systemDate).append("'")
		.append(", first_date='").append(charge_first_date).append("'")
		.append(", second_date='").append(rent_first_date).append("'")
		.append(" where proj_id='").append(project_id).append("'");
	}
	System.out.println(strSql.toString());
	db.executeUpdate(strSql.toString());
	}
	db.close();
%>
<script>

			window.location.href = "zjbcxm_condview.jsp?project_id=<%=project_id%>";
		</script>
