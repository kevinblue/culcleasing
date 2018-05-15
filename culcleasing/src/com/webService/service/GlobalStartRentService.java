/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalStartRentBean;
import com.webService.dao.GlobalStartRentDao;


/**
 * ����
 * 
 * @author toybaby Date:Sep 13, 20112:34:11 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalStartRentService {

	/**
	 * [����(Ӧ��)]��������ͬ�� ÿ��2��
	 * 
	 * @return ����ͬ������
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "����";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalStartRentBean> globalStartRentList = new ArrayList<GlobalStartRentBean>();
		GlobalStartRentDao globalStartRentDao = new GlobalStartRentDao();

		try {
			// 1.1��ERP ��������ȡ����
			globalStartRentList = globalStartRentDao
					.readGlobalStartRentData(syncType);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_START_RENT_NC", "��������ͬ��", "��ȡ�쳣��"
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("��ȡERP Server [" + syncType + "]�����쳣��\n�쳣��Ϣ��\n"
					+ e.getMessage());
		}

		// 2.��List����ͬ����Oracle ����ӿ����ݿ������
		try {
			globalStartRentDao.insert2OracleData(globalStartRentList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_START_RENT_NC", "��������ͬ��", "��ȡ�쳣��"
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
		}

		// ����ִ�в���������
		amount = globalStartRentList.size();
		return amount;
	}
 public static void main(String[] args) {
	 dataSync();
}
}
