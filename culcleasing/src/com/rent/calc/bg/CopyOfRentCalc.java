package com.rent.calc.bg;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * ����������
 * 
 * @author Administrator
 * 
 */
public class CopyOfRentCalc {

	private String year_rate;// ����������

	private String income_number;// ����

	private String lease_money;// ������ֵ

	private String future_money;// ����δ��ֵ

	private String period_type;// ��ǰ/�ں�

	private String lease_interval;// ���޼��

	private String plan_date;// �ſ�����

	private List l_adjust;// ����ֵ

	private List preCash = new ArrayList();// ǰ���ʽ���

	private List preDate = new ArrayList();// ǰ�ڵ��ʽ�ʱ��

	private List afterCash = new ArrayList();// �����ʽ���

	private List afterDate = new ArrayList();// ���ڵ��ʽ�ʱ��

	private String irr_type;// irr��������1,Ϊ���·ݵĴ�;2,Ϊ��������Ĵ���

	private String scale;// ��ȷ����λС��,irr
	private String rentScale = "2";// ��ȷ����λС��,����

	private String v_irr;// irr��ֵ,Ĭ�ϵ�Ϊ�����irr
	private String market_irr = "0";// �г�irr��ֵ

	private String cle_cau_Money;// �����ʶ�+��֤��,����ʣ�౾��ļ���
	private String cauti_Money;// ��֤�����ڱ�֤��ֿ����ļ���

	private String contract_id;// ��ͬ��,�����ֽ�����ͳ��

	private String start_date;// ��������

	private HashMap hm = new HashMap();

	public CopyOfRentCalc() {

	}

	public CopyOfRentCalc(String year_rate, String income_number, String lease_money,
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

	public List getL_adjust() {
		return l_adjust;
	}

	public void setL_adjust(List l_adjust) {
		this.l_adjust = l_adjust;
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
	 * �õ���һ�ڵ�����
	 * 
	 */
	public String getFirstDate(String type) {
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = plan_date;
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
			day = start_date.substring(start_date.lastIndexOf("-") + 1,
					start_date.length());
		}

		if (type.equals("0")) {
			String s = "";
			start_date = getNewDate(start_date, day);
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("��һ��ʱ��:" + start_date);
		return start_date;
	}

	/**
	 * ���ڼ���ÿһ�ڵ����
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

		// ����˵����Pv=��ֵ��Nper=������Rate=����(ע��ͬ��������һ�£���Ҫ���Ѿ������ٷֺŵ���ֵ����0.05)
		// Fv=δ��ֵ��Type=���� 1�� 0������ָ�����ڵĸ���ʱ�������ڳ�������ĩ
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
	 * �ȶ����
	 * 
	 * @param p_year_rate
	 *            �����������
	 * 
	 */
	public List eqRentList(String p_year_rate) {

		String rent = "-1";
		String rate = "";
		rate = String.valueOf(Double.parseDouble(p_year_rate) / 12 / 100
				* Integer.parseInt(lease_interval));

		String lease_money_ = "";
		lease_money_ = this.lease_money;

		// ���ޱ�����ڸ�����(��Ϣ�����������Ĳ���ʱ)
		if (this.lease_money.length() > 0 && this.lease_money.indexOf("-") > -1) {
			lease_money_ = this.lease_money.substring(1, this.lease_money
					.length());

		}
		rent = this.getPMT(rate, this.income_number, "-" + lease_money_,
				this.future_money, this.period_type);

		// ����С��λ����
		rent = Tools.formatNumberDoubleScale(rent, Integer
				.parseInt(this.rentScale));

		List l_rent = new ArrayList();
		// ���ÿһ�ڵ����,�����ܵ������õ����е�����Ϣ
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}
		// ��������б�
		return l_rent;
	}

	/**
	 * 
	 * @param rentList
	 *            ���list
	 * @param leaseMoney
	 *            Ҫ����ı���
	 * @param calRate
	 *            ��������� qzOrqm �ڳ�������δ
	 * @return
	 */
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm) {
		System.out.println("�������������ʣ�" + calRate);
		// ���ڱ�����Ϣ
		List interests = new ArrayList();
		String corpus_total = "0";
		// ���ڵ���Ϣ
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// �������
		corpus_overage = Tools.formatNumberDoubleTwo(leaseMoney);

		for (int i = 0; i < rentList.size(); i++) {// ѭ�����list

			if ("1".equals(qzOrqm) && i == 0) {// ��һ�������ڳ�ʱ
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// ��Ϣ
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// ʣ�౾��*����
				inte = Tools.formatNumberDoubleTwo(inte);
				// ����
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// ���-��Ϣ
				corpus = Tools.formatNumberDoubleTwo(corpus);

			}

			// ���һ�ڵ���Ϣ=ʣ�����Ϣ�ܺ�,������Ȼ=���-��Ϣ
			if (i == rentList.size() - 1) {
				// ���� --�ܵı���-��ǰ�ı����
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

			// �������
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleTwo(corpus_overage);
			// ���list
			interests.add(inte);

		}

		return interests;
	}

	/**
	 * 
	 * @param rentList
	 *            ��� list
	 * @param inteList
	 *            ��Ϣlist
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
	 * @param leaseMoney�ܵı���
	 * @param corpusList
	 *            ÿһ�ڵı���
	 * @return
	 */
	public List getCorpusOvergeList(String leaseMoney, List corpusList) {
		String total = "0";// �ۻ�ÿһ�ڵı���
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
	 *            ��� list
	 * @param perType
	 *            �ڳ�������δ
	 * @return
	 */
	public List getPlanDateList(List rentList, String perType) {
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = this.getFirstDate(perType);
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
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

	private String getNewDate(String start_date, String day) {

		// �������µõ��������һ��
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
	 * �ȶ��,�õ�ÿһ�ڵı���
	 * 
	 * 
	 * 
	 */
	public List eqCorpusList() {

		String corpu = "";

		// �õ�ÿ�ڵı���,�ܵı���/����
		corpu = String.valueOf(Double.parseDouble(this.cle_cau_Money)
				/ Integer.parseInt(this.income_number));
		corpu = Tools.formatNumberDoubleTwo(corpu);

		System.out.println("ÿһ�ڵı���:" + corpu);
		String total = "0";// ���ڻ���ǰ��ı����

		// ���ڱ��汾��
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			// ���һ����Ҫ���ر�Ĵ���

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
	 * �ȶ�����Ϣ�б�
	 * 
	 * @param l_corpus
	 *            ����list
	 * @param cal_rate
	 *            ���������
	 * @return
	 */
	public List getInterestByEqCorpus(List l_corpus_over, String cal_rate,
			List l_corpus_pre) {

		// ���ڱ�����Ϣ�б�
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
	 * �ȶ�������б�
	 * 
	 * @param l_corpus
	 *            �����б�
	 * @param l_inte
	 *            ��Ϣ�б�
	 * @return
	 */
	public List getRentByEqCorpus(List l_corpus, List l_inte) {
		// ���ڱ������
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
	 * �ȶ���� �������ں��� type 1,Ϊ���·ݵĴ�;2,Ϊ��������Ĵ���
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getIrr(String type, List rent_list, List l_plan_date)
			throws Exception {

		// �����г�irr'
		List rent_list_1 = new ArrayList();
		for (int i = 0; i < rent_list.size(); i++) {
			rent_list_1.add(rent_list.get(i));
		}

		List l_plan_date_1 = new ArrayList();
		for (int i = 0; i < l_plan_date.size(); i++) {
			l_plan_date_1.add(l_plan_date.get(i));
		}

		// �����г���irr
		this.getMarkIrr(type, rent_list_1, l_plan_date_1);

		// ��������irr
		IrrCal irr = new IrrCal();
		String i_rr = "";
		// ����ǰ�ڵ��ʽ���
		irr.getPreCashFlow(preDate, preCash);

		if ("1".equals(type)) {// ÿ�¼���

			// ���
			irr.getPreMonthCash(rent_list, l_plan_date);
			// ���ڵ������
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// ʱ�䣬�ʽ����Ĵ�����
			irr.getUniqueByDate();

			// ��ÿ��ʱ
			i_rr = irr.getIRR(irr.getCashList(), "1", "1", "12");
			System.out.println("irr:" + i_rr);

		} else {// ����ԭ�������������

			// ���
			irr.getRentCashFlow(l_plan_date, rent_list);
			// ���ڵ������
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// ʱ�䣬�ʽ����Ĵ�����
			irr.getUniqueByDate();

			// �������
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
	 * �õ���֤��ֿ����List
	 * 
	 * @param rent_list
	 *            ���List
	 * @param caut_money
	 *            ��֤��
	 * @return
	 */
	public List getRentCautNew(List rent_list, String caut_money) {
		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// ���ڼ�¼�±��
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
					int_s.length() - 1) : int_s;// �õ����Եֿ۵������±�
			String[] i_array = int_s.split(",");// ������Եֿ۵�����±�
			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// ���ڱ�������
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					rent_list.set(Integer.parseInt(i_array[j]), "0");// ����֤����ڵ������Ϊ0
				} else {
					rent_list.set(Integer.parseInt(i_array[j]), Double
							.parseDouble(rent_list.get(
									Integer.parseInt(i_array[j])).toString())
							- dcaut);
				}
				dcaut = dcaut - temp_rent;// �޸ı�֤��ֿ۵�ֵ
			}
		}
		return rent_list;
	}

	/**
	 * �ȶ���� �������ں��� type 1,Ϊ���·ݵĴ�;2,Ϊ��������Ĵ���,�õ��г�irr
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getMarkIrr(String type, List rent_list, List l_plan_date)
			throws Exception {
		IrrCal irr = new IrrCal();
		String i_rr = "";

		// ��ӱ�֤���ǰ�ڿ�
		List preDate_1 = new ArrayList();
		for (int i = 0; i < preDate.size(); i++) {
			preDate_1.add(preDate.get(i));
		}
		preDate_1.add(this.start_date);

		List preCash_1 = new ArrayList();
		for (int i = 0; i < preCash.size(); i++) {
			preCash_1.add(preCash.get(i));
		}
		preCash_1.add(this.cauti_Money);

		// ����ǰ�ڵ��ʽ���
		irr.getPreCashFlow(preDate_1, preCash_1);
		// ���ڱ�֤��ֿ۵Ĺ�ϵ,�õ���֤��ֿ۵����list
		rent_list = getRentCautNew(rent_list, this.cauti_Money);

		if ("1".equals(type)) {// ÿ�¼���

			// ���
			irr.getPreMonthCash(rent_list, l_plan_date);
			// ���ڵ������
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// ʱ�䣬�ʽ����Ĵ�����
			irr.getUniqueByDate();
			// ��ÿ��ʱ
			i_rr = irr.getIRR(irr.getCashList(), "1", "1", "12");
			System.out.println("getMarkIrrirr:" + i_rr);

		} else {// ����ԭ�������������

			// ���
			irr.getRentCashFlow(l_plan_date, rent_list);
			// ���ڵ������
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// ʱ�䣬�ʽ����Ĵ�����
			irr.getUniqueByDate();

			i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
					this.lease_interval, String.valueOf(Integer.parseInt("12")
							/ Integer.parseInt(this.lease_interval)));
			System.out.println(i_rr);

		}

		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));

		System.out.println("getMarkIrr===:" + i_rr);
		this.market_irr = i_rr;
		return i_rr;
	}

	/**
	 * 
	 * @param type
	 *            1���ȶ����2���ȶ��
	 * @return
	 * @throws Exception
	 */
	public HashMap getHashRentPlan(String type, List rent_list, List l_plan_date)
			throws Exception {

		if ("1".equals(type)) {
			// ������������Ϣ�Ǹ����ں������������rate���¸�ֵ,������Ϣʱirr/��12/�������
			String rate = String.valueOf(Double.parseDouble(this.getIrr(
					this.irr_type, rent_list, l_plan_date))
					/ (12 / Integer.parseInt(this.lease_interval)));
			System.out.println("���ʣ�����ʱ1��" + rate);
			rate = Tools.formatNumberDoubleScale(rate, Integer
					.parseInt(this.scale));
			System.out.println("���ʣ�����ʱ��" + rate);
			return this.getPlanByEqRent(rate, rent_list);
		} else {// �ȶ��ʱ��Ҫ����irr
			HashMap hmp = this.getPlanByEqCorpus();
			return hmp;
		}
	}

	/**
	 * �ȶ����ʱ
	 * 
	 * @return
	 */

	public HashMap getPlanByEqRent(String p_year_rate, List rent_c_list) {
		HashMap hm = new HashMap();
		// ��������Ǹ�������������ģ������ṩ��irr�������������ֶ���������������
		// �ɿ����ǲ��������
		List l_rent = rent_c_list;

		List l_inte = this.getInterestList(l_rent, this.cle_cau_Money,
				p_year_rate, this.period_type);
		List l_corpus = this.getCorpusList(l_rent, l_inte);
		List l_corpus_overage = this.getCorpusOvergeList(this.cle_cau_Money,
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
	 * �ȶ��ʱ
	 * 
	 * @return
	 * @throws Exception
	 */
	// �����,�����ܶ�,������,�ſ��������ÿ�ڱ���,��Ϣ,��������,ʣ�����,ʣ�౾��,ʣ����Ϣ
	public HashMap getPlanByEqCorpus() throws Exception {
		HashMap hm = new HashMap();

		List l_corpus = this.eqCorpusList();// ����
		String c_rate = String.valueOf(Double.parseDouble(this.year_rate) / 12
				/ 100 * Integer.parseInt(lease_interval));// ����
		List l_corpus_overage = this.getCorpusOvergeList(this.cle_cau_Money,
				l_corpus);// �������

		List l_inte = this.getInterestByEqCorpus(l_corpus_overage, c_rate,
				l_corpus);// ��Ϣ

		List l_rent = this.getRentByEqCorpus(l_corpus, l_inte);// ���

		// ���ڼ���irrʱ�����list
		List l_rent_1 = new ArrayList();
		for (int i = 0; i < l_rent.size(); i++) {
			l_rent_1.add(l_rent.get(i));
		}

		List l_plan_dt = this.getPlanDateList(l_rent, this.period_type);// �ƻ�ʱ��

		// ����irrʱ���ƻ�ʱ��
		List l_plan_dt_1 = new ArrayList();
		for (int i = 0; i < l_plan_dt.size(); i++) {
			l_plan_dt_1.add(l_plan_dt.get(i));
		}

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);
		hm.put("plan_date", l_plan_dt);

		// ��irr=====����irr
		IrrCal irr = new IrrCal();
		// ����ǰ�ڵ��ʽ���
		irr.getPreCashFlow(preDate, preCash);
		// ���
		irr.getRentCashFlow(l_plan_dt, l_rent);
		// ���ڵ������
		irr.getRentAfterCashFlow(afterDate, afterCash);
		// ʱ�䣬�ʽ����Ĵ�����
		irr.getUniqueByDate();

		String i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
				this.lease_interval, String.valueOf(Integer.parseInt("12")
						/ Integer.parseInt(this.lease_interval)));
		System.out.println(i_rr);

		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
		System.out.println("irr===:" + i_rr);
		this.v_irr = i_rr;

		// /===================================�����г�ir
		// �õ��µ����list
		l_rent_1 = this.getRentCautNew(l_rent_1, this.cauti_Money);

		// ��ӱ�֤���ǰ�ڿ�
		List preDate_1 = new ArrayList();
		for (int i = 0; i < preDate.size(); i++) {
			preDate_1.add(preDate.get(i));
		}
		preDate_1.add(this.start_date);

		List preCash_1 = new ArrayList();
		for (int i = 0; i < preCash.size(); i++) {
			preCash_1.add(preCash.get(i));
		}
		preCash_1.add(this.cauti_Money);

		// ����ǰ�ڵ��ʽ���
		irr.getPreCashFlow(preDate_1, preCash_1);
		// ���
		irr.getRentCashFlow(l_plan_dt_1, l_rent_1);
		// ���ڵ������
		irr.getRentAfterCashFlow(afterDate, afterCash);
		// ʱ�䣬�ʽ����Ĵ�����
		irr.getUniqueByDate();

		i_rr = irr.getIRR(irr.getCashList(), this.lease_interval,
				this.lease_interval, String.valueOf(Integer.parseInt("12")
						/ Integer.parseInt(this.lease_interval)));
		System.out.println(i_rr);

		i_rr = Tools
				.formatNumberDoubleScale(i_rr, Integer.parseInt(this.scale));
		System.out.println("Markirr===:" + i_rr);
		this.market_irr = i_rr;

		return hm;
	}

	/**
	 * �õ���֤��ֿ����List �ֽ� ����ϸ
	 * 
	 * @param rent_list
	 *            ���List
	 * @param caut_money
	 *            ��֤��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentDetails(List rent_list, String caut_money) {

		// �ȹ�����������µ���� ��ϸ
		List cash_follow_detail = new ArrayList();

		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// ���ڼ�¼�±��
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
					int_s.length() - 1) : int_s;// �õ����Եֿ۵������±�
			String[] i_array = int_s.split(",");// ������Եֿ۵�����±�

			System.out.println("id_s:" + int_s);

			Hashtable ht = null;// ���ڱ����ֽ�������ϸ
			// /follow_in,follow_in_detail,follow_out,follow_out_detail
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "���" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// ���ڱ�������
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					// rent_list.set(Integer.parseInt(i_array[j]),
					// "0");//����֤����ڵ������Ϊ0

					// �ֽ�����ϸ����
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(j).toString());
					ht.put("follow_in_detail", "���"
							+ rent_list.get(j).toString());
					ht.put("follow_out", rent_list.get(j).toString());
					ht.put("follow_out_detail", "��֤��ֿۣ�"
							+ rent_list.get(j).toString());
					ht.put("net_follow", "0");

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				} else {
					// rent_list.set(Integer.parseInt(i_array[j]),
					// Double.parseDouble(rent_list.get(Integer.parseInt(i_array[j])).toString())-dcaut);

					// �ֽ�����ϸ����
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(j).toString());
					ht.put("follow_in_detail", "���"
							+ rent_list.get(j).toString());
					ht.put("follow_out", dcaut);
					ht.put("follow_out_detail", "��֤��ֿۣ�" + dcaut);
					ht.put("net_follow", Double.parseDouble(rent_list.get(
							Integer.parseInt(i_array[j])).toString())
							- dcaut);

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				}
				dcaut = dcaut - temp_rent;// �޸ı�֤��ֿ۵�ֵ
			}
		} else {

			Hashtable ht = null;
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "���" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

		}
		return cash_follow_detail;
	}

	/**
	 * �õ� �г������ƻ���һЩ��Ϣ
	 * 
	 * @param p_year_rate
	 *            //ÿһ�ڵ���Ϣ
	 * @param rent_c_list
	 *            ��� list
	 * @param lease_money_p
	 *            ��Ҫ����ı���
	 * @param period_type_p
	 *            �ڳ�����ĩ
	 * @return
	 */

	public HashMap getPlanMarketByEqRent(String p_year_rate, List rent_c_list,
			String lease_money_p, String period_type_p) {
		HashMap hm = new HashMap();
		// ��������Ǹ�������������ģ������ṩ��irr�������������ֶ���������������
		// �ɿ����ǲ��������
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

	/**
	 * ����
	 * 
	 * @param args
	 * @throws Exception
	 */

	public static void main(String[] args) throws Exception {
		CopyOfRentCalc rent = new CopyOfRentCalc();
		rent.setYear_rate("0");
		rent.setIncome_number("36");
		rent.setLease_money("11130000.00");

		rent.setFuture_money("0");

		rent.setPeriod_type("0");// �ڳ�������δ
		rent.setIrr_type("2");// 1��Ϊ���·�������irr,2Ϊ�����������
		rent.setScale("8");// ����irr����ʱ�ľ���
		rent.setLease_interval("1");
		rent.setPlan_date("2009-9-31");

		rent.setStart_date("2009-12-18");
		rent.setCle_cau_Money("12000000");
		rent.setCauti_Money("1000000");

		List l_rent_1 = new ArrayList();
		List l_plane = new ArrayList();
		// ����ǰ�ڸ����,���޹�˾������Ϊ-�������Ϊ+,�����������ѣ��豸���֤���
		// �������ʱ���Էŵ���ǰ������б�
		l_rent_1.add("-19740000");
		l_plane.add("2009-11-18");
		rent.setPreCash(l_rent_1);
		rent.setPreDate(l_plane);

		// �õ����list,ע�ⲻ����ʱ�����list
		List rent_list = rent.eqRentList(rent.year_rate);// ����ʱ
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.period_type);// �ƻ�ʱ��

		// 1���ȶ����2���ȶ��,�ȶ��ʱrent_list,l_plan_date_,���Դ�һ���չ�ȥ
		HashMap hm = rent.getHashRentPlan("1", rent_list, l_plan_date_);
		System.out.println("irr:" + rent.getV_irr());
		System.out.println("Markirr:" + rent.getMarket_irr());

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

		System.out.println("Markirr:"
				+ rent.getPMT("0", "36", "11130000.00", "0", "0"));

	}

}
