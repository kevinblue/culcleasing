/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalBjjsBean;
import com.webService.dao.GlobalLxjsDao;


public class GlobalLxjsService {
	
	
	
	public static void main(String[] args) {
		GlobalLxjsService.dataSync("215826,251121");
	}
	/**
	 * [��Ϣ�����]��������ͬ��
	 * 
	 * @return ����ͬ������
	 */
	public static Map<String,Integer> dataSync(String sqlIds) {
	//	int amount = 0;
		Map<String,Integer> amount=new HashMap<String,Integer>();

		String syncType = "��Ϣ��˰��";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalBjjsBean> globalLxjsList = new ArrayList<GlobalBjjsBean>();
		GlobalLxjsDao globalLxjsDao = new GlobalLxjsDao();
		System.out.println("");
		try {
			// 1.1��ERP ��������ȡ����
			globalLxjsList = globalLxjsDao.readGlobalBjjsData(syncType,sqlIds);
//			System.out.println("============="+globalBjjsList);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_LXJS_NC",
						"��Ϣ��˰������ͬ��", "��ȡ�쳣��" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("��ȡERP Server [" + syncType + "]�����쳣��\n�쳣��Ϣ��\n"
					+ e.getMessage());
		}

		// 2.��List����ͬ����Oracle ����ӿ����ݿ������
		try {
			System.out.println("=============���==================");
			amount=globalLxjsDao.insert2OracleData(globalLxjsList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_LXJS_NC",
						"��Ϣ��˰������ͬ��", "��ȡ�쳣��" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
		}

		// ����ִ�в���������
	//	amount = globalLxjsList.size();
		return amount;
	}

}
