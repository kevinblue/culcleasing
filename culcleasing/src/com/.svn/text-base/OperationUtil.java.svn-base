/**
 * com.tenwa.culc.util
 */
package com;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.tenwa.culc.util.ERPDataSource;

/**
 * 简单操作公共类
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 10:52:29 AM Email:JaffeHe@hotmail.com
 */
public class OperationUtil {
	private static ERPDataSource erpDataSource=null;

	// 公共参数
	private static ResultSet rs = null;

	/**
	 * 获取最新流水号
	 * 
	 * @param type
	 *            类型 例：国内收款单
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
		erpDataSource=new ERPDataSource();
		try {
			// 1查询出最新编号
			sqlStr = "select isnull(max(cast(no as int)),0)+1 as no from GENERATE_NO where generate_type='"
					+ type + "'";
			rs = erpDataSource.executeQuery(sqlStr);
			if (rs.next()) {
				resVal = rs.getString("no");
			}
			
			
			// 2.插入当前编号
			sqlStr = "insert into generate_no select '" + type
					+ "',getdate(),'" + resVal + "'";
			erpDataSource.executeUpdate(sqlStr);
		} catch (SQLException e) {
			 e.getMessage();
		} finally {
			// 3.关闭资源
			erpDataSource.close();
		}
		// 补零操作
		if (resVal == null || "".equals(resVal)) {
			resVal = defaultVal;
		} else {
			resVal = operOStr(resVal, amount);
		}
		return resVal;
	}

/**
 * 返回补零操作
 * 
 * @param str
 * @param amount
 *            几位数
 * @return
 */
public static String operOStr(String str, int amount) {
	String resStr = "";
	int strLen = str.length();
	if (strLen >= amount) {
		resStr = str;
	} else {
		for (int i = 0; i < (amount - strLen); i++) {
			str = "0" + str;
		}
		resStr = str;
	}
	return resStr;
}
}
