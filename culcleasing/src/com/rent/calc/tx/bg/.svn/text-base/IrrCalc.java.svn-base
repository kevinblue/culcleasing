package com.rent.calc.tx.bg;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * 租金测算时的irr处理类
 * 
 * @author Administrator
 * 
 */
public class IrrCalc {

	/**
	 * 现金流得到irr
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
		// 参数说明：l_inflow_pour=所有现金流入流出（流入为正，流出为负），chjg=偿还间隔，
		// zjjg=租金间隔,nhkcs=年还款次数
		// BigDecimal year_number = new BigDecimal("3");//偿还间隔
		BigDecimal year_number = new BigDecimal(chjg);// 偿还间隔
		// BigDecimal rent_interval = new BigDecimal("3");//每期租金间隔
		BigDecimal rent_interval = new BigDecimal(zjjg);// 每期租金间隔
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
	 * 得到保证金大于的租金的租金list 下标
	 * 
	 * @param rent_list
	 *            租金
	 * @param caut_money
	 *            保证金
	 * @return
	 */

	@SuppressWarnings("unused")
	private String[] getCautGreatRent(List rent_list, String caut_money) {
		String int_s = "";// 用于记录下标的

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
					int_s.length() - 1) : int_s;// 得到可以抵扣的租金的下标
			i_array = int_s.split(",");// 保存可以抵扣的租金下标
		}
		return i_array;
	}

	/**
	 * 得到保证金抵扣的新的租金List
	 * 
	 * @param rent_list
	 *            租金列表
	 * @param i_array
	 *            能抵扣的租金下标
	 * @param dcaut
	 *            保证金
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "unused" })
	private List getNewRentByCaut(List rent_list, String[] i_array, double dcaut) {

		for (int j = 0; j < i_array.length; j++) {
			double temp_rent = Double.parseDouble(rent_list.get(
					Integer.parseInt(i_array[j])).toString());// 用于保存的租金

			if (Double.parseDouble(rent_list.get(Integer.parseInt(i_array[j]))
					.toString()) < dcaut) {
				rent_list.set(Integer.parseInt(i_array[j]), "0");// 将保证金大于的租金设为0
			} else {
				rent_list.set(Integer.parseInt(i_array[j]), Double
						.parseDouble(rent_list
								.get(Integer.parseInt(i_array[j])).toString())
						- dcaut);
			}
			dcaut = dcaut - temp_rent;// 修改保证金抵扣的值
		}
		return rent_list;
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
		// 得到能抵扣的租金list下标
		String[] i_arry = getCautGreatRent(rent_list, caut_money);
		List r_list = getNewRentByCaut(rent_list, i_arry, Double
				.parseDouble(caut_money));
		return r_list;
	}

	/**
	 * 截取如2010-07-20的2010-07字符串
	 * 
	 * @param date
	 * @return
	 */

	private String getYearAndMonth(String date) {
		return date.substring(0, 7);

	}

	/**
	 * 租金的list中的租金，得到每月的现金流情况
	 * 
	 * @param s_date
	 *            起租开始时间，
	 * @param e_date
	 *            最后一期的结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getPreMonthCash(List rentList, List rentDtList) {

		List l_new_rent = new ArrayList();// 租金
		List l_new_date = new ArrayList();// 所对应的时间

		// 开始日期
		String first_month = getYearAndMonth(rentDtList.get(0).toString());
		String add_start = first_month;
		// 最终结束日期
		String last_month = getYearAndMonth(rentDtList.get(rentList.size() - 1)
				.toString());

		// 得到该租金之间的总共有多少个月份
		int i_month = ToolUtil.getDateDiffMonth(first_month + "-01", last_month
				+ "-01");

		for (int i = 1; i < i_month + 2; i++) {

			// 判断当前的时间是不是与已存在的是时间有类似的
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
	 * 得到去除重复的时间集合，返回一个含有一个时间，对应他的现金集合的下标的键值对
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
	 * 根据时间得到每个时间所对应的现金流
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

			// 总金额,得到同一时间的总金额
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
