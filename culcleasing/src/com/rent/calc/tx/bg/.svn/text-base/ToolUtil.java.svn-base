package com.rent.calc.tx.bg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import dbconn.Conn;

/**
 * 工具类
 * 
 * @author shf
 * 
 */
public class ToolUtil {
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

	/**
	 * 判断某个日期是不是在时间集合中,如里在则返回他的下标标识
	 * 
	 * @param date
	 * @return
	 */
	public static int isInDateList(String date, List inList) {
		for (int i = 0; i < inList.size(); i++) {
			if (date.equals(inList.get(i).toString().subSequence(0, 7))) {
				return i;
			}
		}
		return -1;
	}

	/**
	 * 根据调息日期取得下一期日期的次年的第一天
	 * 
	 * @param txrq
	 *            调息日期
	 * @return
	 */
	public static String getYearFirstDate(String txrq) {

		String rdate = getDateAdd(txrq, 1, "yy");
		rdate = rdate.substring(0, 4) + "-01-01";
		return rdate;

	}

	/**
	 * 
	 * @param calcRate
	 *            所要计算的年利率或都是irr之类的
	 * @param lease_interval
	 *            租金间隔
	 * @return
	 */
	@SuppressWarnings("unused")
	public static String getPreRate(String calcRate, String lease_interval) {

		return String.valueOf(Double.parseDouble(calcRate) / 12 / 100
				* Integer.parseInt(lease_interval));
	}

	/**
	 * 得到一个月的第一天
	 * 
	 * @return
	 */
	public static String getFirstDayByDate(String date) {
		String rdate = getDateAdd(date, 1, "mm");
		rdate = rdate.substring(0, rdate.length() - 2) + "01";
		return rdate;
	}

	/**
	 * 在某个日期上添加相应的年月日的计算
	 * 
	 * @param strDate
	 *            开始日期
	 * @param leng
	 *            添加的大小
	 * @param type
	 *            年月日类型
	 * @return
	 */
	public static String getDateAdd(String strDate, int leng, String type) {
		Date addDate = null;
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = sdf.parse(strDate);
		} catch (Exception e) {
			System.out.println(e);
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		if (type.equals("yy")) {
			cal.add(Calendar.YEAR, leng);
		} else if (type.equals("mm")) {
			cal.add(Calendar.MONTH, leng);
		} else if (type.equals("we")) {
			cal.add(Calendar.WEEK_OF_YEAR, leng);
		} else if (type.equals("dd")) {
			cal.add(Calendar.DAY_OF_YEAR, leng);
		} else if (type.equals("hh")) {
			cal.add(Calendar.HOUR_OF_DAY, leng);
		} else if (type.equals("mi")) {
			cal.add(Calendar.MINUTE, leng);
		} else if (type.equals("ss")) {

		}
		addDate = cal.getTime();
		return sdf.format(addDate);
	}

	/**
	 * 得到两个日期之间的月份间隔
	 * 
	 * @param bdate
	 *            开始日期
	 * @param edate
	 *            结束日期
	 * @return
	 */
	public static int getDateDiffMonth(String bdate, String edate) {
		try {
			String[] barray = bdate.split("-");
			String[] earray = edate.split("-");
			return (Integer.parseInt(earray[0]) - Integer.parseInt(barray[0]))
					* 12
					+ (Integer.parseInt(earray[1]) - Integer
							.parseInt(barray[1]));
		} catch (Exception e) {

		}
		return 0;
	}

	public static long getDateDiff(String strbdate, String stredate) // 返回两时间间隔天数
	// bdate--开始时间字符串
	// edate--结束时间字符串
	{
		Date bdate = null;
		Date edate = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			bdate = sdf.parse(strbdate);
			edate = sdf.parse(stredate);
			long datediff = (bdate.getTime() - edate.getTime())
					/ (1000 * 60 * 60 * 24);
			return datediff;
		} catch (Exception e) {

		}
		return 0;
	}
}
