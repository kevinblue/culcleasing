/**
 * com.tenwa.datasync.finance.dao
 */
package com.webService.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalBeforeConfirmBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.GlobalBeforeComfirmXml;
import com.webService.service.GlobalReceiveXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;

/**
 * �����տ Dao ����
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 6:42:30 PM Email:JaffeHe@hotmail.com
 */
public class GlobalBeforeConfirmDao {

	// ��������
	private ResultSet rs = null;

	/**
	 * ���������ݿ���־
	 * 
	 * @param oper_id
	 * @param amount
	 * @param syncType
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(String oper_id, int amount, String syncType,String operRmark)
			throws SQLException {
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��������
		String sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBLog(oper_id,
				amount, "DATA_SYNC_GLOBAL_BEFORE_CONFIRM_NC", "��ǰ��ֹ��ͬ�տ����ͬ��", operRmark);

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ͷ�
		erpDataSource.close();
	}

	/**
	 * ����ͬ����Ϣ
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(GlobalBeforeConfirmBean globalBeforeConfirmBean,
			String oper_id, String syncType,String operRmark) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		operRmark = operRmark.replaceAll("'", "''");
		String sqlStr = "";
			// ����
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalBeforeConfirmBean.getPriId(),
					globalBeforeConfirmBean.getPara_2(), 
					globalBeforeConfirmBean.getPara_3(),
					globalBeforeConfirmBean.getPara_4(),
					operRmark,
					oper_id, 
					"vi_INTERFACE_before_confirm_nc"
					);

			// ִ�в���
			System.out.println("ִ��sql��"+sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		erpDataSource.close();
	}

	/**
	 * ��ȡERP �����տ����
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalBeforeConfirmBean> readGlobalBeforeConfirmData(String syncType)
			throws SQLException {
		List<GlobalBeforeConfirmBean> globalBeforeConfirmList = new ArrayList<GlobalBeforeConfirmBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil.generateSelectERPBeforeConfirmData();
		LogWriter.logSqlStr("��ȡERP���������տ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalBeforeConfirmBean globalBeforeConfirmBean = new GlobalBeforeConfirmBean();
			// װ������
			globalBeforeConfirmBean.setPriId(ConvertUtil.getDBStr(rs.getString("id")));
			globalBeforeConfirmBean.setInvcode(ConvertUtil.getDBStr(rs.getString("invcode")));//���ݺ�
			globalBeforeConfirmBean.setCcodetrust(ConvertUtil.getDBStr(rs.getString("ccodetrust")));//����ͻ�
			globalBeforeConfirmBean.setBcode(ConvertUtil.getDBStr(rs.getString("bcode")));//��Ŀ����
			globalBeforeConfirmBean.setReceive_account(ConvertUtil.getDBStr(rs.getString("receipt_number")));//�տ��˻�
			globalBeforeConfirmBean.setPayer(ConvertUtil.getDBStr(rs.getString("ccodetrust")));//������
			globalBeforeConfirmBean.setContract_id(ConvertUtil.getDBStr(rs.getString("contract_id")));//��ͬ��
			globalBeforeConfirmBean.setProj_code(ConvertUtil.getDBStr(rs.getString("proj_id")));//��Ŀ���
			globalBeforeConfirmBean.setProj_name(ConvertUtil.getDBStr(rs.getString("project_name")));//��Ŀ����
			globalBeforeConfirmBean.setIndustry(ConvertUtil.getDBStr(rs.getString("industry_type")));//�ڲ���ҵ
			globalBeforeConfirmBean.setLeas_type(ConvertUtil.getDBStr(rs.getString("leas_type")));//��������
			globalBeforeConfirmBean.setRemark_2(ConvertUtil.getDBStr(rs.getString("taxrate")));//˰��
			globalBeforeConfirmBean.setAction_date(ConvertUtil.getDBStr(rs.getString("action_date")));//ʵ�ʵ�������
			globalBeforeConfirmBean.setRent(ConvertUtil.getDBStr(rs.getString("rent")));//���
			globalBeforeConfirmBean.setGuarantee_money(ConvertUtil.getDBStr(rs.getString("guarantee_money")));//��֤��
			globalBeforeConfirmBean.setPenalty(ConvertUtil.getDBStr(rs.getString("agree_penalty")));//��Ϣ
			globalBeforeConfirmBean.setNormal_money(ConvertUtil.getDBStr(rs.getString("nominal_price")));//�����۸��ֽв�ֵ���룩
			globalBeforeConfirmBean.setAction_money(ConvertUtil.getDBStr(rs.getString("action_money")));//��Ŀ�����
			globalBeforeConfirmBean.setRent_cha(ConvertUtil.getDBStr(rs.getString("rentcha")));//�����
			globalBeforeConfirmBean.setInteret_cha(ConvertUtil.getDBStr(rs.getString("rentcha")));//��Ϣ���
			globalBeforeConfirmBean.setInterest_sr(ConvertUtil.getDBStr(rs.getString("interestsr")));//��Ϣ����
			globalBeforeConfirmBean.setNcdeptno(ConvertUtil.getDBStr(rs.getString("nc_deptno")));//���ű���
			globalBeforeConfirmBean.setRemark_o(ConvertUtil.getDBStr(rs.getString("remark_o")));//˰��			
			globalBeforeConfirmBean.setRent_diff(ConvertUtil.getDBStr(rs.getString("rent_diff")));//�ൽ�������ٵ����
		    //�����ǿ�������
			// װ�ص���List
			globalBeforeConfirmList.add(globalBeforeConfirmBean);
			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalBeforeConfirmBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		return globalBeforeConfirmList;
	}

	/**
	 * ���䵽����ӿڹ����տ
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalBeforeConfirmBean> globalBeforeConfirmList,
			String syncType) throws Exception {
		if (globalBeforeConfirmList.size() < 1) {
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");
		} else {
			String oper_id = CommonTool.getUUID();// ����Id

			int i=0;
			GlobalBeforeComfirmXml globalBeforeComfirmXml = new GlobalBeforeComfirmXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.��������List����
			for (GlobalBeforeConfirmBean globalBeforeConfirmBean : globalBeforeConfirmList) {
				
				if("".equals(globalBeforeConfirmBean.getBcode())||globalBeforeConfirmBean.getBcode()==null||"null".equals(globalBeforeConfirmBean.getBcode())){
					writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					continue;
				}				
			
				if("".equals(globalBeforeConfirmBean.getNcdeptno())||globalBeforeConfirmBean.getNcdeptno()==null||"null".equals(globalBeforeConfirmBean.getNcdeptno())){
					writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				//��װxml�ַ���
				try {
					xmlMassage = globalBeforeComfirmXml.getXmlStr(globalBeforeConfirmBean);
					//����nc�����
				   xmlStr=erfs.requst_Nc_Finance("010101","F2",xmlMassage);//=================================================�Ȳ���
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalBeforeConfirmBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// ��¼ͬ���ɹ�������Ϣ
							writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalBeforeConfirmBean.getPriId());
						}
						try {
							// �ļ���־,�ɹ���¼
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ�-�����տ�ӿ�", "XML����:"+xmlMassage,"�����տNC����ͬ����־");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// ��¼ͬ��ʧ��������Ϣ
								writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalBeforeConfirmBean.getPriId());
							}
							try {
								// �ļ���־,ʧ�ܼ�¼
								LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ʧ��",
										"�������ݵ�nc����ӿ�-�����տ�ӿ�", "XML����:"+xmlMassage,"�����տNC����ͬ����־");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
			LogWriter.logDebug("����ִ��[" + syncType + "]����ͬ������������["
					+ i + "]��"+",ʧ��["+(globalBeforeConfirmList.size()-i)+"]��");
			// ���ݿ���־
			writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ�����ɹ�["+ i + "]��"+",ʧ��["+(globalBeforeConfirmList.size()-i)+"]��"));
		}
	}
}
