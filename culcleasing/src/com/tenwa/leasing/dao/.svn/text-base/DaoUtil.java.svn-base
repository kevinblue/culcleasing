package com.tenwa.leasing.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * dao工具类
 * 
 * @author shf
 * 
 */
public class DaoUtil {

	/**
	 * 关闭数据库连接
	 * 
	 * @param rs
	 * @param conn
	 * @throws SQLException
	 */
	public static void closeRSOrConn(ResultSet rs, Conn conn)
			throws SQLException {
		if (rs != null) {
			rs.close();
			rs = null;
		}
		if (conn != null) {
			conn.close();
			conn = null;
		}

	}

	/*
	 * 
	 * 添加用户
	 * 
	 */

	public Boolean add_Users() throws SQLException {

		// try {
		//
		// // 1.要执行的sql语句
		//
		// StringBuilder sql1 = new StringBuilder()
		// .append(
		// "insert into spring_users(U_ID,u_Name,u_Password,u_Email,u_State)")
		// .append(" values(SEQ_USERS.NEXTVAL,?,?,?,?)");
		// // 添加日志
		// StringBuilder sql2 = new StringBuilder()
		// .append(
		// "insert into SPRING_LOG(L_ID,L_NAME,U_ID,L_MESSAGE,L_DATE)")
		// .append(" values(SEQ_LOG.nextval,?,?,?,?)");
		// // 2.要设置的参数列表
		// List pars1 = new ArrayList();
		// // pars1.add(dto.get("u_Name")); // 用户名
		// // pars1.add(dto.get("u_Password")); // 用户密码
		// // pars1.add(dto.get("u_Email")); // 用户E-email
		// // pars1.add(dto.get("u_Rating"));// 权限与用户状态
		//
		// // 获取当前操作员的u_id
		// // String u_Id = (String) dto.get("u_Id");
		// // pars2 = new ArrayList();
		// // pars2.add("SPRING_USERS"); // 设置1 操作的表名
		// // pars2.add(u_Id); // 设置2 操作人id
		// // pars2.add("这是用户添加操作：用户名:" + this.dto.get("u_Name"));// 设置3
		//
		// // 描述看看是不是添加操作
		// // pars2.add(Tools.getSqlTimestamp()); // 设置4 操作时间
		// // 3.编译sql语句并设置参数
		// // pss = new ArrayList<PreparedStatement>();
		// // ps1 = this.conn.prepareStatement(sql1.toString());
		// // ps2 = this.conn.prepareStatement(sql2.toString());
		// // // 设置参数
		// // pss.add(this.setPreparedStatement(ps1, pars1));
		// // pss.add(this.setPreparedStatement(ps2, pars2));
		// //
		// // // 4.调用执行sql语句的方法
		// // returnthis.exceurePreparedStatement(pss);
		//
		// } finally {
		//
		// // // 5.释放使用资源
		// // DBUtils.close(ps1);
		// // DBUtils.close(ps2);
		//
		// }

		return true;

	}

}
