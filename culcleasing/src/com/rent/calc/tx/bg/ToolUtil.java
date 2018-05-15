package com.rent.calc.tx.bg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import dbconn.Conn;

/**
 * ������
 * 
 * @author shf
 * 
 */
public class ToolUtil {
	/**
	 * �ر����ݿ�����
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
	 * �ж�ĳ�������ǲ�����ʱ�伯����,�������򷵻������±��ʶ
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
	 * ���ݵ�Ϣ����ȡ����һ�����ڵĴ���ĵ�һ��
	 * 
	 * @param txrq
	 *            ��Ϣ����
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
	 *            ��Ҫ����������ʻ���irr֮���
	 * @param lease_interval
	 *            �����
	 * @return
	 */
	@SuppressWarnings("unused")
	public static String getPreRate(String calcRate, String lease_interval) {

		return String.valueOf(Double.parseDouble(calcRate) / 12 / 100
				* Integer.parseInt(lease_interval));
	}

	/**
	 * �õ�һ���µĵ�һ��
	 * 
	 * @return
	 */
	public static String getFirstDayByDate(String date) {
		String rdate = getDateAdd(date, 1, "mm");
		rdate = rdate.substring(0, rdate.length() - 2) + "01";
		return rdate;
	}

	/**
	 * ��ĳ�������������Ӧ�������յļ���
	 * 
	 * @param strDate
	 *            ��ʼ����
	 * @param leng
	 *            ��ӵĴ�С
	 * @param type
	 *            ����������
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
	 * �õ���������֮����·ݼ��
	 * 
	 * @param bdate
	 *            ��ʼ����
	 * @param edate
	 *            ��������
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

	public static long getDateDiff(String strbdate, String stredate) // ������ʱ��������
	// bdate--��ʼʱ���ַ���
	// edate--����ʱ���ַ���
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
