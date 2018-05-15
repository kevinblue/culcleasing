package com.tenwa.leasing.util.leasing;

import java.util.ArrayList;
import java.util.List;

import com.tenwa.leasing.util.NumTools;

/**
 * 
 * 项目名称：iulcleasing 类名称：CorpusOvergeTools 类描述： 本金余额测算 创建人：史鸿飞 创建时间：2011-1-25
 * 下午03:24:26 修改人：史鸿飞 修改时间：2011-1-25 下午03:24:26 修改备注：
 * 
 * @version
 */
public class CorpusOvergeTools {

	/**
	 * 
	 * @param leaseMoney总的测算本金
	 * @param corpusList
	 *            每一期的本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusOvergeList(String leaseMoney, List corpusList) {
		String total = "0";// 累积每一期的本金
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = NumTools.formatNumberDoubleScale(total, 2);

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			corps.add(NumTools.formatNumberDoubleScale(String.valueOf(d), 2));
		}
		return corps;
	}
}
