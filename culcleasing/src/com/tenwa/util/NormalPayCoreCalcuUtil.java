/**
 * com.tenwa.util.NormalCoreCalcuUtil
 * create by JavaJeffe.
 * date Aug 9, 2010
 */
package com.tenwa.util;

import java.sql.ResultSet;
import java.util.List;

import dbconn.Conn;
import com.tenwa.util.CommonUtil;

/**
 * ���򸶿�������������
 * 
 * @author JavaJeffe
 * 
 * date ---- 4:39:31 PM
 */
public class NormalPayCoreCalcuUtil {
	private Conn db = null;
	private ResultSet rs = null;
	private String sqlstr = "";
	
	String year_rate ="";//������
	String lease_interval ="";//���޼�� һ��Ϊһ������һ��
	String income_number ="";//������� = ��������
	String lease_money ="";//���ʽ�� ���ͻ���Ҫ���ʵĽ����������д���Ľ�
	String period_first_date ="";//��������
	String period_type = "1";//�ڳ�����ĩ��֧��

	String rent="";//
	String head_amt="";//1 �������
	String caution_money="";//2 ��֤�𣨳����ˣ�
	//3 ��һ�����
	String insurance_lessor="";//4 ���շ�
	String handling_charge="";//5 ������
	String nominalprice="";//6 �����ۿ�
	String supervision_fee="";//7 ��������
	String lessee_caution_money = "";//8 ������
	String sale_caution_money = "";//9 DB��֤��
	String hand_method="";// ֵ��Ϊ��� ����ǰϢ�Ƿ������
	String settle_method="";// �׸��ʽ(������������)
	String first_rent_plan_date = "";// ��һ�����ƻ���ȡ���ڣ��׸������ڣ�
	
	/**
	 * ���򸶿��������
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public void calcuNormalPayRent(String proj_id, String doc_id) {
		
	}

}
