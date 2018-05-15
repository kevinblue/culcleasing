/**
 * com.tenwa.culc.ebank
 */
package com.tenwa.culc.ebank;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.culc.util.MathExtend;
import com.tenwa.log.LogWriter;

/**
 * 租金网银核销
 * 
 * @author Jaffe
 * 
 * Date:Aug 4, 2011 10:28:44 PM Email:JaffeHe@hotmail.com
 */
public class RentHire {
	private static ERPDataSource erpDataSource=null;
	
	// 公共参数
	private ResultSet rs = null;

	/**
	 * 网银核销操作 - 非常严格的数据才能网银核销
	 * 
	 * @param glide_id
	 * @param up_id
	 * @param type
	 * @param creator
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unused")
	public int hireRent(String glide_id, String up_id, String type,
			String creator) throws SQLException {
		int ppAmount = 0;
		int tjAmount = 0;
		int res = 0;
		String sqlStr = "";
		erpDataSource=new ERPDataSource();
		// ======变量定义区 开始=====
		// -1- 网银数据相关字段
		String ebdata_id = "";// 网银数据Id
		// -2- 租金相关字段
		String rent_id = "";
		String contract_id = "";// 合同Id
		String begin_id = "";// 起租Id
		String rent_list = "";// 期次
		String cust_id = "";// 付款人Id
		String fee_type = "";// 费用类型 租金、违约金
		String plan_money = "";// 付款金额

		// ======变量定义区 结束=====
		// 1.遍历glide_id下所有资金款项 - 从最早的租金开始匹配
		sqlStr = "Select vefh.id,vefh.plan_money,vefh.contract_id,vefh.begin_id,vefh.rent_list,vefh.cust_id,vefh.fee_type";
		sqlStr += " from vi_ebank_rent_hire_detail vefh where vefh.id in( select plan_id from apply_info_detail where apply_id='"
				+ glide_id + "') order by plan_date asc";

		rs = erpDataSource.executeQuery(sqlStr);
		while (rs.next()) {
			tjAmount++;
			rent_id = rs.getString("id");
			contract_id = rs.getString("contract_id");
			begin_id = rs.getString("begin_id");
			cust_id = rs.getString("cust_id");
			fee_type = rs.getString("fee_type");
			plan_money = rs.getString("plan_money");
			rent_list = rs.getString("rent_list");

			// 2.查询up_id网银 上传编号 下是否有匹配的网银数据
			ebdata_id = judgeItemExists(up_id, cust_id, plan_money);
			if (ebdata_id != null && !"".equals(ebdata_id)) {
				ppAmount++;
				LogWriter.logDebug("成功匹配资金款项与网银数据，付款人：" + cust_id + " 付款金额："
						+ plan_money);
				// 3.当付款人+付款账号+金额 一致的情况下，核销该期租金 | 20111205不考虑罚息情况
				// 3.1插入租金|违约金实收记录 | 租金会判断罚息情况
				res += operInsFundRentCharge(rent_id, ebdata_id, fee_type,
						creator);
				// 3.2更新租金|违约金计划数据
				res += operUpdBeginFundRentPlan(rent_id, fee_type);
				// 3.3修改网银上传数据
				res += operUpdFundEbankData(ebdata_id, plan_money);
			} else {
				// 4.不存在，则输出相关信息
				LogWriter.logDebug("失败，没有成功匹配资金款项与网银数据，付款人：" + cust_id
						+ " 付款金额：" + plan_money);
				// 5.恢复租金状态
				backRentState(rent_id);
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
	 * 恢复租金状态
	 * 
	 * @param rent_id
	 * @throws SQLException
	 */
	private void backRentState(String rent_id) throws SQLException {
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		partSql = "Update fund_rent_plan set state='0' where id='" + rent_id
				+ "'";

		erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("更新合同租金计划状态,计划id：" + rent_id);
		// 3.释放资源
		erpDataSource.close();
	}

	/**
	 * 更新租金计划|违约金计划状态数据
	 * 
	 * @param rent_id
	 * @param fee_type
	 * @return
	 * @throws SQLException
	 */
	private int operUpdBeginFundRentPlan(String rent_id, String fee_type)
			throws SQLException {
		int res = 0;
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		if (fee_type != null && "租金".equals(fee_type)) {
			partSql = "Update fund_rent_plan set curr_rent=0,curr_corpus=0,curr_interest=0,plan_status='已回笼' where id='"
					+ rent_id + "'";

		} else if (fee_type != null && "违约金".equals(fee_type)) {
			partSql = "Update fund_penalty_plan set curr_penalty=0,plan_status='已回笼' where id='"
					+ rent_id + "'";
		}

		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("更新合同[" + fee_type + "]计划为已回笼，租金计划Id：" + rent_id
				+ ",更新结果：" + (res > 0 ? " -成功- " : " -失败- "));
		// 3.释放资源
		erpDataSource.close();
		// 返回
		return res;
	}

	/**
	 * 插入实收记录 (租金实收、违约金实收)
	 * 
	 * @param rent_id
	 * @param ebdata_id
	 * @param creator
	 * @return
	 * @throws SQLException
	 */
	private int operInsFundRentCharge(String rent_id, String ebdata_id,
			String fee_type, String creator) throws SQLException {
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
		@SuppressWarnings("unused")
		String fact_money = "";// 暂时不用
		String fact_date = "";
		String money_type = "";
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
			money_type = rs2.getString("money_type");
		}

		// 2.2租金实收sql拼接
		StringBuffer sqlBuffer = new StringBuffer();
		if (fee_type != null && "租金".equals(fee_type)) {
			sqlBuffer
					.append(
							"Insert into fund_rent_income(contract_id,begin_id,ebank_number,plan_list,hire_list,hire_type,")
					.append(
							"hire_date,rent,currency,corpus,interest,hire_object,hire_bank,hire_number,")
					.append(
							"receipt_bank,receipt_number,match_id,creator,create_date)");

			sqlBuffer.append(
					" Select verhd.contract_id,verhd.begin_id,'" + ebdata_id
							+ "',verhd.rent_list,verhd.rent_list,'11','"
							+ fact_date + "',frp.rent,'" + money_type
							+ "',frp.corpus,frp.interest,verhd.cust_id,'"
							+ client_bank + "','" + client_accnumber + "','"
							+ account_bank + "','" + acc_number
							+ "',verhd.id,'" + creator + "','"
							+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
							+ "'").append(
					" From vi_ebank_rent_hire_detail verhd ").append(
					" left join fund_rent_plan frp on ").append(
					" verhd.id=frp.id ").append(
					"  where verhd.id='" + rent_id + "'");
			this.operFundRentPenalty(rent_id, fact_date, ebdata_id);
		}

		partSql = sqlBuffer.toString();
		res = erpDataSource.executeUpdate(partSql);
		LogWriter.logDebug("插入[" + fee_type + "]实收记录，计划Id：" + rent_id
				+ ",更新结果：" + (res > 0 ? " -成功- " : " -失败- "));
		// 3.释放资源
		erpDataSource.close();

		return res;
	}

	/**
	 * 违约金处理
	 * 
	 * @param rent_id
	 * @param fact_date
	 * @param ebdata_id
	 * @throws SQLException
	 */
	private void operFundRentPenalty(String rent_id, String fact_date,
			String ebdata_id) throws SQLException {
		// =======变量赋值区=======
		String contract_id = "";
		String begin_id = "";
		String rent_list = "";
		String plan_date = "";
		String curr_rent = "";
		String free_defa_inter_day = "";
		String pena_rate = "";
		String last_hire_date = "";
		String plan_bank_name = "";
		String plan_bank_no = "";
		int pena_day = 0;
		String penalty = "";
		// =======变量赋值区=======
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";// 查询罚息减免天数+租金计划日期+罚息利率
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer
				.append(
						"Select frp.id,frp.contract_id,frp.begin_id,frp.rent_list,frp.plan_bank_name,frp.plan_bank_no,")
				.append(
						" frp.plan_date,frp.curr_rent,bi.pena_rate,bi.free_defa_inter_day,frp.last_hire_date");
		sqlBuffer.append(" from fund_rent_plan frp").append(
				" left join begin_info bi on bi.begin_id=frp.begin_id").append(
				" where frp.id='" + rent_id + "'");
		partSql = sqlBuffer.toString();

		ResultSet rs2 = erpDataSource.executeQuery(partSql);
		if (rs2.next()) {
			// 相关变量赋值
			contract_id = rs2.getString("contract_id");
			begin_id = rs2.getString("begin_id");
			rent_list = rs2.getString("rent_list");
			plan_date = rs2.getString("plan_date");
			curr_rent = rs2.getString("curr_rent");
			pena_rate = rs2.getString("pena_rate");
			free_defa_inter_day = rs2.getString("free_defa_inter_day");
			last_hire_date = rs2.getString("last_hire_date");
			plan_bank_name = rs2.getString("plan_bank_name");
			plan_bank_no = rs2.getString("plan_bank_no");
		}

		// 3.1判断核销是否逾期
		if (CommonTool.compare_date(plan_date, fact_date)) {// 代表逾期
			// 3.2求逾期天数
			pena_day = CommonTool.date_diff(plan_date, fact_date);
			// 3.3判断逾期天数 与 逾期减免天数 大小
			if (ConvertUtil.parseInt(free_defa_inter_day, 0) < pena_day) {
				// 3.4.0判断逾期金额是否超过罚息额度
				boolean flag = true;
				if (last_hire_date != null && !"".equals(last_hire_date)) {
					if (Double.parseDouble(MathExtend.subtract(curr_rent,
							getPenaltyLimit(plan_date))) <= 0) {
						flag = false;
					}
				}

				if (flag) {
					// 3.4.1已经逾期，测算逾期产生的罚息金额
					penalty = this.calcPenalty(curr_rent, pena_rate, pena_day);
					// 3.5更新插入罚息表
					partSql = "Insert into fund_penalty_plan(uuid,begin_id,contract_id,rent_list,";
					partSql += " penalty_rent,penalty_rent_planDate,penalty_rent_hireDate,";
					partSql += " penalty_day_amount,penalty,curr_penalty,plan_date,plan_bank_name,";
					partSql += " plan_bank_no,plan_status,match_id,state)";
					partSql += " Values('" + CommonTool.getUUID() + "','"
							+ begin_id + "','" + contract_id + "','"
							+ rent_list + "','" + curr_rent + "','" + plan_date
							+ "','" + fact_date + "','" + pena_day + "','"
							+ penalty + "','" + penalty + "','" + plan_date
							+ "','" + plan_bank_name + "','" + plan_bank_no
							+ "','未回笼','" + rent_id + "','0')";

					erpDataSource.executeUpdate(partSql);
					LogWriter.logDebug("插入罚息记录，违约租金：" + curr_rent + " 产生罚息："
							+ penalty);
					// 3.6更新租金计划的罚息字段
					partSql = "Update fund_rent_plan set pena_status='未回笼',curr_penalty=(isnull(curr_penalty,0)+"
							+ penalty
							+ "),penalty=(isnull(penalty,0)+"
							+ penalty + "),";
					partSql += "last_hire_date='" + fact_date + "' Where id='"
							+ rent_id + "'";
					erpDataSource.executeUpdate(partSql);
					LogWriter.logDebug("更新租金计划的罚息字段，罚息金额：" + penalty);
				}
			}
		}
		// 4.释放资源
		erpDataSource.close();
	}

	/**
	 * 查询罚息减免额度
	 * 
	 * @param plan_date
	 * @return
	 * @throws SQLException
	 */
	private String getPenaltyLimit(String plan_date) throws SQLException {
		String res = "0";
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		partSql = "Select penalty_limit from sys_penalty_limit Where '"
				+ plan_date + "'>=start_date and '" + plan_date + "'<=end_date";

		ResultSet rs2 = erpDataSource.executeQuery(partSql);
		if (rs2.next()) {
			res = rs2.getString("penalty_limit");
		}
		// 3.释放资源
		erpDataSource.close();
		// 返回
		return res;
	}

	/**
	 * 计算违约金
	 * 
	 * @param curr_rent
	 * @param pena_rate
	 * @param pena_day
	 * @return
	 */
	private String calcPenalty(String curr_rent, String pena_rate, int pena_day) {
		// 逾期租金 * 逾期天数 * 罚息日利率 / 10000
		String penalty = MathExtend.divide((MathExtend.multiply(curr_rent,
				MathExtend.multiply(pena_rate, String.valueOf(pena_day)))),
				String.valueOf(10000));
		penalty = MathExtend.round(penalty, 2);
		return penalty;
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
			partSql = "Update apply_info set status='全部核销',fact_date='"
					+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
					+ "' where glide_id='" + glide_id + "'";
		} else {// 部分核销
			partSql = "Update apply_info set status='部分核销',fact_date='"
					+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:ss")
					+ "' where glide_id='" + glide_id + "'";
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
	 * @param plan_money
	 * @return
	 * @throws SQLException
	 */
	private int operUpdFundEbankData(String ebdata_id, String plan_money)
			throws SQLException {
		int res = 0;
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "Update fund_ebank_data set used_money='" + plan_money
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
	 * 匹配指定网银上传Id下网银数据进行匹配，匹配规则
	 * 
	 * <pre>
	 * 付款人 + 付款账号 + 金额
	 * </pre>
	 * 
	 * @param up_id
	 * @param pay_obj
	 * @param pay_money
	 * @return
	 * @throws SQLException
	 */
	private String judgeItemExists(String up_id, String cust_id,
			String plan_money) throws SQLException {
		String ebdata_id = "";
		// 1.获取连接
		erpDataSource=new ERPDataSource();
		// 2.执行判断
		String partSql = "";
		partSql = "Select ebdata_id from fund_ebank_data where up_id='"
				+ up_id
				+ "' and client_name=(select cust_name from vi_cust_all_info where cust_id='"
				+ cust_id + "')";
		partSql += " and left_money='"
				+ plan_money
				+ "' and client_acc_number=(select acc_number from cust_account where cust_id='"
				+ cust_id + "' and acc_status='是') and status=0 ";
		partSql += " and business_flag=0";

		ResultSet rs2 = erpDataSource.executeQuery(partSql);
		if (rs2.next()) {
			ebdata_id = rs2.getString("ebdata_id");
		}
		LogWriter.logDebug("匹配网银数据" + partSql + ", 匹配结果："
				+ ("".equals(ebdata_id) ? " -失败- " : " -成功-"));
		// 3.释放资源
		erpDataSource.close();
		// 返回
		return ebdata_id;
	}

	public static void main(String[] args) {
		RentHire rentHire = new RentHire();
		System.out.println("222222222222--------2sssssssss");
		// 核销
		try {
			rentHire.hireRent("EF2011-11-242-20", "2011-11-242-42",
					"rent_Ebank_hire", "ADMN-8HT5FP");
		} catch (SQLException e) {
			e.printStackTrace();
		}

//		 Debug：Host1 Server创建新的连接池，对象Id：com.tenwa.culc.util.HostDataSource@d3d6f
//		 2011-12-20 17:32:15,109 INFO com.mchange.v2.c3p0.impl.AbstractPoolBackedDataSource.\
//		getPoolManager() - Initializing c3p0 pool... com.mchange.v2.c3p0.ComboPooledDataSource 
//		[ acquireIncrement -> 3, acquireRetryAttempts -> 30, acquireRetryDelay -> 1000, 
//		autoCommitOnClose -> false, automaticTestTable -> null, breakAfterAcquireFailure -> 
//		false, checkoutTimeout -> 0, connectionCustomizerClassName -> null,
//		connectionTesterClassName -> com.mchange.v2.c3p0.impl.DefaultConnectionTester,
//		dataSourceName -> 1hge0ys8kp7471slvztlm|1e152c5, debugUnreturnedConnectionStackTraces -> 
//		false, description -> null, driverClass -> com.microsoft.sqlserver.jdbc.SQLServerDriver, 
//		factoryClassLocation -> null, forceIgnoreUnresolvedTransactions -> false, 
//		identityToken -> 1hge0ys8kp7471slvztlm|1e152c5, idleConnectionTestPeriod -> 60, 
//		initialPoolSize -> 5, jdbcUrl -> jdbc:sqlserver://db.culc.com:1433;databasename=CulcLeasing, 
//		lastAcquisitionFailureDefaultUser -> null, maxAdministrativeTaskTime -> 0,
//		maxConnectionAge -> 0, maxIdleTime -> 60, maxIdleTimeExcessConnections -> 0, 
//		maxPoolSize -> 15, maxStatements -> 50, maxStatementsPerConnection -> 0, 
//		minPoolSize -> 3, numHelperThreads -> 3, numThreadsAwaitingCheckoutDefaultUser -> 0, 
//		preferredTestQuery -> null, properties -> {user=******, password=******}, 
//		propertyCycle -> 0, testConnectionOnCheckin -> false, testConnectionOnCheckout -> false, 
//		unreturnedConnectionTimeout -> 0, usesTraditionalReflectiveProxies -> false ]

			 
	}
}
