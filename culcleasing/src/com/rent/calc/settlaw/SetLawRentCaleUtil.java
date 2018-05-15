package com.rent.calc.settlaw;

import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.rent.calc.bg.IrrCal;
import com.rent.calc.tx.bg.ToolUtil;

/**
 * ƽϢ�������㹤����
 * 
 * @author shf
 * 
 */
public class SetLawRentCaleUtil {

	/**
	 * �õ���һ�ڵ�����
	 * 
	 * @param type
	 *            ��������
	 * @param lease_interval
	 *            �����
	 * @param plan_date
	 *            �ƻ�����
	 * @return
	 */
	public String getFirstDate(String type, String lease_interval,
			String plan_date) {
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = plan_date;
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
			day = start_date.substring(start_date.lastIndexOf("-") + 1,
					start_date.length());
		}

		if (type.equals("0")) {
			start_date = getNewDate(start_date, day);
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("��һ��ʱ��:" + start_date);
		return start_date;
	}


	/**
	 * 
	 * @param rentList
	 *            ��� list
	 * @param perType
	 *            �ڳ�������δ
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getPlanDateList(List rentList, String perType,
			String lease_interval, String plan_date, String grace, String delay) {
		
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = getFirstDate(perType, lease_interval, plan_date);
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
			day = plan_date.substring(plan_date.lastIndexOf("-") + 1, plan_date
					.length());
		}
		List l_date = new ArrayList();
		// �ӳ������ڴ���
		start_date = Tools.dateAdd("month", Integer.parseInt(delay)
				* Integer.parseInt(lease_interval), start_date);

		for (int i = 0; i < rentList.size(); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date);
			addDate = getNewDate(addDate, day);

			l_date.add(addDate);
		}

		return l_date;
	}


	/**
	 * �жϸ������µõ���ʵ��ÿ�µ���� ����
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


	/**
	 * �õ�����List
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusList(String leaseMoney, String income_number,
			String rentScale, String grace, String delay) {
		
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		

		String total = "0";// �ۻ�ÿһ�ڵı���
		String preCorpus = Tools.formatNumberDoubleScale(String.valueOf(Double
				.parseDouble(leaseMoney)
				/ Double.parseDouble(income_number)), Integer
				.parseInt(rentScale));
		List corpus_list = new ArrayList();

		// ���ӿ�����,�ӳ��ڵı���ֵ
		for (int i = 0; i < Integer.parseInt(grace); i++) {
			corpus_list.add("0");
		}

		String newcorpus = "0";
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			newcorpus = preCorpus;
			if (i == Integer.parseInt(income_number) - 1) {
				newcorpus = Tools.formatNumberDoubleScale(String.valueOf(Double
						.parseDouble(leaseMoney)
						- Double.parseDouble(total)), Integer
						.parseInt(rentScale));
			}

			corpus_list.add(newcorpus);
			total = Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(total)
					+ Double.parseDouble(preCorpus)), Integer
					.parseInt(rentScale));

		}

		return corpus_list;
	}


	/**
	 * ÿһ�ڵ����ֵ
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @return
	 */
	public String getRent(String leaseMoney, String income_number,
			String yearRate, String lease_interval, String rentScale) {

		ToolUtil tu = new ToolUtil();
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(yearRate,
				lease_interval), 12);

		return Tools.formatNumberDoubleScale(String
				.valueOf((Double.parseDouble(leaseMoney) + Double
						.parseDouble(leaseMoney)
						* Double.parseDouble(preRate)
						* Integer.parseInt(income_number))
						/ Integer.parseInt(income_number)), Integer
				.parseInt(rentScale));

	}


	/**
	 * �õ�����б�
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentList(String leaseMoney, String income_number,
			String yearRate, String lease_interval, String rentScale,
			String grace, String delay) {
		
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		String rent = Tools.formatNumberDoubleScale(getRent(leaseMoney,
				income_number, yearRate, lease_interval, rentScale), Integer
				.parseInt(rentScale));
		List rent_list = new ArrayList();
		// // �ӳ���
		// for (int i = 0; i < Integer.parseInt(delay); i++) {
		// rent_list.add("0");
		// }
		// ������
		ToolUtil tu = new ToolUtil();
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(yearRate,
				lease_interval), 12);
		for (int i = 0; i < Integer.parseInt(grace); i++) {
			rent_list.add(Tools
					.formatNumberDoubleScale(String.valueOf(Double
							.parseDouble(leaseMoney)
							* Double.parseDouble(preRate)), Integer
							.parseInt(rentScale)));
		}

		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			rent_list.add(rent);
		}
		return rent_list;

	}


	/**
	 * �г���Ϣ����
	 * 
	 * @param rent_list
	 * @param corpus_list
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterMarket(List rent_list, List corpus_list,
			String rentScale) {

		List inter_list = new ArrayList();
		for (int i = 0; i < rent_list.size(); i++) {
			String s_inter = String.valueOf(Double.parseDouble(Tools
					.formatNumberDoubleScale(rent_list.get(i).toString(),
							Integer.parseInt(rentScale)))
					- Double.parseDouble(Tools.formatNumberDoubleScale(
							corpus_list.get(i).toString(), Integer
									.parseInt(rentScale))));
			inter_list.add(Tools.formatNumberDoubleScale(s_inter, Integer
					.parseInt(rentScale)));
		}
		return inter_list;
	}


	/**
	 * �õ��г���irr
	 * 
	 * @param firstMoney
	 * @param rent_list
	 * @param lease_interval
	 * @param type
	 * @param grace
	 *            ������
	 * 
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public String getIrr(String firstMoney, List rent_list,
			String lease_interval, String type, String delay, String grace) {
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		List new_list = new ArrayList();
		int i = 0;
		if ("1".equals(type)) {// �ȸ�ʱ
			i++;
			new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double
					.parseDouble(firstMoney)
					+ Double.parseDouble(rent_list.get(0).toString()))));
		} else {
			new_list.add(Tools.formatNumberDoubleTwo(firstMoney));
		}

		// 2011-04��15ע��
		// //�������ӳٵ�����ֽ���
		// for (int j = 0; j < Integer.parseInt(delay); j++) {
		// new_list.add("0");
		// }

		// 2011-04��15���Ӳ��ӿ����ڿ�ʼ���ֽ���irr
		i=i+Integer.parseInt(grace);
		

		for (; i < rent_list.size(); i++) {
			new_list.add(rent_list.get(i));
		}

		IrrCal ic = new IrrCal();
		String irr_market = Tools.formatNumberDoubleScale(ic.getIRR(new_list,
				lease_interval, lease_interval, String.valueOf(12 / Integer
						.parseInt(lease_interval))), 12);
		return irr_market;
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
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm, String rentScale, String grace,
			String delay) {
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		System.out.println("�������������ʣ�" + calRate);
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

		// ������ �ӳ�
		// int igrace = Integer.parseInt(grace) + Integer.parseInt(delay);
		// int igrace = Integer.parseInt(delay);
		// if (igrace > 0) {
		// //igrace--;
		// }
		// /�ӳ�
		// for (int i = 0; i < Integer.parseInt(delay); i++) {
		// interests.add("0");
		// }

		// ������
		 for (int i = 0; i < Integer.parseInt(grace); i++) {
		 interests.add(rentList.get(i));
		 }
		//int igrace = 0;
		for (int i = Integer.parseInt(grace); i < rentList.size(); i++) {// ѭ�����list

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
			// ����list
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

	@SuppressWarnings("unchecked")
	public List getCorpusList(List rentList, List inteList, String rentScale,
			String grace, String delay) {
		
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		List corpus_list = new ArrayList();
		// ������
		// int igrace = Integer.parseInt(grace) + Integer.parseInt(delay);
		// if (igrace > 0) {
		// igrace--;
		// }
		// for (int i = 0; i < Integer.parseInt(grace) +
		// Integer.parseInt(delay); i++) {
		// corpus_list.add("0");
		// }
		int igrace = 0;
		for (int i = igrace; i < rentList.size(); i++) {

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
	 *            ÿһ�ڵı���
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusOvergeList(String leaseMoney, List corpusList,
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
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(rentScale)));

		}
		return corps;
	}


	/**
	 * �õ�����б� ָ���ж��ٸ����ֵ
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentListByCount(String leaseMoney, String income_number,
			String yearRate, String lease_interval, String rentScale, String qs) {

		String rent = Tools.formatNumberDoubleScale(getRent(leaseMoney,
				income_number, yearRate, lease_interval, rentScale), Integer
				.parseInt(rentScale));
		List rent_list = new ArrayList();
		for (int i = 0; i < Integer.parseInt(qs); i++) {
			rent_list.add(rent);
		}

		return rent_list;
	}


	public static void main(String[] args) {
		SetLawRentCaleUtil sr = new SetLawRentCaleUtil();
		System.out.println(sr.getRent("1000000", "24", "9.05", "1", "3"));
	}

}