/**
 * com.tenwa.datasync.util
 */
package com.tenwa.culc.calc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * @author Jaffe
 * 
 * Date:Mar 16, 2012 11:03:31 AM Email:JaffeHe@hotmail.com
 */
public class YongYouDataSource {
	// 属性
	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	private String dataSource;

	/**
	 * 获取链接
	 */
	public YongYouDataSource() {
		conn = null;
		stmt = null;
		rs = null;
		dataSource = "jdbc/yongyou";
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup(dataSource);
			System.out.println("====>Oracle DataSource Object Create<=====");
			conn = ds.getConnection();
			stmt = conn.createStatement(1005, 1008);
		} catch (Exception e) {
			System.err.println("!!!!创建Oracle DataSourceError: "
					+ e.getMessage());
		}
	}

	
//	private static String DRIVER = "oracle.jdbc.driver.OracleDriver";// 
//	private static String URL = "jdbc:oracle:thin:@localhost:1521:orcl";// 
//	private static String USER = "ncmd";// 
//	private static String PWD = "123";// 
//
//	private Connection conn = null;
//	private Statement stmt = null;
//	private ResultSet rs = null;
//
//	static {// 静态代码块执行一次
//		try {
//			Class.forName(DRIVER);
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		}
//	}
//
//	public YongYouDataSource() {
//		conn = null;
//		stmt = null;
//		try {
//			conn = DriverManager.getConnection(URL, USER, PWD);
//			stmt = conn.createStatement();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//	}
/*	public Connection getConnection() {
	
		return conn;
	}
*/	/**
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
			System.out.println("====>!!Oracle DataSource Object close!!<=====");
		} catch (Exception e) {
			System.err.println("YongYou DataSource 关闭异常：" + e.getMessage());
		}
	}
	
	public static void main(String[] args) {
		YongYouDataSource s= new YongYouDataSource();
		System.out.println(s.toString());
		
	}

}
