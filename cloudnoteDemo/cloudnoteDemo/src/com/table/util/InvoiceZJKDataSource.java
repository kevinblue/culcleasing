/**
 * com.tenwa.datasync.util
 */
package com.table.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * @author Jaffe
 * 
 *         Date:Mar 15, 2012 4:00:02 PM Email:JaffeHe@hotmail.com
 */
public class InvoiceZJKDataSource {

	// ����
	/*
	 * private Connection conn; private Statement stmt; private ResultSet rs;
	 * private String dataSource;
	 */

	/**
	 * ��ȡ����
	 */
	/*
	 * public ERPDataSource() { conn = null; stmt = null; rs = null; dataSource
	 * = "jdbc/culcleasing"; try { Context ctx = new InitialContext();
	 * DataSource ds = (DataSource) ctx.lookup(dataSource);
	 * System.out.println("====>ERP DataSource Object Create<====="); conn =
	 * ds.getConnection(); stmt = conn.createStatement(1005, 1008); } catch
	 * (Exception e) { System.err.println("!!!!����ERP DataSourceError: " +
	 * e.getMessage()); } }
	 */
	private static String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";// 
	//private static String URL = "jdbc:sqlserver://10.122.2.52:1433;databasename=openinvoice";// 
	//private static String URL = "jdbc:sqlserver://10.122.1.3:1433;databasename=openinvoice";// 
	///private static String URL = "jdbc:sqlserver://10.122.1.3:1433;databasename=openinvoiceTj";//
	private static String URL = "jdbc:sqlserver://localhost:1433;databasename=CulcLeasing";// 
//	private static String URL = "jdbc:sqlserver://10.122.2.52:1433;databasename=CulcLeasingTJ";// 
	private static String USER = "sa";// 
	private static String PWD = "testsa";//
	//private static String PWD = "testsa";// 
	//private static String PWD = "testsa";
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private PreparedStatement inspstmt = null;
	static {// ��̬�����ִ��һ��
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public InvoiceZJKDataSource() {
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

	/**
	 * ִ�в�ѯ
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public ResultSet executeQuery(String sql) throws SQLException {
		return stmt.executeQuery(sql);
	}

	/**
	 * ִ���޸�
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public int executeUpdate(String sql) throws SQLException {
		return stmt.executeUpdate(sql);
	}

	/**
	 * �ر���Դ
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
			System.err.println("ERP DataSource �ر��쳣��" + e.getMessage());
		}
	}

	
}
