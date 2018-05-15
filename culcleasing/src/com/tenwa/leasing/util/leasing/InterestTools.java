package com.tenwa.leasing.util.leasing;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import com.tenwa.leasing.util.NumTools;

/**
 * 
 * 项目名称：iulcleasing 类名称：InterestTools 类描述： 利息计算 创建人：史鸿飞 创建时间：2011-1-25
 * 下午03:21:35 修改人：史鸿飞 修改时间：2011-1-25 下午03:21:35 修改备注：
 * 
 * @version
 */
public class InterestTools {
	private static Logger logger = Logger.getLogger(InterestTools.class);

	/**
	 * 
	 * @param rentList
	 *            租金list
	 * @param leaseMoney
	 *            要测算的本金
	 * @param calRate
	 *            计算的利率 qzOrqm 期初还是期未
	 * @return
	 */

	/**
	 * 租金利息算法
	 * 
	 * @Title: getInterestList
	 * @Description:
	 * @param
	 * @param rentList租金List
	 * @param
	 * @param leaseMoney总测算本金
	 * @param
	 * @param calRate测算利率
	 * @param
	 * @param qzOrqm期初或者期末
	 * @param
	 * @return
	 * @return List利息list
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm) {

		logger.info("传过来计算利率：" + calRate);
		// 用于保留利息
		List interests = new ArrayList();
		String corpus_total = "0";
		// 该期的利息
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// 本金余额
		corpus_overage = NumTools.formatNumberDoubleScale(leaseMoney, 2);

		for (int i = 0; i < rentList.size(); i++) {// 循环租金list

			if ("1".equals(qzOrqm) && i == 0) {// 第一期且是期初时
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = NumTools.formatNumberDoubleScale(inte, 2);
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息
				corpus = NumTools.formatNumberDoubleScale(corpus, 2);

			}

			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {
				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = NumTools.formatNumberDoubleScale(corpus, 2);

				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = NumTools.formatNumberDoubleScale(inte, 2);

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = NumTools.formatNumberDoubleScale(corpus_total, 2);

			// 本金余额
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = NumTools
					.formatNumberDoubleScale(corpus_overage, 2);
			// 添加list
			interests.add(inte);

		}

		return interests;
	}

	/**
	 * 等额本金的利息列表
	 * 
	 * @Title: getInterestByEqCorpus
	 * @Description:
	 * @param
	 * @param l_corpus_over本金余额
	 * @param
	 * @param cal_rate计算利息
	 * @param
	 * @param l_corpus_pre本金list
	 * @param
	 * @param type期初或期末
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getInterestByEqCorpus(List l_corpus_over, String cal_rate,
			List l_corpus_pre, String type) {

		// 用于保存利息列表
		List l_inte = new ArrayList();
		for (int i = 0; i < l_corpus_over.size(); i++) {

			String t = String.valueOf((Double.parseDouble(l_corpus_over.get(i)
					.toString()) + Double.parseDouble(l_corpus_pre.get(i)
					.toString()))
					* Double.parseDouble(cal_rate));
			t = NumTools.formatNumberDoubleScale(t, 2);

			if (i == 0 && "1".equals(type)) {
				t = "0";
			}
			l_inte.add(t);
		}
		return l_inte;
	}

}
