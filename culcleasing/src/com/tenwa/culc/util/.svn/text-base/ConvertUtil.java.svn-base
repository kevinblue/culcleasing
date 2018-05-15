/**
 * 
 */
package com.tenwa.culc.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Jaffe
 * 
 * Nov 26, 2010 email:JaffeHe@hotmail.com
 */
public class ConvertUtil {
	private static final String FINANCE_INT_PATTERN = "#,###";

	/**
	 * 负号转换
	 * 
	 * @param strVal
	 * @return
	 */
	public static String parseInverseNumber(String strVal) {
		BigDecimal b1 = new BigDecimal(strVal);
		BigDecimal b2 = new BigDecimal("-1");
		b1 = b1.multiply(b2);

		return b1.toString();
	}

	/**
	 * 将字符串转化为int
	 * 
	 * @param strVal
	 * @param defaultInt
	 *            默认值
	 * @return
	 */
	public static int parseInt(String strVal, int defaultInt) {
		int reVal = 0;

		try {
			reVal = Integer.parseInt(strVal);
		} catch (NumberFormatException e) {
			reVal = defaultInt;
		}

		return reVal;
	}

	/**
	 * 计算押金
	 * 
	 * @param rentAmount
	 * @param maintAmount
	 * @param rent
	 * @param amint
	 * @return
	 */
	public static String calcCashPledge(String rentAmount, String maintAmount,
			String rent, String amint) {

		BigDecimal b1 = new BigDecimal(rentAmount);
		BigDecimal b2 = new BigDecimal(maintAmount);
		BigDecimal b3 = new BigDecimal(rent);
		BigDecimal b4 = new BigDecimal(amint);

		double b5 = b1.multiply(b3).doubleValue();
		double b6 = b2.multiply(b4).doubleValue();

		return String.valueOf(b5 + b6);
	}

	/**
	 * 数据库的Null字符串处理
	 * 
	 * @param str1
	 * @return
	 */
	public static String getDBStr(String str1) // DB字符串取出处理
	{
		try {
			String temp_n = str1.trim();
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

	public static String getDBMoneyStr(String str1) {
		try {
			String temp_n = str1.trim();
			if ((temp_n == null) || (temp_n.equals(""))
					|| (temp_n.equals("null"))) {
				temp_n = "0";
			} else {
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "0";
	}

	/**
	 * 获取数据库日期 对Null处理
	 * 
	 * @param datestr
	 * @return
	 */
	public static String getDBDateStr(String datestr) // DB时间字符串取出处理
	{
		try {
			String temp_date = datestr;
			if ((temp_date == null) || (temp_date.equals(""))) {
				temp_date = "1900-01-01";
			} else {
				temp_date = parseDatetime(temp_date);
				temp_date = temp_date.substring(0, 10);
			}
			return temp_date;
		} catch (Exception e) {

		}
		return "1900-01-01";
	}

	/**
	 * 获取数据库日期 对Null处理
	 * 
	 * @param datestr
	 * @return
	 */
	public static String getDBDateTimeStr(String datestr) // DB时间字符串取出处理,TimeStmp格式
	{
		try {
			String temp_date = datestr;
			if ((temp_date == null) || (temp_date.equals(""))) {
				temp_date = "1900-01-01 00:00:00";
			} else {
				temp_date = parseDatetime(temp_date);
			}
			return temp_date;
		} catch (Exception e) {

		}
		return "1900-01-01 00:00:00";
	}

	/**
	 * 将日期字符串转化为指定格式
	 * 
	 * @param strVal
	 * @return
	 */
	public static String parseDatetime(String strVal) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");

		try {
			if (strVal != null && !"".equals(strVal)) {
				if (strVal.indexOf(":") < 0) {
					strVal = strVal + " 00:00:00";
				}
				return dateFormat.format(dateFormat.parse(strVal));
			} else {
				return dateFormat.format(new Date()).toString();
			}
		} catch (ParseException e) {
			return dateFormat.format(new Date()).toString();
		}
	}

	/**
	 * 整数型转换
	 * 
	 * @param amount
	 * @return
	 */
	public static final String getDBInt(String amount) {
		if (amount == null || "".equals(amount)) {
			amount = "0";
		}
		return getFormat(FINANCE_INT_PATTERN)
				.format(Double.parseDouble(amount));
	}

	public static final String convertIntAmount(String amount) {
		if (amount == null || "".equals(amount)) {
			amount = "0";
		}
		return getFormat(FINANCE_INT_PATTERN)
				.format(Double.parseDouble(amount));
	}

	public static final String convertIntAmount(double amount) {
		return getFormat(FINANCE_INT_PATTERN).format(amount);
	}

	private static DecimalFormat getFormat(String pattern) {
		return new DecimalFormat(pattern);
	}

	/**
	 * 长度转化
	 * 
	 * @param chargeYearly
	 * @param i
	 * @return
	 */
	public static String parseNumber(String chargeYearly, int i) {
		if ("".equals(chargeYearly) || chargeYearly == null) {
			return "0";
		} else {
			if (chargeYearly.indexOf(".") < 0) {
				return chargeYearly;
			} else if (chargeYearly.indexOf(".") + 1 + i > chargeYearly
					.length()) {
				return chargeYearly;
			} else {
				return chargeYearly.substring(0, chargeYearly.indexOf(".") + 1
						+ i);
			}
		}

	}
}
