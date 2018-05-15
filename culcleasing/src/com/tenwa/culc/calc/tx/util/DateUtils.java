package com.tenwa.culc.calc.tx.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import org.apache.log4j.Logger;

import com.tenwa.culc.util.ERPDataSource;

import common.Assert;

/**
 * 
 * <p>Dateʱ�䴦�����ࡣ</p>
 * @author sea
 * @version 2.0
 * <p>2012-6-4</p>
 */
public class DateUtils {

	/**
	 * log4��־
	 */
	private static Logger logger = Logger.getLogger(DateUtils.class);

	/**
	 * Ĭ�����ڸ�ʽ
	 */
	private static SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");

	/**
	 * Ĭ������ʱ���ʽ
	 */
	private static SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHHmm");

	/**
	 * 
	 * <p>���ص�ǰ���ڡ�</p>
	 * @author sea
	 * @return Date
	 */
	public static Date getCurrentDate() {
		return new Date();

	}
	/**
	 * <p>���ص�ǰ���ڡ�</p>
	 * @author sea
	 * @param date
	 * @return String
	 */
	public static String getNullDate(String date) {
		String tempDate = date;
		if (date == null || "".equals(date)) {
			tempDate = getSystemDate(0);
		}
		return tempDate;
	}

	  /**
	   * <p>ת������Ϊָ����ʽ���ַ�����</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date ����
	   * @param stringformat �ַ�����ʽ����ʾ����ת�����ַ����ĸ�ʽ�����磨YYYY-MM-DD,YYYY/MM/DD��
	   * @return String 
	   */
	  public static String date2String(Date date, String stringformat) {
		//����  
	    //Assert.notNull(date);//�� object ��Ϊ null ʱ�׳��쳣��notNull(Object object, String message) ����������ͨ�� message �����쳣��Ϣ���� notNull() �������Թ����෴�ķ����� isNull(Object object)/isNull(Object object, String message)����Ҫ�����һ���� null��
	    //Assert.hasText(stringformat);//text ����Ϊ null �ұ������ٰ���һ���ǿո���ַ��������׳��쳣��
	    SimpleDateFormat df = new SimpleDateFormat(stringformat);
	    return df.format(date);
	  }
	  
	  /**
	   * <p>��ʽ���ַ������ڡ�</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date String
	   * @return String  YYYY-MM-DD
	   */
	  public static String date2Str(String date) {
	    if (date == null) {
	      return "";
	    }
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    try {
			date = sdf.format( sdf.parse(date) );
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
	    return date;
	  }
	  
	  /**
	   * <p>ת������Ϊ�ַ�����</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date
	   * @return Object  YYYY-MM-DD HH:mm:ss
	   */
	  public static String date2String(Date date) {
		  if (date == null) {
			  return "";
		  }
		  String format = "yyyy-MM-dd HH:mm:ss";
		  return date2String(date, format);
	  }
	  public static int getBetweenMonths(String bdate, String edate,String format)throws Exception {
		  SimpleDateFormat sdf = new SimpleDateFormat(format);
		  return getBetweenMonths(sdf.parse(bdate),sdf.parse(edate));
	  }
	  public static boolean isValidDate(String s){
			try{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sdf.parse( s);
				return true;
			}catch(Exception e){
				return false;
			}
		}
	  /**
	   * <p>ת������Ϊ�ַ���������ʱ���롣</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date
	   * @return Object
	   */
	  public static String dateToString(Date date) {
	    if (date == null) {
	      return "";
	    }
	    String format = "yyyy-MM-dd";
	    return date2String(date, format);
	  }
	  
	  /**
	   * <p>ת���ַ�������Ϊ�������͡�</p>
	   * <pre>��ʽΪyyyyMMdd</pre>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param string �����ַ���
	   * @return Date ���ڣ��ַ���ת���������
	   * @throws ParseException
	   */
	  public static Date toDate(String string) throws ParseException {
	    //Assert.notNull(string);
	    Date cDate = null;
	    df.setLenient(true);
	    cDate = df.parse(string);
	    return cDate;
	  }
	  
	  /**
	   * <p>ת���ַ�������Ϊ����ʱ�����͡�</p>
	   * <pre>��ʽΪyyyyMMddHHmm</pre>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param string ����ʱ���ַ���
	   * @return Date ���ڣ��ַ���ת���������ʱ��
	   * @throws ParseException
	   */
	  public static Date toTime(String string) throws ParseException {
	    //Assert.notNull(string);
	    Date cDate = null;
	    timeFormat.setLenient(true);
	    cDate = timeFormat.parse(string);
	    return cDate;
	  }
	  
	  /**
	   * <p>�����ڶ����ʽ��Ϊָ��format�����ڶ���</p>
	   * <pre>�����ʽ�а���Сʱ�����ӡ��롢���룬��ʽ���Date�����и���ֵ��Ϊ0</pre>
	   * <p>2007-8-31</p>
	   * @author sea
	   * @since 1.1
	   * @param date
	   * @param formatString
	   * @return Date
	   * @throws ParseException
	   */
	  public static Date format(Date date, String formatString)
	      throws ParseException {
	    String ds = date2String(date, formatString);
	    return toDate(formatString, ds);
	  }
	  /**
	   * <p>��ȡָ�����ڵ��յ�һ������ڡ�</p>
	   * <pre>��:2007-8-11�գ����ص�Ϊ2007-8-11 00:00:00</pre>
	   * <p>2007-8-31</p>
	   * @author sea
	   * @since 1.1
	   * @param date
	   * @return Date
	   */
	  public static Date getFirstSecondDate(Date date) {
	    Date retDate = null;
	    try {
	      retDate = format(date, "yyyy-MM-dd 00:00:00");
	    }
	    catch (ParseException e) {
	      e.printStackTrace();
	    }
	    return retDate;
	  }

	  /**
	   * <p>��ȡָ�����ڵ������һ������ڡ�</p>
	   * <pre>��:2007-8-11�գ����ص�Ϊ2007-8-11 23:59:59</pre>
	   * <p>2007-8-31</p>
	   * @author sea
	   * @since 1.1
	   * @param date
	   * @return Date
	   */
	  public static Date getLastSecondDate(Date date) {
	    Date tmpDate = getFirstSecondDate(date);
	    GregorianCalendar cal = new GregorianCalendar();
	    cal.setTime(tmpDate);
	    cal.add(GregorianCalendar.DATE, 1);
	    cal.add(GregorianCalendar.SECOND, -1);
	    return cal.getTime();
	  }

	  /**
	   * <p>ת�������ַ���Ϊָ����ʽ�����ڶ���</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param dateFormat ���ڵĸ�ʽ�ַ���
	   * @param dateString �����ַ���
	   * @return Date ת��������ڶ���
	   * @throws ParseException
	   */
	  public static Date toDate(String dateFormat, String dateString)throws ParseException {
	    //Assert.notNull(dateFormat);
	    //Assert.notNull(dateString);
	    Date cDate = null;
	    SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
	    sdf.setLenient(true);
	    cDate = sdf.parse(dateString);
	    return cDate;
	  }

	  /**
	   * <p>�ж��ַ����Ƿ�Ϊ�������͡�</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param dateStr ������ַ���
	   * @param stringformat �������͵ĸ�ʽ������2007/12/12��20071212��2007-12-12��
	   * @return Boolean
	   */
	  public static Boolean isDate(String dateStr, String stringformat) {
	    //Assert.notNull(dateStr);
	    SimpleDateFormat sdf = new SimpleDateFormat(stringformat);
	    final String STR = "0123456789/-:";
	    if (dateStr.length() != stringformat.length()) {
	      return false;
	    }
	    else {
	      for (int i = 0; i < dateStr.length(); i++) {
	        if (STR.indexOf(dateStr.substring(i, i + 1)) == -1) {
	          return false;
	        }
	      }
	      try {
	        sdf.setLenient(false);
	        sdf.parse(dateStr);
	        return true;
	      }
	      catch (ParseException e) {
	        return false;
	      }
	    }
	  }

	  /**
	   * <p>���������ڵ�ϵͳʱ�������������</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date
	   * @return ��Ӧ������ֵ
	   */
	  public static int gap(Date date) {
	    //Assert.notNull(date);

	    Calendar before = Calendar.getInstance();
	    Calendar current = Calendar.getInstance();
	    before.setTime(date);
	    current.setTime(new Date());
	    logger.debug(date2String(before.getTime()));
	    logger.debug(date2String(current.getTime()));
	    return (int) ((current.getTimeInMillis() - before.getTimeInMillis()) / (1000 * 60 * 60));
	  }

	  /**
	   * <p>��������ʱ��Ĳ��� ��</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date1 Ҫ�Ƚϵ�ʱ��
	   * @param date2 �ο�ʱ��
	   * @return result ����Сʱʱ��
	   */
	  public static int getBetweenHours(Date date1, Date date2) {
	    if (date1 == null || date2 == null)
	      return 0;
	    Calendar cal1 = new GregorianCalendar(Locale.CHINA);
	    Calendar cal2 = new GregorianCalendar(Locale.CHINA);
	    cal1.setTime(date1);
	    cal2.setTime(date2);

	    long timeMillis1 = cal1.getTimeInMillis();
	    long timeMillis2 = cal2.getTimeInMillis();
	    long result = (timeMillis2 - timeMillis1) / (1000 * 60 * 60);
	    return (int) result;
	  }
	  

	  /**
	   * <p>��������ʱ��Ĳ�����</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date1 Ҫ�Ƚϵ�ʱ��
	   * @param date2 �ο�ʱ��
	   * @return result ����Сʱʱ��
	   */
	  public static long getBetweenMins(Date date1, Date date2) {
	    if (date1 == null || date2 == null)
	      return 0;
	    Calendar cal1 = new GregorianCalendar(Locale.CHINA);
	    Calendar cal2 = new GregorianCalendar(Locale.CHINA);
	    cal1.setTime(date1);
	    cal2.setTime(date2);

	    long timeMillis1 = cal1.getTimeInMillis();
	    long timeMillis2 = cal2.getTimeInMillis();
	    long result = (timeMillis2 - timeMillis1) / (1000 * 60);
	    return result;
	  }  

	  /**
	   * <p>�����뵱ǰʱ������Сʱ�� ��</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param date Ҫ�Ƚϵ�ʱ��
	   * @return result ����Сʱʱ��
	   */
	  public static int getBetweenHours(Date date) {
	    Calendar cal1 = new GregorianCalendar(Locale.CHINA);
	    Calendar cal2 = new GregorianCalendar(Locale.CHINA);
	    cal1.setTime(date);
	    cal2.setTime(new Date());

	    long timeMillis1 = cal1.getTimeInMillis();
	    long timeMillis2 = cal2.getTimeInMillis();
	    long result = (timeMillis2 - timeMillis1) / (1000 * 60 * 60);
	    return (int) result;
	  }

	  /**
	   * <p>�����·ݼ����</p>
	   * <p>2008-7-1</p>
	   * @author sea
	   * @param bdate
	   * @param edate
	   * @return �����·ݼ��
	   */
	  public static int getBetweenMonths(Date bdate, Date edate) {
	    Calendar cal1 = new GregorianCalendar(Locale.CHINA);
	    Calendar cal2 = new GregorianCalendar(Locale.CHINA);
	    cal1.setTime(bdate);
	    cal2.setTime(edate);
	    return cal2.get(Calendar.MONTH) - cal1.get(Calendar.MONTH)
	        + (cal2.get(Calendar.YEAR) - cal1.get(Calendar.YEAR)) * 12;
	  }
	  
	  /**
	   * <p>����ָ������ǰN������ڡ�</p>
	   * @author sea
	   * @param cureentDate ��ǰָ��������
	   * @param n ָ��������
	   * @return Date
	   */
	  public static Date getBeforeDate(Date cureentDate,int n) {
	    Date beforeDate = new Date();
	    beforeDate.setTime(cureentDate.getTime() - 24*60*60*1000*n);
	    return beforeDate;
	  }
	  
	  /**
	   * <p>����ָ�����ں�N������ڡ�</p>
	   * @author sea
	   * @param cureentDate ��ǰָ��������
	   * @param n ָ��������
	   * @return Date
	   */
	  public static Date getAfterDate(Date cureentDate,int n) {
	    Date afterDate = new Date();
	    afterDate.setTime(cureentDate.getTime() + 24*60*60*1000*n);
	    return afterDate;
	  }
	  
	  /**
	   * <p>��ǰ�����������֮���������</p>
	   * @author sea
	   * @param dateString
	   * @return long
	   */
	  public static long getBetweenDays(String dateString){
	    try {
	      java.util.Date dt1 =DateUtils.format(DateUtils.toDate("yyyy-MM-dd", dateString), "yyyy-MM-dd hh:mm:ss");   
	      java.util.Date dt2 = new   java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(DateUtils.date2String(DateUtils.getCurrentDate(), "yyyy-MM-dd hh:mm:ss"));   
	      Calendar t1 = Calendar.getInstance();   
	      Calendar t2 = Calendar.getInstance();   
	      t1.setTime(dt1);   
	      t2.setTime(dt2);   
	      long temp = (t2.getTimeInMillis()-t1.getTimeInMillis())/(1000*60*60*24);     
	      return temp;
	    }
	    catch (ParseException e) {
	      e.printStackTrace();
	      return -1;
	    }
	  }
	  
	  /**
	   * <p>������������֮���Сʱ����</p>
	   * @author sea
	   * @param dateA String
	   * @param dateB String
	   * @return int
	   */
	  public static int getBetweenHours(String dateA, String dateB) {
	    long dayNumber = 0;
	    //1Сʱ=60����=3600��=3600000
	    //long mins = 60L * 1000L;
	    long hours=3600000;
	    //long day= 24L * 60L * 60L * 1000L;��������֮��
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    try {
	       java.util.Date d1 = df.parse(dateA);
	       java.util.Date d2 = df.parse(dateB);
	       dayNumber = (d2.getTime() - d1.getTime()) / hours;
	    } catch (Exception e) {
	       e.printStackTrace();
	    }
	    return (int) dayNumber;
	    }
	  
	  /**
	   * <p>������������֮���������</p>
	   * @author sea
	   * @param date1
	   * @param date2
	   * @return long
	   */
	  public static long DateDays(String date1, String date2){
	      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	      long myTime;
	      Date aDate2;
	      Date aDate;
	      long myTime2;
	      long days = 0;
	      try {
	          aDate = formatter.parse(date1);// �������ڣ�������ǰ����
	          myTime = (aDate.getTime() / 1000);
	          // SimpleDateFormat formatter =new SimpleDateFormat("yyyy-MM-dd");
	          aDate2 = formatter.parse(date2);// �������ڣ�������ǰ����
	          myTime2 = (aDate2.getTime() / 1000);

	          if (myTime > myTime2) {
	              days = (myTime - myTime2) / (1 * 60 * 60 * 24);
	          } else {
	              days = (myTime2 - myTime) / (1 * 60 * 60 * 24);
	          }

	      } catch (Exception e) {
	          e.printStackTrace();
	      }
	      return days;
	  }
	
	/**
	 * 
	 * <p>���ڸ�ʽ����������ʽ��Ϊ����ʱ����ĸ�ʽ����Ϊ���򷵻ؿմ���</p>
	 * @author sea
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
	 * <p>����ϵͳʱ�� 0--����ʱ���ַ��� 1--����SQLʱ���ַ�����</p>
	 * @author sea
	 * @param rtype Ĭ�ϣ�yyyy-MM-dd��2��yyyyMMdd��3��yyyy-MM-dd HH:mm:ss ,4:yyyy/MM/dd HH:mm:ss
	 * @return
	 */
	public static String getSystemDate(int rtype) {
		try {
			Calendar cal = Calendar.getInstance();
			String module = "yyyy-MM-dd";
			if (rtype == 2) {
				module = "yyyyMMdd";
			}
			if (rtype == 3) {
				module = "yyyy-MM-dd HH:mm:ss";
			}
			if (rtype == 4) {
				module = "yyyy/MM/dd HH:mm:ss";
			}
			SimpleDateFormat formatter1 = new SimpleDateFormat(module);
			String fld_date = formatter1.format(cal.getTime());
			if (rtype == 0)
				return fld_date;
			else if (rtype == 1)
				return "'" + fld_date + "'"; // sql server
			else
				return fld_date;
		} catch (Exception e) {

		}
		return "null";
	}
	
	/**
	 * <p>��ԭ�е����� ���������ֵ����Ϊ������ʱ���롣</p>
	 * @author sea
	 * @param date ��Ҫ��ӵ�����
	 * @param leng ��Ҫ�����
	 * @param type ��ӵ����� :��YEAR/��MONTH/��DAY_OF_YEAR/ʱHOUR_OF_DAY/��MINUTE
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
	 * <p>���һ���е����һ�졣</p>
	 * @author sea
	 * @param year ��
	 * @param month �·�
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
	 * <p>����һ�����ڵ���һ��ĵ�һ�졣</p>
	 * @author sea
	 * @param chargeDate  
	 * @return
	 */ 
	public static String getYearFirstDay(String chargeDate) {
		Date date;
		String rdate = "";
		try {
			date = toDate(chargeDate);
			rdate = date2String(getDateAdd(date, 1, "yy"),"yyyy-MM-dd"); 
			rdate = rdate.substring(0, 4) + "-01-01";
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		return rdate;

	}
 
	/**
	 * <p>�õ��¸��µĵ�һ�졣</p>
	 * @author sea
	 * @param chargeDate  
	 * @return
	 */ 
	public static String getMonthFirstDay(String chargeDate) {
		Date date;
		String rdate = "";
		try {
			date = toDate(chargeDate);
			rdate = date2String(getDateAdd(date, 1, "mm"),"yyyy-MM-dd"); 
			rdate = rdate.substring(0, rdate.length() - 2) + "01";
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		return rdate;
	}

	/**
	 * <p>�õ�һ�����ڵ���ݡ�</p>
	 * @author sea
	 * @param strDate  
	 * @return
	 */ 
	public static String getDateYear(String strDate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar date = Calendar.getInstance();
		date.setTime(sdf.parse(strDate));
		return String.valueOf(date.get(Calendar.YEAR));

	}

	/**
	 * <p>�õ�һ�����ڵ��·ݡ�</p>
	 * @author sea
	 * @param strDate  
	 * @return
	 */ 
	public static String getDateMonth(String strDate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar date = Calendar.getInstance();
		date.setTime(sdf.parse(strDate));
		return String.valueOf(date.get(Calendar.MONTH) + 1);

	}

	/**
	 * <p>�õ�һ�����ڵ�������</p>
	 * @author sea
	 * @param strDate  
	 * @return
	 */ 
	public static String getDateDay(String strDate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar date = Calendar.getInstance();
		date.setTime(sdf.parse(strDate));
		return String.valueOf(date.get(Calendar.DAY_OF_MONTH));
	}
	
	/**
	 * <p>��õ�Ϣ��ʼʱ��</p>
	 * @author sea
	 * @param strDate  
	 * @return
	 * @throws SQLException 
	 */ 
	public static String getStartDateDay(String txId) throws SQLException {
	    ResultSet rs = null;
	    String tx_date = null;
		String sql = "select start_date from fund_standard_interest where id= '"+txId+"'";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()){
		    	tx_date = rs.getString("start_date").toString();
			}
			erpDataSource.close();
		return tx_date;
	}
	
	
	
	
    /**
     * <p>�Ƚ�2�����ڴ�С��</p>
     * @author Сл
     * @param s1 ����1
     * @param s2 ����2
     * @return s1 > s2 return 1,s1 = s2 return 0,s1 < s2 return -1
     */
    public int getCompareDate(String s1,String s2){
    	int flag = 0;
    	//String s1="2008-01-25";
		//String s2="2008-01-25";
		java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Calendar c1=java.util.Calendar.getInstance();
		java.util.Calendar c2=java.util.Calendar.getInstance();
		try
		{
			c1.setTime(df.parse(s1));
			c2.setTime(df.parse(s2));
		}catch(java.text.ParseException e){
			System.err.println("���ڸ�ʽ����ȷ");
		}
		int result = c1.compareTo(c2);
		if(result==0){
			flag = 0;
			System.out.println("c1���c2");
		}
		else if(result<0){
			flag = -1;
			System.out.println("c1С��c2");
		}
		else{
			flag = 1;
			System.out.println("c1����c2");
		}
		return flag;
    }
    public static long getTimer(int hours){
		long hour = 60 * 60 * 1000;
		long time = System.currentTimeMillis();
		time += 8 * hour; 
		System.out.println(time);
		time %= 24 * hour;
		long millTime = 24*hour-time+hours*hour;
		return millTime;
	}
}
