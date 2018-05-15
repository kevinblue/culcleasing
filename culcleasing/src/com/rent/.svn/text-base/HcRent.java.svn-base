package com.rent;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import com.*;

public class HcRent {
	private String year_rate;// 租赁年利率

	private String income_number;// 租期

	private String lease_money;// 本金现值

	private String lease_interval;// 租赁间隔

	private String period_type;

	private String plan_date;// 放款日期

	private List l_adjust;// 调整值

	private HashMap hm = new HashMap();

	public HcRent() {

	}

	public HcRent(String year_rate, String income_number, String lease_money,
			String lease_interval, String plan_date, String period_type,List l_adjust) {
		this.year_rate = year_rate;
		this.income_number = income_number;
		this.lease_money = lease_money;
		this.lease_interval = lease_interval;
		this.plan_date = plan_date;
		this.period_type = period_type;
		this.l_adjust = l_adjust;
	}

	public List getRent() {
		String rent;
		List l_rent = new ArrayList();
		String pv_str;
		String pvf_str;
		List pv = new ArrayList();
		List pvf = new ArrayList();
		for (int i = 0; i < this.l_adjust.size(); i++) {
			String adjust = (String) this.l_adjust.get(i);
			if (adjust.equals("")) {
				pv_str = "";
				pvf_str = String.valueOf(1 / Math.pow(1 + Double
						.parseDouble(year_rate) / 100 / 12, Double
						.valueOf(i + 1)));
			} else {
				pv_str = String.valueOf(Double.parseDouble(adjust)
						/ Math.pow(
								1 + Double.parseDouble(year_rate) / 100 / 12,
								Double.valueOf(i + 1)));
				pvf_str = "";
			}
			pv.add(pv_str);
			pvf.add(pvf_str);
		}
		pv_str = Tools.getSumList(pv);
		pvf_str = Tools.getSumList(pvf);
		rent = String.valueOf((Double.parseDouble(lease_money) - Double
				.parseDouble(pv_str))
				/ Double.parseDouble(pvf_str));
		rent = Tools.formatNumberDoubleZero(rent);
		for (int i = 0; i < this.l_adjust.size(); i++) {
			String adjust = (String) this.l_adjust.get(i);
			
			if (adjust.equals("")) {
				l_rent.add(rent);
			} else {
				l_rent.add(adjust);
			}
		}
		return l_rent;
	}

	// 由租金,本金总额,年利率,放款日期求出每期本金,利息,偿还日期,剩余租金,剩余本金,剩余利息
	public HashMap getPlan() {
		List l_rent = this.getRent();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_rent_overage = new ArrayList();
		List l_corpus_overage = new ArrayList();
		List l_interest_overage = new ArrayList();
		List l_plan_date = new ArrayList();
		String rent;
		String corpus;
		String interest;
		String rent_overage;
		String corpus_overage;
		String interest_overage;

		rent_overage = Tools.getSumList(l_rent);
		rent_overage = Tools.formatNumberDoubleTwo(rent_overage);
		corpus_overage = Tools.formatNumberDoubleTwo(lease_money);
		interest_overage = String.valueOf(Double.parseDouble(rent_overage)
				- Double.parseDouble(corpus_overage));
		interest_overage = Tools.formatNumberDoubleTwo(interest_overage);
		String rate = String.valueOf(Double.parseDouble(year_rate) / 12 / 100
				* Integer.parseInt(lease_interval));
		String start_date = plan_date;
		if (period_type.equals("0")) {
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), plan_date);
		}
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			rent = (String) l_rent.get(i);
			if (period_type.equals("1") && i == 0) {
				corpus = rent;
				interest = "0";
			} else {
				interest = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(rate));
				interest = Tools.formatNumberDoubleTwo(interest);
				corpus = String.valueOf(Double.parseDouble(rent)
						- Double.parseDouble(interest));
				corpus = Tools.formatNumberDoubleTwo(corpus);
			}
			if (i == Integer.parseInt(income_number) - 1) {
				interest = interest_overage;
				corpus = String.valueOf(Double.parseDouble(rent)
						- Double.parseDouble(interest));
				corpus = Tools.formatNumberDoubleTwo(corpus);
			}
			rent_overage = String.valueOf(Double.parseDouble(rent_overage)
					- Double.parseDouble(rent));
			rent_overage = Tools.formatNumberDoubleTwo(rent_overage);
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleTwo(corpus_overage);
			interest_overage = String.valueOf(Double
					.parseDouble(interest_overage)
					- Double.parseDouble(interest));
			interest_overage = Tools.formatNumberDoubleTwo(interest_overage);
			l_corpus.add(corpus);
			l_interest.add(interest);
			l_rent_overage.add(rent_overage);
			l_corpus_overage.add(corpus_overage);
			l_interest_overage.add(interest_overage);
			l_plan_date.add(Tools.dateAdd("month" , i*Integer.parseInt(lease_interval),start_date ));
		}
		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_interest);
		hm.put("rent_overage", l_rent_overage);
		hm.put("corpus_overage", l_corpus_overage);
		hm.put("interest_overage", l_interest_overage);
		hm.put("plan_date", l_plan_date);

		return this.hm;
	}

	public String getIncome_number() {
		return income_number;
	}

	public void setIncome_number(String income_number) {
		this.income_number = income_number;
	}

	public List getL_adjust() {
		return l_adjust;
	}

	public void setL_adjust(List l_adjust) {
		this.l_adjust = l_adjust;
	}

	public String getLease_interval() {
		return lease_interval;
	}

	public void setLease_interval(String lease_interval) {
		this.lease_interval = lease_interval;
	}

	public String getLease_money() {
		return lease_money;
	}

	public void setLease_money(String lease_money) {
		this.lease_money = lease_money;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getYear_rate() {
		return year_rate;
	}

	public void setYear_rate(String year_rate) {
		this.year_rate = year_rate;
	}

	public static void main(String[] args) {
		HcRent hr = new HcRent();
		hr.setIncome_number("12");
		hr.setLease_interval("3");
		hr.setLease_money("489518.7");
		hr.setPlan_date("2009-12-18");
		hr.setYear_rate("7.95");
		List list = new ArrayList();

		for (int i = 0; i < 12; i++) {
			if (i == 5) {
				list.add("");
			} else if(i==0){
				list.add("40000");
			}else {
				list.add("");
			}
		}

		hr.setL_adjust(list);
		HashMap hm = hr.getPlan();
		List l_rent = (List) hm.get("rent");
		List l_corpus = (List) hm.get("corpus");
		List l_interest = (List) hm.get("interest");
		List l_corpus_overage = (List) hm.get("corpus_overage");
		
		for (int i = 0; i < l_rent.size(); i++) {
			System.out.println("rent:" + l_rent.get(i) + "corpus:"
					+ l_corpus.get(i) + "interest:" + l_interest.get(i)
					+ "corpus_overage:" + l_corpus_overage.get(i));
		}
	}
}
