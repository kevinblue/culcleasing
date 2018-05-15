/**
 * com.tenwa.culc.calc.util
 */
package com.tenwa.culc.calc.zjcs;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.condition.CashFlow;
import com.tenwa.culc.calc.zjcs.RentCalc;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentPlanBean;
import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.culc.dao.RentPlanDao;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.MathExtend;
import com.tenwa.log.LogWriter;

/**
 * @author Jaffe
 * 
 * Date:Jul 18, 2011 10:34:26 AM Email:JaffeHe@hotmail.com
 */
public class RentDBOperation {

	/**
	 * 数据库操作
	 * 
	 * @param contract_id
	 * @param conditionBean
	 * @param Markirr
	 * @param l_plan_date
	 * @param l_rent
	 * @param l_corpus
	 * @param l_interest
	 * @param l_corpus_overage
	 * @param l_RentDetails
	 * @param rent
	 * @param new_rent
	 */
	@SuppressWarnings("unchecked")
	public static void execDBOperation(String contract_id,
			ConditionBean conditionBean, String irr, List l_plan_date,
			List l_rent, List l_corpus, List l_interest, List l_corpus_overage,
			List l_RentDetails, RentCalc rent, List new_rent) {
		/**
		 * =======================================================
		 * 开始更新数据库表数据（交易结构临时表、项目租金计划临时表、项目租金现金流临时表）
		 * =======================================================
		 */
		// --判断更新合同表还是项目表
		System.out.println("数据库更新表操作判断contract_id="+contract_id+"proj_id="+rent.getContract_id());
		int flag = 0;
		if ("".equals(contract_id)|| contract_id == null) {
			// =======1 更新交易结构表的plan_irr
			flag = updateConditionTempPlanIrr(conditionBean.getProj_id(),
					conditionBean.getDoc_id(), irr);
			LogWriter.logDebug("更新proj_condition_temp,结果：" + flag);

			// // =======2 更新项目租金计划临时表
			flag = updateFundRentPlanProjTemp(l_plan_date, l_rent,
					conditionBean.getYear_rate(), l_corpus, l_interest,
					l_corpus_overage, conditionBean.getDoc_id(), conditionBean
							.getProj_id());
			LogWriter.logDebug("更新fund_rent_plan_proj_temp,结果：" + flag);

			// ======3项目现金流临时表
			// 【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(l_rent, conditionBean
					.getCaution_money());
			// 得到保证金抵扣租金List rent_list 租金List,caut_money 保证金
			new_rent = rent.getRentCautNew(l_rent, conditionBean
					.getCaution_money());

			String proj_id = conditionBean.getProj_id();
			String doc_id = conditionBean.getDoc_id();

			// 1创建对象
			CashFlow cashFlow = new CashFlow();

			// 市场现金流
			String new_del_sql = " delete  fund_proj_plan_mark_temp where proj_id = '"
					+ proj_id + "' and doc_id = '" + doc_id + "'";
			flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date, new_rent,
					conditionBean.getLease_money(), conditionBean
							.getConsulting_fee_out(), conditionBean
							.getHandling_charge(),
					conditionBean.getEquip_amt(), conditionBean
							.getOther_expenditure(), conditionBean
							.getCaution_money(), conditionBean.getReturn_amt(),
					conditionBean.getOther_income(), conditionBean
							.getFirst_payment(), conditionBean.getStart_date(),
					conditionBean.getPeriod_type(), proj_id, doc_id,
					conditionBean.getCreator(), conditionBean.getCreate_date(),
					conditionBean.getModificator(), conditionBean
							.getModify_date(), new_del_sql, "", "market_irr",
					"fund_proj_plan_mark_temp", conditionBean
							.getBefore_interest(), l_RentDetails);//

			// 现金流补充代码【2010-08-06】
			if (!conditionBean.getNominalprice().equals("")) {//
				double t_num = Double.valueOf(conditionBean.getNominalprice());
				if (t_num > 0) {// 留购价大于0才进行此操作
					// 市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
					String query_count_market = " select * from fund_proj_plan_mark_temp  where  proj_id = '"
							+ proj_id + "' and doc_id = '" + doc_id + "'";
					query_count_market = query_count_market
							+ " and plan_date = ( select max(plan_date) from fund_proj_plan_mark_temp where proj_id = '"
							+ proj_id + "'  and doc_id = '" + doc_id + "' ) ";
					query_count_market = query_count_market
							+ " and id = ( select max(id) from fund_proj_plan_mark_temp where proj_id = '"
							+ proj_id + "'  and doc_id = '" + doc_id + "' ) ";
					System.out
							.println("查询项目市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "
									+ query_count_market);
					// 调用通用方法
					flag = cashFlow.update_xjl_market(query_count_market,
							conditionBean.getNominalprice(),
							"fund_proj_plan_mark_temp", proj_id, "");// 市场
				}
			}

			String management_fee = conditionBean.getManagement_fee();
			// 需求增加,现金流补充代码【2010-11-30】 现金流第一期加上管理费，加入所有流入中
			if (!"".equals(management_fee)
					&& management_fee != null
					&& (!"0.00".equals(management_fee) && !"0"
							.equals(management_fee))) {
				// 查询市场第一期的数据
				String query_min_market = " select * from fund_proj_plan_mark_temp  where  proj_id = '"
						+ proj_id + "' and doc_id = '" + doc_id + "'";
				query_min_market = query_min_market
						+ " and id = ( select min(id) from fund_proj_plan_mark_temp where proj_id = '"
						+ proj_id + "'  and doc_id = '" + doc_id + "' ) ";
				System.out.println("查询项目市场现金流最小一期的值 ==> " + query_min_market);
				// 调用公用方法将管理费加到所有流入
				flag = cashFlow.updat_xjl(query_min_market, management_fee,
						proj_id, "", doc_id, "proj", "market");
			}

		} else {
			// =======1 更新交易结构表的plan_irr
			flag = updateConditionContractTempPlanIrr(conditionBean
					.getContract_id(), conditionBean.getDoc_id(), irr);
			LogWriter.logDebug("更新contract_condition_temp,结果：" + flag);

			// // =======2 更新项目租金计划临时表
			flag = updateFundRentPlanProjContractTemp(l_plan_date, l_rent,
					conditionBean.getYear_rate(), l_corpus, l_interest,
					l_corpus_overage, conditionBean.getDoc_id(), conditionBean
							.getContract_id());
			LogWriter.logDebug("更新fund_rent_plan_contract_temp,结果：" + flag);

			// ======3项目现金流临时表
			// 【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(l_rent, conditionBean
					.getCaution_money());
			// 得到保证金抵扣租金List rent_list 租金List,caut_money 保证金
			new_rent = rent.getRentCautNew(l_rent, conditionBean
					.getCaution_money());

			String proj_id = conditionBean.getProj_id();
			String doc_id = conditionBean.getDoc_id();

			// 1创建对象
			CashFlow cashFlow = new CashFlow();

			// 市场现金流
			String new_del_sql = " delete  fund_contract_plan_mark_temp where contract_id = '"
					+ contract_id + "' and doc_id = '" + doc_id + "'";
			flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date, new_rent,
					conditionBean.getLease_money(), conditionBean
							.getConsulting_fee_out(), conditionBean
							.getHandling_charge(),
					conditionBean.getEquip_amt(), conditionBean
							.getOther_expenditure(), conditionBean
							.getCaution_money(), conditionBean.getReturn_amt(),
					conditionBean.getOther_income(), conditionBean
							.getFirst_payment(), conditionBean.getStart_date(),
					conditionBean.getPeriod_type(), proj_id, doc_id,
					conditionBean.getCreator(), conditionBean.getCreate_date(),
					conditionBean.getModificator(), conditionBean
							.getModify_date(), new_del_sql, contract_id,
					"market_irr", "fund_contract_plan_mark_temp", conditionBean
							.getBefore_interest(), l_RentDetails);//

			// 现金流补充代码【2010-08-06】
			if (!conditionBean.getNominalprice().equals("")) {//
				double t_num = Double.valueOf(conditionBean.getNominalprice());
				if (t_num > 0) {// 留购价大于0才进行此操作
					// 市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
					String query_count_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"
							+ contract_id + "' and doc_id = '" + doc_id + "'";
					query_count_market = query_count_market
							+ " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"
							+ contract_id + "'  and doc_id = '" + doc_id
							+ "' ) ";
					query_count_market = query_count_market
							+ " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"
							+ contract_id + "'  and doc_id = '" + doc_id
							+ "' ) ";
					System.out
							.println("查询项目市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "
									+ query_count_market);
					// 调用通用方法
					flag = cashFlow.update_xjl_market(query_count_market,
							conditionBean.getNominalprice(),
							"fund_contract_plan_mark_temp", proj_id, "");// 市场
				}
			}

			String management_fee = conditionBean.getManagement_fee();
			// 需求增加,现金流补充代码【2010-11-30】 现金流第一期加上管理费，加入所有流入中
			if (!"".equals(management_fee)
					&& management_fee != null
					&& (!"0.00".equals(management_fee) && !"0"
							.equals(management_fee))) {
				// 查询市场第一期的数据
				String query_min_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"
						+ contract_id + "' and doc_id = '" + doc_id + "'";
				query_min_market = query_min_market
						+ " and id = ( select min(id) from fund_contract_plan_mark_temp where contract_id = '"
						+ contract_id + "'  and doc_id = '" + doc_id + "' ) ";
				System.out.println("查询项目市场现金流最小一期的值 ==> " + query_min_market);
				// 调用公用方法将管理费加到所有流入
				flag = cashFlow.updat_xjl(query_min_market, management_fee,
						proj_id, "", doc_id, "contract", "market");
			}
		}
	}

	/**
	 * 合同租金计划
	 * 
	 * @param l_plan_date
	 * @param l_rent
	 * @param year_rate
	 * @param l_corpus
	 * @param l_interest
	 * @param l_corpus_overage
	 * @param doc_id
	 * @param contract_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static int updateFundRentPlanProjContractTemp(List l_plan_date,
			List l_rent, String year_rate, List l_corpus, List l_interest,
			List l_corpus_overage, String doc_id, String contract_id) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < l_rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setContract_id(contract_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) l_plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) l_rent.get(i));
			rentPlanBean.setRent((String) l_rent.get(i));
			rentPlanBean.setCorpus((String) l_corpus.get(i));
			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setInterest((String) l_interest.get(i));
			rentPlanBean.setCorpus_overage((String) l_corpus_overage.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			// 添加到list
			rentPlanList.add(rentPlanBean);
		}
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteRentPlanContractTempHisData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentPlanDao
					.updateFundRentPlanContractTempData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新contract_Id:" + contract_id + " 的租金计划临时表数据，更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 更新合同irr
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param markirr
	 * @return
	 */
	private static int updateConditionContractTempPlanIrr(String contract_id,
			String doc_id, String markirr) {
		// 1.创建ConditionDao
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行update操作
		markirr = MathExtend.multiply(
				Tools.formatNumberDoubleScale(markirr, 8), "100");
		int resVal = 0;
		try {
			resVal = conditionDao.updateConditionContractTempPlanIrrOper(
					contract_id, doc_id, markirr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新contract_Id:" + contract_id + " 的plan_irr："
				+ markirr + " 更新结果：" + (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 更新fund_rent_plan_proj_temp，项目租金计划临时表数据
	 * 
	 * @param l_plan_date
	 *            偿还日期list
	 * @param l_rent
	 *            租金list
	 * @param year_rate
	 *            年利率
	 * @param l_corpus_market
	 *            市场本金list
	 * @param l_interest_market
	 *            市场利息list
	 * @param l_corpus_overage_market
	 *            市场剩余本金list
	 * @param doc_id
	 *            文档编号
	 * @param proj_id
	 *            项目编号
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static int updateFundRentPlanProjTemp(List l_plan_date,
			List l_rent, String year_rate, List l_corpus_market,
			List l_interest_market, List l_corpus_overage_market,
			String doc_id, String proj_id) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < l_rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setProj_id(proj_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) l_plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) l_rent.get(i));
			rentPlanBean.setRent((String) l_rent.get(i));
			rentPlanBean.setCorpus((String) l_corpus_market.get(i));
			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setInterest((String) l_interest_market.get(i));
			rentPlanBean.setCorpus_overage((String) l_corpus_overage_market
					.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			// 添加到list
			rentPlanList.add(rentPlanBean);
		}
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteRentPlanProjTempHisData(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentPlanDao.updateFundRentPlanProjTempData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新proj_Id:" + proj_id + " 的租金计划临时表数据，更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 更新指定proj_id,doc_id的plan_irr市场irr字段
	 * 
	 * @param proj_id
	 *            项目id
	 * @param doc_id
	 *            文档Id
	 * @param markirr
	 *            内部年利率
	 * @return
	 */
	private static int updateConditionTempPlanIrr(String proj_id,
			String doc_id, String markirr) {
		// 1.创建ConditionDao
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行update操作
		markirr = MathExtend.multiply(
				Tools.formatNumberDoubleScale(markirr, 8), "100");
		int resVal = 0;
		try {
			resVal = conditionDao.updateConditionTempPlanIrrOper(proj_id,
					doc_id, markirr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新proj_Id:" + proj_id + " 的plan_irr：" + markirr
				+ " 更新结果：" + (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

}
