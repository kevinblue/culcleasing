package com.tenwa.culc.service;
/**
 * com.tenwa.culc.service
 */
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.ConditionMediBean;
import com.tenwa.culc.dao.ConditionMediDao;
import com.tenwa.log.LogWriter;


public class ConditionMediService {
		private static Logger log = Logger.getLogger(ConditionMediService.class);

		/**
		 * 租金变更流程之商务条件变更
		 * 
		 * @param contract_id
		 * @param begin_id
		 * @param doc_id
		 */
		public static void flowInitBeginCondData(String contract_id,
				String begin_id, String doc_id) {
			LogWriter.logDebug("执行流程初始化【起租商务条件】【begin_info_temp】数据");
			// 1先判断begin_info_temp表是否存在数据
			// 1.ConditionDao实例化
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeBeginDataExist(contract_id, begin_id,
						doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2存在则执行完毕
			if (flag) {
				LogWriter.logDebug("合同Id:" + contract_id + ", 起租id：" + begin_id
						+ " 文档Id:" + doc_id + " 数据在[begin_info_temp]中存在");
			} else {
				// 3不存在则将[begin_info]正式表数据拷贝临时表[begin_info_temp]
				try {
					conditionMediDao.copyBeginData2Temp(contract_id, begin_id, doc_id);
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
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				usedMoney = conditionMediDao.getUsedMoney(contractId);
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
			LogWriter.logDebug("执行起租流程初始化【起租商务条件】【begin_info_medi_temp】数据");
			// 1先判断begin_info_temp表是否存在数据
			// 1.ConditionDao实例化
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				System.out.println("进了这里");
				flag = conditionMediDao.judgeBeginDataExist(contract_id, begin_id,
						doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2存在则执行完毕
			if (flag) {
				LogWriter.logDebug("合同Id:" + contract_id + ", 起租id：" + begin_id
						+ " 文档Id:" + doc_id + " 数据在[begin_info_medi_temp]中存在");
			} else {
				// 3不存在则将[begin_info]正式表数据拷贝临时表[begin_info_temp]
				try {
					conditionMediDao.copyContract2BeginData2Temp(contract_id, begin_id,
							doc_id);
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
		}

		/**
		 * 流程开始的时候初始化项目交易结构表数据
		 * 
		 * @param proj_id
		 * @param doc_id
		 */
		public static void flowInitTableData(String proj_id, String doc_id) {
			LogWriter.logDebug("执行流程初始化【项目交易结构临时表】【proj_condition_temp】数据");
			// 1先判断proj_condition_temp表是否存在数据
			// 1.ConditionDao实例化
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeDataExist(proj_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2存在则执行完毕
			if (flag) {
				LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据在proj_condition_temp中存在");
			} else {
				// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
				try {
					conditionMediDao.copyData2Temp(proj_id, doc_id);
					LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
							+ " 数据[项目交易结构临时表][proj_condition_temp]初始化完成");
				} catch (SQLException e) {
					LogWriter.logError("项目Id:" + proj_id + " 文档Id:" + doc_id
							+ " 数据[项目交易结构临时表][proj_condition_temp]初始化异常，异常信息：\t"
							+ e.getMessage());
				}
			}
		}

		/**
		 * 租后流程开始的时候初始化合同交易结构表数据
		 * 
		 * @param contract_id
		 * @param doc_id
		 */
		public static void flowInitContractData(String contract_id, String doc_id) {
			LogWriter.logDebug("执行流程初始化【合同交易结构临时表】【contract_condition_temp】数据");
			// 1先判断proj_condition_temp表是否存在数据
			// 1.ConditionDao实例化
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeContractDataExist(contract_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2存在则执行完毕
			if (flag) {
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据在[contract_condition_temp]中存在");
			} else {
				// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
				try {
					conditionMediDao.copyData2ContractTemp(contract_id, doc_id);
					LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
							+ " 数据[合同交易结构临时表][contract_condition_temp]初始化完成");
				} catch (SQLException e) {
					LogWriter
							.logError("合同Id:"
									+ contract_id
									+ " 文档Id:"
									+ doc_id
									+ " 数据[合同交易结构临时表][contract_condition_temp]初始化异常，异常信息：\t"
									+ e.getMessage());
				}
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
				ConditionMediBean conditionMediBean, String save_type) {
			int flag = 0;
			if (log.isInfoEnabled()) {
				log.info("将执行保存合同交易结构到Temp表，操作类型：" + save_type + " 合同id:"
						+ conditionMediBean.getContract_id());
			}
			// 1.ConditionDao1 实例化
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.执行操作
			if (save_type != null && "add".equals(save_type)) {// 插入数据库Insert

			} else {// update修改数据
				try {
					if (log.isInfoEnabled()) {
						log.info("开始执行更改ConditionmediBean到contract_condition_medi_temp表");
					}
					flag = conditionMediDao
							.updateConditionContractBeanInTempTable(conditionMediBean);
					if (log.isInfoEnabled()) {
						log.info("执行插入ConditionmediBean到contract_condition_medi_temp,更新结果："
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
		public static int saveConditionBeanIntoTemp(ConditionMediBean conditionMediBean,
				String save_type) {
			int flag = 0;
			if (log.isInfoEnabled()) {
				log.info("将执行保存交易结构到Temp表，操作类型：" + save_type + " 项目id:"
						+ conditionMediBean.getProj_id());
			}
			// 1.ConditionDao1 实例化
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.执行操作

			try {
				// 2.1先删除数据
				conditionMediDao.deleteProjConditionTempData(
						conditionMediBean.getProj_id(), conditionMediBean.getDoc_id());
				// 2.2插入数据
				if (log.isInfoEnabled()) {
					log.info("开始执行插入ConditionBean到proj_condition_temp表");
				}
				flag = conditionMediDao.insertConditionBeanIntoTempTable(conditionMediBean);
				if (log.isInfoEnabled()) {
					log.info("执行插入conditionMediBean到proj_condition_temp,更新结果：" + flag);
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
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				saveType = conditionMediDao.judgeItemExist(proj_id, doc_id);
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
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeBeginType(contractId);
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
		public static int saveUploadConditionBean(ConditionMediBean conditionBean) {
			int resVal = 0;
			// 1.ConditionDao1 实例化
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.执行操作
			// 2.1先删除该数据
			try {
				conditionMediDao.delProjConditionTempData(conditionBean.getProj_id(),
						conditionBean.getDoc_id());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2.2插入最新数据
			try {
				resVal = conditionMediDao
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
				ConditionMediBean conditionMediBean) {
			int resVal = 0;
			// 1.ConditionDao1 实例化
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.执行操作
			// 2.1先删除该数据
			try {
				conditionMediDao.delProjConditionContractTempData(conditionMediBean
						.getContract_id(), conditionMediBean.getDoc_id());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2.2插入最新数据
			try {
				resVal = conditionMediDao
						.insertConditionContractBeanIntoTempTable(conditionMediBean);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			LogWriter.logDebug("更新contract_id:" + conditionMediBean.getContract_id()
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
		public static ConditionMediBean initConditionBean(String proj_id, String doc_id) {
			ConditionMediBean conditionMediBean = null;

			// 查询数据库假装Bean
			if (log.isInfoEnabled()) {
				
				log.info("加载当前项目：" + proj_id + " doc_id:" + doc_id
						+ " 到conditionBean");
			}
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				conditionMediBean = conditionMediDao
						.loadConditionMediBeanByKey(proj_id, doc_id);
				log.info("获取medi的值：" +conditionMediBean.getFloor_rent());
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return conditionMediBean;
		}
		
//		public static ConditionMediBean initConditionBean(String proj_id) {
//			ConditionMediBean conditionMediBean = null;
//
//			// 查询数据库假装Bean
//			if (log.isInfoEnabled()) {
//				
//				log.info("加载当前项目：" + proj_id + " 到conditionBean");
//			}
//			ConditionMediDao conditionMediDao = new ConditionMediDao();
//			try {
//				conditionMediBean = conditionMediDao
//						.loadConditionMediBeanByKey(proj_id);
//				log.info("获取medi的值：" +conditionMediBean.getFloor_rent());
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//
//			return conditionMediBean;
//		}

		/**
		 * 加载合同交易结构
		 * 
		 * @param proj_id
		 * @param doc_id
		 * @return
		 */
		public static ConditionMediBean initConditionContractBean(String contract_id,
				String doc_id) {
			ConditionMediBean conditionMediBean = null;

			// 查询数据库假装Bean
			if (log.isInfoEnabled()) {
				log.info("加载当前合同：" + contract_id + " doc_id:" + doc_id
						+ " 到conditionBean");
			}
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				conditionMediBean = conditionMediDao.loadConditionContractBeanByKey(
						contract_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return conditionMediBean;
		}

		/**
		 * 加载合同交易结构- 正式
		 * 
		 * @param proj_id
		 * @return
		 */
		public static ConditionMediBean initFactConditionContractBean(String contract_id) {
			ConditionMediBean conditionMediBean = null;

			// 查询数据库假装Bean
			if (log.isInfoEnabled()) {
				log.info("加载当前正式合同：" + contract_id + " 到conditionBean");
			}
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				conditionMediBean = conditionMediDao
						.loadFactConditionContractBeanByKey(contract_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return conditionMediBean;
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
			LogWriter.logDebug("执行合同交易结构临时表[contract_condition_temp]签约审批流程初始化数据");
			// 1先判断contract_condition_temp表是否存在数据
			// 1.ConditionDao实例化
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeItemContractExist(contract_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2存在则执行完毕
			if (flag) {
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据在contract_condition_temp中存在");
			} else {
				// 3不存在则将proj_document正式表数据拷贝临时表
				try {
					conditionMediDao
							.copyData2ContractTemp(contract_id, proj_id, doc_id);
					LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
							+ " 数据[contract_condition_temp]初始化完成");
				} catch (SQLException e) {
					LogWriter.logError("合同Id:" + contract_id + " 文档Id:" + doc_id
							+ " 数据[contract_condition_temp]初始化异常，异常信息：\t"
							+ e.getMessage());
				}
			}

		}
	}