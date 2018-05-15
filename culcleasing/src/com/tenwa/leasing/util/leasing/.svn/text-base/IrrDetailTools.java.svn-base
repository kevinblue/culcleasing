package com.tenwa.leasing.util.leasing;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

/**
 * 现金流明细工具类 项目名称：iulcleasing 类名称：IrrDetailTools 类描述： 创建人：史鸿飞 创建时间：2011-2-9
 * 下午03:30:43 修改人：史鸿飞 修改时间：2011-2-9 下午03:30:43 修改备注：
 * 
 * @version
 */
public class IrrDetailTools {

	/**
	 * 得到保证金抵扣租金List
	 * 
	 * @Title: getRentCautNew
	 * @Description:
	 * @param
	 * @param rent_list租金List
	 * @param
	 * @param caut_money保证金
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getRentCautNew(List rentlist, String caut_money) {
		List rent_list = new ArrayList(rentlist);
		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// 用于记录下标的
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
					int_s.length() - 1) : int_s;// 得到可以抵扣的租金的下标
			String[] i_array = int_s.split(",");// 保存可以抵扣的租金下标
			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// 用于保存的租金
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					rent_list.set(Integer.parseInt(i_array[j]), "0");// 将保证金大于的租金设为0
				} else {
					rent_list.set(Integer.parseInt(i_array[j]), Double
							.parseDouble(rent_list.get(
									Integer.parseInt(i_array[j])).toString())
							- dcaut);
				}
				dcaut = dcaut - temp_rent;// 修改保证金抵扣的值
			}
		}
		return rent_list;
	}

	/**
	 * 得到保证金抵扣租金List 现金 流明细
	 * 
	 * @Title: getRentDetails
	 * @Description:
	 * @param
	 * @param rent_list租金List
	 * @param
	 * @param caut_money保证金
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getRentDetails(List rent_list, String caut_money) {

		// 先构造正常情况下的租金 明细
		List cash_follow_detail = new ArrayList();

		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// 用于记录下标的
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
					int_s.length() - 1) : int_s;// 得到可以抵扣的租金的下标
			String[] i_array = int_s.split(",");// 保存可以抵扣的租金下标

			System.out.println("id_s:" + int_s);

			Hashtable ht = null;// 用于保持现金流的明细
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "租金：" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// 用于保存的租金
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					// rent_list.set(Integer.parseInt(i_array[j]),
					// "0");//将保证金大于的租金设为0

					// 现金流明细处理
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(
							Integer.parseInt(i_array[j])).toString());
					ht.put("follow_in_detail", "租金："
							+ rent_list.get(Integer.parseInt(i_array[j]))
									.toString());
					ht.put("follow_out", rent_list.get(
							Integer.parseInt(i_array[j])).toString());
					ht.put("follow_out_detail", "保证金抵扣："
							+ rent_list.get(Integer.parseInt(i_array[j]))
									.toString());
					ht.put("net_follow", "0");

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				} else {
					// 现金流明细处理
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(
							Integer.parseInt(i_array[j])).toString());
					ht.put("follow_in_detail", "租金："
							+ rent_list.get(Integer.parseInt(i_array[j]))
									.toString());
					ht.put("follow_out", dcaut);
					ht.put("follow_out_detail", "保证金抵扣：" + dcaut);
					ht.put("net_follow", Double.parseDouble(rent_list.get(
							Integer.parseInt(i_array[j])).toString())
							- dcaut);

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				}
				dcaut = dcaut - temp_rent;// 修改保证金抵扣的值
			}
		} else {

			Hashtable ht = null;
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "租金：" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

		}
		return cash_follow_detail;
	}

}
