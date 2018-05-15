package com.tenwa.leasing.dao;

import java.sql.*;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Conn {

	public Connection conn;

	private Statement stmt;

	private ResultSet rs;

	private String dataSource;

	public Conn() {
		conn = null;
		stmt = null;
		rs = null;
		dataSource = "java:comp/env/jdbc/iulcleasing";
		// dataSource = "jdbc/iulcleasing1";
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup(dataSource);
			conn = ds.getConnection();
			stmt = conn.createStatement(1005, 1008);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public ResultSet executeQuery(String sql) throws Exception {
		return stmt.executeQuery(sql);
	}

	public int executeUpdate(String sql) throws Exception {
		return stmt.executeUpdate(sql);
	}

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

	/**
	 * 给PreparedStatement对象设置参数的方法
	 * 
	 * @Title: setPreparedStatement
	 * @Description:
	 * @param
	 * @param ps
	 * @param
	 * @param pars
	 * @param
	 * @return
	 * @param
	 * @throws SQLException
	 * @return PreparedStatement
	 * @throws
	 */

	@SuppressWarnings("unused")
	public PreparedStatement setPreparedStatement(PreparedStatement ps,
			List pars) throws SQLException {

		try {
			// 1.获取数组的长度这样能提高一点性能
			int x = pars.size();
			// 2.循环设置ps中需要的参数
			for (int i = 0; i < x; i++) {
				ps.setObject(i + 1, pars.get(i));
				System.out.println(pars.get(i));
			}

			// 3.添加到缓冲区中
			ps.addBatch();
			// 4.设置完参数的ps返回
			return ps;

		} finally {

		}

	}

	/**
	 * 执行PreparedStatement泛型列表的方法
	 * 
	 * @Title: exceurePreparedStatement
	 * @Description:
	 * @param
	 * @param pss
	 * @param
	 * @return
	 * @param
	 * @throws SQLException
	 * @return privateboolean
	 * @throws
	 */

	@SuppressWarnings("unused")
	public boolean exceurePreparedStatement(List<PreparedStatement> pss)
			throws SQLException {
		int x = 0;
		try {

			// 1.为手动提交
			conn.setAutoCommit(false);
			// 2.执行所有的PreparedStatement对象
			x = pss.size();
			for (int i = 0; i < x; i++) {
				pss.get(i).executeBatch();
			}
			// 3.没有错误的话的就提交事务
			conn.commit();
			System.out.println("执行executeBatch()");
			// 4.如果提交成功那就返回成功true
			return true;

		} catch (Exception e) {
			// 出现异常回滚事务
			e.printStackTrace();
			System.out.println("执行批量时error");
			conn.rollback();
			// 个性化异常
			throw new SQLException("page.error.1000", "1000 数据执行的批量出错.");

		} finally {

			// 最后把手动提交改为自动提交
			conn.setAutoCommit(true);
			// 关闭不用的资源
			for (int i = 0; i < x; i++) {
				// DBUtils.close(pss.get(i));
				if (pss.get(i) != null) {
					pss.get(i).close();
				}
			}

		}

	}

	/**
	 * 重构，单一执行某个语句时
	 * 
	 * @Title: exceurePreparedStatement
	 * @Description:
	 * @param
	 * @param pss
	 * @param
	 * @return
	 * @param
	 * @throws SQLException
	 * @return boolean
	 * @throws
	 */
	public boolean exceurePreparedStatement(PreparedStatement pss)
			throws SQLException {
		int x = 0;
		try {

			// 1.为手动提交
			conn.setAutoCommit(false);
			// 2.执行所有的PreparedStatement对象
			pss.executeBatch();

			// 3.没有错误的话的就提交事务
			conn.commit();
			System.out.println("执行executeBatch()");
			// 4.如果提交成功那就返回成功true
			return true;

		} catch (Exception e) {
			// 出现异常回滚事务
			e.printStackTrace();
			System.out.println("执行批量时error");
			conn.rollback();
			// 个性化异常
			throw new SQLException("page.error.1000", "1000 数据执行的批量出错.");

		} finally {

			// 最后把手动提交改为自动提交
			conn.setAutoCommit(true);
			// 关闭不用的资源
			for (int i = 0; i < x; i++) {
				// DBUtils.close(pss.get(i));
				if (pss != null) {
					pss.close();
				}
			}

		}

	}

}
