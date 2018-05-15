/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;

import com.tenwa.culc.dao.ProjMaterDao;
import com.tenwa.log.LogWriter;

/**
 * ��Ŀ����Service
 * 
 * @author Jaffe
 * 
 * Date:Jul 14, 2011 10:13:05 AM Email:JaffeHe@hotmail.com
 */
public class ProjMaterService {

	/**
	 * ���̿�ʼ��ʱ���ʼ����Ŀ�����嵥������
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {
		LogWriter.logDebug("ִ����Ŀ�������̳�ʼ������");
		// 1���ж�proj_document_temp���Ƿ��������
		// 1.ProjMaterDaoʵ����
		boolean flag = false;
		ProjMaterDao projMaterDao = new ProjMaterDao();
		try {
			flag = projMaterDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
					+ " ������proj_document_temp�д���");
		} else {
			// 3��������proj_document��ʽ�����ݿ�����ʱ��
			try {
				projMaterDao.copyData2Temp(proj_id, doc_id);
				LogWriter.logDebug("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
						+ " ���ݳ�ʼ�����");
			} catch (SQLException e) {
				LogWriter.logError("��ĿId:" + proj_id + " �ĵ�Id:" + doc_id
						+ " ���ݳ�ʼ���쳣���쳣��Ϣ��\t" + e.getMessage());
			}
		}
	}

	/**
	 * �������������ͬ�����ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {
		LogWriter.logDebug("ִ�к�ͬ�������̳�ʼ������");
		// 1���ж�contract_document_temp���Ƿ��������
		// 1.ProjMaterDaoʵ����
		boolean flag = false;
		ProjMaterDao projMaterDao = new ProjMaterDao();
		try {
			flag = projMaterDao.judgeContractItemExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ������[contract_document_temp]�д���");
		} else {
			// 3��������proj_document��ʽ�����ݿ�����ʱ��
			try {
				projMaterDao.copyData2ContractTemp(contract_id, doc_id);
				LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[contract_document_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter.logError("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[contract_document_temp]��ʼ���쳣���쳣��Ϣ��\t" + e.getMessage());
			}
		}
	}

	/**
	 * ǩԼ�������̳�ʼ����Ŀ��������
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		LogWriter.logDebug("ִ����Ŀ����[contract_document_temp]ǩԼ�������̳�ʼ������");
		// 1���ж�proj_document_temp���Ƿ��������
		// 1.ProjMaterDaoʵ����
		boolean flag = false;
		ProjMaterDao projMaterDao = new ProjMaterDao();
		try {
			flag = projMaterDao.judgeItemContractExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ������contract_document_temp�д���");
		} else {
			// 3��������proj_document��ʽ�����ݿ�����ʱ��
			try {
				projMaterDao
						.copyData2ContractTemp(contract_id, proj_id, doc_id);
				LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[contract_document_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter.logError("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
						+ " ����[contract_document_temp]��ʼ���쳣���쳣��Ϣ��\t"
						+ e.getMessage());
			}
		}

	}
}
