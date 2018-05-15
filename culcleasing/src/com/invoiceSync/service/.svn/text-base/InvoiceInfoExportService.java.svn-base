package com.invoiceSync.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.invoiceSync.bean.InvoiceInfoExport;
import com.invoiceSync.dao.InvoiceInfoExportDao;
import com.invoiceSync.log.HTLogWriter;
import com.invoiceSync.util.HangTianInvoiceOperationUtil;


/**
 * 2017-11-16
 * @author kevin
 *
 */

public class InvoiceInfoExportService {
	
	private static String sync_type_name = "[发票接口传输]";
	/**5
	 * 指定开票数据传送
	 * 
	 * @param out_id
	 *        erp单据号
	 * @return
	 */
	public static int dataSync(String out_no,String flag) {
		int res = 0;
		InvoiceInfoExportDao  fldao=new InvoiceInfoExportDao();
		List<InvoiceInfoExport>   list =new  ArrayList<InvoiceInfoExport>();
		List<InvoiceInfoExport> planlist=new ArrayList<InvoiceInfoExport>();
		try {
			// 1.1从Client1 服务器读取数据
			list = fldao.readInvoiceInfoExportDaoData(out_no, flag);
		} catch (Exception e) {
			e.printStackTrace();
			HTLogWriter.logError("读取[" + out_no + "]Client Server "+sync_type_name+"数据异常");
			try {
				HangTianInvoiceOperationUtil.operationExceptionLog("DATA_SYNC_INVOICE_INFO_EXPORT",sync_type_name+"数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		// .将List数据同步到Server数据库服务器
		try {
		
			//3 将数据同步到Server服务器				
			res += fldao.insert2HostData(list);
			
		} catch (SQLException e) {
			try {
				HangTianInvoiceOperationUtil.operationExceptionLog("DATA_SYNC_INVOICE_INFO_EXPORT",sync_type_name+"数据同步", "插入异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			HTLogWriter.logError("更新Host Server "+sync_type_name+" 异常,异常信息: "	+ e.getMessage());
		}
		

		// 本次执行是否成功
		return res;
	}
 public static void main(String[] args) {
	/* String out_no="PR20171115092234001";
	 InvoiceInfoExportDao  fldao=new InvoiceInfoExportDao();
    List<InvoiceInfoExport>   list =new  ArrayList<InvoiceInfoExport>();
	 try {
		list = fldao.readInvoiceInfoExportDaoData(out_no);
		
		System.out.println(list.size());
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i).getCust_name());
			System.out.println(list.get(i).getOut_no());
			System.out.println(list.get(i).getNo_tax_money());
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	 
	
	InvoiceZJKDataSource aa=new InvoiceZJKDataSource();
	
	String sql="select * from open_invoice_info_middle_table";
	try {
		ResultSet rs=aa.executeQuery(sql);
		System.out.println(rs);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		 * PR20171123141911001
PR20171123143846001
		e.printStackTrace();
	}
	 System.out.println(aa);*/
	//int i=InvoiceInfoExportService.dataSync("'PR20171123141344008','PR20171123141344009'","ERP");
	//int i=InvoiceInfoExportService.dataSync("'PR20171123141344008','PR20171123141344009'","ERP");
	int i=InvoiceInfoExportService.dataSync("'b2ccb8c3-a39b-4b66-a980-03603b801614'","Manu");
	System.out.println(i);
	 
	 
  }

}
