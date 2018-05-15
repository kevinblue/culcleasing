package com.tenwa.leasing.util.leasing;

import java.util.List;

/**
 * ��ӡ���ƻ���Ϣ ��Ŀ���ƣ�iulcleasing �����ƣ�PrintRentInfo �������� �����ˣ�ʷ��� ����ʱ�䣺2011-2-10
 * ����10:04:45 �޸��ˣ�ʷ��� �޸�ʱ�䣺2011-2-10 ����10:04:45 �޸ı�ע��
 * 
 * @version
 */
public class PrintRentInfo {

	public static void printRentInfo(List retn_list, List interest_list,
			List corp_list, List corp__overage_list, List l_inte_mark,
			List l_corpus_market, List l_corpus_overage_market) {
		// 0,1������ֵ �ȶ����,���������,�ֹ�����ʱ��Ϊ2ʱ�ȶ���Ȳ�������

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
