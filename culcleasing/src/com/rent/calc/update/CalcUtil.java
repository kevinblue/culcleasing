package com.rent.calc.update;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * �����㹤�߸�����
 * 
 * @author Administrator
 * 
 */
public class CalcUtil {
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
	 * ���·���һ���ڴ��ַ
	 * 
	 * @param l_info
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getNewList(List l_info) {
		List l_new = new ArrayList();
		for (int i = 0; i < l_info.size(); i++) {
			l_new.add(l_info.get(i));
		}
		return l_new;

	}

}
