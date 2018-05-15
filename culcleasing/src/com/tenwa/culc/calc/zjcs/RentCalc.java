package com.tenwa.culc.calc.zjcs;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * 规则租金测算
 * 
 * @author Administrator
 * 
 */
public class RentCalc {

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

	private String v_irr;// irr的值,默认的为财务的irr
	private String market_irr = "0";// 市场irr的值

	private String cle_cau_Money;// 净融资额+保证金,用于剩余本金的计算
	private String cauti_Money;// 保证金用于保证金抵扣租金的计算

	private String contract_id;// 合同号,用于现金流的统计

	private String start_date;// 起租日期


	public RentCalc() {

	}

	public RentCalc(String year_rate, String income_number, String lease_money,
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

	public String getV_irr() {
		return v_irr;
	}

	public void setV_irr(String v_irr) {
		this.v_irr = v_irr;
	}


	public String getContract_id() {
		return contract_id;
	}

	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}

	public String getRentScale() {
		return rentScale;
	}

	public void setRentScale(String rentScale) {
		this.rentScale = rentScale;
	}

	public String getMarket_irr() {
		return market_irr;
	}

	public void setMarket_irr(String market_irr) {
		this.market_irr = market_irr;
	}

	public String getCle_cau_Money() {
		return cle_cau_Money;
	}

	public void setCle_cau_Money(String cle_cau_Money) {
		this.cle_cau_Money = cle_cau_Money;
	}

	public String getCauti_Money() {
		return cauti_Money;
	}

	public void setCauti_Money(String cauti_Money) {
		this.cauti_Money = cauti_Money;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	/**
	 * 得到第一期的日期
	 * 
	 */
	public String getFirstDate(String type) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = plan_date;
		String day = "";
		if (start_date.indexOf("-") > -1) {// 得到日
			day = start_date.substring(start_date.lastIndexOf("-") + 1,
					start_date.length());
		}

		if (type.equals("0")) {
			start_date = getNewDate(start_date, day);
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("第一期时间:" + start_date);
		return start_date;
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
				this.future_money, this.period_type);

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

			if ("1".equals(qzOrqm) && i == 0) {// 第一期且是期初时
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = Tools.formatNumberDoubleTwo(inte);
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息+资产余值
				corpus = Tools.formatNumberDoubleTwo(corpus);

			}

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

	/**
	 * 
	 * @param rentList
	 *            租金 list
	 * @param perType
	 *            期初还是期未
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getPlanDateList(List rentList, String perType) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = this.getFirstDate(perType);
		String day = "";
		if (start_date.indexOf("-") > -1) {// 得到日
			day = this.getPlan_date().substring(
					this.getPlan_date().lastIndexOf("-") + 1,
					this.getPlan_date().length());
		}
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date);
			addDate = getNewDate(addDate, day);

			l_date.add(addDate);
		}

		return l_date;
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
		corpu = String.valueOf(Double.parseDouble(this.cle_cau_Money)
				/ Integer.parseInt(this.income_number));
		corpu = Tools.formatNumberDoubleTwo(corpu);

		System.out.println("每一期的本金:"+this.cle_cau_Money+"//"+this.income_number+"=" + corpu);
		String total = "0";// 用于积累前面的本金和

		// 用于保存本金
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			// 最后一期是要作特别的处理

			if (i == Integer.parseInt(this.income_number) - 1) {
				double d = Double.parseDouble(this.cle_cau_Money)
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
			if (i == 0 && "1".equals(this.period_type)) {
				t = "0";
			}else if(i == l_corpus_over.size()-1){//处理最后一期的利息，如果剩作本金不为0
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

			if (i == 0 && "1".equals(this.period_type)) {
				r = l_corpus.get(i).toString();
			}

			l_rent.add(r);
		}
		return l_rent;

	}

	/**
	 * 等额租金 起租赁内涵率 type 1,为按月份的处;2,为按租金间隔的处理
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getIrr(String type, List rent_list, List l_plan_date)
			throws Exception {

		// 调用市场irr'
		List rent_list_1 = new ArrayList();
		for (int i = 0; i < rent_list.size(); i++) {
			rent_list_1.add(rent_list.get(i));
		}

		List l_plan_date_1 = new ArrayList();
		for (int i = 0; i < l_plan_date.size(); i++) {
			l_plan_date_1.add(l_plan_date.get(i));
		}

		// 计算市场的irr
		this.getMarkIrr(type, rent_list_1, l_plan_date_1);

		// 计算财务的irr
		IrrCal irr = new IrrCal();
		String i_rr = "";
		// 计算前期的资金流
		
		if ("1".equals(type)) {// 每月计算

			// 租金
			irr.getPreMonthCash(rent_list, l_plan_date);
			// 后期的租金流
			// 时间，资金流的处理类
			irr.getUniqueByDate();

			// 安每月时
			i_rr = irr.getIRR(irr.getCashList(), "1", "1", "12");
			System.out.println("irr:" + i_rr);

		} else {// 否则按原来的租金间隔来算

			// 租金
			irr.getRentCashFlow(l_plan_date, rent_list);
			// 后期的租金流
			// 时间，资金流的处理类
			irr.getUniqueByDate();

			// 测试输出
			for (int i = 0; i < irr.getCashList().size(); i++) {
				System.out.println("cashRent:" + irr.getCashList().get(i));

			}

			i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
					this.lease_interval, String.valueOf(Integer.parseInt("12")
							/ Integer.parseInt(this.lease_interval)));
			System.out.println(i_rr);

		}

		
		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
		System.out.println("irr===:" + i_rr);
		
		this.v_irr = i_rr;
		return i_rr;
	}

	/**
	 * 得到保证金抵扣租金List
	 * 
	 * @param rent_list
	 *            租金List
	 * @param caut_money
	 *            保证金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentCautNew(List rent_list, String caut_money) {
		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// 用于记录下标的
		if (Double.parseDouble(caut_money) > 0) {
			for (int i = rent_list.size() - 1; i >= 0; i--) {
				d_total = d_total
						+ Double.parseDouble(rent_list.get(i).toString());
				int_s += i + ",";
				if (d_total > Double.parseDouble(caut_money)) {
					break;
				}
			}
			int_s = int_s.indexOf(",") > -1 ? int_s.substring(0,
					int_s.length() - 1) : int_s;// 得到可以抵扣的租金的下标
			String[] i_array = int_s.split(",");// 保存可以抵扣的租金下标
			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// 用于保存的租金
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					rent_list.set(Integer.parseInt(i_array[j]), "0");// 将保证金大于的租金设为0
				} else {
					rent_list.set(Integer.parseInt(i_array[j]), Double
							.parseDouble(rent_list.get(
									Integer.parseInt(i_array[j])).toString())
							- dcaut);
				}
				dcaut = dcaut - temp_rent;// 修改保证金抵扣的值
			}
		}
		return rent_list;
	}

	/**
	 * 等额租金 起租赁内涵率 type 1,为按月份的处;2,为按租金间隔的处理,得到市场irr
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getMarkIrr(String type, List rent_list, List l_plan_date)
			throws Exception {
		IrrCal irr = new IrrCal();
		String i_rr = "";

		// 添加保证金的前期款
		
		// 计算前期的资金流
		// 存在保证金抵扣的关系,得到保证金抵扣的租金list
		rent_list = getRentCautNew(rent_list, this.cauti_Money);

		if ("1".equals(type)) {// 每月计算

			// 租金
			irr.getPreMonthCash(rent_list, l_plan_date);
			// 后期的租金流
			// 时间，资金流的处理类
			irr.getUniqueByDate();
			// 安每月时
			i_rr = irr.getIRR(irr.getCashList(), "1", "1", "12");

		} else {// 否则按原来的租金间隔来算

			// 租金
			irr.getRentCashFlow(l_plan_date, rent_list);
			// 后期的租金流
			// 时间，资金流的处理类
			irr.getUniqueByDate();

			i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
					this.lease_interval, String.valueOf(Integer.parseInt("12")
							/ Integer.parseInt(this.lease_interval)));
			System.out.println(i_rr);

		}

		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
		this.market_irr = i_rr;
		return i_rr;
	}

	/**
	 * 
	 * @param type
	 *            1，等额租金，2，等额本金
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap getHashRentPlan(String type, List rent_list, List l_plan_date)
			throws Exception {

		if ("1".equals(type)) {
			// 由于友联的利息是根据内涵率来算的所以rate重新赋值,计算利息时irr/（12/租金间隔）
//			String rate = String.valueOf(Double.parseDouble(this.getIrr(
//					this.irr_type, rent_list, l_plan_date))
//					/ (12 / Integer.parseInt(this.lease_interval)));
			System.out.println("进入测算=====================");
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
		List l_plan_dt = this.getPlanDateList(l_rent, this.period_type);

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);
		hm.put("plan_date", l_plan_dt);

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

		// 用于计算irr时的租金list
		List l_rent_1 = new ArrayList();
		for (int i = 0; i < l_rent.size(); i++) {
			l_rent_1.add(l_rent.get(i));
		}

		List l_plan_dt = this.getPlanDateList(l_rent, this.period_type);// 计划时间

		// 计算irr时租金计划时间
		List l_plan_dt_1 = new ArrayList();
		for (int i = 0; i < l_plan_dt.size(); i++) {
			l_plan_dt_1.add(l_plan_dt.get(i));
		}

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);
		hm.put("plan_date", l_plan_dt);

		// 算irr
		IrrCal irr = new IrrCal();
		// 计算前期的资金流
		// 租金
		irr.getRentCashFlow(l_plan_dt, l_rent);
		// 后期的租金流
		// 时间，资金流的处理类
		irr.getUniqueByDate();

		String i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
				this.lease_interval, String.valueOf(Integer.parseInt("12")
						/ Integer.parseInt(this.lease_interval)));

		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
		System.out.println("irr===:" + i_rr);
		this.v_irr = i_rr;

//		// /===================================测算市场ir
//		// 得到新的租金list
//		l_rent_1 = this.getRentCautNew(l_rent_1, this.cauti_Money);
//
//		// 添加保证金的前期款
//		List preDate_1 = new ArrayList();
//		for (int i = 0; i < preDate.size(); i++) {
//			preDate_1.add(preDate.get(i));
//		}
//		preDate_1.add(this.start_date);
//
//		List preCash_1 = new ArrayList();
//		for (int i = 0; i < preCash.size(); i++) {
//			preCash_1.add(preCash.get(i));
//		}
//		preCash_1.add(this.cauti_Money);
//
//		// 计算前期的资金流
//		irr.getPreCashFlow(preDate_1, preCash_1);
//		// 租金
//		irr.getRentCashFlow(l_plan_dt_1, l_rent_1);
//		// 后期的租金流
//		irr.getRentAfterCashFlow(afterDate, afterCash);
//		// 时间，资金流的处理类
//		irr.getUniqueByDate();
//
//		i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
//				this.lease_interval, String.valueOf(Integer.parseInt("12")
//						/ Integer.parseInt(this.lease_interval)));
//		System.out.println(i_rr);
//
//		i_rr = Tools
//				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
//		System.out.println("Markirr===:" + i_rr);
//		this.market_irr = i_rr;

		return hm;
	}

	/**
	 * 得到irr
	 * 
	 * @param firstMoney
	 * @param rent_list
	 * @param lease_interval
	 * @param type
	 * @param grace
	 *            宽限期
	 * 
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public String getIrr(String firstMoney, List rent_list,String caution_money,String assets_value,
			String Other_expenditure,String lease_interval, String type) {
		
		//2011-05-11延迟期改延迟月修改
		
		List new_list = new ArrayList();
		int i = 0;
		if ("1".equals(type)) {// 先付时
			i++;
			new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double
					.parseDouble(firstMoney)
					+ Double.parseDouble(rent_list.get(0).toString()))));
		} else {
			new_list.add(Tools.formatNumberDoubleTwo(firstMoney));
		}

		// 2011-04－15注释
		// //先添加延迟的租金现金流
		// for (int j = 0; j < Integer.parseInt(delay); j++) {
		// new_list.add("0");
		// }

		// 2011-04－15添加不从宽限期开始算现金流irr
		//i=i+Integer.parseInt(grace);
		

		for (; i < rent_list.size(); i++) {
			if(i<(rent_list.size()-1)){
				new_list.add(rent_list.get(i));
			}else{//最后一期现金流考虑资产余值
				new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(rent_list.get(i).toString())-
						Double.parseDouble(caution_money)+Double.parseDouble(assets_value)+
						Double.parseDouble(Other_expenditure))));
			}
		}
//		for(int j=0;j<new_list.size();j++){
//			System.out.println("new_list="+new_list.get(j));
//		}
		IrrCal ic = new IrrCal();
		String irr = Tools.formatNumberDoubleScale(ic.getIRR(new_list,
				lease_interval, lease_interval, String.valueOf(12 / Integer
						.parseInt(lease_interval))), 4);
		return irr;
	}

	
	
	/**
	 * 得到保证金抵扣租金List 现金 流明细
	 * 
	 * @param rent_list
	 *            租金List
	 * @param caut_money
	 *            保证金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentDetails(List rent_list, String caut_money) {

		// 先构造正常情况下的租金 明细
		List cash_follow_detail = new ArrayList();

		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// 用于记录下标的
		if (Double.parseDouble(caut_money) > 0) {
			for (int i = rent_list.size() - 1; i >= 0; i--) {
				d_total = d_total
						+ Double.parseDouble(rent_list.get(i).toString());
				int_s += i + ",";
				if (d_total > Double.parseDouble(caut_money)) {
					break;
				}
			}
			int_s = int_s.indexOf(",") > -1 ? int_s.substring(0,
					int_s.length() - 1) : int_s;// 得到可以抵扣的租金的下标
			String[] i_array = int_s.split(",");// 保存可以抵扣的租金下标

			System.out.println("id_s:" + int_s);

			Hashtable ht = null;// 用于保持现金流的明细
			// /follow_in,follow_in_detail,follow_out,follow_out_detail
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "租金：" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// 用于保存的租金
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					// rent_list.set(Integer.parseInt(i_array[j]),
					// "0");//将保证金大于的租金设为0

					// 现金流明细处理
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(Integer.parseInt(i_array[j])).toString());
					ht.put("follow_in_detail", "租金："
							+ rent_list.get(Integer.parseInt(i_array[j])).toString());
					ht.put("follow_out", rent_list.get(Integer.parseInt(i_array[j])).toString());
					ht.put("follow_out_detail", "保证金抵扣："
							+ rent_list.get(Integer.parseInt(i_array[j])).toString());
					ht.put("net_follow", "0");

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				} else {
					// rent_list.set(Integer.parseInt(i_array[j]),
					// Double.parseDouble(rent_list.get(Integer.parseInt(i_array[j])).toString())-dcaut);

					// 现金流明细处理
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(Integer.parseInt(i_array[j])).toString());
					ht.put("follow_in_detail", "租金："
							+ rent_list.get(Integer.parseInt(i_array[j])).toString());
					ht.put("follow_out", dcaut);
					ht.put("follow_out_detail", "保证金抵扣：" + Tools.formatNumberDoubleTwo(String.valueOf(dcaut)));
					ht.put("net_follow", Double.parseDouble(rent_list.get(
							Integer.parseInt(i_array[j])).toString())
							- dcaut);

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				}
				dcaut = dcaut - temp_rent;// 修改保证金抵扣的值
			}
		} else {

			Hashtable ht = null;
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "租金：" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

		}
		return cash_follow_detail;
	}

	/**
	 * 得到 市场的租金计划的一些信息
	 * 
	 * @param p_year_rate
	 *            //每一期的利息
	 * @param rent_c_list
	 *            租金 list
	 * @param lease_money_p
	 *            所要测算的本金
	 * @param period_type_p
	 *            期初或期末
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public HashMap getPlanMarketByEqRent(String p_year_rate, List rent_c_list,
			String lease_money_p, String period_type_p) {
		HashMap hm = new HashMap();
		// 由于租金是根据年利率算出的，不用提供的irr来算所以这里手动设置他的年利率
		// 由可能是不规则测算
		List l_rent = rent_c_list;

		List l_inte = this.getInterestList(l_rent, lease_money_p, p_year_rate,
				period_type_p);
		List l_corpus = this.getCorpusList(l_rent, l_inte);
		List l_corpus_overage = this.getCorpusOvergeList(lease_money_p,
				l_corpus);

		hm.put("corpus_market", l_corpus);
		hm.put("interest_market", l_inte);
		hm.put("corpus_overage_market", l_corpus_overage);

		return hm;

	}




}
