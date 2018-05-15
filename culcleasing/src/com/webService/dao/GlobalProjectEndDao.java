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
import com.webService.bean.GlobalProjectEndBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.GlobalProjectEndXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;


public class GlobalProjectEndDao {

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
				amount, "DATA_SYNC_GLOBAL_PROJECTEND_NC", "nc��ͬ����ӿ�����ͬ��", operRmark);
		LogWriter.logDebug("writeDataSyncDBLog" + sqlStr);

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
			GlobalProjectEndBean globalProjectEndBean, String oper_id,
			String syncType,String operRmark) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		operRmark=operRmark.replaceAll("'", "''");
		String sqlStr = "";
		
			// ����
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalProjectEndBean.getPriId(), globalProjectEndBean
							.getPara_2(), globalProjectEndBean.getPara_3(),
					globalProjectEndBean.getPara_4(),
					operRmark,
					oper_id,
					"vi_INTERFACE_fina_global_htjq_nc" );
			// LogWriter.logDebug("writeDataSyncDBInfo" + sqlStr);

			// ִ�в���
			erpDataSource.executeUpdate(sqlStr);
		
		erpDataSource.close();
	}

	/**
	 * ��ȡERP ��ͬ���������
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalProjectEndBean> readGlobalInterestSubsidy(String syncType)
			throws SQLException {
		List<GlobalProjectEndBean> globalProjectEndBeanList = new ArrayList<GlobalProjectEndBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil
				.generateSelectERPGlobalProjectEndData1();
		LogWriter.logSqlStr("��ȡERP��ͬ�������Ϣ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalProjectEndBean globalProjectEndBean = new GlobalProjectEndBean();
			// װ������
			globalProjectEndBean.setId(rs.getInt("id"));
			globalProjectEndBean.setPriId(ConvertUtil.getDBStr(rs
					.getString("id")));
			globalProjectEndBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalProjectEndBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalProjectEndBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalProjectEndBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalProjectEndBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalProjectEndBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalProjectEndBean.setAcode(ConvertUtil.getDBStr(rs
					.getString("acode")));
			globalProjectEndBean.setOdate(ConvertUtil.getDBDateStr(rs
					.getString("odate")));
			globalProjectEndBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));

			globalProjectEndBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalProjectEndBean.setRmb(ConvertUtil.getDBStr(rs
					.getString("rmb")));

			globalProjectEndBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalProjectEndBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalProjectEndBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalProjectEndBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalProjectEndBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));

			globalProjectEndBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalProjectEndBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalProjectEndBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalProjectEndBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			if("872".equals(invtype)||"8721".equals(invtype)||"8722".equals(invtype)||"8723".equals(invtype)||"893".equals(invtype)
					||"894".equals(invtype)||"895".equals(invtype)||"897".equals(invtype)||"898".equals(invtype)||"899".equals(invtype)
					||"8851".equals(invtype)||"8852".equals(invtype)||"8853".equals(invtype)||"853".equals(invtype)			
					||"851".equals(invtype)){
				globalProjectEndBean.setRemark_2("0.06");
			}else{
				globalProjectEndBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));
			}			
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalProjectEndBean.setNcode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalProjectEndBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			// װ�ص���List
			globalProjectEndBeanList.add(globalProjectEndBean);

			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalProjectEndBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		return globalProjectEndBeanList;
	}

	/**
	 * �������ݵ�����ӿ�Oracle���ݿ�
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(
			List<GlobalProjectEndBean> globalProjectEndList, String syncType)
			throws Exception {
		if(globalProjectEndList.size()<1){
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");			
		}else{
			String oper_id=CommonTool.getUUID();//����Id
			int i=0;
			GlobalProjectEndXml globalProjectEndXml=new GlobalProjectEndXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer ncserver=new RequestNcServer();
			for(GlobalProjectEndBean globalProjectEndBean  :globalProjectEndList){
               //�ж��ǹ���nc����
				if("".equals(globalProjectEndBean.getNcode())||globalProjectEndBean.getNcode()==null||"null".equals(globalProjectEndBean.getNcode())){
					writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					System.out.println("nccode:"+globalProjectEndBean.getNcode());
					continue; 
               }
				if("0.00".equals(globalProjectEndBean.getRmb())||"0".equals(globalProjectEndBean.getRmb())){
					writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,"����ʧ�ܣ�-���Ϊ��");
					continue; 
               }
				if("".equals(globalProjectEndBean.getNcdeptno())||globalProjectEndBean.getNcdeptno()==null||"null".equals(globalProjectEndBean.getNcdeptno())){
					writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue; 
               }
				System.out.println("nccode:============================="+globalProjectEndBean.getNcode());
				String xmlMassage=null;
				String xmlStr=null;
				String ifsuccess="-1";
				String errorMsg="";
				boolean key=true;
				try {
					xmlMassage=	globalProjectEndXml.getXmlStr(globalProjectEndBean);
					xmlStr=	ncserver.requst_Nc_Finance("010101", "F2", xmlMassage);
					System.out.println("xmlStr:"+xmlStr);
					ifsuccess= xmlanalysis.getMsg(xmlStr);
					System.out.println("ifsuccess"+ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,e.getMessage()==null?"java.lang.NullPointerException":e.getMessage());	
	
					} catch (Exception e2) {
						e2.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e2.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalProjectEndBean.getPriId());
						
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
					 try{
						i++;
					  LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
								"�������ݵ�nc����ӿ����ݿ�-��ͬ�����տ�ӿ�", "XML����:"+xmlMassage,"��ͬ�����տNC����ͬ����־");			
						// ��¼ͬ���ɹ�������Ϣ
						writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,ifsuccess);
					 }catch (Exception e2) {
							// TODO: handle exception
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalProjectEndBean.getPriId());

						}
					 try {
							// �ļ���־,�ɹ���¼
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ����ݿ�-��ͬ�����տ�ӿ�", "XML����:"+xmlMassage,"��ͬ�����տNC����ͬ����־");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,ifsuccess);								
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalProjectEndBean.getPriId());
				
							}
							try {
								// �ļ���־,ʧ�ܼ�¼
								LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ʧ��",
										"�������ݵ�nc����ӿ����ݿ�-��ͬ�����տ�ӿ�", "XML����:"+xmlMassage,"��ͬ�����տNC����ͬ����־");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
			LogWriter.logDebug("����ִ��[" + syncType + "]����ͬ������������["
					+ i + "]��"+",ʧ��["+(globalProjectEndList.size()-i)+"]��");
			// ���ݿ���־
			writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ������������["+ i + "]��"+",ʧ��["+(globalProjectEndList.size()-i)+"]��"));
			
			
			
		}
		
	}


}
