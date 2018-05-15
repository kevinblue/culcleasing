package com.tenwa.leasing.util.leasing;

import java.util.List;

/**
 * 打印租金计划信息 项目名称：iulcleasing 类名称：PrintRentInfo 类描述： 创建人：史鸿飞 创建时间：2011-2-10
 * 上午10:04:45 修改人：史鸿飞 修改时间：2011-2-10 上午10:04:45 修改备注：
 * 
 * @version
 */
public class PrintRentInfo {

	public static void printRentInfo(List retn_list, List interest_list,
			List corp_list, List corp__overage_list, List l_inte_mark,
			List l_corpus_market, List l_corpus_overage_market) {
		// 0,1，其他值 等额租金,不规则测算,手工调整时，为2时等额本金，先不做考虑

		System.out.println(" rent" + " \t corpus" + " \t interest "
				+ " \t corpus_overage" + " \t interest_market"
				+ " \t corpus_market " + " \t corpus_overage_market");

		for (int j = 0; j < retn_list.size(); j++) {
			System.out.println(retn_list.get(j) + "\t" + corp_list.get(j)
					+ "\t" + interest_list.get(j) + "\t"
					+ corp__overage_list.get(j) + "\t" + l_inte_mark.get(j)
					+ "\t" + l_corpus_market.get(j) + "\t"
					+ l_corpus_overage_market.get(j) + "\t");
		}
	}
}
