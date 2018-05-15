package com.rent;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

public class Rent {
	private String year_rate;// 租赁年利率

	private String income_number;// 租期

	private String lease_money;// 本金现值

	private String future_money;// 本金未来值

	private String period_type;// 期前/期后

	private String lease_interval;// 租赁间隔

	private String plan_date;// 放款日期

	private HashMap hm = new HashMap();

	public Rent() {

	}

	public Rent(String year_rate, String income_number, String lease_money,
			String future_money, String period_type, String lease_interval,
			String plan_date) {
		this.year_rate = year_rate;
		this.income_number = income_number;
		this.lease_money = lease_money;
		this.future_money = future_money;
		this.period_type = period_type;
		this.lease_interval = lease_interval;
		this.plan_date = plan_date;
	}

	// pmt公式--等额租金
	public String getRent() {
		String rent = "-1";
		String rate = "";
		if (null != year_rate && !"".equals(year_rate) && null != income_number
				&& !"".equals(income_number) && null != lease_money
				&& !"".equals(lease_money) && null != future_money
				&& !"".equals(future_money) && null != period_type
				&& !"".equals(period_type) && null != lease_interval
				&& !"".equals(lease_interval)) {
			rate = String.valueOf(Double.parseDouble(year_rate) / 12 / 100
					* Integer.parseInt(lease_interval));
			if (period_type.equals("1")) {// 等额租金先付
				rent = String.valueOf(Double.parseDouble(rate)
						* Math.pow(1 + Double.parseDouble(rate), Integer
								.parseInt(income_number) - 1)
						* (Double.parseDouble(lease_money) - Double
								.parseDouble(future_money))
						/ (Math.pow(1 + Double.parseDouble(rate), Integer
								.parseInt(income_number)) - 1)
						+ Double.parseDouble(future_money)
						* Double.parseDouble(rate));
			}
			if (period_type.equals("0")) {// 等额租金后付
				rent = String.valueOf(Double.parseDouble(rate)
						* Math.pow(1 + Double.parseDouble(rate), Integer
								.parseInt(income_number))
						* (Double.parseDouble(lease_money) - Double
								.parseDouble(future_money))
						/ (Math.pow(1 + Double.parseDouble(rate), Integer
								.parseInt(income_number)) - 1)
						+ Double.parseDouble(future_money)
						* Double.parseDouble(rate));
			}
		}
		rent = Tools.formatNumberDoubleZero(rent);
		return rent;
	}

	// 由租金,本金总额,年利率,放款日期求出每期本金,利息,偿还日期,剩余租金,剩余本金,剩余利息
	public HashMap getPlan() {
		String rent = this.getRent();
		if (!rent.equals("-1")) {
			List l_rent = new ArrayList();
			List l_corpus = new ArrayList();
			List l_interest = new ArrayList();
			List l_rent_overage = new ArrayList();
			List l_corpus_overage = new ArrayList();
			List l_interest_overage = new ArrayList();
			List l_plan_date = new ArrayList();
			rent = Tools.formatNumberDoubleTwo(rent);
			String corpus;
			String interest;
			String rent_overage;
			String corpus_overage;
			String interest_overage;

			rent_overage = String.valueOf(Double.parseDouble(rent)
					* Integer.parseInt(income_number));
			rent_overage = Tools.formatNumberDoubleTwo(rent_overage);
			corpus_overage = Tools.formatNumberDoubleTwo(lease_money);
			interest_overage = String.valueOf(Double.parseDouble(rent_overage)
					- Double.parseDouble(corpus_overage));
			interest_overage = Tools.formatNumberDoubleTwo(interest_overage);
			//间隔利率
			String rate = String.valueOf(Double.parseDouble(year_rate) / 12
					/ 100 * Integer.parseInt(lease_interval));
			//如果是期末则第一期租金日期=放款日期+间隔月数
			String start_date = plan_date;
			if (period_type.equals("0")) {
				start_date = Tools.dateAdd("month", Integer
						.parseInt(lease_interval), plan_date);
			}
			//如果是期前则第一期的利息=0,租金=本金
			for (int i = 0; i < Integer.parseInt(income_number); i++) {
				if (period_type.equals("1") && i == 0) {
					corpus = rent;
					interest = "0";
				} else {
					interest = String.valueOf(Double
							.parseDouble(corpus_overage)
							* Double.parseDouble(rate));
					interest = Tools.formatNumberDoubleTwo(interest);
					corpus = String.valueOf(Double.parseDouble(rent)
							- Double.parseDouble(interest));
					corpus = Tools.formatNumberDoubleTwo(corpus);
				}
				//最后一期的利息=剩余的利息总合,本金仍然=租金-利息
				if (i == Integer.parseInt(income_number) - 1) {
					interest = interest_overage;
					corpus = String.valueOf(Double.parseDouble(rent)
							- Double.parseDouble(interest));
					corpus = Tools.formatNumberDoubleTwo(corpus);
				}
				rent_overage = String.valueOf(Double.parseDouble(rent_overage)
						- Double.parseDouble(rent));
				rent_overage = Tools.formatNumberDoubleTwo(rent_overage);
				corpus_overage = String.valueOf(Double
						.parseDouble(corpus_overage)
						- Double.parseDouble(corpus));
				corpus_overage = Tools.formatNumberDoubleTwo(corpus_overage);
				interest_overage = String.valueOf(Double
						.parseDouble(interest_overage)
						- Double.parseDouble(interest));
				interest_overage = Tools
						.formatNumberDoubleTwo(interest_overage);
				l_rent.add(rent);
				l_corpus.add(corpus);
				l_interest.add(interest);
				l_rent_overage.add(rent_overage);
				l_corpus_overage.add(corpus_overage);
				l_interest_overage.add(interest_overage);
				l_plan_date.add(Tools.dateAdd("month", i*Integer.parseInt(lease_interval), start_date));
			}
			hm.put("rent", l_rent);
			hm.put("corpus", l_corpus);
			hm.put("interest", l_interest);
			hm.put("rent_overage", l_rent_overage);
			hm.put("corpus_overage", l_corpus_overage);
			hm.put("interest_overage", l_interest_overage);
			hm.put("plan_date", l_plan_date);

		}
		return this.hm;
	}

	public String getFuture_money() {
		return future_money;
	}

	public void setFuture_money(String future_money) {
		this.future_money = future_money;
	}

	public HashMap getHm() {
		return hm;
	}

	public void setHm(HashMap hm) {
		this.hm = hm;
	}

	public String getIncome_number() {
		return income_number;
	}

	public void setIncome_number(String income_number) {
		this.income_number = income_number;
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

	public String getPeriod_type() {
		return period_type;
	}

	public void setPeriod_type(String period_type) {
		this.period_type = period_type;
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
		Rent rent = new Rent();
		rent.setYear_rate("7.95");
		rent.setIncome_number("36");
		rent.setLease_money("489518.7");
		rent.setFuture_money("0");
		rent.setPeriod_type("0");

		rent.setLease_interval("1");
		rent.setPlan_date("2009-12-18");

		HashMap hm = rent.getPlan();
		List l_rent = (List) hm.get("rent");
		List l_corpus = (List) hm.get("corpus");
		List l_interest = (List) hm.get("interest");
		List l_corpus_overage = (List) hm.get("corpus_overage");
		List l_plan_date = (List) hm.get("plan_date");
		for (int i = 0; i < l_rent.size(); i++) {
			System.out.println("plan_date:" + l_plan_date.get(i) + "rent:" + l_rent.get(i) + "corpus:"
					+ l_corpus.get(i) + "interest:" + l_interest.get(i)
					+ "corpus_overage:" + l_corpus_overage.get(i));
		}
	}

}
