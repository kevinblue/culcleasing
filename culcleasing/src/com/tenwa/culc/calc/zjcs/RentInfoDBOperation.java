/**
 * com.tenwa.culc.calc.zjcs
 */
package com.tenwa.culc.calc.zjcs;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.tenwa.culc.bean.BeginInfoBean;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.ConditionMediBean;
import com.tenwa.culc.bean.RentCashBean;
import com.tenwa.culc.bean.RentInfoBox;
import com.tenwa.culc.bean.RentPlanBean;
import com.tenwa.culc.dao.BeginDao;
import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.culc.dao.RentCashDao;
import com.tenwa.culc.dao.RentPlanDao;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.MathExtend;
import com.tenwa.log.LogWriter;

/**
 * RentInfo - To 数据库操作
 * 
 * @author Jaffe
 * 
 * Date:Jul 27, 2011 7:12:42 PM Email:JaffeHe@hotmail.com
 */
public class RentInfoDBOperation {

	/**
	 * 起租时保存测算结果
	 * 
	 * @param rentInfoBox
	 * @param beginInfoBean
	 * @return
	 */
	public static int operBeginRentInfoBox2DB(RentInfoBox rentInfoBox,
			BeginInfoBean beginInfoBean) {
		// 1定义
		int resVal = 0;

		// 2.更新Irr
		// resVal += updateBeginInfoTempPlanIrr(beginInfoBean.getBegin_id(),
		// beginInfoBean.getDoc_id(), rentInfoBox.getIrr());

		// 3.插入租金测算信息
		// 3.1插入现金流
		// resVal += updateBeginCashData(beginInfoBean.getBegin_id(),
		// beginInfoBean.getDoc_id(), rentInfoBox.getL_RentDetails());
		// 3.2插入租金计划
		resVal += updateBeginRentPlanData(beginInfoBean.getContract_id(),
				beginInfoBean.getBegin_id(), beginInfoBean.getDoc_id(),
				beginInfoBean.getYear_rate(),
				beginInfoBean.getPlan_bank_name(), beginInfoBean
						.getPlan_bank_no(), rentInfoBox.getL_Rent(),
				rentInfoBox.getL_Corpus(), rentInfoBox.getL_Inter(),
				rentInfoBox.getL_CorpusOverge(), rentInfoBox.getL_Plan_date());

		// 4返回
		return resVal;
	}

	/**
	 * 医疗管理项目保存测算结果
	 * 
	 * @param rentInfoBox
	 * @param beginInfoBean
	 * @return
	 */
	public static int operMediProjRentInfoBox2DB(RentInfoBox rentInfoBox,
			ConditionMediBean conditionMediBean) {
		// 1定义
		int resVal = 0;

		// 2.更新Irr
		// resVal += updateBeginInfoTempPlanIrr(beginInfoBean.getBegin_id(),
		// beginInfoBean.getDoc_id(), rentInfoBox.getIrr());

		// 3.插入租金测算信息
		// 3.1插入现金流
		// resVal += updateBeginCashData(beginInfoBean.getBegin_id(),
		// beginInfoBean.getDoc_id(), rentInfoBox.getL_RentDetails());
		// 3.2插入租金计划
		resVal += updateMediProjRentPlanData(conditionMediBean.getProj_id(),
				conditionMediBean.getDoc_id(),
				conditionMediBean.getYear_rate(), conditionMediBean
						.getPlan_bank_name(), conditionMediBean
						.getPlan_bank_no(), rentInfoBox.getL_Rent(),
				rentInfoBox.getL_Corpus(), rentInfoBox.getL_Inter(),
				rentInfoBox.getL_CorpusOverge(), rentInfoBox.getL_Plan_date());

		// 4返回
		return resVal;
	}
	
	/**
	 * 医疗管理项目保存测算结果
	 * 
	 * @param rentInfoBox
	 * @param beginInfoBean
	 * @return
	 */
	public static int operMediContRentInfoBox2DB(RentInfoBox rentInfoBox,
			ConditionMediBean conditionMediBean) {
		// 1定义
		int resVal = 0;

		// 2.更新Irr
		// resVal += updateBeginInfoTempPlanIrr(beginInfoBean.getBegin_id(),
		// beginInfoBean.getDoc_id(), rentInfoBox.getIrr());

		// 3.插入租金测算信息
		// 3.1插入现金流
		// resVal += updateBeginCashData(beginInfoBean.getBegin_id(),
		// beginInfoBean.getDoc_id(), rentInfoBox.getL_RentDetails());
		// 3.2插入租金计划
		resVal += updateMediContRentPlanData(conditionMediBean.getContract_id(),
				conditionMediBean.getDoc_id(),
				conditionMediBean.getYear_rate(), conditionMediBean
						.getPlan_bank_name(), conditionMediBean
						.getPlan_bank_no(), rentInfoBox.getL_Rent(),
				rentInfoBox.getL_Corpus(), rentInfoBox.getL_Inter(),
				rentInfoBox.getL_CorpusOverge(), rentInfoBox.getL_Plan_date());

		// 4返回
		return resVal;
	}

	/**
	 * 签约审批后保存租金测算结果
	 * 
	 * @param rentInfoBox
	 * @param conditionBean
	 * @return
	 */
	public static int operContractRentInfoBox2DB(RentInfoBox rentInfoBox,
			ConditionBean conditionBean) {
		// 1定义
		int resVal = 0;

		// 2.更新Irr
		resVal += updateContractInfoTempPlanIrr(conditionBean.getContract_id(),
				conditionBean.getDoc_id(), rentInfoBox.getIrr());

		// 3.插入租金测算信息
		// 3.1插入现金流
		resVal += updateContractCashData(conditionBean.getContract_id(),
				conditionBean.getDoc_id(), rentInfoBox.getL_RentDetails());
		// 3.2插入租金计划
		resVal += updateContractRentPlanData(conditionBean.getContract_id(),
				conditionBean.getDoc_id(), conditionBean.getYear_rate(),
				rentInfoBox.getL_Rent(), rentInfoBox.getL_Corpus(), rentInfoBox
						.getL_Inter(), rentInfoBox.getL_CorpusOverge(),
				rentInfoBox.getL_Plan_date());

		// 4返回
		return resVal;
	}

	/**
	 * 签约审批前保存租金测算结果
	 * 
	 * @param rentInfoBox
	 * @param conditionBean
	 * @return
	 */
	public static int operProjRentInfoBox2DB(RentInfoBox rentInfoBox,
			ConditionBean conditionBean) {
		// 1定义
		int resVal = 0;

		// 2.更新Irr
		resVal += updateProjInfoTempPlanIrr(conditionBean.getProj_id(),
				conditionBean.getDoc_id(), rentInfoBox.getIrr());

		// 3.插入租金测算信息
		// 3.1插入现金流
		resVal += updateProjCashData(conditionBean.getProj_id(), conditionBean
				.getDoc_id(), rentInfoBox.getL_RentDetails());
		// 3.2插入租金计划
		resVal += updateProjRentPlanData(conditionBean.getProj_id(),
				conditionBean.getDoc_id(), conditionBean.getYear_rate(),
				rentInfoBox.getL_Rent(), rentInfoBox.getL_Corpus(), rentInfoBox
						.getL_Inter(), rentInfoBox.getL_CorpusOverge(),
				rentInfoBox.getL_Plan_date());

		// 4返回
		return resVal;
	}

	/**
	 * 更新签约审批前租金计划数据[fund_rent_plan_proj_temp]
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param year_rate
	 * @param rent
	 * @param corpus
	 * @param inter
	 * @param corpusOverge
	 * @param plan_date
	 * @return
	 */
	private static int updateProjRentPlanData(String proj_id, String doc_id,
			String year_rate, List<String> rent, List<String> corpus,
			List<String> inter, List<String> corpusOverge,
			List<String> plan_date) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setProj_id(proj_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) rent.get(i));
			rentPlanBean.setRent((String) rent.get(i));
			rentPlanBean.setCorpus((String) corpus.get(i));
			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setInterest((String) inter.get(i));
			rentPlanBean.setCorpus_overage((String) corpusOverge.get(i));
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
		LogWriter.logDebug("更新[proj_id]:" + proj_id
				+ " 的租金计划临时表数据，[fund_rent_plan_proj_temp]更新结果："
				+ (resVal == 0 ? "失败" : "成功"));

		// 3.返回
		return resVal;
	}

	/**
	 * 更新[fund_proj_plan_mark_temp]签约审批前现金流
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param rentDetails
	 * @return
	 */
	private static int updateProjCashData(String proj_id, String doc_id,
			List<RentCashBean> rentDetails) {
		// 1.更新rentDetails
		for (RentCashBean cashBean : rentDetails) {
			cashBean.setProj_id(proj_id);
			cashBean.setDoc_id(doc_id);
			cashBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
		}

		// 2. === 将数据更新 ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1删除历史数据
		try {
			rentCashDao.deleteRentCashProjTempHisData(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentCashDao.updateRentCashProjTempData(rentDetails);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新[proj_id]:" + proj_id
				+ " 的现金流临时表数据，[fund_proj_plan_mark_temp]更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 更新[proj_condition_temp]中plan_irr字段
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param irr
	 * @return
	 */
	private static int updateProjInfoTempPlanIrr(String proj_id, String doc_id,
			String irr) {

		// 1.创建ConditionDao
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行update操作
		irr = MathExtend.multiply(Tools.formatNumberDoubleScale(irr, 8), "100");
		int resVal = 0;
		try {
			resVal = conditionDao.updateConditionTempPlanIrrOper(proj_id,
					doc_id, irr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新[proj_id]:" + proj_id
				+ " 的,表[proj_id_condition_temp]中plan_irr：" + irr + " 更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 更新签约审批租金计划数据[fund_rent_plan_contract_temp]
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param year_rate
	 * @param rent
	 * @param corpus
	 * @param inter
	 * @param corpusOverge
	 * @param plan_date
	 * @return
	 */
	private static int updateContractRentPlanData(String contract_id,
			String doc_id, String year_rate, List<String> rent,
			List<String> corpus, List<String> inter, List<String> corpusOverge,
			List<String> plan_date) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setContract_id(contract_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) rent.get(i));
			rentPlanBean.setRent((String) rent.get(i));
			rentPlanBean.setCorpus((String) corpus.get(i));
			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setInterest((String) inter.get(i));
			rentPlanBean.setCorpus_overage((String) corpusOverge.get(i));
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
		LogWriter.logDebug("更新[contract_id]:" + contract_id
				+ " 的租金计划临时表数据，[fund_rent_plan_contract_temp]更新结果："
				+ (resVal == 0 ? "失败" : "成功"));

		// 3.返回
		return resVal;
	}

	/**
	 * 更新[fund_contract_plan_mark_temp]签约审批现金流
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param rentDetails
	 * @return
	 */
	private static int updateContractCashData(String contract_id,
			String doc_id, List<RentCashBean> rentDetails) {
		// 1.更新rentDetails
		for (RentCashBean cashBean : rentDetails) {
			cashBean.setContract_id(contract_id);
			cashBean.setDoc_id(doc_id);
			cashBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
		}

		// 2. === 将数据更新 ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1删除历史数据
		try {
			rentCashDao.deleteRentCashContractTempHisData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentCashDao.updateRentCashContractTempData(rentDetails);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新[Contract_id]:" + contract_id
				+ " 的现金流临时表数据，[fund_contract_plan_mark_temp]更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 更新[Contract_condition_temp]计划irr数据
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param irr
	 * @return
	 */
	private static int updateContractInfoTempPlanIrr(String contract_id,
			String doc_id, String irr) {
		// 1.创建ConditionDao
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行update操作
		irr = MathExtend.multiply(Tools.formatNumberDoubleScale(irr, 8), "100");
		int resVal = 0;
		try {
			resVal = conditionDao.updateConditionContractTempPlanIrrOper(
					contract_id, doc_id, irr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新[Contract_id]:" + contract_id
				+ " 的,表[Contract_condition_temp]中plan_irr：" + irr + " 更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 起租现金流保存
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @param rentDetails
	 * @return
	 */
	private static int updateBeginCashData(String begin_id, String doc_id,
			List<RentCashBean> rentDetails) {
		// 1.更新rentDetails
		for (RentCashBean cashBean : rentDetails) {
			cashBean.setBegin_id(begin_id);
			cashBean.setDoc_id(doc_id);
			cashBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
		}

		// 2. === 将数据更新 ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1删除历史数据
		try {
			rentCashDao.deleteCashListBeginHisData(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentCashDao.updateCashListBeginData(rentDetails);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新[begin_id]:" + begin_id
				+ " 的现金流临时表数据，[fund_begin_plan_mark_temp]更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 起租租金计划
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @param year_rate
	 * @param plan_bank_name
	 * @param plan_bank_no
	 * @param rent
	 * @param corpus
	 * @param inter
	 * @param corpusOverge
	 * @param plan_date
	 * @return
	 */
	private static int updateBeginRentPlanData(String contract_id,
			String begin_id, String doc_id, String year_rate,
			String plan_bank_name, String plan_bank_no, List<String> rent,
			List<String> corpus, List<String> inter, List<String> corpusOverge,
			List<String> plan_date) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setContract_id(contract_id);
			rentPlanBean.setBegin_id(begin_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setMeasure_date(CommonTool.getSysDate("yyyy-MM-dd"));

			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) rent.get(i));
			rentPlanBean.setRent((String) rent.get(i));
			rentPlanBean.setCurr_corpus((String) corpus.get(i));
			rentPlanBean.setCorpus((String) corpus.get(i));

			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setCurr_interest((String) inter.get(i));
			rentPlanBean.setInterest((String) inter.get(i));
			rentPlanBean.setCorpus_overage((String) corpusOverge.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			rentPlanBean.setPlan_bank_name(plan_bank_name);
			rentPlanBean.setPlan_bank_no(plan_bank_no);
			// 添加到list
			rentPlanList.add(rentPlanBean);
		}
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteRentListBeginHisData(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentPlanDao.updateRentListBeginData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter
				.logDebug("更新[begin_id]:"
						+ begin_id
						+ " 的租金计划临时表数据，[fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before]更新结果："
						+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 医疗管理项目租金计划
	 */
	private static int updateMediProjRentPlanData(String proj_id,
			String doc_id, String year_rate,
			String plan_bank_name, String plan_bank_no, List<String> rent,
			List<String> corpus, List<String> inter, List<String> corpusOverge,
			List<String> plan_date) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setProj_id(proj_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setMeasure_date(CommonTool.getSysDate("yyyy-MM-dd"));

			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) rent.get(i));
			rentPlanBean.setRent((String) rent.get(i));
			rentPlanBean.setCurr_corpus((String) corpus.get(i));
			rentPlanBean.setCorpus((String) corpus.get(i));

			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setCurr_interest((String) inter.get(i));
			rentPlanBean.setInterest((String) inter.get(i));
			rentPlanBean.setCorpus_overage((String) corpusOverge.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			rentPlanBean.setPlan_bank_name(plan_bank_name);
			rentPlanBean.setPlan_bank_no(plan_bank_no);
			// 添加到list
			rentPlanList.add(rentPlanBean);
		}
		System.out.println("nimeimeiemei");
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteMediProjRentListData(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentPlanDao.updateMediProjRentListData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter
				.logDebug("更新医疗管理[proj_id]:"
						+ proj_id
						+ " 的租金计划临时表数据，[fund_rent_plan_proj_bd_medi_temp]更新结果："
						+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}

	/**
	 * 医疗管理项目租金计划
	 */
	private static int updateMediContRentPlanData(String contract_id,
			String doc_id, String year_rate,
			String plan_bank_name, String plan_bank_no, List<String> rent,
			List<String> corpus, List<String> inter, List<String> corpusOverge,
			List<String> plan_date) {
		// 1.封装RentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// 属性赋值
			rentPlanBean.setContract_id(contract_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setMeasure_date(CommonTool.getSysDate("yyyy-MM-dd"));

			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) plan_date.get(i));
			rentPlanBean.setPlan_status("未回笼");
			rentPlanBean.setCurr_rent((String) rent.get(i));
			rentPlanBean.setRent((String) rent.get(i));
			rentPlanBean.setCurr_corpus((String) corpus.get(i));
			rentPlanBean.setCorpus((String) corpus.get(i));

			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setCurr_interest((String) inter.get(i));
			rentPlanBean.setInterest((String) inter.get(i));
			rentPlanBean.setCorpus_overage((String) corpusOverge.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			rentPlanBean.setPlan_bank_name(plan_bank_name);
			rentPlanBean.setPlan_bank_no(plan_bank_no);
			// 添加到list
			rentPlanList.add(rentPlanBean);
		}
		System.out.println("nimeimeiemei");
		// 2. === 将数据更新 ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1删除历史数据
		try {
			rentPlanDao.deleteMediContRentListData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentPlanDao.updateMediContRentListData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter
				.logDebug("更新医疗管理[contract_id]:"
						+ contract_id
						+ " 的租金计划临时表数据，[fund_rent_plan_contract_bd_medi_temp]更新结果："
						+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}
	/**
	 * 更新Begin_info_temp表Plan_irr
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @param irr
	 * @return
	 */
	private static int updateBeginInfoTempPlanIrr(String begin_id,
			String doc_id, String irr) {
		int resVal = 0;
		// 1.创建BeginDao
		BeginDao beginDao = new BeginDao();
		// 2.执行update操作
		irr = MathExtend.multiply(Tools.formatNumberDoubleScale(irr, 8), "100");
		try {
			resVal = beginDao.updateBeginInfoTempPlanIrrOper(begin_id, doc_id,
					irr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新[Begin_id]:" + begin_id
				+ " 的,表[Begin_info_temp]中plan_irr：" + irr + " 更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
		// 3.返回
		return resVal;
	}
}
