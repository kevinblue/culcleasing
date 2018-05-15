package com.rent.calc.update;

import java.util.ArrayList;
import java.util.List;

import com.Tools;

/**
 * 等本租金测算计算类
 * 
 * @author Administrator
 * 
 */
public class EqualCorpus extends RentCommon {

	/**
	 * 
	 * @param lease_money
	 *            总测算本金
	 * @param income_number
	 *            总的还租次数
	 * @return
	 */
	@SuppressWarnings("unused")
	public String getPreCorpus(String lease_money, String income_number) {

		String corpu = "";
		// 得到每期的本金,总的本金/期限
		corpu = String.valueOf(Double.parseDouble(lease_money)
				/ Integer.parseInt(income_number));

		corpu = Tools.formatNumberDoubleScale(corpu, Integer
				.parseInt(ConstantInfo.MONEYSCALE));

		System.out.println("每一期的本金:" + corpu);
		return corpu;
	}

	/**
	 * 等额本金 集合
	 * 
	 * @param corpus
	 *            每一期的本金
	 * @param income_number
	 *            总的还租期数
	 * @param lease_money
	 *            总的还租本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqCorpusList(String corpus, String income_number,
			String lease_money) {

		String total = "0";// 用于积累前面的本金和

		// 用于保存本金
		List l_corpus = new ArrayList();
		for (int i = 0; i < Integer.parseInt(income_number); i++) {

			// 最后一期是要作特别的处理,格式化时有小数的细微差别
			if (i == Integer.parseInt(income_number) - 1) {
				double d = Double.parseDouble(lease_money)
						- Double.parseDouble(total);
				l_corpus.add(Tools.formatNumberDoubleTwo(String.valueOf(d)));
			} else {
				l_corpus.add(corpus);
				total = String.valueOf(Double.parseDouble(total)
						+ Double.parseDouble(corpus));
				total = Tools.formatNumberDoubleScale(total, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
			}

		}

		return l_corpus;

	}

	/**
	 * 等额本金的利息列表
	 * 
	 * @param l_corpus_over
	 *            本金余额
	 * @param cal_rate
	 *            每一期的利率
	 * @param l_corpus_pre
	 *            本金
	 * @param period_type
	 *            期初或期限末
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestByEqCorpus(List l_corpus_over, String cal_rate,
			List l_corpus_pre, String period_type) {

		// 用于保存利息列表
		List l_inte = new ArrayList();
		for (int i = 0; i < l_corpus_over.size(); i++) {
			
			String t = String.valueOf((Double.parseDouble(l_corpus_over.get(i)
					.toString()) + Double.parseDouble(l_corpus_pre.get(i)
					.toString()))
					* Double.parseDouble(cal_rate));
			t = Tools.formatNumberDoubleScale(t, Integer
					.parseInt(ConstantInfo.MONEYSCALE));

			if (i == 0 && "1".equals(period_type)) {
				t = "0";
			}
			l_inte.add(t);
		}
		return l_inte;
	}
	
	
	
	
	/**
	 * 等额本金的租金列表
	 * 
	 * @param l_corpus
	 *            本金列表
	 * @param l_inte
	 *            利息列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentByEqCorpus(List l_corpus, List l_inte) {
		// 用于保存租金
		List l_rent = new ArrayList();
		for (int i = 0; i < l_corpus.size(); i++) {
			String r = String.valueOf(Double.parseDouble(l_corpus.get(i)
					.toString())
					+ Double.parseDouble(l_inte.get(i).toString()));
			r = Tools.formatNumberDoubleScale(r, Integer
					.parseInt(ConstantInfo.MONEYSCALE));
			//由于利息已做了处理
			//if (i == 0 && "1".equals(this.period_type)) {
				//r = l_corpus.get(i).toString();
			//}

			l_rent.add(r);
		}
		return l_rent;

	}

	
	
	
	
	

}
