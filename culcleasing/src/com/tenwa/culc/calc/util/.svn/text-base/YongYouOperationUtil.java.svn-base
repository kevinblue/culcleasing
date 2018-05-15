/**
 * com.tenwa.culc.util
 */
package com.tenwa.culc.calc.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * 简单操作公共类
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 10:52:29 AM Email:JaffeHe@hotmail.com
 */
public class YongYouOperationUtil {

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
			LogWriter.logError("生成[" + type + "]流程号异常，\n" + e.getMessage());
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
						"Insert into YY_ERP_DATA_SYNC_LOG(oper_id,oper_type,oper_name,oper_remark,oper_date,")
				.append("update_amount,insert_amount) ");

		sqlStr.append(" values('无-产生异常','" + oper_type + "','" + oper_name
				+ "','" + oper_excep + "','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "',0,0)");
		LogWriter.logError("产生异常：" + sqlStr.toString());
		sql = sqlStr.toString();
		System.out.println("sql============================"+sql);
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}

	/**
	 * 写入ERP错误日志操作
	 * 
	 * @param oper_type
	 * @param oper_name
	 * @param oper_excep
	 * @throws SQLException
	 */
	public static void operationERPExceptionLog(String tablename,String acc_number,String SqlExcep) throws SQLException{
		// 1.创建连接
		YongYouDataSource  yyds =new YongYouDataSource();	
		// 2.upates数据
		String sql = "";

	   // 1Buffer对象
	  StringBuffer sqlStr = new StringBuffer(" update ");
	  if(null!=acc_number && !"".equals(acc_number)){
		  sqlStr.append( " "+tablename+" set read_flag='-1',read_date='"+CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd")+"', read_memo='"+SqlExcep+"' where acc_number='"+acc_number+"'"  );
		  
	  }
		LogWriter.logError("产生异常：" + sqlStr.toString());
		sql = sqlStr.toString();
		System.out.println(sql);
		yyds.executeUpdate(sql);
		yyds.close();
	}
	
	
	/**
	 * 写入ERP保理账号错误日志操作
	 * 
	 * @param tablename
	 * @param contract_id
	 * @param SqlExcep
	 * @throws SQLException
	 */
	public static void operationERPFactoringBankExceptionLog(String tablename,String begin_id,String SqlExcep) throws SQLException{
		// 1.创建连接
		YongYouDataSource  yyds =new YongYouDataSource();	
		// 2.upates数据
		String sql = "";

	   // 1Buffer对象
	  StringBuffer sqlStr = new StringBuffer(" update ");
	  if(null!=begin_id && !"".equals(begin_id)){
		  sqlStr.append( " "+tablename+" set read_flag='-1',read_date='"+CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd")+"', read_memo='"+SqlExcep+"' where begin_id='"+begin_id+"'"  );
		  
	  }
		LogWriter.logError("产生异常：" + sqlStr.toString());
		sql = sqlStr.toString();
		System.out.println(sql);
		yyds.executeUpdate(sql);
		yyds.close();
	}
	
	
}
