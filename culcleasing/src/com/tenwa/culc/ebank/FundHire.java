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
 * 资金核销
 * 
 * @author Jaffe
 * 
 * Date:Aug 3, 2011 5:26:18 PM Email:JaffeHe@hotmail.com
 */
public class FundHire {
	private static ERPDataSource erpDataSource=null;

	// 公共参数
	private ResultSet rs = null;

	/**
	 * 资金网银核销
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
		// ======变量定义区 开始=====
		// -1- 网银数据相关字段
		String ebdata_id = "";// 网银数据Id
		// -2- 资金相关字段
		String fund_id = "";
		String pay_obj = "";// 付款人
		String pay_bank_no;// 付款账号
		String pay_money = "";// 付款金额
		String plan_date = "";// 计划时间 - 加以判断

		// ======变量定义区 结束=====
		// 1.遍历glide_id下所有资金款项
		sqlStr = "Select vefh.id,vefh.pay_bank_name,vefh.pay_bank_no,vefh.pay_obj_name,vefh.plan_money,convert(varchar(10),vefh.plan_date,120) as plan_date ";
		sqlStr += " from vi_ebank_fund_hire_detail vefh where vefh.plan_status='未核销' and vefh.id in( select plan_id from apply_info_detail where apply_id='"
				+ glide_id + "')";
		System.out.println("========sq网银资金核销-===" + sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		while (rs.next()) {
			tjAmount++;
			fund_id = rs.getString("id");
			pay_obj = rs.getString("pay_obj_name");
			pay_bank_no = rs.getString("pay_bank_no");
			pay_money = rs.getString("plan_money");
			plan_date = rs.getString("plan_date");
			// 2.查询up_id网银 上传编号 下是否有匹配的网银数据
			ebdata_id = judgeItemExists(up_id, pay_obj, pay_money, pay_bank_no,
					plan_date);
			if (ebdata_id != null && !"".equals(ebdata_id)) {
				ppAmount++;
				LogWriter.logDebug("成功匹配资金款项与网银数据，付款人：" + pay_obj + " 付款账号："
						+ pay_bank_no + " 付款金额：" + pay_money);
				// 3.当付款人+付款账号+资金金额 一致的情况下，核销该期资金
				// 3.1插入资金实收记录
				res += operInsFundFundCharge(fund_id, ebdata_id, creator);
				// 3.2更新资金计划表数据
				res += operUpdContractFundFundChargePlan(fund_id);
				// 3.3修改网银上传数据
				res += operUpdFundEbankData(ebdata_id, pay_money);
			} else {
				// 4.不存在，则输出相关信息
				LogWriter.logDebug("失败，没有成功匹配资金款项与网银数据，付款人：" + pay_obj
						+ " 付款账号：" + pay_bank_no + " 付款金额：" + pay_money);
				// 5.恢复资金状态
				backFundState(fund_id);
			}
		}

		// 判断匹配成功数量 - 0代表一个未匹配
		if (ppAmount > 0) {
			// 3.4更新付款单的状态
			res += operUpdApplyInfo(glide_id, ppAmount, tjAmount);
			if (ppAmount == tjAmount) {
				res = 1;// 全部核销
			} else {
				res = 2;// 部分核销
			}
		} else {
			res = -1;// 核销失败
		}

		erpDataSource.close();
		return res;
	}

	/**
	 * 恢复资金计划状态
	 * 
	 * @param fund_id
	 * @throws SQLException
	 */
	private void backFundState(String fund_id) throws SQLException {
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		partSql = "Update contract_fund_fund_charge_plan set flag='0' where id='"
				+ fund_id + "'";

		erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("更新合同资金计划状态,计划id：" + fund_id);
		// 3.释放资源
		erpDataSource.close();
	}

	/**
	 * 更新apply_info状态为 已核销
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
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		if (ppAmount == tjAmount) {// 全部核销
			partSql = "Update apply_info set status='已核销',fact_date='"
					+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
					+ "' where glide_id='" + glide_id + "'";
		} else {// 部分核销
			partSql = "Update apply_info set status='部分核销'"
					+ " where glide_id='" + glide_id + "'";
		}

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("更新apply_info，流水号glide_id：" + glide_id + ",更新结果："
				+ (res > 0 ? " -成功- " : " -失败- "));
		// 3.释放资源
		erpDataSource.close();
		// 返回
		return res;
	}

	/**
	 * 更新网银上传数据 used_money,left_money,status
	 * 
	 * 
	 * @param ebdata_id
	 * @return
	 * @throws SQLException
	 */
	private int operUpdFundEbankData(String ebdata_id, String pay_money)
			throws SQLException {
		int res = 0;
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "Update fund_ebank_data set used_money='" + pay_money
				+ "',left_money='0',status='1' where ebdata_id='" + ebdata_id
				+ "'";

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("更新网银上传数据，网银数据Id：" + ebdata_id + ",更新结果："
				+ (res > 0 ? " -成功- " : " -失败- "));
		// 3.释放资源
		erpDataSource.close();
		// 返回
		return res;
	}

	/**
	 * 更新资金计划表数据为 已核销
	 * 
	 * @param fund_id
	 * @return
	 * @throws SQLException
	 */
	private int operUpdContractFundFundChargePlan(String fund_id)
			throws SQLException {
		int res = 0;
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "Update contract_fund_fund_charge_plan set plan_status='已核销',curr_plan_money=0 where id='"
				+ fund_id + "'";

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("更新合同资金计划为已核销，资金计划Id：" + fund_id + ",更新结果："
				+ (res > 0 ? " -成功- " : " -失败- "));
		// 3.释放资源
		erpDataSource.close();
		// 返回
		return res;
	}

	/**
	 * 插入资金实收记录
	 * 
	 * @param fund_id
	 * @param ebdata_id
	 * @return
	 * @throws SQLException
	 */
	private int operInsFundFundCharge(String fund_id, String ebdata_id,
			String creator) throws SQLException {
		int res = 0;
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		ResultSet rs2 = null;
		// 2.执行判断
		String partSql = "";
		// 2.1网银相关信息
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

		// 2.2资金实收sql拼接
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
								+ "','" + client_accnumber + "','收款','"
								+ fund_id + "','" + creator + "','"
								+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
								+ "',pay_obj").append(
						" From vi_ebank_fund_hire_detail where id='" + fund_id
								+ "'");

		partSql = sqlBuffer.toString();

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("插入合同资金实收记录，资金计划Id：" + fund_id + ",更新结果："
				+ (res > 0 ? " -成功- " : " -失败- "));
		// 3.释放资源
		erpDataSource.close();

		return res;
	}

	/**
	 * 匹配指定网银上传Id下网银数据进行匹配，匹配规则
	 * 
	 * <pre>
	 * 付款人 + 付款账号 + 付款金额 + （到账时间 2011-12-05新增）
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
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		partSql = "Select ebdata_id from fund_ebank_data where up_id='" + up_id
				+ "' and client_name='" + pay_obj + "'";
		partSql += " and left_money='" + pay_money
				+ "' and client_acc_number='" + pay_bank_no + "' and status=0 ";
		partSql += " and business_flag=0";
		// 2011-12-20不需要判断日期一致
		// partSql += " and datediff(dd,fact_date,'" + plan_date + "')=0";

		ResultSet rs2 = erpDataSource.executeQuery(partSql);
		LogWriter.logDebug("匹配网银数据" + partSql);
		if (rs2.next()) {
			ebdata_id = rs2.getString("ebdata_id");
		}
		// 3.释放资源
		erpDataSource.close();
		// 返回
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
