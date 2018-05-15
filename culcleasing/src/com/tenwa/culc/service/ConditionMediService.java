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
		 * ���������֮�����������
		 * 
		 * @param contract_id
		 * @param begin_id
		 * @param doc_id
		 */
		public static void flowInitBeginCondData(String contract_id,
				String begin_id, String doc_id) {
			LogWriter.logDebug("ִ�����̳�ʼ��������������������begin_info_temp������");
			// 1���ж�begin_info_temp���Ƿ��������
			// 1.ConditionDaoʵ����
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeBeginDataExist(contract_id, begin_id,
						doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2������ִ�����
			if (flag) {
				LogWriter.logDebug("��ͬId:" + contract_id + ", ����id��" + begin_id
						+ " �ĵ�Id:" + doc_id + " ������[begin_info_temp]�д���");
			} else {
				// 3��������[begin_info]��ʽ�����ݿ�����ʱ��[begin_info_temp]
				try {
					conditionMediDao.copyBeginData2Temp(contract_id, begin_id, doc_id);
					LogWriter.logDebug("��ͬId:" + contract_id + ", ����id��" + begin_id
							+ " �ĵ�Id:" + doc_id
							+ " ����[��������������ʱ][begin_info_temp]��ʼ�����");
				} catch (SQLException e) {
					LogWriter.logError("��ͬId:" + contract_id + ", ����id��" + begin_id
							+ " �ĵ�Id:" + doc_id
							+ " ����[��������������ʱ][begin_info_temp]��ʼ���쳣���쳣��Ϣ��\t"
							+ e.getMessage());
				}
			}
		}

		/**
		 * ��ѯ�ú�ͬ������Ŀ����ʹ����Ŀ���
		 * 
		 * @param contractId
		 * @return
		 */
		public static String getUsedEquipAmt(String contractId) {
			String usedMoney = "";
			// 1.ConditionDaoʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				usedMoney = conditionMediDao.getUsedMoney(contractId);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			LogWriter.logDebug("��ͬ��" + contractId + "��������Ŀ��ʹ����Ŀ���Ϊ��" + usedMoney);

			return usedMoney;
		}

		/**
		 * ���������֮�����������
		 * 
		 * @param contract_id
		 * @param begin_id
		 * @param doc_id
		 */
		public static void flowInitBeginTempData(String contract_id,
				String begin_id, String doc_id) {
			LogWriter.logDebug("ִ���������̳�ʼ��������������������begin_info_medi_temp������");
			// 1���ж�begin_info_temp���Ƿ��������
			// 1.ConditionDaoʵ����
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				System.out.println("��������");
				flag = conditionMediDao.judgeBeginDataExist(contract_id, begin_id,
						doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2������ִ�����
			if (flag) {
				LogWriter.logDebug("��ͬId:" + contract_id + ", ����id��" + begin_id
						+ " �ĵ�Id:" + doc_id + " ������[begin_info_medi_temp]�д���");
			} else {
				// 3��������[begin_info]��ʽ�����ݿ�����ʱ��[begin_info_temp]
				try {
					conditionMediDao.copyContract2BeginData2Temp(contract_id, begin_id,
							doc_id);
					LogWriter.logDebug("��ͬId:" + contract_id + ", ����id��" + begin_id
							+ " �ĵ�Id:" + doc_id
							+ " ����[��������������ʱ][begin_info_temp]��ʼ�����");
				} catch (SQLException e) {
					LogWriter.logError("��ͬId:" + contract_id + ", ����id��" + begin_id
							+ " �ĵ�Id:" + doc_id
							+ " ����[��������������ʱ][begin_info_temp]��ʼ���쳣���쳣��Ϣ��\t"
							+ e.getMessage());
				}
			}
		}

		/**
		 * ���̿�ʼ��ʱ���ʼ����Ŀ���׽ṹ������
		 * 
		 * @param proj_id
		 * @param doc_id
		 */
		public static void flowInitTableData(String proj_id, String doc_id) {
			LogWriter.logDebug("ִ�����̳�ʼ������Ŀ���׽ṹ��ʱ����proj_condition_temp������");
			// 1���ж�proj_condition_temp���Ƿ��������
			// 1.ConditionDaoʵ����
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeDataExist(proj_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2������ִ�����
			if (flag) {
				LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
						+ " ������proj_condition_temp�д���");
			} else {
				// 3��������proj_fund_fund_charge_plan��ʽ�����ݿ�����ʱ��
				try {
					conditionMediDao.copyData2Temp(proj_id, doc_id);
					LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
							+ " ����[��Ŀ���׽ṹ��ʱ��][proj_condition_temp]��ʼ�����");
				} catch (SQLException e) {
					LogWriter.logError("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
							+ " ����[��Ŀ���׽ṹ��ʱ��][proj_condition_temp]��ʼ���쳣���쳣��Ϣ��\t"
							+ e.getMessage());
				}
			}
		}

		/**
		 * ������̿�ʼ��ʱ���ʼ����ͬ���׽ṹ������
		 * 
		 * @param contract_id
		 * @param doc_id
		 */
		public static void flowInitContractData(String contract_id, String doc_id) {
			LogWriter.logDebug("ִ�����̳�ʼ������ͬ���׽ṹ��ʱ����contract_condition_temp������");
			// 1���ж�proj_condition_temp���Ƿ��������
			// 1.ConditionDaoʵ����
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeContractDataExist(contract_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2������ִ�����
			if (flag) {
				LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ������[contract_condition_temp]�д���");
			} else {
				// 3��������proj_fund_fund_charge_plan��ʽ�����ݿ�����ʱ��
				try {
					conditionMediDao.copyData2ContractTemp(contract_id, doc_id);
					LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
							+ " ����[��ͬ���׽ṹ��ʱ��][contract_condition_temp]��ʼ�����");
				} catch (SQLException e) {
					LogWriter
							.logError("��ͬId:"
									+ contract_id
									+ " �ĵ�Id:"
									+ doc_id
									+ " ����[��ͬ���׽ṹ��ʱ��][contract_condition_temp]��ʼ���쳣���쳣��Ϣ��\t"
									+ e.getMessage());
				}
			}
		}

		/**
		 * ����ConditionBean�����浽contract_condition_temp��
		 * 
		 * @param conditionBean
		 * @param save_type
		 * @return Ӱ������
		 */
		public static int saveConditionContractBeanIntoTemp(
				ConditionMediBean conditionMediBean, String save_type) {
			int flag = 0;
			if (log.isInfoEnabled()) {
				log.info("��ִ�б����ͬ���׽ṹ��Temp���������ͣ�" + save_type + " ��ͬid:"
						+ conditionMediBean.getContract_id());
			}
			// 1.ConditionDao1 ʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.ִ�в���
			if (save_type != null && "add".equals(save_type)) {// �������ݿ�Insert

			} else {// update�޸�����
				try {
					if (log.isInfoEnabled()) {
						log.info("��ʼִ�и���ConditionmediBean��contract_condition_medi_temp��");
					}
					flag = conditionMediDao
							.updateConditionContractBeanInTempTable(conditionMediBean);
					if (log.isInfoEnabled()) {
						log.info("ִ�в���ConditionmediBean��contract_condition_medi_temp,���½����"
								+ flag);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			return flag;
		}

		/**
		 * ����ConditionBean�����浽proj_condition_temp��
		 * 
		 * @param conditionBean
		 * @param save_type
		 * @return Ӱ������
		 */
		public static int saveConditionBeanIntoTemp(ConditionMediBean conditionMediBean,
				String save_type) {
			int flag = 0;
			if (log.isInfoEnabled()) {
				log.info("��ִ�б��潻�׽ṹ��Temp���������ͣ�" + save_type + " ��Ŀid:"
						+ conditionMediBean.getProj_id());
			}
			// 1.ConditionDao1 ʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.ִ�в���

			try {
				// 2.1��ɾ������
				conditionMediDao.deleteProjConditionTempData(
						conditionMediBean.getProj_id(), conditionMediBean.getDoc_id());
				// 2.2��������
				if (log.isInfoEnabled()) {
					log.info("��ʼִ�в���ConditionBean��proj_condition_temp��");
				}
				flag = conditionMediDao.insertConditionBeanIntoTempTable(conditionMediBean);
				if (log.isInfoEnabled()) {
					log.info("ִ�в���conditionMediBean��proj_condition_temp,���½����" + flag);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// if (save_type != null && "add".equals(save_type)) {// �������ݿ�Insert
			// try {
			// if (log.isInfoEnabled()) {
			// log.info("��ʼִ�в���ConditionBean��proj_condition_temp��");
			// }
			// flag = conditionDao
			// .insertConditionBeanIntoTempTable(conditionBean);
			// if (log.isInfoEnabled()) {
			// log.info("ִ�в���ConditionBean��proj_condition_temp,���½����"
			// + flag);
			// }
			// } catch (SQLException e) {
			// e.printStackTrace();
			// }
			// } else {// update�޸�����
			// try {
			// if (log.isInfoEnabled()) {
			// log.info("��ʼִ�и���ConditionBean��proj_condition_temp��");
			// }
			// flag = conditionDao
			// .updateConditionBeanInTempTable(conditionBean);
			// if (log.isInfoEnabled()) {
			// log.info("ִ�в���ConditionBean��proj_condition_temp,���½����"
			// + flag);
			// }
			// } catch (SQLException e) {
			// e.printStackTrace();
			// }
			// }

			return flag;
		}

		/**
		 * �жϵ�ǰproj_id\doc_id��proj_condition_temp�Ƿ����
		 * 
		 * @param proj_id
		 * @param doc_id
		 * @return
		 */
		public static String judgeSaveType(String proj_id, String doc_id) {
			String saveType = "";

			// 1.ConditionDaoʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				saveType = conditionMediDao.judgeItemExist(proj_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			if (log.isInfoEnabled()) {
				log.debug("�ж�ִ�в������ͣ�" + saveType);
			}

			return saveType;
		}

		/**
		 * �жϵ�ǰcontractId�Ƿ�������
		 * 
		 * @param contractId
		 * @return
		 */
		public static boolean judgeBeginType(String contractId) {
			boolean flag = false;

			// 1.ConditionDaoʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeBeginType(contractId);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			LogWriter.logDebug("�жϺ�ͬ��" + contractId + " �������ͣ��Ƿ������⣺"
					+ (flag ? "[��]" : "[��]"));

			return flag;
		}

		/**
		 * �����ϴ���ʱ��ConditionBean
		 * 
		 * @param conditionBean
		 * @return
		 */
		public static int saveUploadConditionBean(ConditionMediBean conditionBean) {
			int resVal = 0;
			// 1.ConditionDao1 ʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.ִ�в���
			// 2.1��ɾ��������
			try {
				conditionMediDao.delProjConditionTempData(conditionBean.getProj_id(),
						conditionBean.getDoc_id());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2.2������������
			try {
				resVal = conditionMediDao
						.insertConditionBeanIntoTempTable(conditionBean);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return resVal;
		}

		/**
		 * �����ϴ���ʱ��ConditionBean
		 * 
		 * @param conditionBean
		 * @return
		 */
		public static int saveUploadConditionContractBean(
				ConditionMediBean conditionMediBean) {
			int resVal = 0;
			// 1.ConditionDao1 ʵ����
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			// 2.ִ�в���
			// 2.1��ɾ��������
			try {
				conditionMediDao.delProjConditionContractTempData(conditionMediBean
						.getContract_id(), conditionMediBean.getDoc_id());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2.2������������
			try {
				resVal = conditionMediDao
						.insertConditionContractBeanIntoTempTable(conditionMediBean);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			LogWriter.logDebug("����contract_id:" + conditionMediBean.getContract_id()
					+ " ���׽ṹ��ʱ�����½����" + (resVal == 0 ? "ʧ��" : "�ɹ�"));
			return resVal;
		}

		/**
		 * ��������ʾ���棬�����ǰproj_id\doc_id��proj_condition_temp���ڣ����ѯ��װbean
		 * 
		 * @param proj_id
		 * @param doc_id
		 * @return
		 */
		public static ConditionMediBean initConditionBean(String proj_id, String doc_id) {
			ConditionMediBean conditionMediBean = null;

			// ��ѯ���ݿ��װBean
			if (log.isInfoEnabled()) {
				
				log.info("���ص�ǰ��Ŀ��" + proj_id + " doc_id:" + doc_id
						+ " ��conditionBean");
			}
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				conditionMediBean = conditionMediDao
						.loadConditionMediBeanByKey(proj_id, doc_id);
				log.info("��ȡmedi��ֵ��" +conditionMediBean.getFloor_rent());
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return conditionMediBean;
		}
		
//		public static ConditionMediBean initConditionBean(String proj_id) {
//			ConditionMediBean conditionMediBean = null;
//
//			// ��ѯ���ݿ��װBean
//			if (log.isInfoEnabled()) {
//				
//				log.info("���ص�ǰ��Ŀ��" + proj_id + " ��conditionBean");
//			}
//			ConditionMediDao conditionMediDao = new ConditionMediDao();
//			try {
//				conditionMediBean = conditionMediDao
//						.loadConditionMediBeanByKey(proj_id);
//				log.info("��ȡmedi��ֵ��" +conditionMediBean.getFloor_rent());
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//
//			return conditionMediBean;
//		}

		/**
		 * ���غ�ͬ���׽ṹ
		 * 
		 * @param proj_id
		 * @param doc_id
		 * @return
		 */
		public static ConditionMediBean initConditionContractBean(String contract_id,
				String doc_id) {
			ConditionMediBean conditionMediBean = null;

			// ��ѯ���ݿ��װBean
			if (log.isInfoEnabled()) {
				log.info("���ص�ǰ��ͬ��" + contract_id + " doc_id:" + doc_id
						+ " ��conditionBean");
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
		 * ���غ�ͬ���׽ṹ- ��ʽ
		 * 
		 * @param proj_id
		 * @return
		 */
		public static ConditionMediBean initFactConditionContractBean(String contract_id) {
			ConditionMediBean conditionMediBean = null;

			// ��ѯ���ݿ��װBean
			if (log.isInfoEnabled()) {
				log.info("���ص�ǰ��ʽ��ͬ��" + contract_id + " ��conditionBean");
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
		 * ǩԼ�������̳�ʼ����ͬ���׽ṹ����
		 * 
		 * @param contract_id
		 * @param proj_id
		 * @param doc_id
		 */
		public static void flowInitContractApproveData(String contract_id,
				String proj_id, String doc_id) {
			LogWriter.logDebug("ִ�к�ͬ���׽ṹ��ʱ��[contract_condition_temp]ǩԼ�������̳�ʼ������");
			// 1���ж�contract_condition_temp���Ƿ��������
			// 1.ConditionDaoʵ����
			boolean flag = false;
			ConditionMediDao conditionMediDao = new ConditionMediDao();
			try {
				flag = conditionMediDao.judgeItemContractExist(contract_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2������ִ�����
			if (flag) {
				LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ������contract_condition_temp�д���");
			} else {
				// 3��������proj_document��ʽ�����ݿ�����ʱ��
				try {
					conditionMediDao
							.copyData2ContractTemp(contract_id, proj_id, doc_id);
					LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
							+ " ����[contract_condition_temp]��ʼ�����");
				} catch (SQLException e) {
					LogWriter.logError("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
							+ " ����[contract_condition_temp]��ʼ���쳣���쳣��Ϣ��\t"
							+ e.getMessage());
				}
			}

		}
	}