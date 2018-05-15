/**
 * com.tenwa.culc.junit
 */
package com.tenwa.culc.junit;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.junit.Test;

import com.tenwa.culc.util.ConvertUtil;

/**
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 4:09:43 PM Email:JaffeHe@hotmail.com
 */
public class TestDate {

	@Test
	public void testDiff() throws ParseException {
		// SimpleDateFormat simpledate = new SimpleDateFormat("yyyy-MM-dd");
		// String now_start_date = "2010-4-2";// 整合起租日和偿还日的日期
		// System.out.println("sss"
		// + simpledate.format(simpledate.parse(now_start_date)));
		//
		// Calendar startCale = Calendar.getInstance();
		// startCale.setTime(simpledate.parse(now_start_date));
		// startCale.add(Calendar.MONTH, 13);
		// String end_date = simpledate.format(startCale.getTime());
		// System.out.println("hhh" + end_date);

		String start_date = "2011-06-28";
		String income_day = "5";
		String lease_term = "12";
		SimpleDateFormat simpledate = new SimpleDateFormat("yyyy-MM-dd");
		String now_start_date = start_date.substring(0, 8) + income_day;// 整合起租日和偿还日的日期
		start_date = simpledate.format(simpledate.parse(now_start_date));
		Calendar startCale = Calendar.getInstance();
		startCale.setTime(simpledate.parse(now_start_date));
		startCale.add(Calendar.MONTH, ConvertUtil.parseInt(lease_term, 0));

		String end_date = simpledate.format(startCale.getTime());

		System.out.println("StartDate:" + start_date);
		System.out.println("now_start_date:" + now_start_date);
		System.out.println("end_date:" + end_date);
	}

	@Test
	public void testtdd() {
		// 当前个数/(过关个数/30)
		int count = 20;
		int tmp = 61;

		@SuppressWarnings("unused")
		int ddd = 61 / 30;

		int s = count / (tmp / 30);
		System.out.println("ssss____" + s);
	}
}
