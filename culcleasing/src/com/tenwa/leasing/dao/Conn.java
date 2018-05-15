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
	 * ��PreparedStatement�������ò����ķ���
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
			// 1.��ȡ����ĳ������������һ������
			int x = pars.size();
			// 2.ѭ������ps����Ҫ�Ĳ���
			for (int i = 0; i < x; i++) {
				ps.setObject(i + 1, pars.get(i));
				System.out.println(pars.get(i));
			}

			// 3.��ӵ���������
			ps.addBatch();
			// 4.�����������ps����
			return ps;

		} finally {

		}

	}

	/**
	 * ִ��PreparedStatement�����б�ķ���
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

			// 1.Ϊ�ֶ��ύ
			conn.setAutoCommit(false);
			// 2.ִ�����е�PreparedStatement����
			x = pss.size();
			for (int i = 0; i < x; i++) {
				pss.get(i).executeBatch();
			}
			// 3.û�д���Ļ��ľ��ύ����
			conn.commit();
			System.out.println("ִ��executeBatch()");
			// 4.����ύ�ɹ��Ǿͷ��سɹ�true
			return true;

		} catch (Exception e) {
			// �����쳣�ع�����
			e.printStackTrace();
			System.out.println("ִ������ʱerror");
			conn.rollback();
			// ���Ի��쳣
			throw new SQLException("page.error.1000", "1000 ����ִ�е���������.");

		} finally {

			// �����ֶ��ύ��Ϊ�Զ��ύ
			conn.setAutoCommit(true);
			// �رղ��õ���Դ
			for (int i = 0; i < x; i++) {
				// DBUtils.close(pss.get(i));
				if (pss.get(i) != null) {
					pss.get(i).close();
				}
			}

		}

	}

	/**
	 * �ع�����һִ��ĳ�����ʱ
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

			// 1.Ϊ�ֶ��ύ
			conn.setAutoCommit(false);
			// 2.ִ�����е�PreparedStatement����
			pss.executeBatch();

			// 3.û�д���Ļ��ľ��ύ����
			conn.commit();
			System.out.println("ִ��executeBatch()");
			// 4.����ύ�ɹ��Ǿͷ��سɹ�true
			return true;

		} catch (Exception e) {
			// �����쳣�ع�����
			e.printStackTrace();
			System.out.println("ִ������ʱerror");
			conn.rollback();
			// ���Ի��쳣
			throw new SQLException("page.error.1000", "1000 ����ִ�е���������.");

		} finally {

			// �����ֶ��ύ��Ϊ�Զ��ύ
			conn.setAutoCommit(true);
			// �رղ��õ���Դ
			for (int i = 0; i < x; i++) {
				// DBUtils.close(pss.get(i));
				if (pss != null) {
					pss.close();
				}
			}

		}

	}

}
