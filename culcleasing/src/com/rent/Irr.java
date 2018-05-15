package com.rent;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Tools;

import dbconn.Conn;

public class Irr {
	public Irr() {

	}

	// 根据租金列表,期初期末,净融资额返回用于处理的现金流
	public List getCashFlow(List l_rent, String period_type, String lease_money) {
		List cashFlow = new ArrayList();
		if (l_rent.size() == 0) {
			return null;
		}
		lease_money = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(lease_money)
				* (1 - 1 / 100.0)));
		if (period_type.equals("0")) {
			cashFlow.add("-" + lease_money);
			for (int i = 0; i < l_rent.size(); i++) {
				cashFlow.add((String) l_rent.get(i));
			}
		} else {
			for (int i = 0; i < l_rent.size(); i++) {
				cashFlow.add((String) l_rent.get(i));
			}
			cashFlow.set(0, "-"
					+ String.valueOf(Double.parseDouble(lease_money)
							- Double.parseDouble((String) cashFlow.get(0))));
		}

		return cashFlow;
	}

	// 根据现金流和项目间隔求出irr
	public String getIRR(List l_inflow_pour, String lease_interval) {

		BigDecimal tmp = new BigDecimal("1");
		BigDecimal irr = new BigDecimal("0.1");
		BigDecimal tmp1 = new BigDecimal("0");
		BigDecimal tmp2 = new BigDecimal("10");
		BigDecimal bigdec_1 = new BigDecimal("1");
		BigDecimal bigdec_2 = new BigDecimal("2");
		int j = 0;
		try {
			while (tmp.abs().doubleValue() > 0.0000000001 && j < 100) {
				tmp = new BigDecimal(l_inflow_pour.get(0).toString());
				for (int i = 1; i < l_inflow_pour.size(); i++) {
					tmp = tmp.add(new BigDecimal(l_inflow_pour.get(i)
							.toString()).divide(new BigDecimal(Math.pow(irr
							.add(bigdec_1).doubleValue(), i)), 20,
							BigDecimal.ROUND_HALF_UP));
				}
				if (tmp.doubleValue() > 0
						&& tmp.abs().doubleValue() > 0.0000000001) {
					tmp1 = irr;
					irr = irr.add(tmp2).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				if (tmp.doubleValue() < 0
						&& tmp.abs().doubleValue() > 0.0000000001) {
					tmp2 = irr;
					irr = irr.add(tmp1).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				j++;
			}
			irr = irr.multiply(new BigDecimal(12)).divide(
					new BigDecimal(lease_interval), 20,
					BigDecimal.ROUND_HALF_UP);
			return irr.toString().equals("") ? "0" : irr.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}

	// 暂时不用
	public List getCashFlow(List l_rent, String lease_interval,
			String period_type, String lease_money) {
		List cashFlow = new ArrayList();
		if (l_rent.size() == 0) {
			return null;
		}
		lease_money = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(lease_money)
				* (1 - 1 / 100.0)));
		for (int i = 0; i < l_rent.size(); i++) {
			for (int j = 0; j < Integer.parseInt(lease_interval); j++) {
				if (j % Integer.parseInt(lease_interval) == 0) {
					cashFlow.add((String) l_rent.get(i));
				} else {
					cashFlow.add("0");
				}
			}
		}
		if (period_type.equals("0")) {
			List cash_tmp = new ArrayList();
			for (int j = 0; j < Integer.parseInt(lease_interval); j++) {
				if (j % Integer.parseInt(lease_interval) == 0) {
					cash_tmp.add("-" + lease_money);
				} else {
					cash_tmp.add("0");
				}
			}
			for (int i = 0; i < cashFlow.size(); i++) {
				cash_tmp.add((String) cashFlow.get(i));
			}
			return cash_tmp;
		} else {
			cashFlow.set(0, "-"
					+ String.valueOf(Double.parseDouble(lease_money)
							- Double.parseDouble((String) cashFlow.get(0))));
		}

		return cashFlow;
	}

	// -------------------------------------------------------------------------------
	public List getEnoughMonth(List list) {
		List r_turn = new ArrayList();
		if (list.size() == 0) {
			return null;
		}
		String s_date = (String) list.get(0);
		String e_date = (String) list.get(list.size() - 1);
		while (Tools.dateDiff("month", s_date, e_date) >= 0) {
			r_turn.add(s_date.substring(0, 7));
			s_date = Tools.dateAdd("month", 1, s_date);
		}
		return r_turn;
	}

	public String lookUpSum(String month, List l_plan_date, List l_rent) {
		String r_turn = "0";
		for (int i = 0; i < l_plan_date.size(); i++) {
			String plan_date = ((String) l_plan_date.get(i)).substring(0, 7);
			if(month.equals(plan_date)){
				r_turn=String.valueOf(Double.parseDouble(r_turn)+Double.parseDouble(l_rent.get(i).toString()));
			}
		}
		r_turn=Tools.formatNumberDoubleTwo(r_turn);
		return r_turn;
	}

	public List getCashFlow(List l_plan_date, List l_rent, String period_type,String lease_interval,
			String lease_money) {
		List cashFlow = new ArrayList();
		List cashFlow_tmp = new ArrayList();
		if (l_rent.size() == 0) {
			return null;
		}
		lease_money = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(lease_money)
				* (1 - 1 / 100.0)));
		List l_month = getEnoughMonth(l_plan_date);
		for (int i = 0; i < l_month.size(); i++) {
			cashFlow_tmp.add(lookUpSum(l_month.get(i).toString(),l_plan_date,l_rent));
		}
		if (period_type.equals("0")) {
			cashFlow.add("-" + lease_money);
			for (int j = 0; j < Integer.parseInt(lease_interval)-1; j++) {
				cashFlow.add("0");
			}
			for (int i = 0; i < cashFlow_tmp.size(); i++) {
				cashFlow.add((String) cashFlow_tmp.get(i));
			}
		} else {
			for (int i = 0; i < cashFlow_tmp.size(); i++) {
				cashFlow.add((String) cashFlow_tmp.get(i));
			}
			cashFlow.set(0, "-"
					+ String.valueOf(Double.parseDouble(lease_money)
							- Double.parseDouble((String) cashFlow.get(0))));
		}
		return cashFlow;
	}

	public String getIRR(List l_inflow_pour) {

		BigDecimal tmp = new BigDecimal("1");
		BigDecimal irr = new BigDecimal("0.1");
		BigDecimal tmp1 = new BigDecimal("0");
		BigDecimal tmp2 = new BigDecimal("10");
		BigDecimal bigdec_1 = new BigDecimal("1");
		BigDecimal bigdec_2 = new BigDecimal("2");
		int j = 0;
		try {
			while (tmp.abs().doubleValue() > 0.0000000001 && j < 100) {
				tmp = new BigDecimal(l_inflow_pour.get(0).toString());
				for (int i = 1; i < l_inflow_pour.size(); i++) {
					tmp = tmp.add(new BigDecimal(l_inflow_pour.get(i)
							.toString()).divide(new BigDecimal(Math.pow(irr
							.add(bigdec_1).doubleValue(), i)), 20,
							BigDecimal.ROUND_HALF_UP));
				}
				if (tmp.doubleValue() > 0
						&& tmp.abs().doubleValue() > 0.0000000001) {
					tmp1 = irr;
					irr = irr.add(tmp2).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				if (tmp.doubleValue() < 0
						&& tmp.abs().doubleValue() > 0.0000000001) {
					tmp2 = irr;
					irr = irr.add(tmp1).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				j++;
			}
			irr = irr.multiply(new BigDecimal(12));
			return irr.toString().equals("") ? "0" : irr.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}
	
	public String getIRR(String contract_id,String doc_id) throws Exception{
		String r_turn="";
		Conn db=new Conn();
		String lease_money="";
		String period_type="";
		String lease_interval="";
		List l_plan_date=new ArrayList();
		List l_rent=new ArrayList();
		String sqlstr="select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		ResultSet rs=db.executeQuery(sqlstr);
		if(rs.next()){
			lease_money=Tools.formatNumberDoubleTwo(Tools.getDBStr(rs.getString("lease_money")));
			period_type=Tools.getDBStr(rs.getString("period_type"));
			lease_interval=Tools.getDBStr(rs.getString("income_number_year"));
		}rs.close();
		sqlstr="select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' order by rent_list";
		rs=db.executeQuery(sqlstr);
		while(rs.next()){
			l_plan_date.add(Tools.getDBDateStr(rs.getString("plan_date")));
			l_rent.add(Tools.formatNumberDoubleTwo(Tools.getDBStr(rs.getString("rent"))));
		}rs.close();
		db.close();
		r_turn=getIRR(getCashFlow(l_plan_date,l_rent,period_type,lease_interval,lease_money));
		return r_turn;
	}

	public static void main(String[] args) {
		Irr irr = new Irr();
		List list = new ArrayList();
		List list1 = new ArrayList();
		list.add("2009-01-02");
		list.add("2009-01-05");
		list.add("2009-01-07");
		list.add("2009-02-03");
		list.add("2009-02-06");
		list.add("2009-07-03");
		list.add("2009-08-06");
		for (int i = 0; i < list.size(); i++) {
			list1.add("10");
		}
		String period_type="0";
		String lease_money="50";
		String lease_interval="1";
		List list2=irr.getCashFlow(list, list1, period_type, lease_interval, lease_money);
		String i_rr=irr.getIRR(list2);

		System.out.println(i_rr);
	}
}
