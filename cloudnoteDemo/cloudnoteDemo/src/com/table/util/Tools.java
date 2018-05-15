package com.table.util;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;


public class Tools {

	public static String getStr(String str) // request�ַ������Ĵ���
	{
		try {
			String temp_p = str;
			byte[] temp_t = temp_p.getBytes("ISO8859-1");
			String temp = new String(temp_t);
			return temp;
		} catch (Exception e) {

		}
		return "";
	}

	public static String getSystemDate(int rtype) // ����ϵͳʱ�� 0--����ʱ���ַ���
	// 1--����sqlʱ���ַ���
	{
		try {
			Calendar cal = Calendar.getInstance();
			String module = "yyyy-MM-dd";
			if (rtype == 2) {
				module = "yyyyMMdd";
			}
			if (rtype == 3) {
				module = "yyyyMMddHHmmss";
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

	public static String getDBStr(String str1) // DB�ַ���ȡ������
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

	public static String getDBDateStr(String datestr) // DBʱ���ַ���ȡ������
	{
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

	public static BigDecimal getDBDecStr(BigDecimal decstr) // DB����Decimal�ַ���ȡ������
	{
		try {
			BigDecimal temp_dec = decstr;
			if (temp_dec == null) {
				temp_dec = new BigDecimal("0.00");
			} else {
				temp_dec = decstr;
			}
			return temp_dec;
		} catch (Exception e) {

		}
		return new BigDecimal("0.00");
	}

	public static String formatNumberDoubleTwo(String str) {
		try {
			String temp_num = str;
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				temp_num = new BigDecimal(temp_num).setScale(2,
						BigDecimal.ROUND_HALF_UP).toString();

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

	public static String formatNumberDoubleFour(String str) {
		try {
			String temp_num = str;
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				temp_num = new BigDecimal(temp_num).setScale(4,
						BigDecimal.ROUND_HALF_UP).toString();

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

	public static String formatNumberDoubleSix(String str) {
		try {
			String temp_num = str;
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				temp_num = new BigDecimal(temp_num).setScale(6,
						BigDecimal.ROUND_HALF_UP).toString();

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

	public static String formatNumberDoubleZero(String str) {
		try {
			String temp_num = str;
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				temp_num = new BigDecimal(temp_num).setScale(0,
						BigDecimal.ROUND_HALF_UP).toString();

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

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

	public static String getSumList(List list1) {
		String r_turn = "0";
		for (int i = 0; i < list1.size(); i++) {
			String tmp = (String) list1.get(i);
			if (null == tmp || tmp.equals("")) {
				tmp = "0";
			}
			r_turn = String.valueOf(Double.parseDouble(r_turn)
					+ Double.parseDouble(tmp));
		}
		return r_turn;
	}

	public static String smsReplace(String message) {
		return message.replaceAll("722", "7 22").replaceAll("7.22", "7. 22")
				.replaceAll("64", "6 4").replaceAll("6.4", "6. 4").replaceAll(
						"425", "4 25").replaceAll("4.25", "4. 25").replaceAll(
						"130", "1 30").replaceAll("133", "1 33");
	}

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

	public static List getStInterest(List l_interest) {
		List l_straight_interest = new ArrayList();
		String sum_interest = getSumList(l_interest);
		String per_interest = formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(sum_interest)
				/ l_interest.size()));
		String last_interest = formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(sum_interest)
				- Double.parseDouble(per_interest) * (l_interest.size() - 1)));
		for (int i = 0; i < l_interest.size() - 1; i++) {
			l_straight_interest.add(per_interest);
		}
		l_straight_interest.add(last_interest);
		return l_straight_interest;
	}

	

	/**
	 * 
	 * @param str
	 *            Ҫ�������ֵ
	 * @param num
	 *            ��ȷ��С�����λ��
	 * @return
	 */
	public static String formatNumberDoubleScale(String str, int num) {
		try {
			String temp_num = str;
			if ((temp_num == null) || (temp_num.equals(""))||"null".equals(temp_num)) {
				temp_num = "";
			} else {
				temp_num = new BigDecimal(temp_num).setScale(num,
						BigDecimal.ROUND_HALF_UP).toString();

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}
	
	/**
	 * 
	 * @param str
	 *            Ҫ�������ֵ,�ַ�����ʽ
	 * @param num
	 *            ��ȷ��С�����λ���İٷֱ���ʽ
	 * @return
	 */
	public static String formatStringRate(String flagstr, String str, int num) {
		if(isDouble(str)){	
			if(flagstr.contains("��")||flagstr.contains("��")){
				try {
					String temp_num = str;
					if ((temp_num == null) || (temp_num.equals(""))||"null".equals(temp_num)) {
						temp_num = "";
					} else {
						temp_num = new BigDecimal(temp_num).multiply(new BigDecimal("100")).setScale(num,
								BigDecimal.ROUND_HALF_UP).toString()+"%";
	
					}
					return temp_num;
				} catch (Exception e) {
				}
				return "";
			}else{
				return formatNumberDoubleScale(str,num);
			}
		}else{
			return str;
		}
	}
	//�ж������ַ����Ƿ��Ǹ�����
	public static boolean isDouble(String str) {  
	    if (null == str || "".equals(str)) {  
	        return false;  
	    }  
	    Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");  
	    return pattern.matcher(str).matches();  
	}  
	
	
	public static String getLastDayOfMonth(String year, String month) {
		  Calendar cal = Calendar.getInstance();
		  //��
		  cal.set(Calendar.YEAR, Integer.parseInt(year));
		  //�£���ΪCalendar������Ǵ�0��ʼ������Ҫ-1
		  cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
		  //�գ���Ϊһ��
		  cal.set(Calendar.DATE, 1);
		  //�·ݼ�һ���õ��¸��µ�һ��
		  cal.add(Calendar.MONTH,1);
		  //��һ���¼�һΪ�������һ��
		  cal.add(Calendar.DATE, -1);
		  return String.valueOf(cal.get(Calendar.DAY_OF_MONTH));//�����ĩ�Ǽ���

		 }


	

	public static void main(String[] args) {
		String st = "2009-1-29";
		//System.out.println(Tools.dateAdd("day", 1, st));
		//System.out.println(Tools.dateAdd("month", 1, st));
		//System.out.println(Tools.dateAdd("year", 1, st));
		System.out.println(st.substring(0,st.lastIndexOf("-")+1));
		System.out.println(st.substring(0,st.indexOf("-")));
		System.out.println(st.substring(st.indexOf("-")+1,st.lastIndexOf("-")));
		
		System.out.println(Tools.dateAdd("month", 1, st));
		
		System.out.println(Tools.formatNumberDoubleTwo("11111111111111"));
		
		
		System.out.println(getLastDayOfMonth("2009","8")+"=="+st.substring(st.lastIndexOf("-")+1, st.length()));
	}
}
