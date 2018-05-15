package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalProjectEndBean;
import com.webService.dao.GlobalProjectEndDao;


public class GlobalProjectEndService {

	/**
	 * [��ͬ����(�տ)]��������ͬ�� ÿ����2��ִ��
	 * 
	 * @return ����ͬ������
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "��ͬ����";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalProjectEndBean> globalProjectEndBeanList = new ArrayList<GlobalProjectEndBean>();
		GlobalProjectEndDao globalProjectEndDao = new GlobalProjectEndDao();

		try {
			// 1.1��ERP ��������ȡ����
			globalProjectEndBeanList = globalProjectEndDao
					.readGlobalInterestSubsidy(syncType);
			System.out.println("-------------ȡֵ-----------");
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_PROJECTEND_NC", "��ͬ��������ͬ��", "��ȡ�쳣��"
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("��ȡERP Server [" + syncType + "]�����쳣��\n�쳣��Ϣ��\n"
					+ e.getMessage());
			System.out.println("-------------����һ-----------");
		}

		// 2.��List����ͬ����Oracle ����ӿ����ݿ������
		try {
			globalProjectEndDao.insert2OracleData(globalProjectEndBeanList,syncType);
			System.out.println("-------------��ֵ-----------");
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_PROJECTEND_NC", "��ͬ��������ͬ��", "��ȡ�쳣��"
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
			System.out.println("-------------�����-----------");
		}

		// ����ִ�в���������
		amount = globalProjectEndBeanList.size();
		return amount;
	}
	
	public static void main(String[] args) {
		dataSync();
		
		
	}
}
