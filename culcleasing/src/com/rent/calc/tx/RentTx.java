package com.rent.calc.tx;

/**
 * ��Ϣʱ��������
 */
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

public class RentTx {

	
	/**
	 * �ȶ����ʱ��ÿһ�ڵ������㷽��
	 * 
	 * @param Rate
	 * @param Nper
	 * @param Pv
	 * @param Fv
	 * @param Type
	 * @return
	 */
	public static String getPMT(String Rate, String Nper, String Pv, String Fv,
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
					new BigDecimal("-1")).divide(new BigDecimal(Nper), 2,
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
	 * �ȶ���� ���ÿһ�ڵ����ֵ��δ����ʱ
	 * 
	 * @param rent
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String rent, String income_number, HashMap mp) {

		String rem_corpus = mp.get("rem_corpus").toString();// ʣ�౾��
		String sgrace = mp.get("igrace").toString();// ��������
		String retu_rate = mp.get("retu_vale").toString();// ��Ϣ��������
		String income_number_year = mp.get("income_number_year").toString();// �껹�����

		// �õ�ÿһ����������
		String retu_vale = CalcUtil.getPreRate(retu_rate, income_number_year);

		List l_rent = new ArrayList();
		// �п�����ʱ�����
		for (int i = 0; i < Integer.parseInt(sgrace); i++) {
			// ����µĿ��������,ʣ�౾��*�µ�����ֵ
			l_rent.add(Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(Tools.formatNumberDoubleScale(rem_corpus, 2))
					* Double.parseDouble(retu_vale)), Integer.parseInt(mp.get(
					"rentScale").toString())));
		}

		// ���ÿһ�ڵ����,�����ܵ������õ����е�����Ϣ
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}

		return l_rent;
	}

	/**
	 * ������Ϣ
	 * 
	 * @param rentList
	 *            ���list
	 * @param leaseMoney
	 *            Ҫ����ı���
	 * @param calRate
	 *            ��������� qzOrqm �ڳ�������δ,��Ϣʱ���ӵ�һ�ڿ�ʼ�����ߴ������ڴο�ʼ��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm,HashMap mp) {
		
		//��������
		String sgrace = mp.get("igrace").toString();
		
		// ���ڱ�����Ϣ
		List interests = new ArrayList();
		String corpus_total = "0";
		// ���ڵ���Ϣ
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// �������
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(mp.get("rentScale").toString()));
		
		//��������Ϣ
		for (int i = 0; i < Integer.parseInt(sgrace); i++) {
			interests.add(Double.parseDouble(leaseMoney) * Double.parseDouble(calRate));
		}
		
		//�õ�ѭ���Ŀ�ʼ����
		int istart = Integer.parseInt(sgrace)-1;
		if (istart <0) {
			istart = 0;
		}
		

		for (int i = istart; i < rentList.size(); i++) {// ѭ�����list

			if ("1".equals(qzOrqm) && i == 0) {// ��һ�������ڳ�ʱ
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// ��Ϣ
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// ʣ�౾��*����
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(mp.get("rentScale").toString()));
				// ����
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// ���-��Ϣ
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(mp.get("rentScale").toString()));
			}

			// ���һ�ڵ���Ϣ=ʣ�����Ϣ�ܺ�,������Ȼ=���-��Ϣ
			if (i == rentList.size() - 1) {
				// ���� --�ܵı���-��ǰ�ı����
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(mp.get("rentScale").toString()));
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(mp.get("rentScale").toString()));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(mp.get("rentScale").toString()));

			// �������
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(mp.get("rentScale").toString()));
			// ���list
			interests.add(inte);

		}

		return interests;
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
	public static List getCorpusList(List rentList, List inteList,String rentScale) {
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
	 * 
	 * @param leaseMoney�ܵı���
	 * @param corpusList
	 *            ����
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getCorpusOvergeList(String leaseMoney, List corpusList,String rentScale) {
		String total = "0";// �ۻ�ÿһ�ڵı���
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleScale(total, Integer
					.parseInt(rentScale));

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(rentScale)));

		}
		return corps;
	}

	/**
	 * �õ���𳥻�ʱ���list
	 * 
	 * @param rentList
	 * @param type
	 * @param lease_interval
	 * @param plan_date
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getPlanDateList(List rentList, String lease_interval,
			String plan_date) {
		String start_date = plan_date;
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			l_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date));
		}

		return l_date;
	}

}
