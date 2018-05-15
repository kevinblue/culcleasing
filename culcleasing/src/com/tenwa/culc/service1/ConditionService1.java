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
 * Condition ��������Service����
 * 
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 2:34:55 PM Email:JaffeHe@hotmail.com
 */
public class ConditionService1 {

	private static Logger log = Logger.getLogger(ConditionService1.class);

	/**
	 * ���������֮�����������
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

	/**
	 * ��ѯ�ú�ͬ������Ŀ����ʹ����Ŀ���
	 * 
	 * @param contractId
	 * @return
	 */
	public static String getUsedEquipAmt(String contractId) {
		String usedMoney = "";
		// 1.ConditionDaoʵ����
		ConditionDao conditionDao = new ConditionDao();
		try {
			usedMoney = conditionDao.getUsedMoney(contractId);
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

		// 1.ConditionDaoʵ����
		ConditionDao1 conditionDao1 = new ConditionDao1();

		// 3��������[begin_info]��ʽ�����ݿ�����ʱ��[begin_info_temp]
		try {
			conditionDao1.copyContract2BeginData2Temp(contract_id, begin_id,
					doc_id);
			LogWriter.logDebug("��ͬId:" + contract_id + ", ����id��" + begin_id
					+ " �ĵ�Id:" + doc_id
					+ " ����[��������������ʱ][begin_info_temp]��ʼ��tax_type���");
		} catch (SQLException e) {
			LogWriter.logError("��ͬId:" + contract_id + ", ����id��" + begin_id
					+ " �ĵ�Id:" + doc_id
					+ " ����[��������������ʱ][begin_info_temp]��ʼ��tax_type�쳣���쳣��Ϣ��\t"
					+ e.getMessage());
		}

	}

	/**
	 * ���̿�ʼ��ʱ���ʼ����Ŀ���׽ṹ������
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {

		ConditionDao1 conditionDao1 = new ConditionDao1();

		try {
			conditionDao1.copyData2Temp(proj_id, doc_id);
			LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
					+ " ����[��Ŀ���׽ṹ��ʱ��][proj_condition_temp]��ʼ��tax_type���");
		} catch (SQLException e) {
			LogWriter
					.logError("��ĿId:"
							+ proj_id
							+ " �ĵ�Id:"
							+ doc_id
							+ " ����[��Ŀ���׽ṹ��ʱ��][proj_condition_temp]��ʼ��tax_type�쳣���쳣��Ϣ��\t"
							+ e.getMessage());
		}
	}

	/**
	 * ����ʱ����˰���ֶ�
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static int flowUpdateTaxtype(ConditionBean conditionBean) {

		ConditionDao1 conditionDao1 = new ConditionDao1();
		int flag = 0;
		try {
			flag = conditionDao1.updateTaxType(conditionBean);
			LogWriter.logDebug("��ĿId:" + conditionBean.getProj_id() + " �ĵ�Id:"
					+ conditionBean.getDoc_id()
					+ " ����[��Ŀ���׽ṹ��ʱ��][proj_condition_temp]����tax_type���"
					+ conditionBean.getTax_type());
		} catch (SQLException e) {
			LogWriter.logError("��ĿId:" + conditionBean.getProj_id() + " �ĵ�Id:"
					+ conditionBean.getDoc_id()
					+ " ����[��Ŀ���׽ṹ��ʱ��][proj_condition_temp]����tax_type�쳣���쳣��Ϣ��\t"
					+ e.getMessage());
		}
		return flag;
	}

	/**
	 * ����ʱ����˰���ֶ�
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
			LogWriter.logDebug("��ͬId:" + conditionBean.getContract_id()
					+ " �ĵ�Id:" + conditionBean.getDoc_id()
					+ " ����[��Ŀ���׽ṹ��ʱ��][contract_condition_temp]����tax_type���"
					+ conditionBean.getTax_type());
		} catch (SQLException e) {
			LogWriter
					.logError("��ͬId:"
							+ conditionBean.getContract_id()
							+ " �ĵ�Id:"
							+ conditionBean.getDoc_id()
							+ " ����[��Ŀ���׽ṹ��ʱ��][contract_condition_temp]����tax_type�쳣���쳣��Ϣ��\t"
							+ e.getMessage());
		}
		return flag;
	}

	/**
	 * ������̿�ʼ��ʱ���ʼ����ͬ���׽ṹ������
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {

		// 1.ConditionDaoʵ����
		boolean flag = false;
		ConditionDao1 conditionDao1 = new ConditionDao1();
		try {
			conditionDao1.copyData2ContractTemp(contract_id, doc_id);
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ����[��ͬ���׽ṹ��ʱ��][contract_condition_temp]��ʼ��tax_type���");
		} catch (SQLException e) {
			LogWriter
					.logError("��ͬId:"
							+ contract_id
							+ " �ĵ�Id:"
							+ doc_id
							+ " ����[��ͬ���׽ṹ��ʱ��][contract_condition_temp]��ʼ��tax_type�쳣���쳣��Ϣ��\t"
							+ e.getMessage());

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
			ConditionBean conditionBean, String save_type) {
		int flag = 0;
		if (log.isInfoEnabled()) {
			log.info("��ִ�б����ͬ���׽ṹ��Temp�����������ͣ�" + save_type + " ��ͬid:"
					+ conditionBean.getContract_id());
		}
		// 1.ConditionDao1 ʵ����
		ConditionDao conditionDao = new ConditionDao();
		// 2.ִ�в���
		if (save_type != null && "add".equals(save_type)) {// �������ݿ�Insert

		} else {// update�޸�����
			try {
				if (log.isInfoEnabled()) {
					log.info("��ʼִ�и���ConditionBean��proj_condition_temp��");
				}
				flag = conditionDao
						.updateConditionContractBeanInTempTable(conditionBean);
				if (log.isInfoEnabled()) {
					log.info("ִ�в���ConditionBean��proj_condition_temp,���½����"
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
	public static int saveConditionBeanIntoTemp(ConditionBean conditionBean,
			String save_type) {
		int flag = 0;
		if (log.isInfoEnabled()) {
			log.info("��ִ�б��潻�׽ṹ��Temp�����������ͣ�" + save_type + " ��Ŀid:"
					+ conditionBean.getProj_id());
		}
		// 1.ConditionDao1 ʵ����
		ConditionDao conditionDao = new ConditionDao();
		// 2.ִ�в���

		try {
			// 2.1��ɾ������
			conditionDao.deleteProjConditionTempData(
					conditionBean.getProj_id(), conditionBean.getDoc_id());
			// 2.2��������
			if (log.isInfoEnabled()) {
				log.info("��ʼִ�в���ConditionBean��proj_condition_temp��");
			}
			flag = conditionDao.insertConditionBeanIntoTempTable(conditionBean);
			if (log.isInfoEnabled()) {
				log.info("ִ�в���ConditionBean��proj_condition_temp,���½����" + flag);
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
		ConditionDao conditionDao = new ConditionDao();
		try {
			saveType = conditionDao.judgeItemExist(proj_id, doc_id);
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
		ConditionDao conditionDao = new ConditionDao();
		try {
			flag = conditionDao.judgeBeginType(contractId);
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
	public static int saveUploadConditionBean(ConditionBean conditionBean) {
		int resVal = 0;
		// 1.ConditionDao1 ʵ����
		ConditionDao conditionDao = new ConditionDao();
		// 2.ִ�в���
		// 2.1��ɾ��������
		try {
			conditionDao.delProjConditionTempData(conditionBean.getProj_id(),
					conditionBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		try {
			resVal = conditionDao
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
			ConditionBean conditionBean) {
		int resVal = 0;
		// 1.ConditionDao1 ʵ����
		ConditionDao conditionDao = new ConditionDao();
		// 2.ִ�в���
		// 2.1��ɾ��������
		try {
			conditionDao.delProjConditionContractTempData(conditionBean
					.getContract_id(), conditionBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		try {
			resVal = conditionDao
					.insertConditionContractBeanIntoTempTable(conditionBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("����contract_id:" + conditionBean.getContract_id()
				+ " ���׽ṹ��ʱ�������½����" + (resVal == 0 ? "ʧ��" : "�ɹ�"));
		return resVal;
	}

	/**
	 * ��������ʾ���棬�����ǰproj_id\doc_id��proj_condition_temp���ڣ����ѯ��װbean
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static ConditionBean initConditionBean(ConditionBean conditionBean) {

		// ��ѯ���ݿ��װBean
		if (log.isInfoEnabled()) {
			log.info("���ص�ǰ��Ŀ��" + conditionBean.getProj_id() + " doc_id:"
					+ conditionBean.getDoc_id() + " ��conditionBean");
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

		// ��ѯ���ݿ��װBean
		if (log.isInfoEnabled()) {
			log.info("���ص�ǰ��Ŀ��" + proj_id + " ��conditionBean");
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
	 * ���غ�ͬ���׽ṹ
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
	 * ���غ�ͬ���׽ṹ- ��ʽ
	 * 
	 * @param proj_id
	 * @return
	 */
	public static ConditionBean initFactConditionContractBean(String contract_id) {
		ConditionBean conditionBean = null;

		// ��ѯ���ݿ��װBean
		if (log.isInfoEnabled()) {
			log.info("���ص�ǰ��ʽ��ͬ��" + contract_id + " ��conditionBean");
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
	 * ǩԼ�������̳�ʼ����ͬ���׽ṹ����
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		ConditionDao1 conditionDao1 = new ConditionDao1();
		// 3��������proj_document��ʽ�����ݿ�����ʱ��
		try {
			conditionDao1.copyData2ContractTemp(contract_id, proj_id, doc_id);
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ����[contract_condition_temp]tax_type��ʼ�����");
		} catch (SQLException e) {
			LogWriter.logError("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ����[contract_condition_temp]��ʼ��tax_type�쳣���쳣��Ϣ��\t"
					+ e.getMessage());
		}
	}

}