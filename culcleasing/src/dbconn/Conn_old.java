package dbconn;

import java.io.PrintStream;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Conn_old {

	public Conn_old() {
		conn = null;
		stmt = null;
		rs = null;
		dataSource = "java:comp/env/jdbc/culcleasing";
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

	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	private String dataSource;

}
