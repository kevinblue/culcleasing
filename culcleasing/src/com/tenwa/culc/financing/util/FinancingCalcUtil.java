/**
 * com.tenwa.culc.financing.util
 */
package com.tenwa.culc.financing.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.Tools;

/**
 * @author Jaffe
 * 
 * Date:Dec 27, 2011 9:37:43 AM Email:JaffeHe@hotmail.com
 */
public class FinancingCalcUtil {

	/**
	 * ����ƻ��ƶ�
	 * 
	 * @param drawings_id -
	 *            �����
	 * @param leasMoney -
	 *            ����
	 * @param leasTerm
	 *            -����
	 * @param lease_interval
	 *            �����
	 * @param yearRate -
	 *            ������
	 * @param period -
	 *            �ȸ���
	 * @param startDate -
	 *            ������
	 */
	public List<FinancingRefundPlan> calcPlan(String drawings_id,
			String doc_id, String leasMoney, String leasTerm,
			String lease_interval, String yearRate, String period,
			String startDate) {
		List<FinancingRefundPlan> financingRefundPlan = new ArrayList<FinancingRefundPlan>();

		// ���ÿ�ڶ�Ӧ������ֵ
		String calRate = String.valueOf(Double.parseDouble(yearRate) / 100
				/ (12 / Integer.parseInt(lease_interval)));
		System.out.println("���ʣ�����ʱ1��" + calRate);
		calRate = Tools.formatNumberDoubleScale(calRate, Integer.parseInt("6"));
		System.out.println("���ʣ�����ʱ��" + calRate);

		// ���ÿ�����
		String rent = Tools.formatNumberDoubleTwo(getPMT(calRate, leasTerm, "-"
				+ leasMoney, "0.00", period));
		// System.out.println("rent==="+rent);
		String corpus_overage = "";
		corpus_overage = Tools.formatNumberDoubleTwo(leasMoney);
		// ���ڱ�����Ϣ
		String corpus_total = "0";
		// ���ڵ���Ϣ
		String inte = "";
		String corpus = "";
		// �������
		for (int i = 0; i < Integer.parseInt(leasTerm); i++) {
			// ���ÿһ�����Ӧ������
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), startDate);
			// ÿ�����ڵ����һ����е������֣�����dayΪ31��ʱ��2�¾ͻ�ת��28��
			addDate = getNewDate(addDate, startDate.substring(startDate
					.lastIndexOf("-") + 1, startDate.length()));
			// ������Ϣ

			if ("1".equals(period) && i == 0) {// ��һ�������ڳ�ʱ
				corpus = rent;
				inte = "0";
			} else {
				// ��Ϣ
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// ʣ�౾��*����
				inte = Tools.formatNumberDoubleTwo(inte);
				// ����
				corpus = String.valueOf(Double.parseDouble(rent)
						- Double.parseDouble(inte));// ���-��Ϣ+�ʲ���ֵ
				corpus = Tools.formatNumberDoubleTwo(corpus);

			}

			// ���һ�ڵ���Ϣ=ʣ�����Ϣ�ܺ�,������Ȼ=���-��Ϣ
			if (i == Integer.parseInt(leasTerm) - 1) {
				// ���� --�ܵı���-��ǰ�ı����
				corpus = String.valueOf(Double.parseDouble(leasMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleTwo(corpus);
				System.out.println();
				inte = String.valueOf(Double.parseDouble(rent)
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
			// ========================bean��װ==========================
			FinancingRefundPlan planBean = new FinancingRefundPlan();
			planBean.setDrawings_id(drawings_id);
			planBean.setDoc_id(doc_id);
			planBean.setRefund_plan_date(addDate);
			planBean.setRefund_list(String.valueOf(i + 1));
			planBean.setRefund_money(rent);
			planBean.setRefund_corpus(corpus);
			planBean.setRefund_interest(inte);
			planBean.setRefund_rate(yearRate);
			planBean.setRefund_otherfee_money("0.00");
			planBean.setRefund_subtotal(rent);
			planBean.setState("0");
			planBean.setRefund_status("δ����");
			planBean.setRemark(".");
			// ========================list��װ==========================
			financingRefundPlan.add(planBean);
		}

		return financingRefundPlan;
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
	 * �жϻ�����Ƿ��Ǹ���ĩ�����һ��
	 * 
	 * @param start_date
	 * @param day
	 * @return
	 */
	public String getNewDate(String start_date, String day) {

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

	public static void main(String[] args) {
		List<FinancingRefundPlan> financingRefundPlan = new ArrayList<FinancingRefundPlan>();
		String drawings_id = "s3423432424";
		String doc_id = "55555555555555555";
		String leasMoney = "25650926.69";
		String leasTerm = "53";
		String lease_interval = "1";
		String yearRate = "7.590000";
		String period = "0";
		String startDate = "2011-11-7";
		FinancingCalcUtil financingCalcUtil = new FinancingCalcUtil();
		financingRefundPlan = financingCalcUtil.calcPlan(drawings_id, doc_id,
				leasMoney, leasTerm, lease_interval, yearRate, period,
				startDate);
		for (int i = 0; i < financingRefundPlan.size(); i++) {
			System.out
					.println(financingRefundPlan.get(i).getRefund_money()
							+ "---"
							+ financingRefundPlan.get(i).getRefund_list()
							+ "----"
							+ financingRefundPlan.get(i).getRefund_corpus()
							+ "----"
							+ financingRefundPlan.get(i).getRefund_plan_date());
		}
	}

}
