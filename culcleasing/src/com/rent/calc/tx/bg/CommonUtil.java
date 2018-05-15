package com.rent.calc.tx.bg;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * ���ü�����
 * 
 * @author shf
 * 
 */
public class CommonUtil {
	/**
	 * 
	 * @param leaseMoney�ܵı���
	 * @param corpusList
	 *            ����
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getCorpusOvergeList(String leaseMoney, List corpusList,
			String rentScale) {
		String total = "0";// �ۻ�ÿһ�ڵı���
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleScale(total, Integer
					.parseInt(rentScale));

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			// С��λ�����һ���Ĳ�ֵ
			if (d < 0) {
				d = 0;
			}
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(rentScale)));

		}
		return corps;
	}

	/**
	 * ���ÿһ�ڵı���
	 * 
	 * @param rentList
	 *            ���
	 * @param inteList
	 *            ��Ϣ
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getCorpusList(List rentList, List inteList,
			String rentScale) {
		List corpus_list = new ArrayList();

		for (int i = 0; i < rentList.size(); i++) {

			corpus_list.add(Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(rentList.get(i).toString())
					- Double.parseDouble(inteList.get(i).toString())), Integer
					.parseInt(rentScale)));
		}
		return corpus_list;
	}

	/**
	 * ������Ϣ
	 * 
	 * @param rentList
	 * @param leaseMoney
	 * @param calRate
	 * @param qzOrqm
	 * @param rentScale
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm, String rentScale) {

		// ���ڱ�����Ϣ
		List interests = new ArrayList();
		String corpus_total = "0";
		// ���ڵ���Ϣ
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// �������
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(rentScale));

		for (int i = 0; i < rentList.size(); i++) {// ѭ�����list

			if ("1".equals(qzOrqm) && i == 0) {// ��һ�������ڳ�ʱ
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// ��Ϣ
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// ʣ�౾��*����
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(rentScale));
				// ����
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// ���-��Ϣ
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(rentScale));
			}

			// ���һ�ڵ���Ϣ=ʣ�����Ϣ�ܺ�,������Ȼ=���-��Ϣ
			if (i == rentList.size() - 1) {
				// ���� --�ܵı���-��ǰ�ı����
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(rentScale));
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(rentScale));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(rentScale));

			// �������
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(rentScale));
			// ���list
			interests.add(inte);

		}

		return interests;
	}

	/**
	 * �����һ�ڵ���Ϣ
	 * 
	 * @param rate
	 *            ���ʻ�irrֵ
	 * @param txrq
	 *            ��Ϣ��
	 * @param preDate
	 *            С�ڵ�Ϣ�յ�ǰһ��ʱ��
	 * @param dqDate
	 *            ���ڵ�Ϣ�յĺ�һ��ʱ�伴��Ϣ��ʼ�ڵ�ʱ��
	 * @param leaseMoney
	 *            �����ʣ�౾��
	 * @return
	 */
	public static String getFirstInterestDetail(String preRate, String rate,
			String txrq, String preDate, String dqDate, String leaseMoney) {

		// �õ�����,��Ϣ�յ���Ϣǰһ�ڵ�����
		long preDays = ToolUtil.getDateDiff(txrq, preDate);
		long afterDays = ToolUtil.getDateDiff(dqDate, txrq);

		// ��������ֵ�õ���һ����Ӧ����Ϣ
		// (G19*$E$10/360*(B11-B19))+(G19*$E$11/360)*(B20-B11)
		double dtotalInter = Double.parseDouble(leaseMoney)
				* Double.parseDouble(preRate) / 100 / 360 * preDays
				+ Double.parseDouble(leaseMoney) * Double.parseDouble(rate)
				/ 360 / 100 * afterDays;

		return Tools.formatNumberDoubleScale(String.valueOf(dtotalInter), 4);
	}

	/**
	 * ��һ����Ϣ
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @param leassMoney
	 * @return
	 * @throws Exception
	 *             2010-12-30 �޸� �ֶμ�Ϣ
	 */
	@SuppressWarnings("static-access")
	public static String getFirstInterest(String contract_id, String txrq,
			String start_term, String rateValue, String leassMoney)
			throws Exception {

		// ��һ����Ϣ
		FundRentPlan frp = new FundRentPlan();
		String dqdate = frp.getDqDate(contract_id, start_term);
		String predate = frp.getPreDate(contract_id, start_term);

		// �õ�ԭ����
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		
		//����Ǵӵ�һ�� ��ʼ��ǰһ�ڵ�����Ϊ��������
		if (predate.equals("0")) {
			predate=ht.get("start_date").toString();
		}

		// /2010-12-30 �޸�
		// ��ѯ���ڵ����Ƿ��е�Ϣ��¼
		FundAdjustInter fai = new FundAdjustInter();
		Hashtable ht_recoder = fai.searcherRecoder(contract_id, start_term, ht
				.get("ajdustStyle").toString());

		String first_interest = "0";
		List start_dates = (List) ht_recoder.get("start_date");

		if (!ht_recoder.isEmpty() && start_dates.size() > 0) {// �õ���Ϣ��¼ �ֶμ�Ϣ

			// ����Ǵ���ʱ
			if (null != ht.get("ajdustStyle").toString()
					&& "3".equals(ht.get("ajdustStyle").toString())) {

//				// �õ���Ϣ����������
//				List after_rates = (List) ht_recoder.get("after_rate");
//				String year_rate = after_rates.get(after_rates.size() - 1)
//						.toString();
				
				// �õ���Ϣ����ԭʼ����20110222�޸�
//				List before_rate = (List) ht_recoder.get("before_rate");
//				String year_rate = before_rate.get(0)
//				.toString();
				
				//�õ���һ�ڵ�����ֵ������
				String year_rate=frp.getPreRateByCN(contract_id, start_term);
				first_interest = getFirstInterestDetail(year_rate, rateValue,
						txrq, predate, dqdate, leassMoney);
				
				

			} else if (ht.get("grace") != null
					&& Integer.parseInt(ht.get("grace").toString()) >= Integer
							.parseInt(start_term)) {// �п�����ʱ // �����ڶ�ε�Ϣʱ

				// ((B11-B17)*E10+(B12-B11)*E11+(B18-B12)*E12)/(B18-B17)*G13/12*1
				// ���������ڵ�����,����������
				String income_number_year = ht.get("income_number_year")
						.toString();
				long days = ToolUtil.getDateDiff(dqdate, predate);
				Double dto = Double.parseDouble(leassMoney) / days / 12
						* Integer.parseInt(income_number_year);

				// ��������Ϣֵ

				List start_days = (List) ht_recoder.get("start_date");
				List before_rates = (List) ht_recoder.get("before_rate");
				List after_rates = (List) ht_recoder.get("after_rate");

				// �տ�ʼ��ǰһ���������Ϣ��¼�е����ڼ���
				String temp_pre_date = predate;
				String tem_rate = "0";
				String tem_date = start_dates.get(0).toString();
				String tem_interest = "0";

				for (int i = 0; i < start_days.size(); i++) {
					if (i == 0) {// ��һ��ʱȡ��ԭʼ����������
						tem_rate = before_rates.get(0).toString();
						tem_date = start_days.get(0).toString();

					} else {

						tem_rate = before_rates.get(i).toString();
						tem_date = start_days.get(i).toString();
						temp_pre_date = start_days.get(i - 1).toString();

					}

					long ds = ToolUtil.getDateDiff(tem_date, temp_pre_date);
					double dtotalInter = Double.parseDouble(tem_rate) * ds
							/ 100;

					System.out.println(dtotalInter);
					tem_interest = String.valueOf(dtotalInter
							+ Double.parseDouble(tem_interest));
				}
				// tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
				System.out.println("tem_interest" + tem_interest);
				System.out.println(after_rates.get(after_rates.size() - 1)
						.toString()
						+ "==" + tem_date);

				// ���ڵļ����Ϣ���� ������ʱ�䣭�ϴε�Ϣ�����ڣ����µ�����

				long ds_1 = ToolUtil.getDateDiff(txrq, start_days.get(
						start_days.size() - 1).toString());
				first_interest = String.valueOf(ds_1
						* Double.parseDouble(after_rates.get(
								after_rates.size() - 1).toString()) / 100);

				long ds_d = ToolUtil.getDateDiff(dqdate, txrq);

				first_interest = String.valueOf(Double
						.parseDouble(first_interest)
						+ ds_d * Double.parseDouble(rateValue) / 100);
				first_interest = Tools.formatNumberDoubleTwo(String
						.valueOf((Double.parseDouble(first_interest) + Double
								.parseDouble(tem_interest))
								* dto));

			} else {

				first_interest = subselection(txrq, rateValue, leassMoney,
						dqdate, predate, ht_recoder);
			}

		} else {
			// /ht.get("year_rate").toString()
			String year_rate = frp.getPreRate(contract_id, start_term);

			if (Double.parseDouble(year_rate) < 0.0000000000001) {
				year_rate = ht.get("year_rate").toString();
			}

			if (ht.get("grace") != null
					&& Integer.parseInt(ht.get("grace").toString()) >= Integer
					.parseInt(start_term) && ("1".equals(ht.get("ajdustStyle").toString())
					|| "0".equals(ht.get("ajdustStyle").toString()))) {// ����,����ʱ
				String income_number_year = ht.get("income_number_year")
						.toString();
				long preDays = ToolUtil.getDateDiff(txrq, predate);
				long afterDays = ToolUtil.getDateDiff(dqdate, txrq);
				long preDq = ToolUtil.getDateDiff(dqdate, predate);
				first_interest = Tools.formatNumberDoubleScale(
						String.valueOf((preDays * Double.parseDouble(year_rate)
								/ 100 + afterDays
								* Double.parseDouble(rateValue) / 100)
								/ preDq
								/ 12
								* Integer.parseInt(income_number_year)
								* Double.parseDouble(leassMoney)), 4);

			} else {
			
				first_interest = getFirstInterestDetail(year_rate, rateValue,
						txrq, predate, dqdate, leassMoney);
			}

		}

		return first_interest;

	}

	/**
	 * �ֶμ������
	 * 
	 * @param txrq
	 * @param rateValue
	 * @param leassMoney
	 * @param dqdate
	 * @param predate
	 * @param ht_recoder
	 * @return
	 */
	private static String subselection(String txrq, String rateValue,
			String leassMoney, String dqdate, String predate,
			Hashtable ht_recoder) {
		String first_interest = "0";
		List start_dates = (List) ht_recoder.get("start_date");
		List before_rates = (List) ht_recoder.get("before_rate");
		List after_rates = (List) ht_recoder.get("after_rate");
		// �տ�ʼ��ǰһ���������Ϣ��¼�е����ڼ���
		String temp_pre_date = predate;
		String tem_rate = "0";
		String tem_date = start_dates.get(0).toString();
		String tem_interest = "0";
		// String leaseMoney = "100";

		for (int i = 0; i < start_dates.size(); i++) {
			if (i == 0) {// ��һ��ʱȡ��ԭʼ����������
				tem_rate = before_rates.get(0).toString();
				tem_date = start_dates.get(0).toString();

			} else {

				tem_rate = before_rates.get(i).toString();
				tem_date = start_dates.get(i).toString();
				temp_pre_date = start_dates.get(i - 1).toString();

			}

			long days = ToolUtil.getDateDiff(tem_date, temp_pre_date);
			double dtotalInter = Double.parseDouble(leassMoney)
					* Double.parseDouble(tem_rate) / 100 / 360 * days;

			System.out.println(dtotalInter);
			tem_interest = String.valueOf(dtotalInter
					+ Double.parseDouble(Tools
							.formatNumberDoubleTwo(tem_interest)));
		}
		tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
		System.out.println("tem_interest" + tem_interest);

		System.out.println(after_rates.get(after_rates.size() - 1).toString()
				+ "==" + tem_date);

		// ���ڵļ����Ϣ����
		first_interest = getFirstInterestDetail(after_rates.get(
				after_rates.size() - 1).toString(), rateValue, txrq, tem_date,
				dqdate, leassMoney);
		first_interest = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(first_interest)
				+ Double.parseDouble(tem_interest)));
		return first_interest;
	}

	public static void main(String[] args) {
		Hashtable ht_recoder = new Hashtable();

		List start_date = new ArrayList();
		List before_rate = new ArrayList();
		List after_rate = new ArrayList();

		start_date.add("2010-10-20");
		start_date.add("2010-10-25");
		start_date.add("2010-10-30");
		start_date.add("2010-11-05");

		before_rate.add("7.490000");
		before_rate.add("7.500000");
		before_rate.add("7.52000");
		before_rate.add("7.530000");

		after_rate.add("7.50000");
		after_rate.add("7.52000");
		after_rate.add("7.530000");
		after_rate.add("7.550000");

		ht_recoder.put("start_date", start_date);
		ht_recoder.put("before_rate", before_rate);
		ht_recoder.put("after_rate", after_rate);

		List start_dates = (List) ht_recoder.get("start_date");
		List before_rates = (List) ht_recoder.get("before_rate");
		List after_rates = (List) ht_recoder.get("after_rate");
		// �տ�ʼ��ǰһ���������Ϣ��¼�е����ڼ���
		String temp_pre_date = "2010-10-15";
		String tem_rate = "0";
		String tem_date = start_dates.get(0).toString();
		String tem_interest = "0";
		String leaseMoney = "100";

		for (int i = 0; i < start_dates.size(); i++) {
			if (i == 0) {// ��һ��ʱȡ��ԭʼ����������
				tem_rate = before_rates.get(0).toString();
				tem_date = start_dates.get(0).toString();

			} else {

				tem_rate = before_rates.get(i).toString();
				tem_date = start_dates.get(i).toString();
				temp_pre_date = start_dates.get(i - 1).toString();

			}

			long days = ToolUtil.getDateDiff(tem_date, temp_pre_date);
			double dtotalInter = Double.parseDouble(leaseMoney)
					* Double.parseDouble(tem_rate) / 100 / 360 * days;

			System.out.println(dtotalInter);
			tem_interest = String.valueOf(dtotalInter
					+ Double.parseDouble(Tools
							.formatNumberDoubleTwo(tem_interest)));
		}
		tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
		System.out.println("tem_interest" + tem_interest);

		System.out.println(after_rates.get(after_rates.size() - 1).toString()
				+ "==" + tem_date);
		// String first_interest =
		// getFirstInterestDetail(after_rates.get(after_rates.size()-1).toString(),
		// rateValue, txrq, tem_date, dqdate, leassMoney);

	}

}
