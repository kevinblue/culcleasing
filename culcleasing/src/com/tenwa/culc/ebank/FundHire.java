/**
 * com.tenwa.culc.fundHire
 */
package com.tenwa.culc.ebank;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * �ʽ����
 * 
 * @author Jaffe
 * 
 * Date:Aug 3, 2011 5:26:18 PM Email:JaffeHe@hotmail.com
 */
public class FundHire {
	private static ERPDataSource erpDataSource=null;

	// ��������
	private ResultSet rs = null;

	/**
	 * �ʽ���������
	 * 
	 * @param glide_id
	 * @param up_id
	 * @param type
	 * @param creator
	 * @return
	 * @throws SQLException
	 */
	public int hireFund(String glide_id, String up_id, String type,
			String creator) throws SQLException {
		int ppAmount = 0;
		int tjAmount = 0;
		int res = 0;
		String sqlStr = "";
		erpDataSource=new ERPDataSource();
		// ======���������� ��ʼ=====
		// -1- ������������ֶ�
		String ebdata_id = "";// ��������Id
		// -2- �ʽ�����ֶ�
		String fund_id = "";
		String pay_obj = "";// ������
		String pay_bank_no;// �����˺�
		String pay_money = "";// ������
		String plan_date = "";// �ƻ�ʱ�� - �����ж�

		// ======���������� ����=====
		// 1.����glide_id�������ʽ����
		sqlStr = "Select vefh.id,vefh.pay_bank_name,vefh.pay_bank_no,vefh.pay_obj_name,vefh.plan_money,convert(varchar(10),vefh.plan_date,120) as plan_date ";
		sqlStr += " from vi_ebank_fund_hire_detail vefh where vefh.plan_status='δ����' and vefh.id in( select plan_id from apply_info_detail where apply_id='"
				+ glide_id + "')";
		System.out.println("========sq�����ʽ����-===" + sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		while (rs.next()) {
			tjAmount++;
			fund_id = rs.getString("id");
			pay_obj = rs.getString("pay_obj_name");
			pay_bank_no = rs.getString("pay_bank_no");
			pay_money = rs.getString("plan_money");
			plan_date = rs.getString("plan_date");
			// 2.��ѯup_id���� �ϴ���� ���Ƿ���ƥ�����������
			ebdata_id = judgeItemExists(up_id, pay_obj, pay_money, pay_bank_no,
					plan_date);
			if (ebdata_id != null && !"".equals(ebdata_id)) {
				ppAmount++;
				LogWriter.logDebug("�ɹ�ƥ���ʽ�������������ݣ������ˣ�" + pay_obj + " �����˺ţ�"
						+ pay_bank_no + " �����" + pay_money);
				// 3.��������+�����˺�+�ʽ��� һ�µ�����£����������ʽ�
				// 3.1�����ʽ�ʵ�ռ�¼
				res += operInsFundFundCharge(fund_id, ebdata_id, creator);
				// 3.2�����ʽ�ƻ�������
				res += operUpdContractFundFundChargePlan(fund_id);
				// 3.3�޸������ϴ�����
				res += operUpdFundEbankData(ebdata_id, pay_money);
			} else {
				// 4.�����ڣ�����������Ϣ
				LogWriter.logDebug("ʧ�ܣ�û�гɹ�ƥ���ʽ�������������ݣ������ˣ�" + pay_obj
						+ " �����˺ţ�" + pay_bank_no + " �����" + pay_money);
				// 5.�ָ��ʽ�״̬
				backFundState(fund_id);
			}
		}

		// �ж�ƥ��ɹ����� - 0����һ��δƥ��
		if (ppAmount > 0) {
			// 3.4���¸����״̬
			res += operUpdApplyInfo(glide_id, ppAmount, tjAmount);
			if (ppAmount == tjAmount) {
				res = 1;// ȫ������
			} else {
				res = 2;// ���ֺ���
			}
		} else {
			res = -1;// ����ʧ��
		}

		erpDataSource.close();
		return res;
	}

	/**
	 * �ָ��ʽ�ƻ�״̬
	 * 
	 * @param fund_id
	 * @throws SQLException
	 */
	private void backFundState(String fund_id) throws SQLException {
		// 1.��ȡ����
		erpDataSource=new ERPDataSource();
		// 2.ִ���ж�
		String partSql = "";
		partSql = "Update contract_fund_fund_charge_plan set flag='0' where id='"
				+ fund_id + "'";

		erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("���º�ͬ�ʽ�ƻ�״̬,�ƻ�id��" + fund_id);
		// 3.�ͷ���Դ
		erpDataSource.close();
	}

	/**
	 * ����apply_info״̬Ϊ �Ѻ���
	 * 
	 * @param glide_id
	 * @param pgFlag
	 * @param tjAmount
	 * @return
	 * @throws SQLException
	 */
	private int operUpdApplyInfo(String glide_id, int ppAmount, int tjAmount)
			throws SQLException {
		int res = 0;
		// 1.��ȡ����
		erpDataSource=new ERPDataSource();
		// 2.ִ���ж�
		String partSql = "";
		if (ppAmount == tjAmount) {// ȫ������
			partSql = "Update apply_info set status='�Ѻ���',fact_date='"
					+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
					+ "' where glide_id='" + glide_id + "'";
		} else {// ���ֺ���
			partSql = "Update apply_info set status='���ֺ���'"
					+ " where glide_id='" + glide_id + "'";
		}

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("����apply_info����ˮ��glide_id��" + glide_id + ",���½����"
				+ (res > 0 ? " -�ɹ�- " : " -ʧ��- "));
		// 3.�ͷ���Դ
		erpDataSource.close();
		// ����
		return res;
	}

	/**
	 * ���������ϴ����� used_money,left_money,status
	 * 
	 * 
	 * @param ebdata_id
	 * @return
	 * @throws SQLException
	 */
	private int operUpdFundEbankData(String ebdata_id, String pay_money)
			throws SQLException {
		int res = 0;
		// 1.��ȡ����
		erpDataSource=new ERPDataSource();
		// 2.ִ���ж�
		String partSql = "Update fund_ebank_data set used_money='" + pay_money
				+ "',left_money='0',status='1' where ebdata_id='" + ebdata_id
				+ "'";

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("���������ϴ����ݣ���������Id��" + ebdata_id + ",���½����"
				+ (res > 0 ? " -�ɹ�- " : " -ʧ��- "));
		// 3.�ͷ���Դ
		erpDataSource.close();
		// ����
		return res;
	}

	/**
	 * �����ʽ�ƻ�������Ϊ �Ѻ���
	 * 
	 * @param fund_id
	 * @return
	 * @throws SQLException
	 */
	private int operUpdContractFundFundChargePlan(String fund_id)
			throws SQLException {
		int res = 0;
		// 1.��ȡ����
		erpDataSource=new ERPDataSource();
		// 2.ִ���ж�
		String partSql = "Update contract_fund_fund_charge_plan set plan_status='�Ѻ���',curr_plan_money=0 where id='"
				+ fund_id + "'";

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("���º�ͬ�ʽ�ƻ�Ϊ�Ѻ������ʽ�ƻ�Id��" + fund_id + ",���½����"
				+ (res > 0 ? " -�ɹ�- " : " -ʧ��- "));
		// 3.�ͷ���Դ
		erpDataSource.close();
		// ����
		return res;
	}

	/**
	 * �����ʽ�ʵ�ռ�¼
	 * 
	 * @param fund_id
	 * @param ebdata_id
	 * @return
	 * @throws SQLException
	 */
	private int operInsFundFundCharge(String fund_id, String ebdata_id,
			String creator) throws SQLException {
		int res = 0;
		// 1.��ȡ����
		erpDataSource=new ERPDataSource();
		ResultSet rs2 = null;
		// 2.ִ���ж�
		String partSql = "";
		// 2.1���������Ϣ
		String account_bank = "";
		String acc_number = "";
		// String client_name = "";
		String client_bank = "";
		String client_accnumber = "";
		String fact_money = "";
		String fact_date = "";
		partSql = "Select * from fund_ebank_data where ebdata_id='" + ebdata_id
				+ "'";
		rs2 = erpDataSource.executeQuery(partSql);
		if (rs2.next()) {
			account_bank = rs2.getString("own_bank");
			acc_number = rs2.getString("own_acc_number");
			// client_name = rs2.getString("client_name");
			client_bank = rs2.getString("client_bank");
			client_accnumber = rs2.getString("client_acc_number");
			fact_money = rs2.getString("fact_money");
			fact_date = rs2.getString("fact_date");
		}

		// 2.2�ʽ�ʵ��sqlƴ��
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer
				.append(
						"Insert into fund_fund_charge(contract_id,ebank_number,charge_list,fee_type,settle_method,fact_date,fact_money,")
				.append(
						"fee_adjust,currency,fact_object,account_bank,acc_number,client_bank,")
				.append("client_accnumber,item_method,match_list,").append(
						"creator,create_date,pay_cust)").append(
						" Select contract_id,'" + ebdata_id
								+ "',fee_num,fee_type,pay_type,'" + fact_date
								+ "','" + fact_money
								+ "',null,currency,pay_obj,'" + account_bank
								+ "','" + acc_number + "','" + client_bank
								+ "','" + client_accnumber + "','�տ�','"
								+ fund_id + "','" + creator + "','"
								+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
								+ "',pay_obj").append(
						" From vi_ebank_fund_hire_detail where id='" + fund_id
								+ "'");

		partSql = sqlBuffer.toString();

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("�����ͬ�ʽ�ʵ�ռ�¼���ʽ�ƻ�Id��" + fund_id + ",���½����"
				+ (res > 0 ? " -�ɹ�- " : " -ʧ��- "));
		// 3.�ͷ���Դ
		erpDataSource.close();

		return res;
	}

	/**
	 * ƥ��ָ�������ϴ�Id���������ݽ���ƥ�䣬ƥ�����
	 * 
	 * <pre>
	 * ������ + �����˺� + ������ + ������ʱ�� 2011-12-05������
	 * </pre>
	 * 
	 * @param up_id
	 * @param pay_obj
	 * @param pay_money
	 * @param pay_bank_no
	 * @return
	 * @throws SQLException
	 */
	private String judgeItemExists(String up_id, String pay_obj,
			String pay_money, String pay_bank_no, String plan_date)
			throws SQLException {
		String ebdata_id = "";
		// 1.��ȡ����
		erpDataSource=new ERPDataSource();
		// 2.ִ���ж�
		String partSql = "";
		partSql = "Select ebdata_id from fund_ebank_data where up_id='" + up_id
				+ "' and client_name='" + pay_obj + "'";
		partSql += " and left_money='" + pay_money
				+ "' and client_acc_number='" + pay_bank_no + "' and status=0 ";
		partSql += " and business_flag=0";
		// 2011-12-20����Ҫ�ж�����һ��
		// partSql += " and datediff(dd,fact_date,'" + plan_date + "')=0";

		ResultSet rs2 = erpDataSource.executeQuery(partSql);
		LogWriter.logDebug("ƥ����������" + partSql);
		if (rs2.next()) {
			ebdata_id = rs2.getString("ebdata_id");
		}
		// 3.�ͷ���Դ
		erpDataSource.close();
		// ����
		return ebdata_id;
	}

	public static void main(String[] args) {
		System.out.println("22222222211111111");
		FundHire fundHire = new FundHire();
		try {
			System.out.println("2222");
			fundHire.hireFund("EF2011-12-21-26", "2011-12-21-53",
					"fund_Ebank_hire", "ADMN-8HT5FG");
			System.out.println("33333");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
