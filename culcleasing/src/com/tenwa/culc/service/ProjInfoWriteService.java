package com.tenwa.culc.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.bean.ContractPlanBean;
import com.tenwa.culc.bean.VbadinfoBean;
import com.tenwa.culc.bean.VendProBean;
import com.tenwa.culc.dao.ProjInfoDao;
import com.tenwa.log.LogWriter;

/**
 * 
 * @ClassName ProjInfoWriteService

 * @Description ��дCRM���õ�service����

 * @Author ����˧

 * @Date 2013-6-12����04:33:10
 */

public class ProjInfoWriteService {
	
	/**
	 * 
	 * @Title dataSyncFinal
	
	 * @Param contractId ��ͬ���
	
	 * @Description ������д��Ӧ��������Ϣ��������Ϣ
	
	 * @Return int ִ�гɹ����ز������Ŀ��,ִ��ʧ�ܷ���0
	
	 * @throw
	 */
	public static int dataSyncFinal(String contractId){
		int res = 0;
		List<String> list = new ArrayList<String>();
		ProjInfoDao projIndoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1��Client1 ��������ȡ����
				list = projIndoDao.readERPProjEquipInfoData(contractId);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("��ȡERP Server [��Ŀ��Ϣ] �쳣");
			}

			// 2.������ͬ����Server���ݿ������
			try {
				dataSync4(contractId);
				for (String string : list) {
					dataSync6(contractId,string);
					res++;
				}
			} catch (Exception e) {
				e.printStackTrace();
				LogWriter.logError("����CRM Server [��Ŀ��Ϣ] �쳣,�쳣��Ϣ: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("��Ŀ��Ų��Ϸ���" + contractId);
		}
		return res;
	}
	
	
	/**
	 * 
	 * @Title dataSync6
	
	 * @Param contractId ��ͬ���
	 * @Param equip_id �������ID
	
	 * @Description ��д��Ӧ��������Ŀ��Ϣ
	
	 * @Return int ִ�гɹ����ز������Ŀ��,ִ��ʧ�ܷ���0
	
	 * @throw
	 */
	public static int dataSync6(String contractId,String equip_id){
		int res = 0;
		// 1.��ERP���ݿ�������������ݱ�����VendProBean
		VendProBean vendProBean = new VendProBean();
		ProjInfoDao projIndoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1��Client1 ��������ȡ����
				vendProBean = projIndoDao.readERPProjVendProInfoData(contractId,equip_id);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("��ȡERP Server [��Ŀ��Ϣ] �쳣");
			}

			// 2.��VendProBean����ͬ����Server���ݿ������
			try {
				//�������ݷ��ز�������
				res = projIndoDao.insertCRMVendProData(vendProBean);
				System.out.println(vendProBean.getDarrive());
				dataSync5(contractId,
						//2014��9��18�ո��ļƻ�ʱ��
						vendProBean.getDarrive().substring(0, 10),vendProBean.getPlan_date().substring(0, 10)
						//"2013-03-13"
								,equip_id);
			} catch (SQLException e) {
				// д������־�����ݿ�2013-7-22
				/*try {
					OperationUtil.operationExceptionLog("DATA_VENDPRO_WRITE_INFO",
							"ERP��дCRM��Ŀ��Ϣ", "��ȡ�쳣��" + e.getMessage());
				} catch (SQLException e1) {
					e1.printStackTrace();
				}*/
				e.printStackTrace();
				LogWriter.logError("����CRM Server [��Ŀ��Ϣ] �쳣,�쳣��Ϣ: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("��Ŀ��Ų��Ϸ���" + contractId);
		}
		// ����ִ���Ƿ�ɹ�
		return res;
	}
	
	/**
	 * 
	 * @Title dataSync5
	
	 * @Param contractId ��ͬ���
	 * @Param factDate ʵ�ʵ���ʱ��
	 * @Param planDate �ƻ�����ʱ��
	 * @Param equip_id �������ID
	
	 * @Description ��������Ϣ��д��crm��
	
	 * @Return int ִ�гɹ����ػ�д����Ŀ��,ִ��ʧ�ܷ���0
	
	 * @throw
	 */
	public static int dataSync5(String contractId,String factDate,String planDate,String equip_id){
		int res = 0;
		// 1.��ERP���ݿ�������������ݱ�����VbadinfoBean
		VbadinfoBean vbadinfoBean = new VbadinfoBean();
		ProjInfoDao projInfoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1��Client1 ��������ȡ����
				vbadinfoBean = projInfoDao.readERPProjBadInfoData(contractId,factDate,planDate,equip_id);
			} catch (SQLException e) {
				// д������־�����ݿ�2013-7-22
				/*try {
					OperationUtil.operationExceptionLog("DATA_VBAD_WRITE_INFO",
							"ERP��дCRM��Ŀ��Ϣ", "��ȡ�쳣��" + e.getMessage());
				} catch (SQLException e1) {
					e1.printStackTrace();
				}*/
				e.printStackTrace();
				LogWriter.logError("��ȡERP Server [��Ŀ��Ϣ] �쳣");
			}

			// 2.��VbadinfoBean����ͬ����Server���ݿ������
			try {
				//�������ݷ��ز�������
				res = projInfoDao.insertCRMBadData(vbadinfoBean,factDate,planDate);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("����CRM Server [��Ŀ��Ϣ] �쳣,�쳣��Ϣ: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("��Ŀ��Ų��Ϸ���" + contractId);
		}

		// ����ִ���Ƿ�ɹ�
		return res;
	}
	
	/**
	 * 
	 * @Title dataSync4
	
	 * @Param contractId ��ͬ���
	
	 * @Description ����Ӧ����Ŀ��������˺���Ϣ��д��crm
	
	 * @Return int ִ�гɹ����ػ�д����Ŀ��,ִ��ʧ�ܷ���0
	
	 * @throw
	 */
	public static int dataSync4(String contractId){
		int res = 0;
		// 1.��ERP���ݿ�������������ݱ�����ContractPlanBean
		List<ContractPlanBean> contractPlanList = new ArrayList<ContractPlanBean>();
		ProjInfoDao projInfoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1��Client1 ��������ȡ����
				contractPlanList = projInfoDao.readERPProjZJJHInfoData(contractId);
			} catch (SQLException e) {
				// д������־�����ݿ�2013-7-22
//				try {
//					OperationUtil.operationExceptionLog("DATA_GYSXM_WRITE_INFO",
//							"ERP��дCRM��Ŀ��Ϣ", "��ȡ�쳣��" + e.getMessage());
//				} catch (SQLException e1) {
//					e1.printStackTrace();
//				}
				e.printStackTrace();
				LogWriter.logError("��ȡERP Server [��Ŀ��Ϣ] �쳣");
			}

			// 2.��ContractPlanBean����ͬ����Server���ݿ������
			try {
				//�������ݷ��ز�������
				res = projInfoDao.insertCRMZJJHData(contractPlanList);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("����CRM Server [��Ŀ��Ϣ] �쳣,�쳣��Ϣ: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("��Ŀ��Ų��Ϸ���" + contractId);
		}

		// ����ִ���Ƿ�ɹ�
		return res;
	}
}
