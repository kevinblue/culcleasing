package com.rent.calc.tx.bg;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * ������ʱ��irr������
 * 
 * @author Administrator
 * 
 */
public class IrrCalc {

	/**
	 * �ֽ����õ�irr
	 * 
	 * @param l_inflow_pour
	 * @param chjg
	 * @param zjjg
	 * @param nhkcs
	 * @return
	 */

	public static String getIRR(List l_inflow_pour, String chjg, String zjjg,
			String nhkcs) {
		chjg = chjg.equals("") ? "0" : chjg;
		zjjg = zjjg.equals("") ? "0" : zjjg;
		nhkcs = nhkcs.equals("") ? "0" : nhkcs;
		// ����˵����l_inflow_pour=�����ֽ���������������Ϊ��������Ϊ������chjg=���������
		// zjjg=�����,nhkcs=�껹�����
		// BigDecimal year_number = new BigDecimal("3");//�������
		BigDecimal year_number = new BigDecimal(chjg);// �������
		// BigDecimal rent_interval = new BigDecimal("3");//ÿ�������
		BigDecimal rent_interval = new BigDecimal(zjjg);// ÿ�������
		BigDecimal tmp = new BigDecimal("1");
		BigDecimal irr = new BigDecimal("0");
		BigDecimal tmp1 = new BigDecimal("0");
		BigDecimal tmp2 = new BigDecimal("100");
		BigDecimal bigdec_1 = new BigDecimal("1");
		BigDecimal bigdec_2 = new BigDecimal("2");
		int j = 0;
		try {
			while (tmp.abs().doubleValue() > 0.0000000001 && j < 100) {
				tmp = new BigDecimal(l_inflow_pour.get(0).toString());
				for (int i = 1; i < l_inflow_pour.size(); i++) {

					tmp = tmp.add(new BigDecimal(l_inflow_pour.get(i)
							.toString()).divide(new BigDecimal(Math.pow(irr
							.add(bigdec_1).doubleValue(), i)), 20,
							BigDecimal.ROUND_HALF_UP));
				}
				if (tmp.doubleValue() > 0) {
					tmp1 = irr;
					irr = irr.add(tmp2).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				if (tmp.doubleValue() < 0) {
					tmp2 = irr;
					irr = irr.add(tmp1).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				j++;
			}
			irr = irr.multiply(year_number).divide(rent_interval, 20,
					BigDecimal.ROUND_HALF_UP);
			// irr = irr.multiply(new BigDecimal("4"));
			irr = irr.multiply(new BigDecimal(nhkcs));
			return irr.toString().equals("") ? "0" : irr.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}

	
	
	

	/**
	 * �õ���֤����ڵ��������list �±�
	 * 
	 * @param rent_list
	 *            ���
	 * @param caut_money
	 *            ��֤��
	 * @return
	 */

	@SuppressWarnings("unused")
	private String[] getCautGreatRent(List rent_list, String caut_money) {
		String int_s = "";// ���ڼ�¼�±��

		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String[] i_array = null;
		if (Double.parseDouble(caut_money) > 0) {
			for (int i = rent_list.size() - 1; i >= 0; i--) {
				d_total += Double.parseDouble(rent_list.get(i).toString());
				int_s += i + ",";
				if (d_total > Double.parseDouble(caut_money)) {
					break;
				}
			}
			int_s = int_s.indexOf(",") > -1 ? int_s.substring(0,
					int_s.length() - 1) : int_s;// �õ����Եֿ۵������±�
			i_array = int_s.split(",");// ������Եֿ۵�����±�
		}
		return i_array;
	}

	/**
	 * �õ���֤��ֿ۵��µ����List
	 * 
	 * @param rent_list
	 *            ����б�
	 * @param i_array
	 *            �ֿܵ۵�����±�
	 * @param dcaut
	 *            ��֤��
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "unused" })
	private List getNewRentByCaut(List rent_list, String[] i_array, double dcaut) {

		for (int j = 0; j < i_array.length; j++) {
			double temp_rent = Double.parseDouble(rent_list.get(
					Integer.parseInt(i_array[j])).toString());// ���ڱ�������

			if (Double.parseDouble(rent_list.get(Integer.parseInt(i_array[j]))
					.toString()) < dcaut) {
				rent_list.set(Integer.parseInt(i_array[j]), "0");// ����֤����ڵ������Ϊ0
			} else {
				rent_list.set(Integer.parseInt(i_array[j]), Double
						.parseDouble(rent_list
								.get(Integer.parseInt(i_array[j])).toString())
						- dcaut);
			}
			dcaut = dcaut - temp_rent;// �޸ı�֤��ֿ۵�ֵ
		}
		return rent_list;
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
	@SuppressWarnings("unchecked")
	public List getRentCautNew(List rent_list, String caut_money) {
		// �õ��ֿܵ۵����list�±�
		String[] i_arry = getCautGreatRent(rent_list, caut_money);
		List r_list = getNewRentByCaut(rent_list, i_arry, Double
				.parseDouble(caut_money));
		return r_list;
	}

	/**
	 * ��ȡ��2010-07-20��2010-07�ַ���
	 * 
	 * @param date
	 * @return
	 */

	private String getYearAndMonth(String date) {
		return date.substring(0, 7);

	}

	/**
	 * ����list�е���𣬵õ�ÿ�µ��ֽ������
	 * 
	 * @param s_date
	 *            ���⿪ʼʱ�䣬
	 * @param e_date
	 *            ���һ�ڵĽ���ʱ��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getPreMonthCash(List rentList, List rentDtList) {

		List l_new_rent = new ArrayList();// ���
		List l_new_date = new ArrayList();// ����Ӧ��ʱ��

		// ��ʼ����
		String first_month = getYearAndMonth(rentDtList.get(0).toString());
		String add_start = first_month;
		// ���ս�������
		String last_month = getYearAndMonth(rentDtList.get(rentList.size() - 1)
				.toString());

		// �õ������֮����ܹ��ж��ٸ��·�
		int i_month = ToolUtil.getDateDiffMonth(first_month + "-01", last_month
				+ "-01");

		for (int i = 1; i < i_month + 2; i++) {

			// �жϵ�ǰ��ʱ���ǲ������Ѵ��ڵ���ʱ�������Ƶ�
			int pdI = ToolUtil.isInDateList(first_month, rentDtList);
			if (pdI > -1) {
				l_new_rent.add(rentList.get(pdI));
			} else {
				l_new_rent.add("0");
			}
			l_new_date.add(first_month + "-01");
			first_month = ToolUtil.getDateAdd(add_start + "-01", i, "mm")
					.substring(0, 7);
		}

		Hashtable ht = new Hashtable();
		ht.put("l_new_date", l_new_date);
		ht.put("l_new_rent", l_new_rent);
		return ht;

	}

	/**
	 * �õ�ȥ���ظ���ʱ�伯�ϣ�����һ������һ��ʱ�䣬��Ӧ�����ֽ𼯺ϵ��±�ļ�ֵ��
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public HashMap delRepeat(List l_date) {
		HashMap hmDate = new HashMap();
		List dtList = new ArrayList();
		String str = "";
		for (int i = 0; i < l_date.size(); i++) {

			if (!hmDate.containsKey(l_date.get(i).toString().substring(0, 7))) {
				hmDate.put(l_date.get(i).toString().substring(0, 7), String
						.valueOf(i));
				dtList.add(l_date.get(i));
			} else {
				str = (String) hmDate.get(l_date.get(i).toString().substring(0,
						7));
				str = str + "," + String.valueOf(i);
				hmDate.put(l_date.get(i).toString().substring(0, 7), str);

			}

		}
		return hmDate;

	}

	/**
	 * ����ʱ��õ�ÿ��ʱ������Ӧ���ֽ���
	 * 
	 * @param l_date
	 * @param l_cash
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getUniqCashByDate(List l_date, List l_cash) {
		HashMap map = delRepeat(l_date);
		List listNew = new ArrayList();

		Object[] obj = map.keySet().toArray();
		Arrays.sort(obj);

		for (int i = 0; i < obj.length; i++) {

			String[] strArray = map.get(obj[i].toString()).toString()
					.split(",");

			// �ܽ��,�õ�ͬһʱ����ܽ��
			String total = "0";
			for (int j = 0; j < strArray.length; j++) {
				total = String.valueOf(Double.parseDouble(total)
						+ Double.parseDouble(l_cash.get(
								Integer.parseInt(strArray[j].toString()))
								.toString()));
				total = Tools.formatNumberDoubleTwo(total);
			}
			listNew.add(total);

		}
		return listNew;

	}

}
