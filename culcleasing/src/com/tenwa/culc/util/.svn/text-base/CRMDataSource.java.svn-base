/**
 * com.tenwa.datasync.util
 */
package com.tenwa.culc.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * @author Jaffe
 * 
 * Date:Mar 15, 2012 3:59:20 PM Email:JaffeHe@hotmail.com
 */
public class CRMDataSource {

	// 属性
	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	private String dataSource;

	/**
	 * 获取链接
	 */
	public CRMDataSource() {
		conn = null;
		stmt = null;
		rs = null;
		dataSource = "jdbc/crm";
		try {
			Context ctx = new InitialContext();
			System.out.println("====>CRM DataSource Object Create<=====");
			DataSource ds = (DataSource) ctx.lookup(dataSource);
			conn = ds.getConnection();
			stmt = conn.createStatement(1005, 1008);
		} catch (Exception e) {
			System.err.println("!!!!创建CRM DataSourceError: " + e.getMessage());
		}
	}

	/**
	 * 执行查询
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public ResultSet executeQuery(String sql) throws SQLException {
		return stmt.executeQuery(sql);
	}

	/**
	 * 执行修改
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public int executeUpdate(String sql) throws SQLException {
		return stmt.executeUpdate(sql);
	}

	/**
	 * 关闭资源
	 */
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
			System.out.println("====>!!Crm DataSource Object close!!<=====");
		} catch (Exception e) {
			System.err.println("CRM DataSource 关闭异常：" + e.getMessage());
		}
	}

	
	
}
