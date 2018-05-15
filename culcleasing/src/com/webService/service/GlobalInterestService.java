/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalInterestBean;
import com.webService.dao.GlobalInterestDao;


/**
 * ��Ϣ�����(Ӧ��)
 * 
 * @author toybaby Date:Sep 13, 20112:34:11 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalInterestService {
	public static void main(String[] args) {
		dataSync();
	}

	/**
	 * [��Ϣ�����(Ӧ��)]��������ͬ��
	 * 
	 * @return ����ͬ������
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "��Ϣ�����";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalInterestBean> globalInterestList = new ArrayList<GlobalInterestBean>();
		GlobalInterestDao globalInterestDao = new GlobalInterestDao();

		try {
			// 1.1��ERP ��������ȡ����
			globalInterestList = globalInterestDao
					.readGlobalInterestData(syncType);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_INTEREST_NC",
						"NC��Ϣ���������ͬ��", "��ȡ�쳣��" + e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("��ȡERP Server [" + syncType + "]�����쳣��\n�쳣��Ϣ��\n"
					+ e.getMessage());
		}

		// 2.��List����ͬ����Oracle ����ӿ����ݿ������
		try {
			globalInterestDao.insert2OracleData(globalInterestList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_INTEREST_NC",
						"NC��Ϣ���������ͬ��", "�����쳣��" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
		}

		// ����ִ�в���������
		amount = globalInterestList.size();
		return amount;
	}

	
	
}
