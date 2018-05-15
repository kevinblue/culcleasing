package com.tenwa.leasing.test;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class TConnection {

	private Statement stmt;

	public Connection conn = null;

	public TConnection() {
		if (conn == null) {
			conn = getConn();
		}

	}

	private Connection getConn() {
		Connection con = null;
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection(
					"jdbc:jtds:sqlserver://localhost:1433/master", "sa",
					"111111");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}

	public ResultSet executeQuery(String sql) throws Exception {
		return stmt.executeQuery(sql);
	}

	public int executeUpdate(String sql) throws Exception {
		return stmt.executeUpdate(sql);
	}

	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws SQLException {
		TConnection tc = new TConnection();

		Statement st = tc.conn.createStatement();

//		ResultSet rs = st
//		.executeQuery("SELECT  * FROM contract_condition ");
		ResultSet rs = st
		.executeQuery("select * from dbo.spt_monitor ");
		if (rs.next()) {
			System.out.println(rs.getString(1));
			
		}
//		ResultSetMetaData rsmd = rs.getMetaData();
//		int numberOfColumns = rsmd.getColumnCount();
//
//		BigDecimal tempdec = new BigDecimal("0.000000");
//		String tempStr = "";
//		Hashtable<String, String> htBean = new Hashtable<String, String>();
//		List<Hashtable<String, String>> list_ht = new ArrayList<Hashtable<String, String>>();
//		while (rs.next()) {
//			htBean = new Hashtable<String, String>();
//			for (int i = 1; i <= numberOfColumns; i++) { // money,decimal类型时
//				if ((rsmd.getColumnTypeName(i).equals("money"))
//						|| (rsmd.getColumnTypeName(i).equals("decimal"))) {
//
//					tempdec = rs.getBigDecimal(rsmd.getColumnName(i), 6);
//					if (null == tempdec || "".equals(tempdec)
//							|| "null".equals(tempdec)) {
//						tempdec = new BigDecimal("0.000000");
//					}
//					// 赋值
//					tempStr = tempdec.toString();
//				} else {
//					tempStr = tc.getDBStr(rs.getString(rsmd.getColumnName(i)));
//				}
//				htBean.put(rsmd.getColumnName(i), tempStr);
//				//System.out.println(rsmd.getColumnName(i));
//
//			}
//			//System.out.println(htBean);
//			list_ht.add(htBean);
//		}
//		System.out.println(list_ht.size());
	}

	public String getZeroStr(String value) {
		try {
			String temp_n = value;
			if (temp_n == null || temp_n.equals("") || temp_n.equals("null")) {
				temp_n = "0";
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "0";
	}

	public String getDBStr(String str1) // DB字符串取出处理
	{
		try {
			String temp_n = str1;
			if ((temp_n == null) || (temp_n.equals(""))
					|| (temp_n.equals("null"))) {
				temp_n = "";
			} else {
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "";
	}
}
