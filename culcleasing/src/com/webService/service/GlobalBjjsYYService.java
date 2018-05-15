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
import com.webService.dao.GlobalBjjsYYDao;


public class GlobalBjjsYYService {
  
	
	public static void main(String[] args) {
		//GlobalBjjsYYService.dataSync("68812,68813,68814,68815,68816");
		GlobalBjjsYYService.dataSync("1105,1106,1107,1108,1109,1110");//������
	}
	/**
	 * [��Ϣ�����]��������ͬ��
	 * �����˰��Ӫҵ˰���ӿ�
	 * @return ����ͬ������
	 */
	public static Map<String,Integer> dataSync(String sqlIds) {
		//int amount = 0;
		Map<String,Integer> amount=new HashMap<String,Integer>();
		String syncType = "�����˰��";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalBjjsBean> globalBjjsList = new ArrayList<GlobalBjjsBean>();
		GlobalBjjsYYDao globalBjjsYYDao = new GlobalBjjsYYDao();
		System.out.println("");
		try {
			// 1.1��ERP ��������ȡ����
			globalBjjsList = globalBjjsYYDao.readGlobalBjjsData(syncType,sqlIds);
//			System.out.println("============="+globalBjjsList);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_BJJS_YY_NC",
						"�����˰������ͬ��", "��ȡ�쳣��" + e.getMessage());
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
		 amount=globalBjjsYYDao.insert2OracleData(globalBjjsList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_BJJS_YY_NC",
						"�����˰������ͬ��", "��ȡ�쳣��" + e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
		}

		// ����ִ�в���������
		//amount = globalBjjsList.size();
		return amount;
	}

}
