package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalInterestSubsidyBean;
import com.webService.dao.GlobalInterestSubsidyDao;



public class GlobalInterestSubsidyService {
	
	public static void main(String[] args) {
		dataSync();
	}

	/**
	 * [ȷ����Ϣ����(Ӧ��)]��������ͬ��
	 * 
	 * ÿ��10��ִ�г���
	 * 
	 * @return ����ͬ������
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "ȷ����Ϣ����";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalInterestSubsidyBean> globalInterestSubsidyList = new ArrayList<GlobalInterestSubsidyBean>();
		GlobalInterestSubsidyDao globalInterestSubsidyDao = new GlobalInterestSubsidyDao();

		try {
			// 1.1��ERP ��������ȡ����
			globalInterestSubsidyList = globalInterestSubsidyDao
					.readGlobalInterestSubsidy(syncType);
		}catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_INTERESTSUBSIDY_NC", "NCȷ����Ϣ��������ͬ��",
						"��ȡ�쳣��" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("��ȡERP Server [" + syncType + "]�����쳣��\n�쳣��Ϣ��\n"
					+ e.getMessage());
		}

		// 2.��List����ͬ����Oracle ����ӿ����ݿ������
		try {
			globalInterestSubsidyDao.insert2OracleData(
					globalInterestSubsidyList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_INTERESTSUBSIDY_NC", "NCȷ����Ϣ��������ͬ��",
						"�����쳣��" + e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
		}

		// ����ִ�в���������
		amount = globalInterestSubsidyList.size();
		return amount;
	}
}
