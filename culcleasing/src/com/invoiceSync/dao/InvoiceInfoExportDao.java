package com.invoiceSync.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.invoiceSync.bean.InvoiceInfoExport;
import com.invoiceSync.datasource.InvoiceZJKDataSource;
import com.invoiceSync.log.HTLogWriter;
import com.invoiceSync.util.HTSqlGenerateUtil;
import com.invoiceSync.util.HTSqlTableUtil;
import com.invoiceSync.util.HangTianSqlGenerateUtil;
import com.tenwa.culc.calc.util.YongYouDataSource;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;





public class InvoiceInfoExportDao {
	
	
// ��������
    
	private ResultSet rs = null;
	private String sync_type_name = "[��Ʊ�ӿڴ���]";
	/**
	 * ��ȡ��ͬ�ʽ�ƻ���Ϣ
	 * 
	 * @return
	 * @throws Exception 
	 */
	
	public List<InvoiceInfoExport>  readInvoiceInfoExportDaoData(String out_no,String flag) throws Exception{
		List<InvoiceInfoExport>  list=new  ArrayList<InvoiceInfoExport>();
		InvoiceInfoExport ifp = null;
		// 1��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		StringBuffer selectsql = new StringBuffer();
		if(flag.equals("ERP")){
			if(null!=out_no && !"".equals(out_no)){
				System.out.println("ERP���ݿ�Ʊ");
				selectsql.append("select * from vi_invoice_export_to_middle_table where out_no in("+out_no+")");
			}
		}else if(flag.equals("Manu")){
			System.out.println("�ֹ���Ʊ");
			if(null!=out_no && !"".equals(out_no)){
				selectsql.append("select * from vi_manual_open_invoice_info where out_no in("+out_no+")");
			}			
		}
		
		System.out.println(selectsql.toString());
		rs=erpDataSource.executeQuery(selectsql.toString());
		
		while (rs.next()) {
			try {						
			ifp = new InvoiceInfoExport();
			ifp=(InvoiceInfoExport) HTSqlTableUtil.getResultSetObj(ifp, rs, "vi_invoice_export_to_middle_table");
			list.add(ifp);
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("��������ͬ��ʧ�ܣ���д����־ʱ����-"+"��ĿID:"+ifp.getOut_no());

			}
		}
		rs.close();
		erpDataSource.close();
		return list;
		
	}
	/**
	 * �����м��
	 * @param beanList
	 * @throws SQLException
	 */
	public int insert2HostData(List<InvoiceInfoExport> beanList)	throws SQLException {
		
		int updAmount = 0;// �޸�����������
		int insAmount = 0;// ��������������
		if (beanList.size() < 1) {
			HTLogWriter.logDebug("��ǰû��"+sync_type_name+"������Ҫͬ��");
		} else {
				String oper_id = CommonTool.getUUID();// ����Id
				InvoiceZJKDataSource zjkDataSource=null;
				ERPDataSource erpDataSource = null;
				try{
				 zjkDataSource=new InvoiceZJKDataSource();
				 erpDataSource = new ERPDataSource();
				String sqlStr = "";
			    String deleteoraclesql="";
			    String deletesqlservicesql="";
				// 1.��������List����
			    System.out.println(beanList.size());
				for (InvoiceInfoExport invoiceInfoExport : beanList) {				
					sqlStr = HTSqlTableUtil.getAllFiledInsertSQLFORMSQLSERVER(invoiceInfoExport,"open_invoice_info_middle_table");
					insAmount++;
					System.out.println(insAmount);			
					// 2.1.3ִ�в���
					if (!"".equals(sqlStr)) {
						zjkDataSource.executeUpdate(sqlStr);
						HTLogWriter.operationLog("���β����м���sql==="+sqlStr);
					}
				}
				}catch(Exception e){
					e.printStackTrace();
				}finally{
				HTLogWriter.logDebug("����ִ��"+sync_type_name+"����ͬ������������[" + insAmount+ "]��");
				// �ļ���־
				HTLogWriter.operationLog("����ִ��"+sync_type_name+"����ͬ������������[" + insAmount+ "]��");
				// ���ݿ���־
				writeDataSyncDBLog(insAmount, updAmount, oper_id);
				// ͬ��������Ϣ
				writeDataSyncDBInfo(beanList,oper_id);
				erpDataSource.close();
				zjkDataSource.close();
				}
			}
		return insAmount;
}

	

	/**
	 * ����ͬ����Ϣ
	 * 
	 * @param equipMedLibList
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(List<InvoiceInfoExport> beanList,	String oper_id) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		// 1.��������List����
		for (InvoiceInfoExport invoiceInfoExport : beanList) {
			// ����
			sqlStr = HangTianSqlGenerateUtil.getDataSyncDBPlanInfoALLinvoice(oper_id, invoiceInfoExport.getOut_no(),invoiceInfoExport.getCust_name(),null);

			// ִ�в���
			System.out.println(sync_type_name+"ͬ����Ϣ������־SQL" + sqlStr);
			HTLogWriter.operationLog(sync_type_name+"ͬ����Ϣ������־SQL" + sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		}
		erpDataSource.close();
	}

	/**
	 * ���������ݿ���־
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(int insAmount, int updAmount, String oper_id)
			throws SQLException {
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��������
		String sqlStr = HangTianSqlGenerateUtil.generateDataSyncProjInfoLog(
				insAmount, updAmount, oper_id,sync_type_name,"DATA_SYNC_INTER_FUND_PLAN");
   
		erpDataSource.executeUpdate(sqlStr);

		// 3.�ͷ�
		erpDataSource.close();
	}

	


}
