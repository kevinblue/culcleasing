package com.tenwa.leasing.util.leasing;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import com.tenwa.leasing.util.NumTools;

/**
 * 
 * 项目名称：iulcleasing 类名称：CorpusTools 类描述： 本金测算 创建人：史鸿飞 创建时间：2011-1-25 下午03:23:39
 * 修改人：史鸿飞 修改时间：2011-1-25 下午03:23:39 修改备注：
 * 
 * @version
 */
public class CorpusTools {

	private static Logger logger = Logger.getLogger(CorpusTools.class);

	/**
	 * pmt 本金算法
	 * 
	 * @Title: getCorpusList
	 * @Description:
	 * @param
	 * @param rentList租金List
	 * @param
	 * @param inteList利息List
	 * @param
	 * @return
	 * @return List本金List
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
	 * 等额本金,得到本金list
	 * 
	 * @Title: eqCorpusList
	 * @Description:
	 * @param
	 * @param leaseMoney测算本金值
	 * @param
	 * @param incomeNumber总的测算期数
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List eqCorpusList(String leaseMoney, String incomeNumber) {

		String corpu = "";

		// 得到每期的本金,总的本金/期限
		corpu = String.valueOf(Double.parseDouble(leaseMoney)
				/ Integer.parseInt(incomeNumber));
		corpu = NumTools.formatNumberDoubleScale(corpu, 2);

		logger.info("每一期的本金:" + corpu);
		String total = "0";// 用于积累前面的本金和

		// 用于保存本金
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(incomeNumber); i++) {
			// 最后一期是要作特别的处理

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
