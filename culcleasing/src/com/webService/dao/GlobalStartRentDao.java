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
import com.webService.bean.GlobalStartRentBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.GlobalStartRentXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;



/**
 * ���� Dao ����
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 6:42:30 PM Email:JaffeHe@hotmail.com
 */
public class GlobalStartRentDao {

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
				amount, "DATA_SYNC_GLOBAL_START_RENT_NC", "NC�������ӿ�����ͬ��", operRmark);

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
			GlobalStartRentBean globalStartRentBean, String oper_id,
			String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalStartRentBean.getPriId(), globalStartRentBean
							.getPara_2(), globalStartRentBean.getPara_3(),
					globalStartRentBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_rent_start_rent_nc");

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
	public List<GlobalStartRentBean> readGlobalStartRentData(String syncType)
			throws SQLException {
		List<GlobalStartRentBean> globalStartRentList = new ArrayList<GlobalStartRentBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil
				.generateSelectERPGlobalStartRentData1();
		LogWriter.logSqlStr("��ȡERP����������Ϣ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalStartRentBean globalStartRentBean = new GlobalStartRentBean();
			// װ������
			globalStartRentBean.setPriId(ConvertUtil.getDBStr(rs
					.getString("id")));
			globalStartRentBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalStartRentBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalStartRentBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalStartRentBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalStartRentBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalStartRentBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalStartRentBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalStartRentBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalStartRentBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalStartRentBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalStartRentBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalStartRentBean.setChangesign(ConvertUtil.getDBStr(rs
					.getString("changesign")));
			globalStartRentBean.setOdate(ConvertUtil.getDBDateStr(rs
					.getString("odate")));
			globalStartRentBean.setModifydate(ConvertUtil.getDBDateStr(rs
					.getString("modifydate")));
			globalStartRentBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalStartRentBean.setRmb(ConvertUtil
					.getDBStr(rs.getString("rmb")));
			globalStartRentBean.setStartrentscode(ConvertUtil.getDBStr(rs
					.getString("startrentscode")));
			globalStartRentBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalStartRentBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalStartRentBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalStartRentBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalStartRentBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalStartRentBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalStartRentBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));

			// װ�ص���List
			globalStartRentList.add(globalStartRentBean);

			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalStartRentBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		return globalStartRentList;
	}

	/**
	 * �������ݵ�����ӿ�Oracle���ݿ�
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(
			List<GlobalStartRentBean> globalStartRentList, String syncType)
			throws Exception {
		if(globalStartRentList.size()<1){
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");
		}else{
			String oper_id=CommonTool.getUUID();//����Id
			int i=0;
			GlobalStartRentXml globalStartRentXml=new GlobalStartRentXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer ncserver=new RequestNcServer();
			//��������list
			for(GlobalStartRentBean globalStartRentBean:globalStartRentList){
				//�ж��Ƿ���nc����
				if("".equals(globalStartRentBean.getNccode())||globalStartRentBean.getNccode()==null || "null".equals(globalStartRentBean.getNccode()) ){
					writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					continue;
				}
				if("0.00".equals(globalStartRentBean.getRmb())|| "0".equals(globalStartRentBean.getRmb()) ){
					writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,"����ʧ�ܣ�-���Ϊ��");
					continue;
				}
				if("".equals(globalStartRentBean.getNcdeptno())||globalStartRentBean.getNcdeptno()==null || "null".equals(globalStartRentBean.getNcdeptno()) ){
					writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue;
				}
				String xmlMassage=null;
				String xmlStr=null;
				String ifsuccess="-1";
				String errorMsg="";
				boolean key=true;
				
				try {
					xmlMassage=globalStartRentXml.getXmlStr(globalStartRentBean);
					xmlStr=ncserver.requst_Nc_Finance("010101", "F0", xmlMassage);
					System.out.println("xmlStr:"+xmlStr);
					ifsuccess= xmlanalysis.getMsg(xmlStr);
					System.out.println("ifsuccess"+ifsuccess);

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					try{
						writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,e.getMessage()==null?"java.lang.NullPointerException":e.getMessage());	

					}catch(Exception e2){
						e2.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e2.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalStartRentBean.getPriId());
						
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							i++;
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ����ݿ�-����(Ӧ��)���ӿ�", "XML����:"+xmlMassage,"����(Ӧ��)��NC����ͬ����־");			
							// ��¼ͬ���ɹ�������Ϣ
							writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,ifsuccess);
						} catch (Exception e2) {
							// TODO: handle exception
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalStartRentBean.getPriId());
						}
						try {
							// �ļ���־,�ɹ���¼
							LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ɹ�",
									"�������ݵ�nc����ӿ����ݿ�-����(Ӧ��)���ӿ�", "XML����:"+xmlMassage,"����(Ӧ��)���ӿ�NC����ͬ����־");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalStartRentBean.getPriId());
				
							}
							try {
								// �ļ���־,ʧ�ܼ�¼
								LogWriter.operationFILogNc("����ִ��[" + syncType + "]����ͬ�������ݴ���ʧ��",
										"�������ݵ�nc����ӿ����ݿ�-����(Ӧ��)���ӿ�", "XML����:"+xmlMassage,"����(Ӧ��)���ӿ�NC����ͬ����־");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
		
		LogWriter.logDebug("����ִ��[" + syncType + "]����ͬ������������["
				+ i + "]��"+",ʧ��["+(globalStartRentList.size()-i)+"]��");
		// ���ݿ���־
		writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ������������["+ i + "]��"+",ʧ��["+(globalStartRentList.size()-i)+"]��"));
		
		
	}

	}

}
