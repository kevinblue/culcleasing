package com.rent.calc.update;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.Tools;

/**
 * 租金测算常用方法
 * 
 * @author Administrator
 * 
 */
public class RentCalc extends RentCommon{


	/**
	 * 等额租金时的每一期的租金测算方法
	 * 
	 * @param Rate
	 * @param Nper
	 * @param Pv
	 * @param Fv
	 * @param Type
	 * @return
	 */
	private String getPMT(String Rate, String Nper, String Pv, String Fv,
			String Type) {
		// 参数说明：Pv=现值，Nper=期数，Rate=利率(注意同期数周期一致，且要求已经包括百分号的数值！如0.05)
		// Fv=未来值，Type=数字 1或 0，用以指定各期的付款时间是在期初还是期末
		Rate = Rate.equals("") ? "0" : Rate;
		Nper = Nper.equals("") ? "0" : Nper;
		Pv = Pv.equals("") ? "0" : Pv;
		Fv = Fv.equals("") ? "0" : Fv;
		Type = Type.equals("") ? "0" : Type;
		BigDecimal Pv_B = new BigDecimal(Pv);
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
	 * 计算每一期的租金(等额时)
	 * 
	 * @param calcRate
	 *            每一期租金的间隔利率
	 * @param lease_money
	 *            所要计算的本金
	 * @param period_type
	 *            期初还是期末
	 * @param income_number
	 *            总还租期数
	 * @param future_money
	 *            租金计算将来值
	 * @return
	 */
	public String getEqRent(String calcRate, String lease_money,
			String period_type, String income_number, String future_money) {

		// 根据pmt公司来计算新的租金
		String rent = getPMT(calcRate, income_number, "-"
				+ judgeLeaseMoney(lease_money), future_money, period_type);

		// 租金的小数位保存
		rent = Tools.formatNumberDoubleScale(rent, Integer
				.parseInt(ConstantInfo.MONEYSCALE));

		return rent;
	}

	
	/**
	 * 等额租金 添加每一期的租金值在未调整时
	 * 
	 * @param rent
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String rent, String income_number) {

		List l_rent = new ArrayList();
		// 添加每一期的租金,根据总的期数得到所有的租信息
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}

		return l_rent;
	}

	/**
	 * 计算利息
	 * 
	 * @param rentList
	 *            租金list
	 * @param leaseMoney
	 *            要测算的本金
	 * @param calRate
	 *            计算的利率 qzOrqm 期初还是期未
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm) {
		// 用于保留利息
		List interests = new ArrayList();
		String corpus_total = "0";
		// 该期的利息
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// 本金余额
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(ConstantInfo.MONEYSCALE));

		for (int i = 0; i < rentList.size(); i++) {// 循环租金list

			if ("1".equals(qzOrqm) && i == 0) {// 第一期且是期初时
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
			}

			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {
				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(ConstantInfo.MONEYSCALE));
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(ConstantInfo.MONEYSCALE));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(ConstantInfo.MONEYSCALE));

			// 本金余额
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(ConstantInfo.MONEYSCALE));
			// 添加list
			interests.add(inte);

		}

		return interests;
	}

	/**
	 * 添加每一期的本金余额
	 * 
	 * @param rentList
	 *            租金
	 * @param inteList
	 *            利息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusList(List rentList, List inteList) {
		List corpus_list = new ArrayList();

		for (int i = 0; i < rentList.size(); i++) {

			corpus_list.add(Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(rentList.get(i).toString())
					- Double.parseDouble(inteList.get(i).toString())), Integer
					.parseInt(ConstantInfo.MONEYSCALE)));
		}
		return corpus_list;
	}

	
	

	
	
	
	
}
