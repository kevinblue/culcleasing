/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;

import com.tenwa.culc.dao.CustAccountDao;
import com.tenwa.log.LogWriter;


/**
 * @author Toybaby
 * 2014-03-24
 * ���ں�ͬ������ҳ���ʼ���жϺ�ͬ�����ʺ���ʱ�����Ƿ�������
 *
 */
public class CustAccountOperationService {

	/**
	 * @param contract_id
	 * @param doc_id
	 * ���ں�ͬ������ҳ���ʼ���жϺ�ͬ�����ʺ���ʱ�����Ƿ�������
	 */
	public static void flowInitContractApproveAccountData(String contract_id,String cust_id,
			 String doc_id, String proj_id) {
		LogWriter
				.logDebug("ִ�к�ͬ����[contract_cust_account_temp]��ͬ�����ʻ�[contract_cust_account_temp]ǩԼ�������̳�ʼ������");
		// 1���ж�proj_document_temp���Ƿ��������
		// 1.CustAccountDaoʵ����
		boolean flag = false;
		CustAccountDao custAccountDao = new CustAccountDao();
		try {
			//flag = custAccountDao.existsData(contract_id, doc_id);
			flag = custAccountDao.existsData(contract_id, doc_id,0);
			System.out.println(flag+"==========================================================1");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ͬId:" + contract_id + " �ĵ�Id:" + doc_id
					+ " ������contract_cust_account_temp�д���");
		} else {
			// 3����������ʽ�����ݿ�����ʱ��
			try {
				flag = custAccountDao.existsData(contract_id, doc_id,1);
				System.out.println(flag+"==========================================================2");
				if(flag == true){
					custAccountDao.copyDataToContractTemp(contract_id, cust_id, doc_id);
				}else{
					flag = custAccountDao.existsProjData(proj_id, doc_id, 1);
					System.out.println(flag+"==========================================================3");
					if(flag == true){
						custAccountDao.copyDataFromProjToContractTemp(contract_id, cust_id, doc_id,proj_id);
					}
				}
				
				//custAccountDao.copyData(contract_id, cust_id,
				//		doc_id);
				LogWriter.logDebug("��ĿId: �ĵ�Id:" + doc_id
						+ " ����[contract_cust_account_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter.logError("��ĿId: �ĵ�Id:" + doc_id
						+ " ����[contract_cust_account_temp]��ʼ���쳣���쳣��Ϣ��\t"
						+ e.getMessage());
			}
		}

	}
	
	/**
	 * @param proj_id
	 * @param doc_id
	 * ���ں�ͬ������ҳ���ʼ���жϺ�ͬ�����ʺ���ʱ�����Ƿ�������
	 */
	public static void flowInitProjApproveAccountData(String proj_id,String cust_id,
			 String doc_id) {
		LogWriter
				.logDebug("ִ�к�ͬ����[contract_cust_account_temp]��ͬ�����ʻ�[contract_cust_account_temp]ǩԼ�������̳�ʼ������");
		// 1���ж�proj_document_temp���Ƿ��������
		// 1.CustAccountDaoʵ����
		boolean flag = false;
		CustAccountDao custAccountDao = new CustAccountDao();
		try {
			flag = custAccountDao.existsProjData(proj_id, doc_id,0);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2������ִ�����
		if (flag) {
			LogWriter.logDebug("��ͬId:" + proj_id + " �ĵ�Id:" + doc_id
					+ " ������contract_cust_account_temp�д���");
		} else {
			// 3����������ʽ�����ݿ�����ʱ��
			try {
				flag = custAccountDao.existsProjData(proj_id, doc_id,1);
				if(flag == true){
					custAccountDao.copyDataToProjTemp(proj_id, cust_id, doc_id);
				}
				
				//custAccountDao.copyData(proj_id, cust_id,
				//		doc_id);
				LogWriter.logDebug("��ĿId: �ĵ�Id:" + doc_id
						+ " ����[contract_cust_account_temp]��ʼ�����");
			} catch (SQLException e) {
				LogWriter.logError("��ĿId: �ĵ�Id:" + doc_id
						+ " ����[contract_cust_account_temp]��ʼ���쳣���쳣��Ϣ��\t"
						+ e.getMessage());
			}
		}

	}
}
