/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.BeginInfoBean;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.ConditionMediBean;
import com.tenwa.culc.bean.RentInfoBox;
import com.tenwa.culc.bean.RentPlanBean;
import com.tenwa.culc.calc.util.EqualCorpusUtil;
import com.tenwa.culc.calc.util.EqualDiffCorUtil;
import com.tenwa.culc.calc.util.EqualDiffRentUtil;
import com.tenwa.culc.calc.util.EqualPaymentUtil;
import com.tenwa.culc.calc.util.EqualRatioCorpusUtil;
import com.tenwa.culc.calc.util.EqualRatioRentUtil;
import com.tenwa.culc.calc.util.SettleLawUtil;
import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.culc.dao.RentPlanDao;
import com.tenwa.log.LogWriter;

/**
 * 租金计划Service操作类
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 5:37:49 PM Email:JaffeHe@hotmail.com
 */
public class RentPlanService {

	private static Logger log = Logger.getLogger(RentPlanService.class);

	/**
	 * 租金测算，通过Condition商务条件
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static RentInfoBox calcRentPlan(ConditionBean conditionBean) {
		RentInfoBox rentInfoBox = null;

		if (log.isInfoEnabled()) {
			log.info("开始测算项目：" + conditionBean.getProj_id() + " 租金计划！");
		}
		// 1参数的提取
		// 1.1租金测算方法
		String settle_method = conditionBean.getSettle_method();

		if ("RentCalcType1".equals(settle_method)) {// 等额租金
			rentInfoBox = EqualPaymentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType2".equals(settle_method)) {// 等差租金
			rentInfoBox = EqualDiffRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType3".equals(settle_method)) {// 等比租金
			rentInfoBox = EqualRatioRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType4".equals(settle_method)) {// 等额本金
			rentInfoBox = EqualCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType5".equals(settle_method)) {// 等差本金
			rentInfoBox = EqualDiffCorUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType6".equals(settle_method)) {// 等比本金
			rentInfoBox = EqualRatioCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType7".equals(settle_method)) {// 均息法
			rentInfoBox = SettleLawUtil.getRentInfoBox(conditionBean);
		}

		// 2返回测算结果
		return rentInfoBox;
	}

	/**
	 * 租金测算，通过Condition商务条件
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static RentInfoBox calcContractRentPlan(ConditionBean conditionBean) {
		RentInfoBox rentInfoBox = null;

		if (log.isInfoEnabled()) {
			log.info("开始测算合同：" + conditionBean.getContract_id() + " 租金计划！");
		}
		// 1参数的提取
		// 1.1租金测算方法
		String settle_method = conditionBean.getSettle_method();

		if ("RentCalcType1".equals(settle_method)) {// 等额租金
			rentInfoBox = EqualPaymentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType2".equals(settle_method)) {// 等差租金
			rentInfoBox = EqualDiffRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType3".equals(settle_method)) {// 等比租金
			rentInfoBox = EqualRatioRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType4".equals(settle_method)) {// 等额本金
			rentInfoBox = EqualCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType5".equals(settle_method)) {// 等差本金
			rentInfoBox = EqualDiffCorUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType6".equals(settle_method)) {// 等比本金
			rentInfoBox = EqualRatioCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType7".equals(settle_method)) {// 均息法
			rentInfoBox = SettleLawUtil.getRentInfoBox(conditionBean);
		}

		// 2测算结果返回
		return rentInfoBox;
	}

	/**
	 * 起租租金测算
	 * 
	 * @param beginInfoBean
	 */

	public static RentInfoBox calcBeginRentPlan(BeginInfoBean beginInfoBean) {

		RentInfoBox rentInfoBox = new RentInfoBox();

		LogWriter.logDebug("开始测算合同：" + beginInfoBean.getContract_id()
				+ ",起租id：" + beginInfoBean.getBegin_id() + " 租金计划！");
		// ---BeginInfoBean 转换 ConditionBean
		ConditionDao conditionDao = new ConditionDao();
		ConditionBean conditionBean = new ConditionBean();
		try {
			conditionBean.setContract_id(beginInfoBean.getContract_id());
			conditionBean = conditionDao
					.loadConditionContractBeanByContractId(beginInfoBean
							.getContract_id());
			LogWriter.logDebug("测试用 ID:" + conditionBean.getContract_id());
			LogWriter.logDebug("测试用 ID2:" + conditionBean.getActual_fund());
			LogWriter.logDebug("测试用 ID3:" + conditionBean.getBefore_interest());
			LogWriter.logDebug("测试用 ID4:" + conditionBean.getReturn_amt());
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 将BeginInfoBean字段拷贝到ConditionBean
		filedDataCopy(conditionBean, beginInfoBean);

		// 1参数的提取
		// 1.1租金测算方法
		String settle_method = beginInfoBean.getSettle_method();

		// 2执行测算
		if ("RentCalcType1".equals(settle_method)) {// 等额租金
			rentInfoBox = EqualPaymentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType2".equals(settle_method)) {// 等差租金
			rentInfoBox = EqualDiffRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType3".equals(settle_method)) {// 等比租金
			rentInfoBox = EqualRatioRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType4".equals(settle_method)) {// 等额本金
			rentInfoBox = EqualCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType5".equals(settle_method)) {// 等差本金
			rentInfoBox = EqualDiffCorUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType6".equals(settle_method)) {// 等比本金
			rentInfoBox = EqualRatioCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType7".equals(settle_method)) {// 均息法
			rentInfoBox = SettleLawUtil.getRentInfoBox(conditionBean);
		}

		// 3 测算结果返回
		return rentInfoBox;
	}

	/**
	 * 医疗管理项目租金测算
	 * 
	 * @param beginInfoBean
	 */
	public static RentInfoBox calcMediProjRentPlan(
			ConditionMediBean conditionMediBean) {

		RentInfoBox rentInfoBox = new RentInfoBox();

		LogWriter.logDebug("开始测算医疗管理项目项目：" + conditionMediBean.getProj_id()
				+ " 租金计划！");
		// ---BeginInfoBean 转换 ConditionBean
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setProj_id(conditionMediBean.getProj_id());

		// 将conditionMediBean字段拷贝到ConditionBean
		filedDataCopyMediProj(conditionBean, conditionMediBean);

		// 1参数的提取
		// 1.1租金测算方法
		String settle_method = conditionBean.getSettle_method();
		System.out.println("111111" + settle_method);
		// 2执行测算
		if ("RentCalcType1".equals(settle_method)) {// 等额租金
			rentInfoBox = EqualPaymentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType2".equals(settle_method)) {// 等差租金
			rentInfoBox = EqualDiffRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType3".equals(settle_method)) {// 等比租金
			rentInfoBox = EqualRatioRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType4".equals(settle_method)) {// 等额本金
			rentInfoBox = EqualCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType5".equals(settle_method)) {// 等差本金
			rentInfoBox = EqualDiffCorUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType6".equals(settle_method)) {// 等比本金
			rentInfoBox = EqualRatioCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType7".equals(settle_method)) {// 均息法
			rentInfoBox = SettleLawUtil.getRentInfoBox(conditionBean);
		}

		// 3 测算结果返回
		return rentInfoBox;
	}
	
	/**
	 * 医疗管理项目租金测算
	 * 
	 * @param beginInfoBean
	 */
	public static RentInfoBox calcMediContRentPlan(
			ConditionMediBean conditionMediBean) {

		RentInfoBox rentInfoBox = new RentInfoBox();

		LogWriter.logDebug("开始测算医疗管理项目项目：" + conditionMediBean.getContract_id()
				+ " 租金计划！");
		// ---BeginInfoBean 转换 ConditionBean
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setContract_id(conditionMediBean.getContract_id());

		// 将conditionMediBean字段拷贝到ConditionBean
		filedDataCopyMediProj(conditionBean, conditionMediBean);

		// 1参数的提取
		// 1.1租金测算方法
		String settle_method = conditionBean.getSettle_method();
		System.out.println("111111" + settle_method);
		// 2执行测算
		if ("RentCalcType1".equals(settle_method)) {// 等额租金
			rentInfoBox = EqualPaymentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType2".equals(settle_method)) {// 等差租金
			rentInfoBox = EqualDiffRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType3".equals(settle_method)) {// 等比租金
			rentInfoBox = EqualRatioRentUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType4".equals(settle_method)) {// 等额本金
			rentInfoBox = EqualCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType5".equals(settle_method)) {// 等差本金
			rentInfoBox = EqualDiffCorUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType6".equals(settle_method)) {// 等比本金
			rentInfoBox = EqualRatioCorpusUtil.getRentInfoBox(conditionBean);
		} else if ("RentCalcType7".equals(settle_method)) {// 均息法
			rentInfoBox = SettleLawUtil.getRentInfoBox(conditionBean);
		}

		// 3 测算结果返回
		return rentInfoBox;
	}

	/**
	 * 字段覆盖
	 * 
	 * @param conditionBean
	 * @param beginInfoBean
	 */
	private static void filedDataCopy(ConditionBean conditionBean,
			BeginInfoBean beginInfoBean) {
		conditionBean.setCurrency(beginInfoBean.getCurrency());
		conditionBean.setLease_money(beginInfoBean.getLease_money());
		conditionBean.setActual_fund(beginInfoBean.getActual_fund());
		conditionBean.setAssets_value(beginInfoBean.getAssets_value());

		conditionBean.setIncome_number(beginInfoBean.getIncome_number());
		conditionBean.setIncome_number_year(beginInfoBean
				.getIncome_number_year());
		conditionBean.setLease_term(beginInfoBean.getLease_term());
		conditionBean.setSettle_method(beginInfoBean.getSettle_method());
		conditionBean.setPeriod_type(beginInfoBean.getPeriod_type());

		conditionBean.setRate_float_type(beginInfoBean.getRate_float_type());
		conditionBean.setRate_float_amt(beginInfoBean.getRate_float_amt());
		conditionBean.setYear_rate(beginInfoBean.getYear_rate());
		conditionBean.setPena_rate(beginInfoBean.getPena_rate());
		conditionBean.setStart_date(beginInfoBean.getStart_date());
		conditionBean.setIncome_day(beginInfoBean.getIncome_day());
		conditionBean.setEnd_date(beginInfoBean.getEnd_date());

		conditionBean.setPlan_irr(beginInfoBean.getPlan_irr());
		conditionBean.setFree_defa_inter_day(beginInfoBean
				.getFree_defa_inter_day());
		conditionBean.setAdjust_style(beginInfoBean.getAdjust_style());
		conditionBean.setInto_batch(beginInfoBean.getInto_batch());
		conditionBean.setRatio_param(beginInfoBean.getRatio_param());
		conditionBean.setRent_start_date(beginInfoBean.getRent_start_date());
	}

	/**
	 * 字段覆盖-医疗管理项目
	 * 
	 * @param conditionBean
	 * @param beginInfoBean
	 */
	private static void filedDataCopyMediProj(ConditionBean conditionBean,
			ConditionMediBean conditionMediBean) {
		conditionBean.setEquip_amt(conditionMediBean.getEquip_amt());
		conditionBean.setCurrency(conditionMediBean.getCurrency());
		conditionBean.setLease_money(conditionMediBean.getLease_money());
		conditionBean.setFirst_payment_ratio(conditionMediBean.getFirst_payment());
		conditionBean.setFirst_payment(conditionMediBean.getFirst_payment());
		conditionBean.setCaution_money(conditionMediBean.getCaution_money());
		conditionBean.setActual_fund(conditionMediBean.getActual_fund());
		conditionBean.setHandling_charge(conditionMediBean.getHandling_charge());
		// ===22==
		conditionBean.setManagement_fee(conditionMediBean.getManagement_fee());
		conditionBean.setNominalprice(conditionMediBean.getNominalprice());
		conditionBean.setReturn_amt(conditionMediBean.getReturn_amt());
		conditionBean.setRate_subsidy(conditionMediBean.getRate_subsidy());
		conditionBean.setBefore_interest(conditionMediBean.getBefore_interest());
		conditionBean.setBefore_interest_type(conditionMediBean.getBefore_interest_type());
		conditionBean.setDiscount_rate(conditionMediBean.getDiscount_rate());
		conditionBean.setConsulting_fee_out(conditionMediBean.getConsulting_fee_out());
		// ==33==
		conditionBean.setConsulting_fee_in(conditionMediBean.getConsulting_fee_in());
		conditionBean.setOther_income(conditionMediBean.getOther_income());
		conditionBean.setOther_expenditure(conditionMediBean.getOther_expenditure());
		conditionBean.setIncome_number(conditionMediBean.getIncome_number());
		conditionBean.setIncome_number_year(conditionMediBean.getIncome_number_year());
		conditionBean.setLease_term(conditionMediBean.getLease_term());
		conditionBean.setSettle_method(conditionMediBean.getSettle_method());
		conditionBean.setPeriod_type(conditionMediBean.getPeriod_type());
		// ==44==
		conditionBean.setRate_float_type(conditionMediBean.getRate_float_type());
		conditionBean.setRate_float_amt(conditionMediBean.getRate_float_amt());
		conditionBean.setAdjust_style(conditionMediBean.getAdjust_style());
		conditionBean.setYear_rate(conditionMediBean.getYear_rate());
		conditionBean.setPena_rate(conditionMediBean.getPena_rate());
		conditionBean.setStart_date(conditionMediBean.getStart_date());
		conditionBean.setIncome_day(conditionMediBean.getIncome_day());
		// ==55==
		conditionBean.setEnd_date("2015-04-03");
		conditionBean.setRent_start_date(conditionMediBean.getRent_start_date());
		conditionBean.setPlan_irr("0");
		conditionBean.setInsure_type(conditionMediBean.getInsure_type());
		conditionBean.setInto_batch(conditionMediBean.getInto_batch());
		conditionBean.setInsure_money(conditionMediBean.getInsure_money());
		conditionBean.setFree_defa_inter_day(conditionMediBean.getFree_defa_inter_day());
		// ==66==
		conditionBean.setAssets_value("0");
		conditionBean.setAssess_adjust("0");
		conditionBean.setRatio_param(conditionMediBean.getRatio_param());
		//==77==
		conditionBean.setInvoice_type("");
		conditionBean.setInsure_pay_type(conditionMediBean.getInsure_pay_type());
	}

	/**
	 * 保存租金上传excel里面的租金计划
	 * 
	 * @param rentPlanList
	 */
	public static void saveUploadRentPlanList(List<RentPlanBean> rentPlanList,
			String proj_id, String doc_id) {
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
	}

	/**
	 * 保存合同租金上传excel里面的租金计划
	 * 
	 * @param rentPlanList
	 */
	public static void saveUploadRentPlanContractList(
			List<RentPlanBean> rentPlanList, String contract_id, String doc_id) {
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
		LogWriter.logDebug("更新contract_id:" + contract_id + " 的租金计划临时表数据，更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
	}

	/**
	 * 保存起租流程租金上传excel里面的租金计划
	 * 
	 * @param rentPlanList
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 */
	public static int saveUploadRentPlanBeginList(
			List<RentPlanBean> rentPlanList, String contract_id,
			String begin_id, String doc_id) {
		int resVal = 0;
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteRentPlanBeginTempHisData(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		try {
			resVal = rentPlanDao.updateRentListBeginData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("起租流程，更新contract_id:" + contract_id + ",起租编号："
				+ begin_id + " 的租金计划相关表数据，更新结果：" + (resVal == 0 ? "失败" : "成功"));
		return resVal;
	}

	/**
	 * 保存租金变更流程租金上传excel里面的租金计划
	 * 
	 * @param rentPlanList
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 */
	public static int saveUploadRentChangePlanBeginList(
			List<RentPlanBean> rentPlanList, String contract_id,
			String begin_id, String doc_id) {
		int resVal = 0;
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteRentChangeBeginTempData(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		try {
			resVal = rentPlanDao.updateRentChangeListBeginData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("租金变更流程，更新contract_id:" + contract_id + ",起租编号："
				+ begin_id + " 的租金计划相关表数据，更新结果：" + (resVal == 0 ? "失败" : "成功"));
		return resVal;
	}

	/**
	 * 流程开始的时候初始化项目租金计划表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {
		LogWriter.logDebug("执行流程初始化【项目租金计划临时表】【fund_rent_plan_proj_temp】数据");
		// 1先判断fund_rent_plan_proj_temp表是否存在数据
		// 1.RentPlanDao实例化
		boolean flag = false;
		RentPlanDao rentPlanDao = new RentPlanDao();
		try {
			flag = rentPlanDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
					+ " 数据在[fund_rent_plan_proj_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				rentPlanDao.copyData2Temp(proj_id, doc_id);
				LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据[项目租金计划临时表][fund_rent_plan_proj_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("项目Id:"
								+ proj_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[项目租金计划临时表][fund_rent_plan_proj_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 租金变更流程之租金计划变更，初始化租金偿还数据
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 */
	public static void flowInitBeginRentData(String contract_id,
			String begin_id, String doc_id) {
		LogWriter.logDebug("执行流程初始化【起租租金计划临时表】【fund_rent_plan_temp】数据");
		// 1先判断[fund_rent_plan_temp]表是否存在数据
		// 1.RentPlanDao实例化
		boolean flag = false;
		RentPlanDao rentPlanDao = new RentPlanDao();
		try {
			flag = rentPlanDao.judgeBeginItemExist(contract_id, begin_id,
					doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + ",起租Id:" + begin_id
					+ " 文档Id:" + doc_id + " 数据在[fund_rent_plan_temp]中存在");
		} else {
			// 3不存在则将[fund_rent_plan]正式表数据拷贝临时表
			try {
				rentPlanDao.copyBeginRentData2Temp(contract_id, begin_id,
						doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + ",起租Id:" + begin_id
						+ " 文档Id:" + doc_id
						+ " 数据[起租租金计划临时表][fund_rent_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + ",起租Id:" + begin_id
						+ " 文档Id:" + doc_id
						+ " 数据[起租租金计划临时表][fund_rent_plan_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}
	}

	/**
	 * 起租流程 - 初始化租金计划数据
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 */
	public static void flowInitBeginTempData(String contract_id,
			String begin_id, String doc_id) {
		LogWriter.logDebug("执行起租流程初始化【起租租金计划临时表】【fund_rent_plan_temp】数据");
		// 1先判断[fund_rent_plan_temp]表是否存在数据
		// 1.RentPlanDao实例化
		boolean flag = false;
		RentPlanDao rentPlanDao = new RentPlanDao();
		try {
			flag = rentPlanDao.judgeRentTempItemExist(contract_id, begin_id,
					doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + ",起租Id:" + begin_id
					+ " 文档Id:" + doc_id + " 数据在[fund_rent_plan_temp]中存在");
		} else {
			// 3不存在则将[fund_rent_plan]正式表数据拷贝临时表
			try {
				rentPlanDao.copyContract2BeginRentData2Temp(contract_id,
						begin_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + ",起租Id:" + begin_id
						+ " 文档Id:" + doc_id
						+ " 数据[起租租金计划临时表][fund_rent_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + ",起租Id:" + begin_id
						+ " 文档Id:" + doc_id
						+ " 数据[起租租金计划临时表][fund_rent_plan_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}
	}

	/**
	 * 租后流程开始的时候初始化合同租金计划表数据
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {
		LogWriter
				.logDebug("执行流程初始化[合同租金计划临时表][fund_rent_plan_contract_temp]数据");
		// 1先判断fund_rent_plan_contract_temp表是否存在数据
		// 1.RentPlanDao实例化
		boolean flag = false;
		RentPlanDao rentPlanDao = new RentPlanDao();
		try {
			flag = rentPlanDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同租金计划临时表][fund_rent_plan_contract_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				rentPlanDao.copyData2ContractTemp(contract_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[合同租金计划临时表][fund_rent_plan_contract_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同租金计划临时表][fund_rent_plan_contract_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 签约审批流程初始化合同租金计划临时表数据
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		LogWriter
				.logDebug("执行合同租金计划临时表[fund_rent_plan_contract_temp]签约审批流程初始化数据");
		// 1先判断contract_condition_temp表是否存在数据
		// 1.RentPlanDao实例化
		boolean flag = false;
		RentPlanDao rentPlanDao = new RentPlanDao();
		try {
			flag = rentPlanDao.judgeItemContractExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在fund_rent_plan_contract_temp中存在");
		} else {
			// 3不存在则将proj_document正式表数据拷贝临时表
			try {
				rentPlanDao.copyData2ContractTemp(contract_id, proj_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[fund_rent_plan_contract_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[fund_rent_plan_contract_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}
	}
}
