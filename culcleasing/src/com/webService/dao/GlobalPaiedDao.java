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
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalPaiedBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.RequestNcServer;
import com.webService.service.XmlAnalysis;


/**
 * ��� Dao ����
 * 
 * @author toybaby Date:Sep 15, 20116:37:52 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalPaiedDao {

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
				amount, "DATA_SYNC_GLOBAL_PAIED_NC", "nc�������ӿ�����ͬ��", operRmark);

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ͷ�
		erpDataSource.close();
	}
	
	
	//������������ͬ����Ϣ
	private void writeDataSyncDBInfo2(GlobalPaiedBean globalPaiedBean,
			String oper_id, String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
			// ����
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(globalPaiedBean
					.getPriId(), globalPaiedBean.getPara_2(), globalPaiedBean
					.getPara_3(), globalPaiedBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_paied_nc");

			System.out.println("999999999999999999999"+sqlStr);
			// ִ�в���
			erpDataSource.executeUpdate(sqlStr);
		erpDataSource.close();
	}

	/**
	 * ��ȡERP ��������
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalPaiedBean> readGlobalPaiedData(String syncType)
			throws SQLException {
		List<GlobalPaiedBean> globalPaiedList = new ArrayList<GlobalPaiedBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalPaiedData1();
		LogWriter.logSqlStr("��ȡERP���������Ϣ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalPaiedBean globalPaiedBean = new GlobalPaiedBean();
			// װ������
			globalPaiedBean.setPriId(ConvertUtil.getDBStr(rs.getString("id")));
			globalPaiedBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalPaiedBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalPaiedBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalPaiedBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalPaiedBean.setBcode(ConvertUtil
					.getDBStr(rs.getString("bcode")));
			globalPaiedBean.setRdate(ConvertUtil.getDBDateStr(rs
					.getString("rdate")));
			globalPaiedBean.setCcode(ConvertUtil
					.getDBStr(rs.getString("ccode")));
			globalPaiedBean.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalPaiedBean.setModifydate(ConvertUtil.getDBDateStr(rs
					.getString("modifydate")));
			globalPaiedBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalPaiedBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalPaiedBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalPaiedBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalPaiedBean.setPcode(ConvertUtil
					.getDBStr(rs.getString("pcode")));
			globalPaiedBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalPaiedBean.setSettlement(ConvertUtil.getDBStr(rs
					.getString("settlement")));
			globalPaiedBean.setPawnsign(ConvertUtil.getDBStr(rs
					.getString("pawnsign")));
			globalPaiedBean.setPawnrmb(ConvertUtil.getDBStr(rs
					.getString("pawnrmb")));
			globalPaiedBean.setAcode(ConvertUtil
					.getDBStr(rs.getString("acode")));
			globalPaiedBean.setO_acode(ConvertUtil.getDBStr(rs
					.getString("o_acode")));

			globalPaiedBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalPaiedBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalPaiedBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalPaiedBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			
			globalPaiedBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));						
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalPaiedBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalPaiedBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			
			// װ�ص���List
			globalPaiedList.add(globalPaiedBean);

			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalPaiedBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		return globalPaiedList;
	}

	/**
	 * ͬ�����ݵ�����ӿ�Oracle���ݿ�
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalPaiedBean> globalPaiedList,
			String syncType) throws Exception {
		if (globalPaiedList.size() < 1) {
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");
		} else {
			String oper_id = CommonTool.getUUID();// ����Id
			int i=0;
			FinancialPaiedXml financialpaiedxml = new FinancialPaiedXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.��������List����
			for (GlobalPaiedBean globalPaiedBean : globalPaiedList) {
				if("".equals(globalPaiedBean.getNccode())||globalPaiedBean.getNccode()==null||"null".equals(globalPaiedBean.getNccode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					continue;
				}
				
				if("".equals(globalPaiedBean.getCcode())||globalPaiedBean.getCcode()==null||"null".equals(globalPaiedBean.getCcode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"����ʧ�ܣ�-�տ��˱���Ϊ��");
					continue;
				}
				if("0.00".equals(globalPaiedBean.getRmb())||"0".equals(globalPaiedBean.getRmb())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"����ʧ�ܣ�-���Ϊ��");
					continue;
				}
				if("".equals(globalPaiedBean.getNcdeptno())||"null".equals(globalPaiedBean.getNcdeptno())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue;
				}
				
				if("".equals(globalPaiedBean.getBcode())||"null".equals(globalPaiedBean.getBcode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"����ʧ�ܣ�-��Ա����Ϊ��(��Ŀ����)");
					continue;
				}
				if("".equals(globalPaiedBean.getAcode())||"null".equals(globalPaiedBean.getAcode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"�����˻�Ϊ��");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				try {
					//��װxml�ַ���
					xmlMassage = FinancialPaiedXml.getXmlStr(globalPaiedBean);
					//����nc�����
				    xmlStr=erfs.requst_Nc_Finance("0101","F3",xmlMassage);
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalPaiedBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// ��¼ͬ���ɹ�������Ϣ
							writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalPaiedBean.getPriId());
						}
						try {
							// �ļ���־,�ɹ���¼
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ����ݿ�-����ӿ�", "XML����:"+xmlMassage,"���NC����ͬ����־");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// ��¼ͬ��ʧ��������Ϣ
								writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalPaiedBean.getPriId());
							}
							try {
								// �ļ���־,ʧ�ܼ�¼
								LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ʧ��",
										"�������ݵ�nc����ӿ����ݿ�-����ӿ�", "XML����:"+xmlMassage,"���NC����ͬ����־");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
				
			}
			LogWriter.logDebug("����ִ��[" + syncType + "]����ͬ�����ɹ�["
					+ i + "]��"+",ʧ��["+(globalPaiedList.size()-i)+"]��");
			// ���ݿ���־
			writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ�����ɹ�["+ i + "]��"+",ʧ��["+(globalPaiedList.size()-i)+"]��"));
			
		}
	}
}
