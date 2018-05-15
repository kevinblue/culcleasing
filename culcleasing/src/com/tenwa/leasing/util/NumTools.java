package com.tenwa.leasing.util;

import java.math.BigDecimal;
import java.util.regex.Pattern;

/**
 * �������ʹ�����
 * 
 * @author shf
 * 
 */
public class NumTools {

	/**
	 * �ж��Ƿ�Ϊ������������double��float
	 * 
	 * @param str
	 *            ������ַ���
	 * @return �Ǹ���������true,���򷵻�false
	 */
	public static boolean isDouble(String str) {
		Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");
		return pattern.matcher(str).matches();
	}

	/**
	 * �ж��Ƿ�Ϊ����
	 * 
	 * @param str
	 *            ������ַ���
	 * @return ����������true,���򷵻�false
	 */
	public static boolean isInteger(String str) {
		System.out.println(":::");
		Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
		return pattern.matcher(str).matches();
	}

	/**
	 * 
	 * @param value
	 * @return
	 */
	public String getZeroStr(String value) {
		try {
			String temp_n = value;
			if (temp_n == null || temp_n.equals("") || temp_n.equals("null")) {
				temp_n = "0";
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "0";
	}

	/**
	 * double�������봦�� scale--����
	 * 
	 * @param dbl
	 * @param scale
	 * @return
	 */
	public double rnddouble(double dbl, int scale) {
		try {
			BigDecimal temp_bd = new BigDecimal(dbl);
			double newdbl = temp_bd.setScale(scale, BigDecimal.ROUND_HALF_UP)
					.doubleValue();
			return newdbl;
		} catch (Exception e) {

		}
		return 0;
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
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				temp_num = new BigDecimal(temp_num).setScale(num,
						BigDecimal.ROUND_HALF_UP).toString();

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "0";
	}

}
