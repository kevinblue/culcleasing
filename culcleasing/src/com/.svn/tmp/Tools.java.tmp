package com;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import dbconn.Conn;

public class Tools {

	public static String getStr(String str) // request字符串中文处理
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

	public static String getSystemDate(int rtype) // 返回系统时间 0--返回时间字符串
	// 1--返回sql时间字符串
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

	public static String getDBStr(String str1) // DB字符串取出处理
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

	public static String getDBDateStr(String datestr) // DB时间字符串取出处理
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

	public static BigDecimal getDBDecStr(BigDecimal decstr) // DB数字Decimal字符串取出处理
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

	public static void handSt(String contract_id, String doc_id)
			throws Exception {
		Conn db = new Conn();
		ResultSet rs = null;
		String sqlstr = "";
		String start_list = "";
		List l_interest = new ArrayList();
		List l_st = new ArrayList();
		if (doc_id.equals("")) {
			sqlstr = "select min(rent_list) as rent_list from fund_rent_plan where contract_id='"
					+ contract_id
					+ "' and plan_status='未回笼' order by rent_list";
			rs = db.executeQuery(sqlstr);
			while (rs.next()) {
				start_list = getDBStr(rs.getString("rent_list"));
			}
			rs.close();
			sqlstr = "select * from fund_rent_plan where contract_id='"
					+ contract_id
					+ "' and plan_status='未回笼' order by rent_list";
			rs = db.executeQuery(sqlstr);
			while (rs.next()) {
				l_interest.add(getDBStr(rs.getString("interest")));
			}
			rs.close();
			l_st = getStInterest(l_interest);
			for (int i = 0; i < l_st.size(); i++) {
				sqlstr = "update fund_rent_plan set straight_interest="
						+ l_st.get(i) + " where contract_id='" + contract_id
						+ "' and rent_list="
						+ (Integer.parseInt(start_list) + i);
				db.executeUpdate(sqlstr);
			}
			db.close();
		} else {
			sqlstr = "select min(rent_list) as rent_list from fund_rent_plan_temp where contract_id='"
					+ contract_id
					+ "' and measure_id='"
					+ doc_id
					+ "' and plan_status='未回笼' order by rent_list";
			rs = db.executeQuery(sqlstr);
			while (rs.next()) {
				start_list = getDBStr(rs.getString("rent_list"));
			}
			rs.close();
			sqlstr = "select * from fund_rent_plan_temp where contract_id='"
					+ contract_id + "' and measure_id='" + doc_id
					+ "' and plan_status='未回笼' order by rent_list";
			rs = db.executeQuery(sqlstr);
			while (rs.next()) {
				l_interest.add(getDBStr(rs.getString("interest")));
			}
			rs.close();
			l_st = getStInterest(l_interest);
			for (int i = 0; i < l_st.size(); i++) {
				sqlstr = "update fund_rent_plan_temp set straight_interest="
						+ l_st.get(i) + " where contract_id='" + contract_id
						+ "' and measure_id='" + doc_id + "' and rent_list="
						+ (Integer.parseInt(start_list) + i);
				db.executeUpdate(sqlstr);
			}
			db.close();
		}
	}

	/**
	 * 
	 * @param str
	 *            要处理的数值
	 * @param num
	 *            精确到小数点后位数
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
	 *            要处理的数值,字符串形式
	 * @param num
	 *            精确到小数点后位数的百分比形式
	 * @return
	 */
	public static String formatStringRate(String flagstr, String str, int num) {
		if(isDouble(str)){	
			if(flagstr.contains("比")||flagstr.contains("率")){
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
	//判断数字字符串是否是浮点数
	public static boolean isDouble(String str) {  
	    if (null == str || "".equals(str)) {  
	        return false;  
	    }  
	    Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");  
	    return pattern.matcher(str).matches();  
	}  
	
	
	public static String getLastDayOfMonth(String year, String month) {
		  Calendar cal = Calendar.getInstance();
		  //年
		  cal.set(Calendar.YEAR, Integer.parseInt(year));
		  //月，因为Calendar里的月是从0开始，所以要-1
		  cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
		  //日，设为一号
		  cal.set(Calendar.DATE, 1);
		  //月份加一，得到下个月的一号
		  cal.add(Calendar.MONTH,1);
		  //下一个月减一为本月最后一天
		  cal.add(Calendar.DATE, -1);
		  return String.valueOf(cal.get(Calendar.DAY_OF_MONTH));//获得月末是几号

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
