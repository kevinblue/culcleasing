/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service1;

import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.culc.dao1.ConditionDao1;
import com.tenwa.log.LogWriter;

/**
 * Condition 商务条件Service操作
 * 
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 2:34:55 PM Email:JaffeHe@hotmail.com
 */
public class ConditionService1 {

	private static Logger log = Logger.getLogger(ConditionService1.class);

	/**
	 * 租金变更流程之商务条件变更
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 */
	public static void flowInitBeginCondData(String contract_id,
			String begin_id, String doc_id) {
		ConditionDao1 conditionDao1 = new ConditionDao1();
		
			try {
				conditionDao1.copyBeginData2Temp(contract_id, begin_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + ", 起租id：" + begin_id
						+ " 文档Id:" + doc_id
						+ " 数据[起租商务条件临时][begin_info_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + ", 起租id：" + begin_id
						+ " 文档Id:" + doc_id
						+ " 数据[起租商务条件临时][begin_info_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}

	}

	/**
	 * 查询该合同所属项目的已使用项目金额
	 * 
	 * @param contractId
	 * @return
	 */
	public static String getUsedEquipAmt(String contractId) {
		String usedMoney = "";
		// 1.ConditionDao实例化
		ConditionDao conditionDao = new ConditionDao();
		try {
			usedMoney = conditionDao.getUsedMoney(contractId);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("合同：" + contractId + "，所属项目已使用项目金额为：" + usedMoney);

		return usedMoney;
	}

	/**
	 * 租金变更流程之商务条件变更
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 */
	public static void flowInitBeginTempData(String contract_id,
			String begin_id, String doc_id) {

		// 1.ConditionDao实例化
		ConditionDao1 conditionDao1 = new ConditionDao1();

		// 3不存在则将[begin_info]正式表数据拷贝临时表[begin_info_temp]
		try {
			conditionDao1.copyContract2BeginData2Temp(contract_id, begin_id,
					doc_id);
			LogWriter.logDebug("合同Id:" + contract_id + ", 起租id：" + begin_id
					+ " 文档Id:" + doc_id
					+ " 数据[起租商务条件临时][begin_info_temp]初始化tax_type完成");
		} catch (SQLException e) {
			LogWriter.logError("合同Id:" + contract_id + ", 起租id：" + begin_id
					+ " 文档Id:" + doc_id
					+ " 数据[起租商务条件临时][begin_info_temp]初始化tax_type异常，异常信息：\t"
					+ e.getMessage());
		}

	}

	/**
	 * 流程开始的时候初始化项目交易结构表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {

		ConditionDao1 conditionDao1 = new ConditionDao1();

		try {
			conditionDao1.copyData2Temp(proj_id, doc_id);
			LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
					+ " 数据[项目交易结构临时表][proj_condition_temp]初始化tax_type完成");
		} catch (SQLException e) {
			LogWriter
					.logError("项目Id:"
							+ proj_id
							+ " 文档Id:"
							+ doc_id
							+ " 数据[项目交易结构临时表][proj_condition_temp]初始化tax_type异常，异常信息：\t"
							+ e.getMessage());
		}
	}

	/**
	 * 保存时更新税种字段
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static int flowUpdateTaxtype(ConditionBean conditionBean) {

		ConditionDao1 conditionDao1 = new ConditionDao1();
		int flag = 0;
		try {
			flag = conditionDao1.updateTaxType(conditionBean);
			LogWriter.logDebug("项目Id:" + conditionBean.getProj_id() + " 文档Id:"
					+ conditionBean.getDoc_id()
					+ " 数据[项目交易结构临时表][proj_condition_temp]更新tax_type完成"
					+ conditionBean.getTax_type());
		} catch (SQLException e) {
			LogWriter.logError("项目Id:" + conditionBean.getProj_id() + " 文档Id:"
					+ conditionBean.getDoc_id()
					+ " 数据[项目交易结构临时表][proj_condition_temp]更新tax_type异常，异常信息：\t"
					+ e.getMessage());
		}
		return flag;
	}

	/**
	 * 保存时更新税种字段
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static int flowUpdateTaxtypeToContractTemp(
			ConditionBean conditionBean) {

		ConditionDao1 conditionDao1 = new ConditionDao1();
		int flag = 0;
		try {
			flag = conditionDao1.updateTaxTypeToContractTemp(conditionBean);
			LogWriter.logDebug("合同Id:" + conditionBean.getContract_id()
					+ " 文档Id:" + conditionBean.getDoc_id()
					+ " 数据[项目交易结构临时表][contract_condition_temp]更新tax_type完成"
					+ conditionBean.getTax_type());
		} catch (SQLException e) {
			LogWriter
					.logError("合同Id:"
							+ conditionBean.getContract_id()
							+ " 文档Id:"
							+ conditionBean.getDoc_id()
							+ " 数据[项目交易结构临时表][contract_condition_temp]更新tax_type异常，异常信息：\t"
							+ e.getMessage());
		}
		return flag;
	}

	/**
	 * 租后流程开始的时候初始化合同交易结构表数据
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {

		// 1.ConditionDao实例化
		boolean flag = false;
		ConditionDao1 conditionDao1 = new ConditionDao1();
		try {
			conditionDao1.copyData2ContractTemp(contract_id, doc_id);
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据[合同交易结构临时表][contract_condition_temp]初始化tax_type完成");
		} catch (SQLException e) {
			LogWriter
					.logError("合同Id:"
							+ contract_id
							+ " 文档Id:"
							+ doc_id
							+ " 数据[合同交易结构临时表][contract_condition_temp]初始化tax_type异常，异常信息：\t"
							+ e.getMessage());

		}
	}

	/**
	 * 保存ConditionBean，保存到contract_condition_temp表
	 * 
	 * @param conditionBean
	 * @param save_type
	 * @return 影响行数
	 */
	public static int saveConditionContractBeanIntoTemp(
			ConditionBean conditionBean, String save_type) {
		int flag = 0;
		if (log.isInfoEnabled()) {
			log.info("将执行保存合同交易结构到Temp表，操作类型：" + save_type + " 合同id:"
					+ conditionBean.getContract_id());
		}
		// 1.ConditionDao1 实例化
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行操作
		if (save_type != null && "add".equals(save_type)) {// 插入数据库Insert

		} else {// update修改数据
			try {
				if (log.isInfoEnabled()) {
					log.info("开始执行更改ConditionBean到proj_condition_temp表");
				}
				flag = conditionDao
						.updateConditionContractBeanInTempTable(conditionBean);
				if (log.isInfoEnabled()) {
					log.info("执行插入ConditionBean到proj_condition_temp,更新结果："
							+ flag);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return flag;
	}

	/**
	 * 保存ConditionBean，保存到proj_condition_temp表
	 * 
	 * @param conditionBean
	 * @param save_type
	 * @return 影响行数
	 */
	public static int saveConditionBeanIntoTemp(ConditionBean conditionBean,
			String save_type) {
		int flag = 0;
		if (log.isInfoEnabled()) {
			log.info("将执行保存交易结构到Temp表，操作类型：" + save_type + " 项目id:"
					+ conditionBean.getProj_id());
		}
		// 1.ConditionDao1 实例化
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行操作

		try {
			// 2.1先删除数据
			conditionDao.deleteProjConditionTempData(
					conditionBean.getProj_id(), conditionBean.getDoc_id());
			// 2.2插入数据
			if (log.isInfoEnabled()) {
				log.info("开始执行插入ConditionBean到proj_condition_temp表");
			}
			flag = conditionDao.insertConditionBeanIntoTempTable(conditionBean);
			if (log.isInfoEnabled()) {
				log.info("执行插入ConditionBean到proj_condition_temp,更新结果：" + flag);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// if (save_type != null && "add".equals(save_type)) {// 插入数据库Insert
		// try {
		// if (log.isInfoEnabled()) {
		// log.info("开始执行插入ConditionBean到proj_condition_temp表");
		// }
		// flag = conditionDao
		// .insertConditionBeanIntoTempTable(conditionBean);
		// if (log.isInfoEnabled()) {
		// log.info("执行插入ConditionBean到proj_condition_temp,更新结果："
		// + flag);
		// }
		// } catch (SQLException e) {
		// e.printStackTrace();
		// }
		// } else {// update修改数据
		// try {
		// if (log.isInfoEnabled()) {
		// log.info("开始执行更改ConditionBean到proj_condition_temp表");
		// }
		// flag = conditionDao
		// .updateConditionBeanInTempTable(conditionBean);
		// if (log.isInfoEnabled()) {
		// log.info("执行插入ConditionBean到proj_condition_temp,更新结果："
		// + flag);
		// }
		// } catch (SQLException e) {
		// e.printStackTrace();
		// }
		// }

		return flag;
	}

	/**
	 * 判断当前proj_id\doc_id在proj_condition_temp是否存在
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static String judgeSaveType(String proj_id, String doc_id) {
		String saveType = "";

		// 1.ConditionDao实例化
		ConditionDao conditionDao = new ConditionDao();
		try {
			saveType = conditionDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (log.isInfoEnabled()) {
			log.debug("判断执行操作类型：" + saveType);
		}

		return saveType;
	}

	/**
	 * 判断当前contractId是否多次起租
	 * 
	 * @param contractId
	 * @return
	 */
	public static boolean judgeBeginType(String contractId) {
		boolean flag = false;

		// 1.ConditionDao实例化
		ConditionDao conditionDao = new ConditionDao();
		try {
			flag = conditionDao.judgeBeginType(contractId);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("判断合同：" + contractId + " 起租类型，是否多次起租："
				+ (flag ? "[是]" : "[否]"));

		return flag;
	}

	/**
	 * 保存上传的时候ConditionBean
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static int saveUploadConditionBean(ConditionBean conditionBean) {
		int resVal = 0;
		// 1.ConditionDao1 实例化
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行操作
		// 2.1先删除该数据
		try {
			conditionDao.delProjConditionTempData(conditionBean.getProj_id(),
					conditionBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2插入最新数据
		try {
			resVal = conditionDao
					.insertConditionBeanIntoTempTable(conditionBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resVal;
	}

	/**
	 * 保存上传的时候ConditionBean
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static int saveUploadConditionContractBean(
			ConditionBean conditionBean) {
		int resVal = 0;
		// 1.ConditionDao1 实例化
		ConditionDao conditionDao = new ConditionDao();
		// 2.执行操作
		// 2.1先删除该数据
		try {
			conditionDao.delProjConditionContractTempData(conditionBean
					.getContract_id(), conditionBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2插入最新数据
		try {
			resVal = conditionDao
					.insertConditionContractBeanIntoTempTable(conditionBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("更新contract_id:" + conditionBean.getContract_id()
				+ " 交易结构临时表，更新结果：" + (resVal == 0 ? "失败" : "成功"));
		return resVal;
	}

	/**
	 * 租金测算显示界面，如果当前proj_id\doc_id在proj_condition_temp存在，则查询假装bean
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static ConditionBean initConditionBean(ConditionBean conditionBean) {

		// 查询数据库假装Bean
		if (log.isInfoEnabled()) {
			log.info("加载当前项目：" + conditionBean.getProj_id() + " doc_id:"
					+ conditionBean.getDoc_id() + " 到conditionBean");
		}
		ConditionDao1 conditionDao1 = new ConditionDao1();
		try {
			conditionBean = conditionDao1.loadConditionBeanByKey(conditionBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conditionBean;
	}

	public static ConditionBean initConditionBean1(String proj_id) {
		ConditionBean conditionBean = null;

		// 查询数据库假装Bean
		if (log.isInfoEnabled()) {
			log.info("加载当前项目：" + proj_id + " 到conditionBean");
		}
		ConditionDao conditionDao = new ConditionDao();
		try {
			conditionBean = conditionDao.loadConditionBeanByKey1(proj_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conditionBean;
	}

	/**
	 * 加载合同交易结构
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static ConditionBean initConditionContractBean(
			ConditionBean conditionBean) {

		ConditionDao1 conditionDao1 = new ConditionDao1();
		try {
			conditionBean = conditionDao1
					.loadConditionContractBeanByKey(conditionBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conditionBean;
	}

	/**
	 * 加载合同交易结构- 正式
	 * 
	 * @param proj_id
	 * @return
	 */
	public static ConditionBean initFactConditionContractBean(String contract_id) {
		ConditionBean conditionBean = null;

		// 查询数据库假装Bean
		if (log.isInfoEnabled()) {
			log.info("加载当前正式合同：" + contract_id + " 到conditionBean");
		}
		ConditionDao conditionDao = new ConditionDao();
		try {
			conditionBean = conditionDao
					.loadFactConditionContractBeanByKey(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conditionBean;
	}

	/**
	 * 签约审批流程初始化合同交易结构数据
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		ConditionDao1 conditionDao1 = new ConditionDao1();
		// 3不存在则将proj_document正式表数据拷贝临时表
		try {
			conditionDao1.copyData2ContractTemp(contract_id, proj_id, doc_id);
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据[contract_condition_temp]tax_type初始化完成");
		} catch (SQLException e) {
			LogWriter.logError("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据[contract_condition_temp]初始化tax_type异常，异常信息：\t"
					+ e.getMessage());
		}
	}

}
