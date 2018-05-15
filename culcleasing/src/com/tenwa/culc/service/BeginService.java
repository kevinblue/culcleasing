/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;

import com.tenwa.culc.bean.BeginInfoBean;
import com.tenwa.culc.dao.BeginDao;
import com.tenwa.log.LogWriter;

/**
 * ������Ϣ����
 * 
 * @author Jaffe
 * 
 * Date:Jul 25, 2011 8:16:44 PM Email:JaffeHe@hotmail.com
 */
public class BeginService {

	/**
	 * ����BeginInfoBean�����浽begin_info_temp��
	 * 
	 * @param beginInfoBean
	 * @param save_type
	 * @return Ӱ������
	 */
	public static int saveBeginBeanIntoTemp(BeginInfoBean beginInfoBean,
			String save_type) {
		int flag = 0;

		LogWriter.logDebug("��ִ�б���������Ϣ�ṹ��Temp���������ͣ�" + save_type + " ��ͬid:"
				+ beginInfoBean.getContract_id() + "������Id:"
				+ beginInfoBean.getBegin_id());
		// 1.BeginDao1 ʵ����
		BeginDao beginDao = new BeginDao();
		// 2.ִ�в���
		// 2.1��ɾ������ [��] ��������
		try {
			beginDao.deleteBeginInfoTempData(beginInfoBean.getBegin_id(),
					beginInfoBean.getDoc_id());
			LogWriter.logDebug("ɾ������Id" + beginInfoBean.getBegin_id()
					+ "��begin_info_temp�����ݳɹ�����ʼִ�в������");
			flag = beginDao.insertBeginBeanIntoTempTable(beginInfoBean);

			LogWriter
					.logDebug("ִ�в���BeginInfoBean��begin_info_temp,���½����" + flag);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return flag;
	}

	/**
	 * �жϵ�ǰ����Id�Ƿ����
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String judgeSaveType(String begin_id, String doc_id) {
		String saveType = "";

		// 1.BeginDao1 ʵ����
		BeginDao beginDao = new BeginDao();
		try {
			saveType = beginDao.judgeItemExist(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("�ж����������ִ�в������ͣ�" + saveType);

		return saveType;
	}

	/**
	 * ������㣬��ʼ������Bean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static BeginInfoBean initBeginInfoBean(String begin_id, String doc_id) {
		BeginInfoBean beginInfoBean = null;

		// ��ѯ���ݿ��װBean
		LogWriter.logDebug("���ص�ǰ����Id��" + begin_id + " doc_id:" + doc_id
				+ " ��beginInfoBean");

		BeginDao beginDao = new BeginDao();
		try {
			beginInfoBean = beginDao.loadBeginInfoBeanByKey(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoBean;
	}

	/**
	 * ��ʷ������Ϣ����Bean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static BeginInfoBean initBeginInfoHisBean(String begin_id) {
		BeginInfoBean beginInfoBean = null;

		// ��ѯ���ݿ��װBean
		LogWriter.logDebug("������ʷ����[Begin_id]��" + begin_id + " ��beginInfoBean");

		BeginDao beginDao = new BeginDao();
		try {
			beginInfoBean = beginDao.loadBeginInfoHisBeanByKey(begin_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoBean;
	}

	/**
	 * ��ͬ�����ޱ���
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getTotalLeaseMoney(String contract_id) {
		String totalLeaseMoney = "";
		BeginDao beginDao = new BeginDao();
		try {
			totalLeaseMoney = beginDao.selectTotalLeaseMoney(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return totalLeaseMoney;
	}

	/**
	 * ��ͬ����������ޱ���
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getUsedLeaseMoney(String contract_id) {
		String usedLeaseMoney = "";
		BeginDao beginDao = new BeginDao();
		try {
			usedLeaseMoney = beginDao.selectUsedLeaseMoney(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return usedLeaseMoney;
	}
	
	/**
	 * ��ͬ����������ޱ���
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getUsedLeaseMoneyB(String contract_id,String flow_date) {
		String usedLeaseMoney = "";
		BeginDao beginDao = new BeginDao();
		try {
			usedLeaseMoney = beginDao.selectUsedLeaseMoneyB(contract_id, flow_date);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return usedLeaseMoney;
	}

	/**
	 * �����ϴ������㣬����beginInfoBean�����浽begin_info_temp��
	 * 
	 * @param beginInfoBean
	 * @param save_type
	 * @return Ӱ������
	 */
	public static int saveUploadBeginInfoBean(BeginInfoBean beginInfoBean) {
		int resVal = 0;
		// 1.beginDao ʵ����
		BeginDao beginDao = new BeginDao();
		// 2.ִ�в���
		// 2.1��ɾ��������
		try {
			beginDao.delBeginInfoTempData(beginInfoBean.getContract_id(),
					beginInfoBean.getBegin_id(), beginInfoBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		try {
			resVal = beginDao.insertBean2BeginIntoTempTable(beginInfoBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("�ϴ����棬����contract_id:"
				+ beginInfoBean.getContract_id() + "��������:"
				+ beginInfoBean.getBegin_id() + " ���׽ṹ��ʱ�����½����"
				+ (resVal == 0 ? "ʧ��" : "�ɹ�"));

		return resVal;
	}

	/**
	 * ��ѯ���κ�ͬ���������к�
	 * 
	 * @param contract_id
	 * @return
	 */
	public static int getBeginOrderIndex(String contract_id) {
		int beginOrderIndex = 1;
		BeginDao beginDao = new BeginDao();
		try {
			beginOrderIndex = beginDao.selectBeginOrderIndex(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return beginOrderIndex;
	}
}
