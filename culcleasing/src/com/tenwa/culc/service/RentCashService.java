/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;
import java.util.List;

import com.tenwa.culc.bean.RentCashBean;
import com.tenwa.culc.dao.RentCashDao;
import com.tenwa.log.LogWriter;

/**
 * @author Jaffe
 * 
 * Date:Jul 13, 2011 10:24:12 AM Email:JaffeHe@hotmail.com
 */
public class RentCashService {

	/**
	 * �����ϴ�Excel�����ļ����ֽ�������
	 * 
	 * @param rentCashList
	 * @param proj_id
	 * @param doc_id
	 */
	public static void saveUploadRentCashList(List<RentCashBean> rentCashList,
			String proj_id, String doc_id) {
		// 2. === �����ݸ��� ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1ɾ����ʷ����
		try {
			rentCashDao.deleteRentCashProjTempHisData(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		int resVal = 0;
		try {
			resVal = rentCashDao.updateRentCashProjTempData(rentCashList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("����proj_Id:" + proj_id + " ����Ŀ�ֽ�����ʱ�����ݣ����½����"
				+ (resVal == 0 ? "ʧ��" : "�ɹ�"));
	}

	/**
	 * �����ϴ�Excel�����ļ����ͬ�ֽ�������
	 * 
	 * @param rentCashList
	 * @param contract_id
	 * @param doc_id
	 */
	public static void saveUploadRentCashContractList(
			List<RentCashBean> rentCashList, String contract_id, String doc_id) {
		// 2. === �����ݸ��� ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1ɾ����ʷ����
		try {
			rentCashDao.deleteRentCashContractTempHisData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		int resVal = 0;
		try {
			resVal = rentCashDao.updateRentCashContractTempData(rentCashList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("����contract_id:" + contract_id
				+ " �ĺ�ͬ�ֽ�����ʱ�����ݣ����½����" + (resVal == 0 ? "ʧ��" : "�ɹ�"));
	}

	/**
	 * ���̿�ʼ��ʱ���ʼ����Ŀ�ֽ����ƻ�������
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {
		LogWriter.logDebug("ִ�����̳�ʼ������Ŀ����ֽ�����ʱ����fund_proj_plan_mark_temp������");
		// 1���ж�fund_proj_plan_mark_temp���Ƿ��������
		// 1.RentCashDaoʵ����
		boolean flag = false;
		RentCashDao rentCashDao = new RentCashDao();
		try {
			flag = rentCashDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
					+ " ������fund_proj_plan_mark_temp�д���");
		} else {
			// 3��������proj_fund_fund_charge_plan��ʽ�����ݿ�����ʱ��
			try {
				rentCashDao.copyData2Temp(proj_id, doc_id);
				LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
						+ " ����[��Ŀ����ֽ�����ʱ��][fund_proj_plan_mark_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter
						.logError("��ĿId:"
								+ proj_id
								+ " �ĵ�Id:"
								+ doc_id
								+ " ����[��Ŀ����ֽ�����ʱ��][fund_proj_plan_mark_temp]��ʼ���쳣���쳣��Ϣ��\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * ������̿�ʼ��ʱ���ʼ����ͬ�ֽ���������
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {
		LogWriter.logDebug("ִ�����̳�ʼ��[��ͬ�ֽ�����ʱ��][fund_contract_plan_mark_temp]����");
		// 1���ж�fund_contract_plan_mark_temp���Ƿ��������
		// 1.RentCashDaoʵ����
		boolean flag = false;
		RentCashDao rentCashDao = new RentCashDao();
		try {
			flag = rentCashDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ������[��ͬ�ֽ�����ʱ��][fund_contract_plan_mark_temp]�д���");
		} else {
			// 3��������proj_fund_fund_charge_plan��ʽ�����ݿ�����ʱ��
			try {
				rentCashDao.copyData2ContractTemp(contract_id, doc_id);
				LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[��ͬ�ֽ�����ʱ��][fund_contract_plan_mark_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter
						.logError("��ͬId:"
								+ contract_id
								+ " �ĵ�Id:"
								+ doc_id
								+ " ����[��ͬ�ֽ�����ʱ��][fund_contract_plan_mark_temp]��ʼ���쳣���쳣��Ϣ��\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * ǩԼ�������̳�ʼ����ͬ�ֽ�����ʱ������
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		LogWriter
				.logDebug("ִ�к�ͬ�ֽ�����ʱ��[fund_contract_plan_mark_temp]ǩԼ�������̳�ʼ������");
		// 1���ж�contract_condition_temp���Ƿ��������
		// 1.RentPlanDaoʵ����
		boolean flag = false;
		RentCashDao rentCashDao = new RentCashDao();
		try {
			flag = rentCashDao.judgeItemContractExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ������[fund_contract_plan_mark_temp]�д���");
		} else {
			// 3��������proj_document��ʽ�����ݿ�����ʱ��
			try {
				rentCashDao.copyData2ContractTemp(contract_id, proj_id, doc_id);
				LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[fund_contract_plan_mark_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter.logError("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[fund_contract_plan_mark_temp]��ʼ���쳣���쳣��Ϣ��\t"
						+ e.getMessage());
			}
		}

	}
}
