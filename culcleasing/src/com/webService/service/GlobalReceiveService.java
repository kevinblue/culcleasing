/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalReceiveBean;
import com.webService.dao.GlobalReceiveDao;

/**
 * �����տService���� -ÿ��2��ִ��
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 6:03:09 PM Email:JaffeHe@hotmail.com
 */
public class GlobalReceiveService {
	
	public static void main(String[] args) {
		try {
			dataSync();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * [�����տ]��������ͬ��
	 * 
	 * @return ����ͬ������
	 * @throws SQLException 
	 */
	public static int dataSync() throws SQLException {
		int amount = 0;
		String syncType = "�����տ";
		// 1.��ERP���ݿ�������������ݱ�����List
		List<GlobalReceiveBean> globalReceiveList = new ArrayList<GlobalReceiveBean>();
		GlobalReceiveDao globalReceiveDao = new GlobalReceiveDao();

		try {
			// 1.1��ERP ��������ȡ����
			globalReceiveList = globalReceiveDao
					.readGlobalReceiveData(syncType);
			System.out.println("�������������������������Բ��Բ���2222����������������");
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_RECEIVE_NC", "nc�����տ����ͬ��", "��ȡ�쳣��"
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
			globalReceiveDao.insert2OracleData(globalReceiveList, syncType);
			System.out.println("�������������������������Բ��Բ���1111����������������");
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_RECEIVE_NC", "nc�����տ����ͬ��", "�����쳣��"
								+ e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Fina Interface Server [" + syncType
					+ "] �쳣,\n�쳣��Ϣ: \n" + e.getMessage());
			System.out.println(e.getMessage().toString());
		}

		// ����ִ�в���������
		amount = globalReceiveList.size();
		return amount;
	}
}
