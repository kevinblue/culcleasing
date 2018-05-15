package com.tenwa.leasing.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;



/**
 * Dateʱ�䴦������
 * 
 * @author shf
 * 
 */
public class DateTools {
	/**
	 * DBʱ���ַ���ȡ������
	 * 
	 * @param datestr
	 * @return
	 */
	public static String getDBDateStr(String datestr) {
		try {
			String temp_date = datestr;
			if ((temp_date == null) || (temp_date.equals(""))
					|| (temp_date.indexOf("1900") >= 0)) {
				temp_date = "";
			} else {
				temp_date = temp_date.substring(0, 10);
			}
			return temp_date;
		} catch (Exception e) {

		}
		return "";
	}

	/**
	 * ����ϵͳʱ�� 0--����ʱ���ַ��� 1--����sqlʱ���ַ���
	 * 
	 * @param rtype
	 * @return
	 */
	public static String getSystemDate(int rtype) {
		try {
			Calendar cal = Calendar.getInstance();
			String module = "yyyy-MM-dd";
			if (rtype == 2) {
				module = "yyyyMMdd";
			}
			SimpleDateFormat formatter1 = new SimpleDateFormat(module);
			String fld_date = formatter1.format(cal.getTime());
			if (rtype == 0)
				return fld_date;
			else if (rtype == 1)
				return "'" + fld_date + "'"; // sql server
			// return "to_date("+fld_date+",'yyyy-mm-dd')"; //oracle
			else
				return fld_date;
		} catch (Exception e) {

		}
		return "null";
	}

	/**
	 * ��ԭ�е����������ֵ
	 * 
	 * @param date
	 *            ��Ҫ��ӵ�����
	 * @param leng
	 *            ��Ҫ�����
	 * @param type
	 *            ��ӵ����� �꣬�£���
	 * @return
	 */
	public static Date getDateAdd(Date date, int leng, String type) {
		Date addDate = null;
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
		return addDate;
	}

	/**
	 * ��ԭ�е����������ֵ
	 * 
	 * @param date
	 *            ��Ҫ��ӵ�����(�ַ������͵�����)
	 * @param leng
	 *            ��Ҫ�����
	 * @param type
	 *            ��ӵ����� �꣬�£���
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
	 * �õ���ʱ��ļ������
	 * 
	 * @param bdate
	 * @param edate
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

	/**
	 * ������ʱ�������� bdate--��ʼʱ���ַ��� edate--����ʱ���ַ���
	 * 
	 * @param bdate
	 * @param edate
	 * @return
	 */
	public static long getDateDiff(Date bdate, Date edate) {
		try {
			long datediff = (bdate.getTime() - edate.getTime())
					/ (1000 * 60 * 60 * 24);
			return datediff;
		} catch (Exception e) {

		}
		return 0;
	}

	/**
	 * ������ʱ�������� bdate--��ʼʱ���ַ��� edate--����ʱ���ַ���
	 * 
	 * @param strbdate
	 * @param stredate
	 * @return
	 */
	public static long getDateDiff(String strbdate, String stredate) {
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

	/**
	 * ���һ���е����һ��
	 * 
	 * @param year
	 * @param month
	 * @return
	 */
	public static String getLastDayOfMonth(String year, String month) {
		Calendar cal = Calendar.getInstance();
		// ��
		cal.set(Calendar.YEAR, Integer.parseInt(year));
		// �£���ΪCalendar������Ǵ�0��ʼ������Ҫ-1
		cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
		// �գ���Ϊһ��
		cal.set(Calendar.DATE, 1);
		// �·ݼ�һ���õ��¸��µ�һ��
		cal.add(Calendar.MONTH, 1);
		// ��һ���¼�һΪ�������һ��
		cal.add(Calendar.DATE, -1);
		return String.valueOf(cal.get(Calendar.DAY_OF_MONTH));// �����ĩ�Ǽ���

	}

	/**
	 * �����ڼ����
	 * 
	 * @param type
	 *            �꣬�£���
	 * @param b_date
	 * @param e_date
	 * @return
	 */
	public static long dateDiff(String type, String b_date, String e_date) {
		long r_turn = -1;
		String b_year = b_date.substring(0, 4);
		String e_year = e_date.substring(0, 4);
		String b_month = b_date.substring(5, 7);
		String e_month = e_date.substring(5, 7);
		if (type.equals("year")) {
			r_turn = Long.parseLong(e_year) - Long.parseLong(b_year);
		} else if (type.equals("month")) {
			r_turn = Long.parseLong(e_year) * 12 + Long.parseLong(e_month)
					- Long.parseLong(b_year) * 12 - Long.parseLong(b_month);
		} else if (type.equals("day")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date begin_date = sdf.parse(b_date);
				Date end_date = sdf.parse(e_date);
				r_turn = (end_date.getTime() - begin_date.getTime()) / 24 / 60
						/ 60 / 1000;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return r_turn;
	}

	/**
	 * ��ĳ���������ĳ���͵�������
	 * 
	 * @param type
	 * @param leng
	 * @param strDate
	 * @return
	 */
	public static String dateAdd(String type, int leng, String strDate) {
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
		if (type.equals("year")) {
			cal.add(Calendar.YEAR, leng);
		} else if (type.equals("month")) {
			cal.add(Calendar.MONTH, leng);
		} else if (type.equals("we")) {
			cal.add(Calendar.WEEK_OF_YEAR, leng);
		} else if (type.equals("day")) {
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
	 * ����һ�����ڵ���һ��ĵ�һ��
	 * 
	 * @Title: getYearFirstDate
	 * @Description:
	 * @param
	 * @param txrq
	 * @param
	 * @return
	 * @return String
	 * @throws
	 */
	public static String getYearFirstDate(String chargeDate) {

		String rdate = getDateAdd(chargeDate, 1, "yy");
		rdate = rdate.substring(0, 4) + "-01-01";
		return rdate;

	}
	
	


}
