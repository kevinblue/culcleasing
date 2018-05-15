package com.tenwa.util;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * 连接对象
 * @author JavaJeffe
 *
 * date ---- 12:49:28 PM
 */
public class DBManager {
	private String dataSource = null;
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	public DBManager() {//初始化连接对象
		
	}

	/**
	 * @return the conn
	 */
	public Connection getConn() {
		return conn;
	}

	/**
	 * @param conn the conn to set
	 */
	public void setConn(Connection conn) {
		this.conn = conn;
	}

	/**
	 * @return the stmt
	 */
	public Statement getStmt() {
		return stmt;
	}

	/**
	 * @param stmt the stmt to set
	 */
	public void setStmt(Statement stmt) {
		this.stmt = stmt;
	}

	/**
	 * 执行更新
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public int executeUpdate(String sql) throws Exception {
		return stmt.executeUpdate(sql);
	}
	
	/**
	 * 执行查询
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public ResultSet executeQuery(String sql) throws Exception {
		return stmt.executeQuery(sql);
	}

	/**
	 * 开启事务
	 * @param conn
	 */
	public void beginTran(Connection conn) {
		try {
			if (conn != null) {
				conn.setAutoCommit(false);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 开始work
	 * 
	 * @param conn
	 */
	public void startWork(){
		conn = null;
		dataSource = "java:comp/env/jdbc/stleasing";
		// dataSource = "jdbc/stleasing";
		try {
			Context ctx = new InitialContext();
			System.out.println("=ctx=="+ctx);
			DataSource ds = (DataSource) ctx.lookup(dataSource);
			System.out.println("=ds=="+ds);
			conn = ds.getConnection();
			System.out.println("=conn=="+conn);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}
	
	public void createStmt() throws SQLException{
		stmt = conn.createStatement();
	}

	/**
	 * 事务回滚
	 * @param conn
	 */
	public void rollback(Connection conn) {
		try {
			if (conn != null) {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 事务提交
	 * @param conn
	 */
	public void commit(Connection conn) {
		try {
			if (conn != null) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 释放资源
	 */
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
