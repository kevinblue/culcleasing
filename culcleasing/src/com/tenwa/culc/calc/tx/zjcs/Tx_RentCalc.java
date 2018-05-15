package com.tenwa.culc.calc.tx.zjcs;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

/**
 * 规则租金测算
 * 
 * @author Administrator
 * 
 */
public class Tx_RentCalc {

	private String year_rate;// 租赁年利率

	private String income_number;// 租期

	private String lease_money;// 本金现值

	private String future_money;// 本金未来值

	private String period_type;// 期前/期后

	private String lease_interval;// 租赁间隔

	private String plan_date;// 放款日期

	private String irr_type;// irr测算类型1,为按月份的处;2,为按租金间隔的处理

	private String scale;// 精确到几位小数,irr
	
	private String rentScale = "2";// 精确到几位小数,租金的

	public Tx_RentCalc() {

	}

	public Tx_RentCalc(String year_rate, String income_number, String lease_money,
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

	public String getFuture_money() {
		return future_money;
	}

	public void setFuture_money(String future_money) {
		this.future_money = future_money;
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



	public String getIrr_type() {
		return irr_type;
	}

	public void setIrr_type(String irr_type) {
		this.irr_type = irr_type;
	}

	public String getScale() {
		return scale;
	}
	//2010-12-15 修改为14位
	public void setScale(String scale) {
		//this.scale = scale;
		this.scale = "14";
	}




	public String getRentScale() {
		return rentScale;
	}

	public void setRentScale(String rentScale) {
		this.rentScale = rentScale;
	}






	/**
	 * 用于计算每一期的租金
	 * 
	 * @param Rate
	 * @param Nper
	 * @param Pv
	 * @param Fv
	 * @param Type
	 * @return
	 */
	public String getPMT(String Rate, String Nper, String Pv, String Fv,
			String Type) {

		// 参数说明：Pv=现值，Nper=期数，Rate=利率(注意同期数周期一致，且要求已经包括百分号的数值！如0.05)
		// Fv=未来值，Type=数字 1或 0，用以指定各期的付款时间是在期初还是期末
		Rate = Rate.equals("") ? "0" : Rate;
		Nper = Nper.equals("") ? "0" : Nper;
		Pv = Pv.equals("") ? "0" : Pv;
		Fv = Fv.equals("") ? "0" : Fv;
		Type = Type.equals("") ? "0" : Type;

		if (Double.parseDouble(Nper) == 0) {
			return "0";
		}
		if (Double.parseDouble(Rate) == 0) {
			// divide(xxxxx,2, BigDecimal.ROUND_HALF_EVEN)
			return ((new BigDecimal(Pv).add(new BigDecimal(Fv)).multiply(
					new BigDecimal("-1")).divide(new BigDecimal(Nper), 20,
					BigDecimal.ROUND_HALF_UP))).toString();
		}

		BigDecimal Pv_B = new BigDecimal(Pv);
		BigDecimal Rate_B = new BigDecimal(Rate);
		BigDecimal Fv_B = new BigDecimal(Fv);
		BigDecimal Type_B = new BigDecimal(Type);
		BigDecimal pmt_B = new BigDecimal("0");
		BigDecimal num1_B = new BigDecimal("1");
		BigDecimal numfu1_B = new BigDecimal("-1");
		int Nper_i = Integer.valueOf(Nper).intValue();
		try {
			pmt_B = numfu1_B.multiply(Rate_B).multiply(
					Pv_B.multiply((num1_B.add(Rate_B)).pow(Nper_i)).add(Fv_B))
					.divide(
							(num1_B.add(Rate_B.multiply(Type_B)))
									.multiply((num1_B.add(Rate_B)).pow(Nper_i)
											.subtract(num1_B)), 20,
							BigDecimal.ROUND_HALF_UP);
			return pmt_B.toString().equals("") ? "0" : pmt_B.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}

	/**
	 * 等额租金
	 * 
	 * @param p_year_rate
	 *            表测算年利率
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String p_year_rate) {

		String rent = "-1";
		String rate = "";
		rate = String.valueOf(Double.parseDouble(p_year_rate) / 12 / 100
				* Integer.parseInt(lease_interval));

		String lease_money_ = "";
		lease_money_ = this.lease_money;

		// 租赁本金存在负数是(调息或者是其他的测算时)
		if (this.lease_money.length() > 0 && this.lease_money.indexOf("-") > -1) {
			lease_money_ = this.lease_money.substring(1, this.lease_money
					.length());

		}
		rent = this.getPMT(rate, this.income_number, "-" + lease_money_,
				this.future_money, "0");

		// 租金的小数位保存
		rent = Tools.formatNumberDoubleScale(rent, Integer
				.parseInt(this.rentScale));

		List l_rent = new ArrayList();
		// 添加每一期的租金,根据总的期数得到所有的租信息
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}
		// 返回租金列表
		return l_rent;
	}

	/**
	 * 
	 * @param rentList
	 *            租金list
	 * @param leaseMoney
	 *            要测算的本金
	 * @param calRate
	 *            计算的利率 qzOrqm 期初还是期未
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm) {
		// 用于保留利息
		List interests = new ArrayList();
		String corpus_total = "0";
		// 该期的利息
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// 本金余额
		corpus_overage = Tools.formatNumberDoubleTwo(leaseMoney);

		for (int i = 0; i < rentList.size(); i++) {// 循环租金list

				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = Tools.formatNumberDoubleTwo(inte);
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息+资产余值
				corpus = Tools.formatNumberDoubleTwo(corpus);


			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {
				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleTwo(corpus);
				System.out.println();
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus)+Double.parseDouble(this.future_money));
				inte = Tools.formatNumberDoubleTwo(inte);

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleTwo(corpus_total);

			// 本金余额
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleTwo(corpus_overage);
			// 添加list
			interests.add(inte);

		}

		return interests;
	}

	/**
	 * 
	 * @param rentList
	 *            租金 list
	 * @param inteList
	 *            利息list
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public List getCorpusList(List rentList, List inteList) {
		List corpus_list = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			corpus_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double
					.parseDouble(rentList.get(i).toString())
					- Double.parseDouble(inteList.get(i).toString()))));
		}
		return corpus_list;
	}

	/**
	 * 
	 * @param leaseMoney总的本金
	 * @param corpusList
	 *            每一期的本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusOvergeList(String leaseMoney, List corpusList) {
		String total = "0";// 累积每一期的本金
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleTwo(total);

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			corps.add(Tools.formatNumberDoubleTwo(String.valueOf(d)));

		}
		return corps;
	}


	public String getNewDate(String start_date, String day) {

		// 根据年月得到他的最后一天
		String year = start_date.substring(0, start_date.indexOf("-"));
		String month = start_date.substring(start_date.indexOf("-") + 1,
				start_date.lastIndexOf("-"));
		String lastDay = Tools.getLastDayOfMonth(year, month);
		String u_day = "";

		u_day = day;
		if (Integer.parseInt(lastDay) <= Integer.parseInt(day)) {
			u_day = lastDay;
		}

		return year + "-" + month + "-" + u_day;
	}

	/**
	 * 等额本金,得到每一期的本金
	 * 
	 * 
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List eqCorpusList() {

		String corpu = "";

		// 得到每期的本金,总的本金/期限
		corpu = String.valueOf((Double.parseDouble(this.lease_money)-Double.parseDouble(this.future_money))
				/ Integer.parseInt(this.income_number));
		corpu = Tools.formatNumberDoubleTwo(corpu);

		System.out.println("每一期的本金:"+this.lease_money+"//"+this.income_number+"=" + corpu);
		String total = "0";// 用于积累前面的本金和

		// 用于保存本金
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			// 最后一期是要作特别的处理

			if (i == Integer.parseInt(this.income_number) - 1) {
				double d = Double.parseDouble(this.lease_money)
						- Double.parseDouble(total);
				l_corpus.add(Tools.formatNumberDoubleTwo(String.valueOf(d)));
			} else {
				l_corpus.add(corpu);
				total = String.valueOf(Double.parseDouble(total)
						+ Double.parseDouble(corpu));
				total = Tools.formatNumberDoubleScale(total, 2);
			}

		}

		return l_corpus;

	}

	/**
	 * 等额本金的利息列表
	 * 
	 * @param l_corpus
	 *            本金list
	 * @param cal_rate
	 *            计算的利率
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestByEqCorpus(List l_corpus_over, String cal_rate,
			List l_corpus_pre) {

		// 用于保存利息列表
		List l_inte = new ArrayList();
		for (int i = 0; i < l_corpus_over.size(); i++) {

			String t = String.valueOf((Double.parseDouble(l_corpus_over.get(i)
					.toString()) + Double.parseDouble(l_corpus_pre.get(i)
					.toString()))
					* Double.parseDouble(cal_rate));
			t = Tools.formatNumberDoubleScale(t, 2);
			if(i == l_corpus_over.size()-1){//处理最后一期的利息，如果剩作本金不为0
				t = String.valueOf((Double.parseDouble(t)-(Double.parseDouble(this.lease_money)-
						Double.parseDouble(l_corpus_pre.get(1).toString())*l_corpus_over.size())+
						Double.parseDouble(l_corpus_over.get(i).toString())));
				t = Tools.formatNumberDoubleScale(t, 2);
			}
			l_inte.add(t);
		}
		return l_inte;
	}

	/**
	 * 等额本金的租金列表
	 * 
	 * @param l_corpus
	 *            本金列表
	 * @param l_inte
	 *            利息列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentByEqCorpus(List l_corpus, List l_inte) {
		// 用于保存租金
		List l_rent = new ArrayList();
		for (int i = 0; i < l_corpus.size(); i++) {
			String r = String.valueOf(Double.parseDouble(l_corpus.get(i)
					.toString())
					+ Double.parseDouble(l_inte.get(i).toString()));
			r = Tools.formatNumberDoubleScale(r, Integer
					.parseInt(this.rentScale));

//			if (i == 0 && "1".equals(this.period_type)) {
//				r = l_corpus.get(i).toString();
//			}
			l_rent.add(r);
		}
		return l_rent;
	}
	/**
	 * 
	 * @param type
	 *            1，等额租金，2，等额本金
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap getHashRentPlan(String type, List rent_list)
			throws Exception {

		if ("1".equals(type)) {
			// 由于友联的利息是根据内涵率来算的所以rate重新赋值,计算利息时irr/（12/租金间隔）
//			String rate = String.valueOf(Double.parseDouble(this.getIrr(
//					this.irr_type, rent_list, l_plan_date))
//					/ (12 / Integer.parseInt(this.lease_interval)));
			System.out.println("测算前-----------------");
			String rate = String.valueOf(Double.parseDouble(this.year_rate)/100/( 12/Integer.parseInt(lease_interval)));
			System.out.println("利率（测算时1）" + rate);
			rate = Tools.formatNumberDoubleScale(rate, Integer
					.parseInt(this.scale));
			System.out.println("利率（测算时）" + rate);
			return this.getPlanByEqRent(rate, rent_list);
		} else {// 等额本金时还要计算irr
			HashMap hmp = this.getPlanByEqCorpus();
			return hmp;
		}
	}

	/**
	 * 等额租金时
	 * 
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public HashMap getPlanByEqRent(String p_year_rate, List rent_c_list) {
		HashMap hm = new HashMap();
		// 由于租金是根据年利率算出的，不用提供的irr来算所以这里手动设置他的年利率
		// 由可能是不规则测算
		List l_rent = rent_c_list;

		List l_inte = this.getInterestList(l_rent, this.lease_money,
				p_year_rate, this.period_type);
		List l_corpus = this.getCorpusList(l_rent, l_inte);
		List l_corpus_overage = this.getCorpusOvergeList(this.lease_money,
				l_corpus);

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);

		return hm;

	}

	/**
	 * 等额本金时
	 * 
	 * @return
	 * @throws Exception
	 */
	// 由租金,本金总额,年利率,放款日期求出每期本金,利息,偿还日期,剩余租金,剩余本金,剩余利息
	@SuppressWarnings("unchecked")
	public HashMap getPlanByEqCorpus() throws Exception {
		HashMap hm = new HashMap();

		List l_corpus = this.eqCorpusList();// 本金
		String c_rate = String.valueOf(Double.parseDouble(this.year_rate) / 12
				/ 100 * Integer.parseInt(lease_interval));// 利率
		List l_corpus_overage = this.getCorpusOvergeList(this.lease_money,
				l_corpus);// 本金余额

		List l_inte = this.getInterestByEqCorpus(l_corpus_overage, c_rate,
				l_corpus);// 利息

		List l_rent = this.getRentByEqCorpus(l_corpus, l_inte);// 租金

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);


		return hm;
	}




}
