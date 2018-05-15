package com.tenwa.util;

import java.text.DecimalFormat;

/**
 * 
 * @author JavaJeffe
 * 
 * date ---- 9:54:06 AM
 */
public class CurrencyUtil {

	private static final String[] CHINESE_DIGIT = { "��", "Ҽ", "��", "��", "��",
			"��", "½", "��", "��", "��" };
	private static final String[] CHINESE_DIGITAL = { "ʰ", "��", "Ǫ", "��", "��" };
	private static final String RMB_YUAN = "Բ";
	private static final String[] RMB_DECIMAL = { "��", "��" };
	private static final String RMB_WHOLE = "��";
	private static final char ZERO = '0';
	private static final String FINANCE_PATTERN = "#,##0.00";
	private static final String SIX_ROUND_PATTERN = "###0.000000";
	private static final String FINANCE_INT_PATTERN = "#,###";
	private static final String CHINESE_YUAN_PATTERN = "0.00";

	/**
	 * ת���ɴ�д���
	 * 
	 * @param money
	 *            (String):�淶�����ֻ�����ʽ�ַ���
	 */
	public static String convertChineseYuan(String amount) {
		StringBuilder builder = new StringBuilder();
		int dot = amount.lastIndexOf(".");
		String integer = amount;
		String decimal = "";
		if (dot > 0) {
			integer = amount.substring(0, dot);
			decimal = amount.substring(dot + 1);
		}
		// --------����λ����---------------
		char theBit = ZERO; // ��ǰ����λ
		int zeroBit = 0; // ��ʼ��λ
		int bitLen = 0; // ��ǰλ������λ��(�Ӹ�λ��ʼ0����)
		boolean flag = false; // �Ƿ������Ч������λ
		char[] ci = integer.toCharArray();
		for (int index = 0; index < ci.length; index++) {
			theBit = ci[index]; // ȡ����ǰ���������λ
			bitLen = ci.length - index - 1; // ���㵱ǰ�����������ʲôλ��
			if (zeroBit > 0 && theBit != ZERO) {
				builder.append(CHINESE_DIGIT[0]); // ��ǰ����
			}
			if (theBit != ZERO) {
				builder.append(CHINESE_DIGIT[theBit - ZERO]); // ��д����
			}
			if (bitLen % 8 == 0) {
				if (bitLen == 0) {// Ԫ
					if (ci.length > 1 || theBit != ZERO) {
						builder.append(RMB_YUAN); // Ԫ
					}
				} else {// ��
					builder.append(CHINESE_DIGITAL[4]); // ��
				}
			} else {
				if (bitLen % 4 == 0) {// ��
					if (theBit != ZERO || zeroBit == 0 || zeroBit - bitLen < 3) {
						builder.append(CHINESE_DIGITAL[3]); // ��
					}
				} else {// Ǫ��ʰ
					if (theBit != ZERO) {
						builder.append(CHINESE_DIGITAL[bitLen % 4 - 1]); // Ǫ��ʰ
					}
				}
			}
			// ��鲢����������λ
			if (theBit == ZERO) {
				zeroBit = zeroBit == 0 ? bitLen : zeroBit;
			} else {
				zeroBit = 0;
				flag = true;
			}

		}
		// ----------------------------------------------------����С������
		StringBuilder decbuilder = new StringBuilder();
		char[] cf = decimal.toCharArray();
		for (int index = 0; index < cf.length; index++) {
			theBit = cf[index]; // ȡ����ǰ�����С��λ
			if (zeroBit > 0 && theBit != ZERO && flag) {// ����������ʮλ�͸�λȫ��Ϊ��ʱ
				decbuilder.append(CHINESE_DIGIT[0]); // ��ǰ��
			}
			if (theBit != ZERO) {
				decbuilder.append(CHINESE_DIGIT[theBit - ZERO]) // ��д����
						.append(RMB_DECIMAL[index]);// �Ƿֵ�λ
			}
			zeroBit = theBit == ZERO ? 1 : 0;
		}
		if (decbuilder.length() < 1) { // ���С������ȫ��Ϊ0���������β
			decbuilder.append(RMB_WHOLE);
		}
		builder.append(decbuilder);
		return builder.toString();
	}

	public static final String convertChineseYuan(Number amount) {
		return convertChineseYuan(getFormat(CHINESE_YUAN_PATTERN)
				.format(amount));
	}

	public static final String convertFinance(double amount) {
		return getFormat(FINANCE_PATTERN).format(amount);
	}

	public static final String convertFinance(String amount) {
		if (amount == null || "".equals(amount)) {
			amount = "0";
		}
		return getFormat(FINANCE_PATTERN).format(Double.parseDouble(amount));
	}

	/**
	 * ת��Ϊ6λС����
	 * 
	 * @param amount
	 * @return
	 */
	public static final String formatNumberSix(String amount) {
		if (amount == null || "".equals(amount)) {
			amount = "0";
		}

		return getFormat(SIX_ROUND_PATTERN).format(Double.parseDouble(amount));
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
}
