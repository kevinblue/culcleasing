package com.rent.calc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * ����������
 * 
 * @author Administrator
 * 
 */
public class RentCalc {

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
	private String rentScale="0";// ��ȷ����λС��,����

	private String v_irr;// irr��ֵ,Ĭ�ϵ�Ϊ�����irr
	private String market_irr;// �г�irr��ֵ
	
	private String cle_cau_Money;//�����ʶ�+��֤��,����ʣ�౾��ļ���
	private String cauti_Money;//��֤�����ڱ�֤��ֿ����ļ���

	private String contract_id;// ��ͬ��,�����ֽ�����ͳ��
	


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
	 * �õ�����������list
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
	 * �õ���һ�ڵ�����
	 * 
	 */
	public String getFirstDate(String type) {
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = plan_date;
		if (type.equals("0")) {
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), plan_date);
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
		
		String lease_money_="";
		lease_money_=this.lease_money;
		
		if (this.lease_money.length()>0 && this.lease_money.indexOf("-")>-1) {
			lease_money_ = this.lease_money.substring(1,this.lease_money.length());
			
		}
		rent = this.getPMT(rate, this.income_number, "-" + lease_money_,
				this.future_money, this.period_type);

		//����С��λ����
		rent = Tools.formatNumberDoubleScale(rent, Integer.parseInt(this.rentScale));
		
		
		List l_rent = new ArrayList();
		// ���ÿһ�ڵ����
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
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			l_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date));
		}

		return l_date;
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
		corpu = String.valueOf(Double.parseDouble(this.lease_money)
				/ Integer.parseInt(this.income_number));
		corpu = Tools.formatNumberDoubleTwo(corpu);

		System.out.println("ÿһ�ڵı���:" + corpu);
		String total = "0";// ���ڻ���ǰ��ı����

		// ���ڱ��汾��
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			// ���һ����Ҫ���ر�Ĵ���

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
			r = Tools.formatNumberDoubleTwo(r);

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
	public String getIrr(String type, List rent_list, List l_plan_date) throws Exception {
		IrrCal irr = new IrrCal();

		String i_rr = "";

		// ����ǰ�ڵ��ʽ���
		irr.getPreCashFlow(preDate, preCash);

		// �õ����list
		// List rent_list = this.eqRentList(this.year_rate);
		// List l_plan_date = this.getPlanDateList(rent_list,
		// this.period_type);// �ƻ�ʱ��

		if ("1".equals(type)) {// ÿ�¼���

			// ���
			irr.getPreMonthCash(rent_list, l_plan_date);
			// ���ڵ������
			irr.getRentAfterCashFlow(afterDate, afterCash);
			// ʱ�䣬�ʽ����Ĵ�����
			irr.getUniqueByDate();

//			 ����ֽ�����¼
		///	this.insertCashFlow(irr.getCashList(), irr.getDateList());

			
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
//			 ����ֽ�����¼
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
	 *            1���ȶ����2���ȶ��
	 * @return
	 * @throws Exception 
	 */
	public HashMap getHashRentPlan(String type, List rent_list, List l_plan_date) throws Exception {

		if ("1".equals(type)) {

			// ������������Ϣ�Ǹ����ں������������rate���¸�ֵ,������Ϣʱirr/��12/�������
			String rate = String.valueOf(Double.parseDouble(this.getIrr(
					this.irr_type, rent_list, l_plan_date))
					/ (12 / Integer.parseInt(this.lease_interval)));
			rate = Tools.formatNumberDoubleScale(rate, Integer
					.parseInt(this.scale));

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
		// List l_rent = this.eqRentList(this.year_rate);
		// �ɿ����ǲ��������
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
		List l_corpus_overage = this.getCorpusOvergeList(this.lease_money,
				l_corpus);// �������

		List l_inte = this.getInterestByEqCorpus(l_corpus_overage, c_rate,
				l_corpus);// ��Ϣ

		List l_rent = this.getRentByEqCorpus(l_corpus, l_inte);// ���

		List l_plan_dt = this.getPlanDateList(l_rent, this.period_type);// �ƻ�ʱ��

		hm.put("rent", l_rent);
		hm.put("corpus", l_corpus);
		hm.put("interest", l_inte);
		hm.put("corpus_overage", l_corpus_overage);
		hm.put("plan_date", l_plan_dt);

		// ��irr
		IrrCal irr = new IrrCal();
		// ����ǰ�ڵ��ʽ���
		irr.getPreCashFlow(preDate, preCash);
		// ���
		irr.getRentCashFlow(l_plan_dt, l_rent);
		// ���ڵ������
		irr.getRentAfterCashFlow(afterDate, afterCash);
		// ʱ�䣬�ʽ����Ĵ�����
		irr.getUniqueByDate();

		// ����ֽ�����¼
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
	 * ����
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
		rent.setPeriod_type("1");// �ڳ�������δ
		rent.setIrr_type("2");// 1��Ϊ���·�������irr,2Ϊ�����������
		rent.setScale("8");// ����irr����ʱ�ľ���
		rent.setLease_interval("3");
		rent.setPlan_date("2009-12-18");

		List l_rent_1 = new ArrayList();
		List l_plane = new ArrayList();
		// ����ǰ�ڸ����,���޹�˾������Ϊ-�������Ϊ+,�����������ѣ��豸���֤���
		// �������ʱ���Էŵ���ǰ������б�
		l_rent_1.add("-10000000");
		l_plane.add("2009-11-18");
		rent.setPreCash(l_rent_1);
		rent.setPreDate(l_plane);

		// �õ����list,ע�ⲻ����ʱ�����list
		List rent_list = rent.eqRentList(rent.year_rate);// ����ʱ
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.period_type);// �ƻ�ʱ��

		// 1���ȶ����2���ȶ��,�ȶ��ʱrent_list,l_plan_date_,���Դ�һ���չ�ȥ
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
	 * ������Ӽ���irr���ֽ���
	 * 
	 * @param cashs
	 *            �ֽ���
	 * @param dates
	 *            ����Ӧ�ļ���ʱ��
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
