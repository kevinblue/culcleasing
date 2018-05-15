package com.tenwa.leasing.util.leasing;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.tenwa.leasing.util.DateTools;
import com.tenwa.leasing.util.NumTools;

/**
 * 现金流处理 项目名称：iulcleasing 类名称：IrrTools 类描述： 创建人：史鸿飞 创建时间：2011-2-9 下午02:10:53
 * 修改人：史鸿飞 修改时间：2011-2-9 下午02:10:53 修改备注：
 * 
 * @version
 */
public class IrrTools {

	/**
	 * 去除时间集合中的重复时间，返回含有时间（键），对应他的租金集合的下标（值）
	 * 
	 * @Title: IdenDateListInfo
	 * @Description:
	 * @param
	 * @param dateList
	 * @param
	 * @return
	 * @return HashMap
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public HashMap idenDateListInfo(List dateList) {
		HashMap hmDate = new HashMap();
		List dtList = new ArrayList();
		String str = "";
		for (int i = 0; i < dateList.size(); i++) {

			if (!hmDate.containsKey(dateList.get(i).toString().substring(0, 7))) {
				hmDate.put(dateList.get(i).toString().substring(0, 7), String
						.valueOf(i));
				dtList.add(dateList.get(i));
			} else {
				str = (String) hmDate.get(dateList.get(i).toString().substring(
						0, 7));
				str = str + "," + String.valueOf(i);
				hmDate.put(dateList.get(i).toString().substring(0, 7), str);
			}

		}
		// hmDate.put("dtList", dtList);// 去除重复时间后的时间集合
		return hmDate;

	}

	/**
	 * 根据时间list,租金list得到某个时间的租金总值
	 * 
	 * @Title: getUniqueByDate
	 * @Description:
	 * @param
	 * @param cashList
	 * @param
	 * @param dateList
	 * @param
	 * @return 净现金流
	 * @return HashMap
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public HashMap getUniqueByDate(List cashList, List dateList) {
		HashMap map = this.idenDateListInfo(dateList);
		List listNew = new ArrayList();

		HashMap hmCash = new HashMap();

		Object[] obj = map.keySet().toArray();
		Arrays.sort(obj);

		for (int i = 0; i < obj.length; i++) {

			String[] strArray = map.get(obj[i].toString()).toString()
					.split(",");

			// 总金额,得到同一时间的总金额d
			String total = "0";
			for (int j = 0; j < strArray.length; j++) {
				total = String.valueOf(Double.parseDouble(total)
						+ Double.parseDouble(cashList.get(
								Integer.parseInt(strArray[j].toString()))
								.toString()));
				total = NumTools.formatNumberDoubleScale(total, 2);
			}
			listNew.add(total);

		}
		hmCash.put("listNew", listNew);
		return hmCash;
	}

	/**
	 * 根据租金计划，日期list构造每月的现金流
	 * 
	 * @Title: getPreMonthCashInfo
	 * @Description:
	 * @param
	 * @param rentList
	 * @param
	 * @param dtList
	 * @param
	 * @return
	 * @return Hashtable<String,String>
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public Hashtable<String, String> getPreMonthCashInfo(List rentList,
			List dtList) {

		Hashtable ht_cash = new Hashtable<String, String>();
		String first_month = dtList.get(0).toString().substring(0, 7);
		String add_start = first_month;
		String last_month = dtList.get(dtList.size() - 1).toString().substring(
				0, 7);
		List<String> cashList = new ArrayList<String>();
		List<String> dateList = new ArrayList<String>();

		int i_month = DateTools.getDateDiffMonth(first_month + "-01",
				last_month + "-01");

		for (int i = 1; i < i_month + 2; i++) {
			// 判断当前的时间是不是与已存在的是时间有类似的
			int pdI = this.isInDateList(first_month, dtList);
			if (pdI > -1) {
				cashList.add(rentList.get(pdI).toString());
			} else {
				cashList.add("0");
			}
			dateList.add(first_month + "-01");
			first_month = DateTools.getDateAdd(add_start + "-01", i, "mm")
					.substring(0, 7);
		}
		ht_cash.put("dateList", dateList);
		ht_cash.put("cashList", cashList);
		return ht_cash;

	}

	/**
	 * 判断某个日期是不是在某个时间集合中，如在测返回他的集合下标，如果不存在则返回－1
	 * 
	 * @Title: isInDateList
	 * @Description:
	 * @param
	 * @param date
	 * @param
	 * @param inList
	 * @param
	 * @return
	 * @return int
	 * @throws
	 */
	public int isInDateList(String date, List inList) {
		for (int i = 0; i < inList.size(); i++) {
			if (date.equals(inList.get(i).toString().subSequence(0, 7))) {
				return i;
			}
		}
		return -1;
	}

	/**
	 * 根据租金现金流，偿还间隔，租金间隔，年还款次数测算irr
	 * 
	 * @param l_inflow_pour所有现金流入流出
	 * @param chjg偿还间隔
	 * @param zjjg租金间隔
	 * @param nhkcs年还款次数
	 * @return
	 */

	public String getIRR(List l_inflow_pour, String chjg, String zjjg,
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

}
