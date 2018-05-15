/**
 * com.tenwa.datasync.util
 */
package com.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 * @author Jaffe
 * 
 * Date:Mar 15, 2012 4:00:02 PM Email:JaffeHe@hotmail.com
 */
public class ERPDataSource {

	// // 属性
	// private Connection conn;
	// private Statement stmt;
	// private ResultSet rs;
	// private String dataSource;
	//
	// /**
	// * 获取链接
	// */
	// public ERPDataSource() {
	// conn = null;
	// stmt = null;
	// rs = null;
	// dataSource = "jdbc/culcleasing";
	// try {
	// Context ctx = new InitialContext();
	// DataSource ds = (DataSource) ctx.lookup(dataSource);
	// System.out.println("====>ERP DataSource Object Create<=====");
	// conn = ds.getConnection();
	// stmt = conn.createStatement(1005, 1008);
	// } catch (Exception e) {
	// System.err.println("!!!!创建ERP DataSourceError: " + e.getMessage());
	// }
	// }

	private static String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";// 
	//private static String URL = "jdbc:sqlserver://192.168.112.166:1433;databasename=CulcLeasing";//
	private static String URL = "jdbc:sqlserver://localhost:1433;databasename=CulcLeasing";// 
	private static String USER = "sa";// 
	private static String PWD = "testsa";// 

	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	static {// 静态代码块执行一次
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public ERPDataSource() {
		conn = null;
		stmt = null;
		try {
			conn = DriverManager.getConnection(URL, USER, PWD);
			stmt = conn.createStatement();
			System.out.println("====>!!ERP DataSource Object open!!<=====");
		
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
public static void main(String[] args) {
	ERPDataSource s= new ERPDataSource();
	System.out.println(s.toString());
	
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
			System.out.println("====>!!ERP DataSource Object close!!<=====");
		} catch (Exception e) {
			System.err.println("ERP DataSource 关闭异常：" + e.getMessage());
		}
	}
}
