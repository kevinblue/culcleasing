package com.tenwa.leasing.bean;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;
import com.tenwa.leasing.util.StrTools;

/**
 * 数据库数据载体类
 * 
 * 项目名称：iulcleasing 类名称：CommBean 类描述： 创建人：史鸿飞 创建时间：2011-1-24 下午02:54:30 修改人：史鸿飞
 * 修改时间：2011-1-24 下午02:54:30 修改备注：
 * 
 * @version
 */
public class CommBean {
	/**
	 * 
	 * @Title: getSignBean
	 * @Description: 查询一条数据，并把他封装到hashTable中，前以列名成为主键，该列的值为HashTable的值
	 * @param
	 * @param sql
	 * @param
	 * @return
	 * @param
	 * @throws Exception
	 * @return Hashtable<String,String>
	 * @throws
	 */

	@SuppressWarnings("deprecation")
	public static Hashtable<String, String> getSignBean(String sql) throws Exception {

		Conn conn = new Conn();
		ResultSet rs = conn.executeQuery(sql);

		// 用于获得查询语句的列名
		ResultSetMetaData rsmd = rs.getMetaData();
		int numberOfColumns = rsmd.getColumnCount();

		BigDecimal tempdec = new BigDecimal("0.000000");
		StrTools sts = new StrTools();
		String tempStr = "";

		// 用于保存查询中的值
		Hashtable<String, String> htBean = new Hashtable<String, String>();

		if (rs.next()) {
			for (int i = 1; i <= numberOfColumns; i++) { // money,decimal类型时
				if ((rsmd.getColumnTypeName(i).equals("money"))
						|| (rsmd.getColumnTypeName(i).equals("decimal"))) {

					tempdec = rs.getBigDecimal(rsmd.getColumnName(i), 6);
					if (null == tempdec || "".equals(tempdec)
							|| "null".equals(tempdec)) {
						tempdec = new BigDecimal("0.000000");
					}
					// 赋值
					tempStr = tempdec.toString();
				} else {
					tempStr = sts.getDBStr(rs.getString(rsmd.getColumnName(i)));
				}
				htBean.put(rsmd.getColumnName(i), tempStr);
				System.out.println(rsmd.getColumnName(i));

			}
			System.out.println(htBean);
		}
		// 关闭连接
		DaoUtil.closeRSOrConn(rs, conn);

		return htBean;
	}

	/**
	 * 
	 * @Title: getListBean
	 * @Description: 查询所有的满足条件的值，并以列名成为主键，该列的值为HashTable的值 保存到list集合当中
	 * @param
	 * @param sql
	 * @param
	 * @return
	 * @param
	 * @throws Exception
	 * @return List<Hashtable<String,String>>
	 * @throws
	 */
	@SuppressWarnings("deprecation")
	public List<Hashtable<String, String>> getListBean(String sql)
			throws Exception {

		Conn conn = new Conn();
		ResultSet rs = conn.executeQuery(sql);

		// 用于获得查询语句的列名
		ResultSetMetaData rsmd = rs.getMetaData();
		int numberOfColumns = rsmd.getColumnCount();

		BigDecimal tempdec = new BigDecimal("0.000000");
		StrTools sts = new StrTools();
		String tempStr = "";

		// 用于保存查询中的值
		Hashtable<String, String> htBean = new Hashtable<String, String>();

		List<Hashtable<String, String>> list_ht = new ArrayList<Hashtable<String, String>>();
		while (rs.next()) {
			htBean = new Hashtable<String, String>();
			for (int i = 1; i <= numberOfColumns; i++) { // money,decimal类型时
				if ((rsmd.getColumnTypeName(i).equals("money"))
						|| (rsmd.getColumnTypeName(i).equals("decimal"))) {

					tempdec = rs.getBigDecimal(rsmd.getColumnName(i), 6);
					if (null == tempdec || "".equals(tempdec)
							|| "null".equals(tempdec)) {
						tempdec = new BigDecimal("0.000000");
					}
					// 赋值
					tempStr = tempdec.toString();
				} else {
					tempStr = sts.getDBStr(rs.getString(rsmd.getColumnName(i)));
				}
				htBean.put(rsmd.getColumnName(i), tempStr);
				// System.out.println(rsmd.getColumnName(i));

			}
			// System.out.println(htBean);
			list_ht.add(htBean);
		}

		// 关闭连接
		DaoUtil.closeRSOrConn(rs, conn);
		
		return list_ht;
	}

}
