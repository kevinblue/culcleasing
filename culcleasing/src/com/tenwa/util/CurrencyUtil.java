package com.tenwa.util;

import java.text.DecimalFormat;

/**
 * 
 * @author JavaJeffe
 * 
 * date ---- 9:54:06 AM
 */
public class CurrencyUtil {

	private static final String[] CHINESE_DIGIT = { "零", "壹", "贰", "叁", "肆",
			"伍", "陆", "柒", "捌", "玖" };
	private static final String[] CHINESE_DIGITAL = { "拾", "佰", "仟", "万", "亿" };
	private static final String RMB_YUAN = "圆";
	private static final String[] RMB_DECIMAL = { "角", "分" };
	private static final String RMB_WHOLE = "整";
	private static final char ZERO = '0';
	private static final String FINANCE_PATTERN = "#,##0.00";
	private static final String SIX_ROUND_PATTERN = "###0.000000";
	private static final String FINANCE_INT_PATTERN = "#,###";
	private static final String CHINESE_YUAN_PATTERN = "0.00";

	/**
	 * 转换成大写金额
	 * 
	 * @param money
	 *            (String):规范的数字货币形式字符串
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
		// --------整数位处理---------------
		char theBit = ZERO; // 当前数字位
		int zeroBit = 0; // 开始零位
		int bitLen = 0; // 当前位所处的位置(从个位开始0计数)
		boolean flag = false; // 是否具有有效的整数位
		char[] ci = integer.toCharArray();
		for (int index = 0; index < ci.length; index++) {
			theBit = ci[index]; // 取出当前处理的整数位
			bitLen = ci.length - index - 1; // 计算当前处理的数处于什么位置
			if (zeroBit > 0 && theBit != ZERO) {
				builder.append(CHINESE_DIGIT[0]); // 加前导零
			}
			if (theBit != ZERO) {
				builder.append(CHINESE_DIGIT[theBit - ZERO]); // 大写数字
			}
			if (bitLen % 8 == 0) {
				if (bitLen == 0) {// 元
					if (ci.length > 1 || theBit != ZERO) {
						builder.append(RMB_YUAN); // 元
					}
				} else {// 亿
					builder.append(CHINESE_DIGITAL[4]); // 亿
				}
			} else {
				if (bitLen % 4 == 0) {// 万
					if (theBit != ZERO || zeroBit == 0 || zeroBit - bitLen < 3) {
						builder.append(CHINESE_DIGITAL[3]); // 万
					}
				} else {// 仟佰拾
					if (theBit != ZERO) {
						builder.append(CHINESE_DIGITAL[bitLen % 4 - 1]); // 仟佰拾
					}
				}
			}
			// 检查并条件更新零位
			if (theBit == ZERO) {
				zeroBit = zeroBit == 0 ? bitLen : zeroBit;
			} else {
				zeroBit = 0;
				flag = true;
			}

		}
		// ----------------------------------------------------处理小数部分
		StringBuilder decbuilder = new StringBuilder();
		char[] cf = decimal.toCharArray();
		for (int index = 0; index < cf.length; index++) {
			theBit = cf[index]; // 取出当前处理的小数位
			if (zeroBit > 0 && theBit != ZERO && flag) {// 当整数部分十位和个位全部为零时
				decbuilder.append(CHINESE_DIGIT[0]); // 加前零
			}
			if (theBit != ZERO) {
				decbuilder.append(CHINESE_DIGIT[theBit - ZERO]) // 大写数字
						.append(RMB_DECIMAL[index]);// 角分单位
			}
			zeroBit = theBit == ZERO ? 1 : 0;
		}
		if (decbuilder.length() < 1) { // 如果小数部分全部为0，添加整结尾
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
	 * 转换为6位小数点
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
