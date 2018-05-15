package com.rent.calc.update;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.Tools;

/**
 * �����㳣�÷���
 * 
 * @author Administrator
 * 
 */
public class RentCalc extends RentCommon{


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
	private String getPMT(String Rate, String Nper, String Pv, String Fv,
			String Type) {
		// ����˵����Pv=��ֵ��Nper=������Rate=����(ע��ͬ��������һ�£���Ҫ���Ѿ������ٷֺŵ���ֵ����0.05)
		// Fv=δ��ֵ��Type=���� 1�� 0������ָ�����ڵĸ���ʱ�������ڳ�������ĩ
		Rate = Rate.equals("") ? "0" : Rate;
		Nper = Nper.equals("") ? "0" : Nper;
		Pv = Pv.equals("") ? "0" : Pv;
		Fv = Fv.equals("") ? "0" : Fv;
		Type = Type.equals("") ? "0" : Type;
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
	 * ����ÿһ�ڵ����(�ȶ�ʱ)
	 * 
	 * @param calcRate
	 *            ÿһ�����ļ������
	 * @param lease_money
	 *            ��Ҫ����ı���
	 * @param period_type
	 *            �ڳ�������ĩ
	 * @param income_number
	 *            �ܻ�������
	 * @param future_money
	 *            �����㽫��ֵ
	 * @return
	 */
	public String getEqRent(String calcRate, String lease_money,
			String period_type, String income_number, String future_money) {

		// ����pmt��˾�������µ����
		String rent = getPMT(calcRate, income_number, "-"
				+ judgeLeaseMoney(lease_money), future_money, period_type);

		// ����С��λ����
		rent = Tools.formatNumberDoubleScale(rent, Integer
				.parseInt(ConstantInfo.MONEYSCALE));

		return rent;
	}

	
	/**
	 * �ȶ���� ���ÿһ�ڵ����ֵ��δ����ʱ
	 * 
	 * @param rent
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String rent, String income_number) {

		List l_rent = new ArrayList();
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
	 *            ��������� qzOrqm �ڳ�������δ
	 * @return
	 */
	@SuppressWarnings("unchecked")
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
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(ConstantInfo.MONEYSCALE));

		for (int i = 0; i < rentList.size(); i++) {// ѭ�����list

			if ("1".equals(qzOrqm) && i == 0) {// ��һ�������ڳ�ʱ
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// ��Ϣ
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// ʣ�౾��*����
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
				// ����
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// ���-��Ϣ
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
			}

			// ���һ�ڵ���Ϣ=ʣ�����Ϣ�ܺ�,������Ȼ=���-��Ϣ
			if (i == rentList.size() - 1) {
				// ���� --�ܵı���-��ǰ�ı����
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(ConstantInfo.MONEYSCALE));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(ConstantInfo.MONEYSCALE));

			// �������
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(ConstantInfo.MONEYSCALE));
			// ���list
			interests.add(inte);

		}

		return interests;
	}

	/**
	 * ���ÿһ�ڵı������
	 * 
	 * @param rentList
	 *            ���
	 * @param inteList
	 *            ��Ϣ
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusList(List rentList, List inteList) {
		List corpus_list = new ArrayList();

		for (int i = 0; i < rentList.size(); i++) {

			corpus_list.add(Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(rentList.get(i).toString())
					- Double.parseDouble(inteList.get(i).toString())), Integer
					.parseInt(ConstantInfo.MONEYSCALE)));
		}
		return corpus_list;
	}

	
	

	
	
	
	
}
