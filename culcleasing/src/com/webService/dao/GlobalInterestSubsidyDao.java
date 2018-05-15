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
import com.webService.bean.GlobalInterestSubsidyBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.GlobalInterestSubsidyXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;


public class GlobalInterestSubsidyDao {

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
		String sqlStr = SqlGenerateFIUtil
				.generateFIDataSyncDBLog(oper_id, amount,
						"DATA_SYNC_GLOBAL_INTERESTSUBSIDY", "ncȷ����Ϣ�����ӿ�����ͬ��", operRmark);
		LogWriter.logDebug("writeDataSyncDBLog11" + sqlStr);

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
	private void writeDataSyncDBInfo(
			GlobalInterestSubsidyBean globalInterestSubsidyBean,
			String oper_id, String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
			// ����
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalInterestSubsidyBean.getPriId(),
					globalInterestSubsidyBean.getPara_2(),
					globalInterestSubsidyBean.getPara_3(),
					globalInterestSubsidyBean.getPara_4(),
					ifsuccess,
					oper_id,
					"vi_INTERFACE_fina_global_interestSubsidy");
			// LogWriter.logDebug("writeDataSyncDBInfo22" + sqlStr);

			// ִ�в���
			erpDataSource.executeUpdate(sqlStr);
		erpDataSource.close();
	}

	/**
	 * ��ȡERP ȷ����Ϣ����������
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalInterestSubsidyBean> readGlobalInterestSubsidy(
			String syncType) throws SQLException {
		List<GlobalInterestSubsidyBean> globalInterestSubsidyList = new ArrayList<GlobalInterestSubsidyBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil
				.generateSelectERPGlobalInterestSubsidyData();
		LogWriter.logSqlStr("��ȡERPȷ����Ϣ��������Ϣ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalInterestSubsidyBean globalInterestSubsidyBean = new GlobalInterestSubsidyBean();
			// װ������
			globalInterestSubsidyBean.setId(rs.getInt("id"));
			globalInterestSubsidyBean.setPriId(ConvertUtil.getDBStr(rs
					.getString("id")));
			globalInterestSubsidyBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalInterestSubsidyBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalInterestSubsidyBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalInterestSubsidyBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalInterestSubsidyBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalInterestSubsidyBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalInterestSubsidyBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalInterestSubsidyBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalInterestSubsidyBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			// 2012-2-22 Jaffe ������ǰ��©д
			globalInterestSubsidyBean.setSub_date(ConvertUtil.getDBDateStr(rs
					.getString("sub_date")));

			globalInterestSubsidyBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalInterestSubsidyBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalInterestSubsidyBean.setRmb(ConvertUtil.getDBStr(rs
					.getString("rmb")));
			globalInterestSubsidyBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalInterestSubsidyBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalInterestSubsidyBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalInterestSubsidyBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalInterestSubsidyBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			
			globalInterestSubsidyBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalInterestSubsidyBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
					
			// װ�ص���List
			globalInterestSubsidyList.add(globalInterestSubsidyBean);

			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalInterestSubsidyBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		return globalInterestSubsidyList;
	}

	/**
	 * ͬ�����ݵ�����ӿ�Oracle���ݿ�
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception
	 */
	public void insert2OracleData(
			List<GlobalInterestSubsidyBean> globalInterestSubsidyList,
			String syncType) throws Exception {
		if (globalInterestSubsidyList.size() < 1) {
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");
		} else {
			String oper_id = CommonTool.getUUID();// ����Id
            int i = 0;
            GlobalInterestSubsidyXml globalinterestsubsidyxml = new GlobalInterestSubsidyXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.��������List����
			for (GlobalInterestSubsidyBean globalInterestSubsidyBean : globalInterestSubsidyList) {
				if("".equals(globalInterestSubsidyBean.getNccode())||globalInterestSubsidyBean.getNccode()==null||"null".equals(globalInterestSubsidyBean.getNccode())){
					writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					continue;
				}
				
				if("0.00".equals(globalInterestSubsidyBean.getRmb())||"0".equals(globalInterestSubsidyBean.getRmb())){
					writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,"����ʧ�ܣ�-���Ϊ��");
					continue;
				}
				if("".equals(globalInterestSubsidyBean.getNcdeptno())||globalInterestSubsidyBean.getNcdeptno()==null||"null".equals(globalInterestSubsidyBean.getNcdeptno())){
					writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				String number = OperationUtil.getSerialNumber(syncType, "0001",
						4);
				globalInterestSubsidyBean.setInvcode(globalInterestSubsidyBean
						.getInvcode()
						+ number);
				try {
					//��װxml�ַ���
					xmlMassage = globalinterestsubsidyxml.getXmlStr(globalInterestSubsidyBean);
					//����nc�����
				    xmlStr=erfs.requst_Nc_Finance("010101","F0",xmlMassage);
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalInterestSubsidyBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// ��¼ͬ���ɹ�������Ϣ
							writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalInterestSubsidyBean.getPriId());
						}
						try {
							// �ļ���־,�ɹ���¼
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ����ݿ�-ȷ����Ϣ�����ӿ�", "XML����:"+xmlMassage,"ȷ����Ϣ����(Ӧ��)NC����ͬ����־");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// ��¼ͬ��ʧ��������Ϣ
								writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalInterestSubsidyBean.getPriId());
							}
							try {
								// �ļ���־,ʧ�ܼ�¼
								LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ʧ��",
										"�������ݵ�nc����ӿ����ݿ�-ȷ����Ϣ�����ӿ�", "XML����:"+xmlMassage,"ȷ����Ϣ����(Ӧ��)NC����ͬ����־");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
			}
			}
				LogWriter.logDebug("����ִ��[" + syncType + "]����ͬ�����ɹ�["
						+ i + "]��"+",ʧ��["+(globalInterestSubsidyList.size()-i)+"]��");
				// ���ݿ���־
			
				writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ�����ɹ�["+ i + "]��"+",ʧ��["+(globalInterestSubsidyList.size()-i)+"]��"));
		
	}
  }
}
