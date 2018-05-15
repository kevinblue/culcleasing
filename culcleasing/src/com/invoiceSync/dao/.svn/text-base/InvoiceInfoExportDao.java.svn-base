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
	
	
// 公共参数
    
	private ResultSet rs = null;
	private String sync_type_name = "[发票接口传输]";
	/**
	 * 读取合同资金计划信息
	 * 
	 * @return
	 * @throws Exception 
	 */
	
	public List<InvoiceInfoExport>  readInvoiceInfoExportDaoData(String out_no,String flag) throws Exception{
		List<InvoiceInfoExport>  list=new  ArrayList<InvoiceInfoExport>();
		InvoiceInfoExport ifp = null;
		// 1获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		StringBuffer selectsql = new StringBuffer();
		if(flag.equals("ERP")){
			if(null!=out_no && !"".equals(out_no)){
				System.out.println("ERP数据开票");
				selectsql.append("select * from vi_invoice_export_to_middle_table where out_no in("+out_no+")");
			}
		}else if(flag.equals("Manu")){
			System.out.println("手工开票");
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
				throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+ifp.getOut_no());

			}
		}
		rs.close();
		erpDataSource.close();
		return list;
		
	}
	/**
	 * 插入中间库
	 * @param beanList
	 * @throws SQLException
	 */
	public int insert2HostData(List<InvoiceInfoExport> beanList)	throws SQLException {
		
		int updAmount = 0;// 修改数据数据量
		int insAmount = 0;// 插入数据数据量
		if (beanList.size() < 1) {
			HTLogWriter.logDebug("当前没有"+sync_type_name+"数据需要同步");
		} else {
				String oper_id = CommonTool.getUUID();// 操作Id
				InvoiceZJKDataSource zjkDataSource=null;
				ERPDataSource erpDataSource = null;
				try{
				 zjkDataSource=new InvoiceZJKDataSource();
				 erpDataSource = new ERPDataSource();
				String sqlStr = "";
			    String deleteoraclesql="";
			    String deletesqlservicesql="";
				// 1.遍历所有List数据
			    System.out.println(beanList.size());
				for (InvoiceInfoExport invoiceInfoExport : beanList) {				
					sqlStr = HTSqlTableUtil.getAllFiledInsertSQLFORMSQLSERVER(invoiceInfoExport,"open_invoice_info_middle_table");
					insAmount++;
					System.out.println(insAmount);			
					// 2.1.3执行操作
					if (!"".equals(sqlStr)) {
						zjkDataSource.executeUpdate(sqlStr);
						HTLogWriter.operationLog("本次插入中间库的sql==="+sqlStr);
					}
				}
				}catch(Exception e){
					e.printStackTrace();
				}finally{
				HTLogWriter.logDebug("本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
				// 文件日志
				HTLogWriter.operationLog("本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
				// 数据库日志
				writeDataSyncDBLog(insAmount, updAmount, oper_id);
				// 同步数据信息
				writeDataSyncDBInfo(beanList,oper_id);
				erpDataSource.close();
				zjkDataSource.close();
				}
			}
		return insAmount;
}

	

	/**
	 * 数据同步信息
	 * 
	 * @param equipMedLibList
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(List<InvoiceInfoExport> beanList,	String oper_id) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		// 1.遍历所有List数据
		for (InvoiceInfoExport invoiceInfoExport : beanList) {
			// 插入
			sqlStr = HangTianSqlGenerateUtil.getDataSyncDBPlanInfoALLinvoice(oper_id, invoiceInfoExport.getOut_no(),invoiceInfoExport.getCust_name(),null);

			// 执行操作
			System.out.println(sync_type_name+"同步信息插入日志SQL" + sqlStr);
			HTLogWriter.operationLog(sync_type_name+"同步信息插入日志SQL" + sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		}
		erpDataSource.close();
	}

	/**
	 * 服务器数据库日志
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(int insAmount, int updAmount, String oper_id)
			throws SQLException {
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.更新数据
		String sqlStr = HangTianSqlGenerateUtil.generateDataSyncProjInfoLog(
				insAmount, updAmount, oper_id,sync_type_name,"DATA_SYNC_INTER_FUND_PLAN");
   
		erpDataSource.executeUpdate(sqlStr);

		// 3.释放
		erpDataSource.close();
	}

	


}
