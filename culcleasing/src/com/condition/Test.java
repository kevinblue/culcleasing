package com.condition;

import java.util.ArrayList;
import java.util.List;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * <p>。</p>
 * @author 小谢
 * <p>Jun 10, 2010</p>
 */
public class Test {

	/**
	 * <p>。</p>
	 * @author 小谢
	 * @param args
	 */
	public static void main(String[] args) {
		  int i= compare_date("1995-11-12 15:21", "1999-12-11 09:59");
	       System.out.println("i=="+i);
	       
	}
	
	public static int compare_date(String DATE1, String DATE2) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                System.out.println("dt1 在dt2前");
                return 1;
            } else if (dt1.getTime() < dt2.getTime()) {
                System.out.println("dt1在dt2后");
                return -1;
            } else {
                return 0;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return 0;
    }
}
