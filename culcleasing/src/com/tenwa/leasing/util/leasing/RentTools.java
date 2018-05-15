package com.tenwa.leasing.util.leasing;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import com.tenwa.leasing.util.NumTools;

/**
 * 
 * 项目名称：iulcleasing 类名称：RentTools 类描述： 租金值计算工具类 创建人：史鸿飞 创建时间：2011-1-25
 * 下午02:54:09 修改人：史鸿飞 修改时间：2011-1-25 下午02:54:09 修改备注：
 * 
 * @version
 */
public class RentTools {
	private static Logger logger = Logger.getLogger(RentTools.class);

	/**
	 * 用于计算每一期的租金
	 * 
	 * @param Rate
	 * @param Nper
	 * @param Pv
	 * @param Fv
	 * @param Type
	 * @return
	 */
	public static String getPMT(String Rate, String Nper, String Pv, String Fv,
			String Type) {

		// 参数说明：Pv=现值，Nper=期数，Rate=利率(注意同期数周期一致，且要求已经包括百分号的数值！如0.05)
		// Fv=未来值，Type=数字 1或 0，用以指定各期的付款时间是在期初还是期末
		Rate = Rate.equals("") ? "0" : Rate;
		Nper = Nper.equals("") ? "0" : Nper;
		Pv = Pv.equals("") ? "0" : Pv;
		Fv = Fv.equals("") ? "0" : Fv;
		Type = Type.equals("") ? "0" : Type;

		if (Double.parseDouble(Nper) == 0) {
			return "0";
		}
		if (Double.parseDouble(Rate) == 0) {
			// divide(xxxxx,2, BigDecimal.ROUND_HALF_EVEN)
			return ((new BigDecimal(Pv).add(new BigDecimal(Fv)).multiply(
					new BigDecimal("-1")).divide(new BigDecimal(Nper), 20,
					BigDecimal.ROUND_HALF_UP))).toString();
		}

		BigDecimal Pv_B = new BigDecimal(Pv);
		// BigDecimal Nper_B = new BigDecimal(Nper);
		BigDecimal Rate_B = new BigDecimal(Rate);
		BigDecimal Fv_B = new BigDecimal(Fv);
		BigDecimal Type_B = new BigDecimal(Type);
		BigDecimal pmt_B = new BigDecimal("0");
		BigDecimal num1_B = new BigDecimal("1");
		BigDecimal numfu1_B = new BigDecimal("-1");
		int Nper_i = Integer.valueOf(Nper).intValue();
		try {
			pmt_B = numfu1_B.multiply(Rate_B).multiply(
					Pv_B.multiply((num1_B.add(Rate_B)).pow(Nper_i)).add(Fv_B))
					.divide(
							(num1_B.add(Rate_B.multiply(Type_B)))
									.multiply((num1_B.add(Rate_B)).pow(Nper_i)
											.subtract(num1_B)), 20,
							BigDecimal.ROUND_HALF_UP);
			return pmt_B.toString().equals("") ? "0" : pmt_B.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}

	/**
	 * pmt 得到租金list
	 * 
	 * @Title: getRentListByPmt
	 * @Description:
	 * @param
	 * @param rent
	 *            pmt 测算出的租金
	 * @param
	 * @param rent_list
	 *            期数
	 * @param
	 * @param rents
	 *            存放租金的list
	 * @param
	 * @return
	 * @return List<String> 租金list
	 * @throws
	 */
	public static List<String> getRentListByPmt(String rent, String rent_list,
			List<String> rents) {

		for (int i = 0; i < Integer.parseInt(rent_list); i++) {
			rents.add(rent);
		}
		return rents;
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
	public List getRentByEqCorpus(List l_corpus, List l_inte, String rentScale,
			String type) {
		// 用于保存租金
		List l_rent = new ArrayList();
		for (int i = 0; i < l_corpus.size(); i++) {
			String r = String.valueOf(Double.parseDouble(l_corpus.get(i)
					.toString())
					+ Double.parseDouble(l_inte.get(i).toString()));
			r = NumTools
					.formatNumberDoubleScale(r, Integer.parseInt(rentScale));

			if (i == 0 && "1".equals(type)) {
				r = l_corpus.get(i).toString();
			}

			l_rent.add(r);
		}
		return l_rent;

	}

	/**
	 * 根据交易结构信息测算出新的租金
	 * 
	 * @Title: getRentByPmt
	 * @Description:
	 * @param
	 * @param mp租金测算信息
	 * @param
	 * @return
	 * @return String
	 * @throws
	 */
	public static String getRentByPmt(HashMap mp) {

		String retu_vale = mp.get("retu_vale").toString();
		String rem_rent_list = mp.get("rem_rent_list").toString();
		String rem_corpus = mp.get("rem_corpus").toString();
		String period_type = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		String nominalprice = mp.get("nominalprice").toString();
		String rentScale = mp.get("rentScale").toString();

		// 得到每一期租金的利率
		retu_vale = RateTools.getPreRate(retu_vale, income_number_year);

		// 得到新的租金测算期次,由于宽限期不用于pmt的租金测算
		rem_rent_list = String.valueOf(Integer.parseInt(mp.get("rem_rent_list")
				.toString())
				- Integer.parseInt(mp.get("igrace").toString()));

		// 得到租金
		String rent = getPMT(retu_vale, rem_rent_list, "-" + rem_corpus,
				nominalprice, period_type);
		logger.info("新的租金 :" + rent);
		return NumTools.formatNumberDoubleScale(rent, Integer
				.parseInt(rentScale));
	}

}
