package com.rent.calc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

import dbconn.Conn;

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

	private List l_adjust;// 调整值

	private List preCash = new ArrayList();// 前期资金流

	private List preDate = new ArrayList();// 前期的资金时间

	private List afterCash = new ArrayList();// 后期资金流

	private List afterDate = new ArrayList();// 后期的资金时间

	private String irr_type;// irr测算类型1,为按月份的处;2,为按租金间隔的处理

	private String scale;// 精确到几位小数,irr
	private String rentScale="0";// 精确到几位小数,租金的

	private String v_irr;// irr的值,默认的为财务的irr
	private String market_irr;// 市场irr的值
	
	private String cle_cau_Money;//净融资额+保证金,用于剩余本金的计算
	private String cauti_Money;//保证金用于保证金抵扣租金的计算

	private String contract_id;// 合同号,用于现金流的统计
	


	private HashMap hm = new HashMap();

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

	public List getAfterCash() {
		return afterCash;
	}

	public void setAfterCash(List afterCash) {
		this.afterCash = afterCash;
	}

	public List getAfterDate() {
		return afterDate;
	}

	public void setAfterDate(List afterDate) {
		this.afterDate = afterDate;
	}

	public List getPreCash() {
		return preCash;
	}

	public void setPreCash(List preCash) {
		this.preCash = preCash;
	}

	public List getPreDate() {
		return preDate;
	}

	public void setPreDate(List preDate) {
		this.preDate = preDate;
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

	public void setScale(String scale) {
		this.scale = scale;
	}

	public String getV_irr() {
		return v_irr;
	}

	public void setV_irr(String v_irr) {
		this.v_irr = v_irr;
	}

	/**
	 * 得到调整后的租金list
	 * 
	 * @return
	 */
	public List getNoStanRent() {

		return null;
	}

	public List getL_adjust() {
		return l_adjust;
	}

	public void setL_adjust(List l_adjust) {
		this.l_adjust = l_adjust;
	}

	/**
	 * 得到第一期的日期
	 * 
	 */
	public String getFirstDate(String type) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = plan_date;
		if (type.equals("0")) {
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), plan_date);
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
		BigDecimal Pv_B = new BigDecimal(Pv);
		BigDecimal Nper_B = new BigDecimal(Nper);
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
	public List eqRentList(String p_year_rate) {

		String rent = "-1";
		String rate = "";
		rate = String.valueOf(Double.parseDouble(p_year_rate) / 12 / 100
				* Integer.parseInt(lease_interval));
		
		String lease_money_="";
		lease_money_=this.lease_money;
		
		if (this.lease_money.length()>0 && this.lease_money.indexOf("-")>-1) {
			lease_money_ = this.lease_money.substring(1,this.lease_money.length());
			
		}
		rent = this.getPMT(rate, this.income_number, "-" + lease_money_,
				this.future_money, this.period_type);

		//租金的小数位保存
		rent = Tools.formatNumberDoubleScale(rent, Integer.parseInt(this.rentScale));
		
		
		List l_rent = new ArrayList();
		// 添加每一期的租金
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
						- Double.parseDouble(inte));// 租金-利息
				corpus = Tools.formatNumberDoubleTwo(corpus);

			}

			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {

				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleTwo(corpus);

				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
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

	public List getCorpusList(List rentList, List inteList) {
		List corpus_list = new ArrayList();
		String total = "0";
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
	public List getPlanDateList(List rentList, String perType) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = this.getFirstDate(perType);
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			l_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date));
		}

		return l_date;
	}

	/**
	 * 等额本金,得到每一期的本金
	 * 
	 * 
	 * 
	 */
	public List eqCorpusList() {

		String corpu = "";

		// 得到每期的本金,总的本金/期限
		corpu = String.valueOf(Double.parseDouble(this.lease_money)
				/ Integer.parseInt(this.income_number));
		corpu = Tools.formatNumberDoubleTwo(corpu);

		System.out.println("每一期的本金:" + corpu);
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
	public List getRentByEqCorpus(List l_corpus, List l_inte) {
		// 用于保存租金
		List l_rent = new ArrayList();
		for (int i = 0; i < l_corpus.size(); i++) {
			String r = String.valueOf(Double.parseDouble(l_corpus.get(i)
					.toString())
					+ Double.parseDouble(l_inte.get(i).toString()));
			r = Tools.formatNumberDoubleTwo(r);

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
	public String getIrr(String type, List rent_list, List l_plan_date) throws Exception {
		IrrCal irr = new IrrCal();

		String i_rr = "";

		// 计算前期的资金流
		irr.getPreCashFlow(preDate, preCash);

		// 得到租金list
		// List rent_list = this.eqRentList(this.year_rate);
		// List l_plan_date = this.getPlanDateList(rent_list,
		// this.period_type);// 计划时间

		if ("1".equals(type)) {// 每月计算

			// 租金
			irr.getPreMonthCash(rent_list, l_plan_date);
			// 后期的租金流
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// 时间，资金流的处理类
			irr.getUniqueByDate();

//			 添加现金流记录
		///	this.insertCashFlow(irr.getCashList(), irr.getDateList());

			
			// 安每月时
			i_rr = irr.getIRR(irr.getCashList(), "1", "1", "12");
			System.out.println("irr:" + i_rr);

		} else {// 否则按原来的租金间隔来算

			// 租金
			irr.getRentCashFlow(l_plan_date, rent_list);
			// 后期的租金流
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// 时间，资金流的处理类
			irr.getUniqueByDate();
//			 添加现金流记录
		///	this.insertCashFlow(irr.getCashList(), irr.getDateList());

			i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
					this.lease_interval, String.valueOf(Integer
							.parseInt(this.income_number)
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
	 * 
	 * @param type
	 *            1，等额租金，2，等额本金
	 * @return
	 * @throws Exception 
	 */
	public HashMap getHashRentPlan(String type, List rent_list, List l_plan_date) throws Exception {

		if ("1".equals(type)) {

			// 由于友联的利息是根据内涵率来算的所以rate重新赋值,计算利息时irr/（12/租金间隔）
			String rate = String.valueOf(Double.parseDouble(this.getIrr(
					this.irr_type, rent_list, l_plan_date))
					/ (12 / Integer.parseInt(this.lease_interval)));
			rate = Tools.formatNumberDoubleScale(rate, Integer
					.parseInt(this.scale));

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

	public HashMap getPlanByEqRent(String p_year_rate, List rent_c_list) {
		HashMap hm = new HashMap();
		// 由于租金是根据年利率算出的，不用提供的irr来算所以这里手动设置他的年利率
		// List l_rent = this.eqRentList(this.year_rate);
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

		List l_plan_dt = this.getPlanDateList(l_rent, this.period_type);// 计划时间

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);
		hm.put("plan_date", l_plan_dt);

		// 算irr
		IrrCal irr = new IrrCal();
		// 计算前期的资金流
		irr.getPreCashFlow(preDate, preCash);
		// 租金
		irr.getRentCashFlow(l_plan_dt, l_rent);
		// 后期的租金流
		irr.getRentAfterCashFlow(afterDate, afterCash);
		// 时间，资金流的处理类
		irr.getUniqueByDate();

		// 添加现金流记录
		//this.insertCashFlow(irr.getCashList(), irr.getDateList());

		String i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
				this.lease_interval, String.valueOf(Integer
						.parseInt(this.income_number)
						/ Integer.parseInt(this.lease_interval)));
		System.out.println(i_rr);

		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
		System.out.println("irr===:" + i_rr);
		this.v_irr = i_rr;

		return hm;
	}

	/**
	 * 测试
	 * 
	 * @param args
	 * @throws Exception 
	 */

	public static void main(String[] args) throws Exception {
		RentCalc rent = new RentCalc();
		rent.setYear_rate("7.95");
		rent.setIncome_number("12");
		rent.setLease_money("10000000");
		rent.setFuture_money("0");
		rent.setPeriod_type("1");// 期初还是期未
		rent.setIrr_type("2");// 1，为按月份来计算irr,2为租金间隔来处理
		rent.setScale("8");// 设置irr计算时的精度
		rent.setLease_interval("3");
		rent.setPlan_date("2009-12-18");

		List l_rent_1 = new ArrayList();
		List l_plane = new ArrayList();
		// 设置前期付款额,租赁公司付出的为-，收入的为+,包括，手续费，设备款，保证金等
		// 在租金变更时可以放调整前的租金列表
		l_rent_1.add("-10000000");
		l_plane.add("2009-11-18");
		rent.setPreCash(l_rent_1);
		rent.setPreDate(l_plane);

		// 得到租金list,注意不规则时的租金list
		List rent_list = rent.eqRentList(rent.year_rate);// 规则时
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.period_type);// 计划时间

		// 1，等额租金，2，等额本金,等额本金时rent_list,l_plan_date_,可以传一个空过去
		HashMap hm = rent.getHashRentPlan("1", rent_list, l_plan_date_);
		System.out.println("irr:" + rent.getV_irr());

		List l_rent = (List) hm.get("rent");
		List l_corpus = (List) hm.get("corpus");
		List l_interest = (List) hm.get("interest");
		List l_corpus_overage = (List) hm.get("corpus_overage");
		List l_plan_date = (List) hm.get("plan_date");
		for (int i = 0; i < l_rent.size(); i++) {
			System.out.println("plan_date:  " + l_plan_date.get(i)
					+ "\t rent:  " + l_rent.get(i) + " \t corpus: "
					+ l_corpus.get(i) + " \t interest:  " + l_interest.get(i)
					+ " \t corpus_overage:  " + l_corpus_overage.get(i));
		}

	}

	public String getContract_id() {
		return contract_id;
	}

	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}

	/**
	 * 用于添加计算irr的现金流
	 * 
	 * @param cashs
	 *            现金流
	 * @param dates
	 *            所对应的计算时间
	 * @throws Exception
	 */
	public void insertCashFlow(List cashs, List dates) throws Exception {
		String sql = "";
		for (int i = 0; i < cashs.size(); i++) {
			sql += "  insert into fund_contract_plan (contract_id,plan_date,net_flow,create_date) select '"
					+ this.contract_id
					+ "','"
					+ dates.get(i).toString()
					+ "','" + cashs.get(i).toString() + "',getdate()   ";
		}
		Conn conn = new Conn();
		conn.executeUpdate(sql);
		conn.close();

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


}
