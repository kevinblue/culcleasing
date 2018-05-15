package com.tenwa.leasing.util.leasing;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import com.tenwa.leasing.util.NumTools;

/**
 * 
 * ��Ŀ���ƣ�iulcleasing �����ƣ�CorpusTools �������� ������� �����ˣ�ʷ��� ����ʱ�䣺2011-1-25 ����03:23:39
 * �޸��ˣ�ʷ��� �޸�ʱ�䣺2011-1-25 ����03:23:39 �޸ı�ע��
 * 
 * @version
 */
public class CorpusTools {

	private static Logger logger = Logger.getLogger(CorpusTools.class);

	/**
	 * pmt �����㷨
	 * 
	 * @Title: getCorpusList
	 * @Description:
	 * @param
	 * @param rentList���List
	 * @param
	 * @param inteList��ϢList
	 * @param
	 * @return
	 * @return List����List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusList(List rentList, List inteList) {
		List corpus_list = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			corpus_list.add(NumTools.formatNumberDoubleScale(String
					.valueOf(Double.parseDouble(rentList.get(i).toString())
							- Double.parseDouble(inteList.get(i).toString())),
					2));
		}
		return corpus_list;
	}

	/**
	 * �ȶ��,�õ�����list
	 * 
	 * @Title: eqCorpusList
	 * @Description:
	 * @param
	 * @param leaseMoney���㱾��ֵ
	 * @param
	 * @param incomeNumber�ܵĲ�������
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List eqCorpusList(String leaseMoney, String incomeNumber) {

		String corpu = "";

		// �õ�ÿ�ڵı���,�ܵı���/����
		corpu = String.valueOf(Double.parseDouble(leaseMoney)
				/ Integer.parseInt(incomeNumber));
		corpu = NumTools.formatNumberDoubleScale(corpu, 2);

		logger.info("ÿһ�ڵı���:" + corpu);
		String total = "0";// ���ڻ���ǰ��ı����

		// ���ڱ��汾��
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(incomeNumber); i++) {
			// ���һ����Ҫ���ر�Ĵ���

			if (i == Integer.parseInt(incomeNumber) - 1) {
				double d = Double.parseDouble(leaseMoney)
						- Double.parseDouble(total);
				l_corpus.add(NumTools.formatNumberDoubleScale(
						String.valueOf(d), 2));
			} else {
				l_corpus.add(corpu);
				total = String.valueOf(Double.parseDouble(total)
						+ Double.parseDouble(corpu));
				total = NumTools.formatNumberDoubleScale(total, 2);
			}

		}

		return l_corpus;

	}

}
