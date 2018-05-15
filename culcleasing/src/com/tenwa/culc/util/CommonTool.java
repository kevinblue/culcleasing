/**
 * com.tenwa.culc.util
 */
package com.tenwa.culc.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

/**
 * 工具类
 * 
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 4:59:19 PM Email:JaffeHe@hotmail.com
 */
public class CommonTool {

	/**
	 * 判断日期大小
	 * 
	 * @param start_date
	 * @param end_date
	 * @return
	 */
	public static boolean compare_date(String start_date, String end_date) {
		boolean flag = false;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date dt1 = df.parse(start_date);
			Date dt2 = df.parse(end_date);
			if (dt1.getTime() > dt2.getTime()) {
				flag = false;
			} else if (dt1.getTime() < dt2.getTime()) {
				flag = true;
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}

		return flag;
	}

	/**
	 * 获取日期字符的指定部分数值
	 * 
	 * @param date
	 * @param type
	 * @return
	 */
	public static String datePart(String date, int type) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date dt1 = null;
		try {
			dt1 = df.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Calendar ca = Calendar.getInstance();
		ca.setTime(dt1);

		if (type == 1) {
			return String.valueOf(ca.get(Calendar.YEAR));
		} else if (type == 2) {
			return String.valueOf((ca.get(Calendar.MONTH) + 1));
		} else {
			return String.valueOf(ca.get(Calendar.DAY_OF_MONTH));
		}
	}

	/**
	 * 获取日期字符的指定部分数值
	 * 
	 * @param date
	 * @param type
	 * @return
	 */
	public static int datePart(int type, String date) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date dt1 = null;
		try {
			dt1 = df.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Calendar ca = Calendar.getInstance();
		ca.setTime(dt1);

		if (type == 1) {
			return ca.get(Calendar.YEAR);
		} else if (type == 2) {
			return (ca.get(Calendar.MONTH) + 1);
		} else {
			return ca.get(Calendar.DAY_OF_MONTH);
		}
	}

	/**
	 * 判断两个日期之间日差距
	 * 
	 * @param start_date
	 * @param end_date
	 * @param type
	 * @return
	 */
	public static int date_diff(String start_date, String end_date) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		long quot = 0;
		try {
			Date dt1 = df.parse(start_date);
			Date dt2 = df.parse(end_date);

			quot = dt2.getTime() - dt1.getTime();
			quot = quot / 1000 / 60 / 60 / 24;
		} catch (Exception exception) {
			exception.printStackTrace();
		}

		return (int) (quot * 1);
	}

	/**
	 * 除法
	 * 
	 * @return
	 */
	public double calDivisionRatio() {
		return 0;
	}

	/**
	 * 返回指定格式的当前时间
	 * 
	 * @param dateFormatStr
	 * @return
	 */
	public static String getSysDate(String dateFormatStr) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(dateFormatStr);

		String sysDate = dateFormat.format(new Date()).toString();
		return sysDate;
	}

	/**
	 * 取出唯一值
	 * 
	 * @return
	 */
	public static String getUUID() {
		return UUID.randomUUID().toString();
	}

	/**
	 * 返回补零操作
	 * 
	 * @param str
	 * @param amount
	 *            几位数
	 * @return
	 */
	public static String operOStr(String str, int amount) {
		String resStr = "";
		int strLen = str.length();
		if (strLen >= amount) {
			resStr = str;
		} else {
			for (int i = 0; i < (amount - strLen); i++) {
				str = "0" + str;
			}
			resStr = str;
		}

		return resStr;
	}

}
