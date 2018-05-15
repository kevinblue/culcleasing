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
import com.webService.bean.GlobalReceiveBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
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
public class GlobalReceiveDao {

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
				amount, "DATA_SYNC_GLOBAL_RECEIVE", "nc�����տ����ӿ�����ͬ��", operRmark);

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
	private void writeDataSyncDBInfo(GlobalReceiveBean globalReceiveBean,
			String oper_id, String syncType,String operRmark) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		operRmark = operRmark.replaceAll("'", "''");
		String sqlStr = "";
			// ����
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalReceiveBean.getPriId(),
					globalReceiveBean.getPara_2(), 
					globalReceiveBean.getPara_3(),
					globalReceiveBean.getPara_4(),
					operRmark,
					oper_id, 
					"vi_INTERFACE_fina_global_receive_nc"
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
	public List<GlobalReceiveBean> readGlobalReceiveData(String syncType)
			throws SQLException {
		List<GlobalReceiveBean> globalReceiveList = new ArrayList<GlobalReceiveBean>();
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��ѯClient1���ݿ�
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalReceiveData();
		LogWriter.logSqlStr("��ȡERP��ǰ��ֹ��ͬ�տ", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.װ�ص�List
		while (rs.next()) {
			GlobalReceiveBean globalReceiveBean = new GlobalReceiveBean();
			// װ������

			globalReceiveBean
					.setPriId(ConvertUtil.getDBStr(rs.getString("id")));
			globalReceiveBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalReceiveBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalReceiveBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			// ConvertUtil.getDBStr("")
			globalReceiveBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			globalReceiveBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalReceiveBean.setAcode(ConvertUtil.getDBStr(rs
					.getString("acode")));
			globalReceiveBean.setOdate(ConvertUtil.getDBStr(rs
					.getString("odate")));
			globalReceiveBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalReceiveBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalReceiveBean.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalReceiveBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalReceiveBean.setOffset(ConvertUtil.getDBStr(rs
					.getString("offset")));
			globalReceiveBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));			
			globalReceiveBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalReceiveBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalReceiveBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalReceiveBean.setPawnsign(ConvertUtil.getDBStr(rs
					.getString("pawnsign")));
			globalReceiveBean.setPawnrmb(ConvertUtil.getDBStr(rs
					.getString("pawnrmb")));
			globalReceiveBean.setPawncode(ConvertUtil.getDBStr(rs
					.getString("pawncode")));
			globalReceiveBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalReceiveBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalReceiveBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalReceiveBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			System.out.println("invtype:"+ConvertUtil.getDBStr(rs
					.getString("invtype")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			//851��853��8851,8852,8853,8723,8721��8722,897,898,899,885,872
			if("872".equals(invtype)||"8721".equals(invtype)||"8722".equals(invtype)||"8723".equals(invtype)||"893".equals(invtype)
			||"894".equals(invtype)||"895".equals(invtype)||"897".equals(invtype)||"898".equals(invtype)||"899".equals(invtype)
			||"8851".equals(invtype)||"8852".equals(invtype)||"8853".equals(invtype)||"853".equals(invtype)			
			||"851".equals(invtype)){
				globalReceiveBean.setRemark_2("0.06");
			}else if("871".equals(invtype)||"873".equals(invtype)){ //��Ƶ����׸��� ��Ԥ������Ϣ����ǰϢ��
				globalReceiveBean.setRemark_2("0.17");
			}else{
				globalReceiveBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));
			}
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalReceiveBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalReceiveBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			globalReceiveBean.setSparecolumn_a(ConvertUtil.getDBStr(rs
					.getString("sparecolumn_a")));
			globalReceiveBean.setSparecolumn_b(ConvertUtil.getDBStr(rs
					.getString("sparecolumn_b")));
			// װ�ص���List
			globalReceiveList.add(globalReceiveBean);
			LogWriter.logDebug("����[" + syncType + "]�����ݺţ�"
					+ globalReceiveBean.getInvcode());
		}
		// 4.�ر���Դ
		erpDataSource.close();

		// 5.����
		return globalReceiveList;
	}

	/**
	 * ���䵽����ӿڹ����տ
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalReceiveBean> globalReceiveList,
			String syncType) throws Exception {
		if (globalReceiveList.size() < 1) {
			LogWriter.logDebug("��ǰû��[" + syncType + "]������Ҫͬ��");
		} else {
			String oper_id = CommonTool.getUUID();// ����Id

			int i=0;
			GlobalReceiveXml globalreceivexml = new GlobalReceiveXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.��������List����
			for (GlobalReceiveBean globalReceiveBean : globalReceiveList) {
				if("".equals(globalReceiveBean.getNccode())||globalReceiveBean.getNccode()==null||"null".equals(globalReceiveBean.getNccode())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"����ʧ�ܣ�-NC���̱���Ϊ��");
					continue;
				}
				if("0.00".equals(globalReceiveBean.getRmb())||"0".equals(globalReceiveBean.getRmb())||"0.0000".equals(globalReceiveBean.getRmb())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"����ʧ�ܣ�-���Ϊ��");
					continue;
				}
				
				if("".equals(globalReceiveBean.getNcdeptno())||globalReceiveBean.getNcdeptno()==null||"null".equals(globalReceiveBean.getNcdeptno())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"����ʧ�ܣ�-NC���ű���Ϊ��");
					continue;
				}
				if("".equals(globalReceiveBean.getAcode())||globalReceiveBean.getAcode()==null||"null".equals(globalReceiveBean.getAcode())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"����ʧ�ܣ�-�����˻�Ϊ��");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				//��װxml�ַ���
				try {
					xmlMassage = globalreceivexml.getXmlStr(globalReceiveBean);
					//����nc�����
				   xmlStr=erfs.requst_Nc_Finance("010101","F2",xmlMassage);//=================================================�Ȳ���
				   System.out.println("xmlStr::::;;;;"+xmlStr); 
				   System.out.println("_-------------------------------"); 
				   ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("����ʧ��ԭ��"+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalReceiveBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// ��¼ͬ���ɹ�������Ϣ
							writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("��������ͬ���ɹ�����д����־ʱ����-"+"��ĿID:"+globalReceiveBean.getPriId());
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
								writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("����ʧ��ԭ��"+ifsuccess);
								throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+globalReceiveBean.getPriId());
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
					+ i + "]��"+",ʧ��["+(globalReceiveList.size()-i)+"]��");
			// ���ݿ���־
			writeDataSyncDBLog(oper_id, i, syncType,("����ִ��[" + syncType + "]����ͬ�����ɹ�["+ i + "]��"+",ʧ��["+(globalReceiveList.size()-i)+"]��"));
		}
	}
}
