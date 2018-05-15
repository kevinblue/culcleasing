/**
 * com.tenwa.culc.util
 */
package com.invoiceSync.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.invoiceSync.log.HTLogWriter;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;


/**
 * 简单操作公共类
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 10:52:29 AM Email:JaffeHe@hotmail.com
 */
public class HangTianInvoiceOperationUtil {

	// 公共参数
	private static ResultSet rs = null;

	/**
	 * 获取最新流水号
	 * 
	 * @param type
	 *            类型 例：
	 * @param defaultVal
	 *            默认流水号
	 * @param amount
	 *            流水号长度
	 * @return
	 */
	public static String getSerialNumber(String type, String defaultVal,
			int amount) {
		String resVal = "";
		String sqlStr = "";
		// 1.查询数据库得到settle_method值
		ERPDataSource erpDataSource=new ERPDataSource();
		try {
			// 1查询出最新编号
			sqlStr = "select isnull(max(cast(no as int)),1)+1 as no from GENERATE_NO where generate_type='"
					+ type + "'";
			rs = erpDataSource.executeQuery(sqlStr);
			if (rs.next()) {
				resVal = rs.getString("no");
			}
			// 2.插入当前编号
			sqlStr = "insert into generate_no select '" + type
					+ "',getdate(),'" + resVal + "'";
			erpDataSource.executeUpdate(sqlStr);
			erpDataSource.close();
		} catch (SQLException e) {
			HTLogWriter.logError("生成[" + type + "]流程号异常，\n" + e.getMessage());
		} finally {
			// 3.关闭资源
			erpDataSource.close();
		}
		// 补零操作
		if (resVal == null || "".equals(resVal)) {
			resVal = defaultVal;
		} else {
			resVal = CommonTool.operOStr(resVal, amount);
		}

		return resVal;
	}

	/**
	 * CRM错误日志操作
	 * 
	 * @param oper_type
	 * @param oper_name
	 * @param oper_excep
	 * @throws SQLException
	 */
	public static void operationExceptionLog(String oper_type,
			String oper_name, String oper_excep) throws SQLException {
		// 1.创建连接
		ERPDataSource erpDataSource=new ERPDataSource();
		// 2.插入最新数据
		String sql = "";

		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();

		oper_excep = oper_excep.replaceAll("'", "''");
		// 2拼接sql
		sqlStr
				.append(
						"Insert into HT_ERP_DATA_SYNC_LOG(oper_id,oper_type,oper_name,oper_remark,oper_date,")
				.append("update_amount,insert_amount) ");

		sqlStr.append(" values('无-产生异常','" + oper_type + "','" + oper_name
				+ "','" + oper_excep + "','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "',0,0)");
		HTLogWriter.logError("产生异常：" + sqlStr.toString());
		sql = sqlStr.toString();
		System.out.println("sql============================"+sql);
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}


	

	
	
}
