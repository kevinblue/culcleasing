package com.tenwa.leasing.util.leasing;

/**
 * ���ʼ����� ��Ŀ���ƣ�iulcleasing �����ƣ�RateTools �������� �����ˣ�ʷ��� ����ʱ�䣺2011-2-10 ����09:35:29
 * �޸��ˣ�ʷ��� �޸�ʱ�䣺2011-2-10 ����09:35:29 �޸ı�ע��
 * 
 * @version
 */
public class RateTools {

	/**
	 * ����ÿһ�ڲ���ʱ������ֵ
	 * 
	 * @Title: getPreRate
	 * @Description:
	 * @param
	 * @param calcRate��Ҫ����������ʻ�irr
	 * @param
	 * @param lease_interval
	 *            �����
	 * @param
	 * @return
	 * @return String
	 * @throws
	 */
	@SuppressWarnings("unused")
	public static String getPreRate(String calcRate, String lease_interval) {

		return String.valueOf(Double.parseDouble(calcRate) / 12 / 100
				* Integer.parseInt(lease_interval));
	}

}
