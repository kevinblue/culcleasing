/**
 * com.tenwa.datasync.finance.dao
 */
package com.webService.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalBjjsBean;
import com.webService.bean.GlobalInterestBean;
import com.webService.bean.OracleDataSource;

import com.webService.service.GlobalBjjsXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;



/**
 * ��Ϣ����� Dao ����
 * 
 * @author toybaby Date:Sep 15, 20114:18:09 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalBjjsDao {

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
						amount, "DATA_SYNC_GLOBAL_BJJS_NC", "NC��Ϣ���������ӿ�����ͬ��",operRmark);
				
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
	@SuppressWarnings("unused")
	private void writeDataSyncDBInfo(
			GlobalBjjsBean globalBjjsBean, String oper_id,
			String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
		// 1.��������List����
			// ����
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalBjjsBean.getPriId(), globalBjjsBean
							.getPara_2(), globalBjjsBean.getPara_3(),
							globalBjjsBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_bjjs_nc");

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
	public List<GlobalBjjsBean> readGlobalBjjsData(String syncType,String sqlIds)
			throws SQLException {
		List<GlobalBjjsBean> globalBjjsList = new ArrayList<GlobalBjjsBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalBjjsDataNc(sqlIds);
		LogWriter.logSqlStr("��ȡERP���������˰����Ϣ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalBjjsBean globalBjjsBean = new GlobalBjjsBean();
			// �����ˮ��
			// String SerialNumber = OperationUtil.getSerialNumber("����", "0001",
			// 4);
			// װ������
			globalBjjsBean.setPriId(ConvertUtil
					.getDBStr(rs.getString("id")));
			globalBjjsBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalBjjsBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalBjjsBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalBjjsBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalBjjsBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalBjjsBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalBjjsBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalBjjsBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalBjjsBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalBjjsBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalBjjsBean.setInvyear(ConvertUtil.getDBStr(rs
					.getString("invyear")));
			globalBjjsBean.setInvmonth(ConvertUtil.getDBStr(rs
					.getString("invmonth")));
			globalBjjsBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalBjjsBean
					.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalBjjsBean.setInvyear_month(ConvertUtil.getDBStr(rs
					.getString("invyear_month")));
			globalBjjsBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalBjjsBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalBjjsBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalBjjsBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalBjjsBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));			
			globalBjjsBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalBjjsBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));

			// װ�ص���List
			globalBjjsList.add(globalBjjsBean);

			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalBjjsBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		System.out.println("test==="+globalBjjsList.size());
		return globalBjjsList;
	}

	/**
	 * �������ݵ�����ӿ�Oracle���ݿ�
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws SQLException
	 */
	public Map<String,Integer> insert2OracleData(List<GlobalBjjsBean> globalBjjsList,
			String syncType) throws Exception {
		int i=0;
		Map<String,Integer> amount=new HashMap<String,Integer>();    
		if (globalBjjsList.size() < 1) {
			i=globalBjjsList.size();//i=0;
			amount.put("success", i);
			amount.put("fail", 0);
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");
		} else {
			String oper_id = CommonTool.getUUID();// ����Id
			 i=0;
			GlobalBjjsXml globalBjjsXml = new GlobalBjjsXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.��������List����
			System.out.println("=============���3==================");		
			for (GlobalBjjsBean globalBjjsBean : globalBjjsList) {
				if("".equals(globalBjjsBean.getNccode())||globalBjjsBean.getNccode()==null||"null".equals(globalBjjsBean.getNccode())){
					writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					continue;
				}
				
				if("0.00".equals(globalBjjsBean.getRmb())||"0".equals(globalBjjsBean.getRmb())){
					writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,"����ʧ�ܣ�-���Ϊ��");
					continue;
				}
				if("".equals(globalBjjsBean.getNcdeptno())||globalBjjsBean.getNcdeptno()==null||"null".equals(globalBjjsBean.getNcdeptno())){
					writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue;
				}
				String number = "";
				try {
					System.out.println("=============���3-1==================");	
					 number = OperationUtil.getSerialNumber(syncType, "0001",4);
					 System.out.println("=============���3-2==================");	
				} catch (Exception e) {
					throw new Exception("���кŴ���");

				}
				globalBjjsBean.setInvcode(globalBjjsBean.getInvcode()
						+ number);
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				try{
					
				try {
					//��װxml�ַ���
					xmlMassage = globalBjjsXml.getXmlStr(globalBjjsBean);
					//����nc�����
					System.out.println("=============���4==================");		
				    xmlStr=erfs.requst_Nc_Finance("010101","F0",xmlMassage);
				    System.out.println("=============���4-----------:"+xmlStr+"==================");		
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalBjjsBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// ��¼ͬ���ɹ�������Ϣ
							writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalBjjsBean.getPriId());
						}
						try {
							// �ļ���־,�ɹ���¼
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ����ݿ�-�������˰����Ӧ�գ��ӿ�", "XML����:"+xmlMassage,"�����˰����Ӧ�գ�NC����ͬ����־");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// ��¼ͬ��ʧ��������Ϣ
								writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalBjjsBean.getPriId());
							}
							try {
								// �ļ���־,ʧ�ܼ�¼
								LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ʧ��",
										"�������ݵ�nc����ӿ����ݿ�-�����˰����Ӧ�գ��ӿ�", "XML����:"+xmlMassage,"�����˰����Ӧ�գ�NC����ͬ����־");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
			   }
				} catch (Exception e) {
					throw new Exception("���кŴ���1111");

				}
			}
			LogWriter.logDebug("����ִ��[" + syncType + "]����ͬ�����ɹ�["
					+ i + "]��"+",ʧ��["+(globalBjjsList.size()-i)+"]��");
			// ���ݿ���־
			writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ�����ɹ�["+ i + "]��"+",ʧ��["+(globalBjjsList.size()-i)+"]��"));
			amount.put("success", i);
			amount.put("fail",globalBjjsList.size()-i);
		}
		
		return amount;
	}

	

}