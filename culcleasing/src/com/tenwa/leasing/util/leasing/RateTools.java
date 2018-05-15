package com.tenwa.leasing.util.leasing;

/**
 * 利率计算类 项目名称：iulcleasing 类名称：RateTools 类描述： 创建人：史鸿飞 创建时间：2011-2-10 上午09:35:29
 * 修改人：史鸿飞 修改时间：2011-2-10 上午09:35:29 修改备注：
 * 
 * @version
 */
public class RateTools {

	/**
	 * 计算每一期测算时的利率值
	 * 
	 * @Title: getPreRate
	 * @Description:
	 * @param
	 * @param calcRate所要计算的年利率或irr
	 * @param
	 * @param lease_interval
	 *            租金间隔
	 * @param
	 * @return
	 * @return String
	 * @throws
	 */
	@SuppressWarnings("unused")
	public static String getPreRate(String calcRate, String lease_interval) {

		return String.valueOf(Double.parseDouble(calcRate) / 12 / 100
				* Integer.parseInt(lease_interval));
	}

}
