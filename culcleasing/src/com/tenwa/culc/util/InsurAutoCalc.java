/**
 * 保费自动测算
 */
package com.tenwa.culc.util;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.tenwa.log.LogWriter;

/**
 * @author Jaffe 保费自动计算
 */
public class InsurAutoCalc {

	private static ERPDataSource erpDataSource = null;

	// 公共参数
	private static ResultSet rs = null;

	/**
	 * 自动计算保费信息并插入数据库
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param item1
	 * @param item2
	 * @param czId
	 * @return
	 */
	public int autoCalc(String contract_id, String doc_id, String item1,
			String item2, String dqczy, String cust_name) {
		int resVal = 0;

		erpDataSource = new ERPDataSource();

		// 1删除历史
		String sqlstr = "Delete from contract_fund_fund_charge_plan_bxf_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";
		System.out.print("1删除历史：" + sqlstr);
		try {
			erpDataSource.executeUpdate(sqlstr);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}

		// 插入 - 每次续保，以12月为一个投保期限，续保？？多久算续保
		int tbQxN = Integer.parseInt(item2);
		int n12 = tbQxN / 12;
//		int nTbqx = 0;
		//0-1计算第一次就可以
		String sqlStr = "";
		sqlStr = getInsurSql(contract_id, doc_id, item1, String
				.valueOf(tbQxN), dqczy, cust_name);
		try {
			resVal += erpDataSource.executeUpdate(sqlStr);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		//2012-9-10 张建军来说明情况了 16:10
//		for (int i = 0; i < n12; i++) {
//			nTbqx = tbQxN - 12 * i;// 当前投保期限
//			System.out.print("当前投保期限：" + nTbqx);
//			sqlStr = getInsurSql(contract_id, doc_id, item1, String
//					.valueOf(nTbqx), dqczy, cust_name);
//
//			try {
//				resVal += erpDataSource.executeUpdate(sqlStr);
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		//0-2自动计算续保的金额
		n12 = tbQxN % 12>0? (n12): (--n12) ;
		double bfM2 = calcInsurMoney(item1, item2);
		for (int i = 0; i < n12; i++) {
			bfM2 = MathExtend.multiply(bfM2, 0.92);
			System.out.print("当前投保期限：保费金额：" + bfM2);
			sqlStr = getInsurSql2(contract_id, doc_id, bfM2, dqczy, cust_name);

			try {
				resVal += erpDataSource.executeUpdate(sqlStr);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return resVal;
	}

	public static void main(String[] args) {
		int tbQxN = Integer.parseInt("60");
		int n12 = tbQxN / 12;
		int nTbqx = 0;
		for (int i = 0; i < n12; i++) {
			nTbqx = tbQxN - 12 * i;// 当前投保期限
			System.out.println("当前投保期限：" + nTbqx);
		}

	}

	/**
	 * 创建插入Sql
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param item1
	 * @param item2
	 * @param czId
	 * @param cust_name
	 * @return
	 */
	private String getInsurSql(String contract_id, String doc_id, String item1,
			String item2, String dqczy, String cust_name) {
		String sqlstr = "";
		erpDataSource = new ERPDataSource();

		// 计算保费金额
		double bfM = calcInsurMoney(item1, item2);

		// 获取资金计划数据参数
		String id = "";
		String pay_way = "付款";// 款项方式
		String fee_type = "26";// 款项内容

		// 保费不做超过判断 2012-3-27 Jaffe
		// 2.1先查询出已经生产资金计划的金额
		int fee_num = 0;
		sqlstr = "select count(fee_num) as fee_num from contract_fund_fund_charge_plan_bxf_temp";
		sqlstr += " where contract_id='" + contract_id + "' and doc_id='"
				+ doc_id + "' and fee_type='" + fee_type + "'";
		try {
			rs = erpDataSource.executeQuery(sqlstr);
			if (rs.next()) {
				fee_num = rs.getInt("fee_num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		String fee_name = "自付保险费" + fee_num;
		String pay_obj = "0870060127"; // 159 1032 2128
		String pay_bank_name = "建行北京阜成路支行";
		String pay_bank_no = "11001085400059611337";
		String plan_bank_name = "";
		String plan_bank_no = "";
		String datestr = CommonTool.getSysDate("yyyy-MM-dd");
		String plan_date = datestr;
		String currency = "currency_type1";
		String plan_money = String.valueOf(bfM * 2);
		String pay_type = "01";
		String fpnote = ".";

		// 2.3插入资金计划
		sqlstr = "insert into contract_fund_fund_charge_plan_bxf_temp(make_contract_id,payment_id,doc_id,contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
		sqlstr += " pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)";
		// 付款 -- 设备款
		sqlstr += " select '" + id + "','" + CommonTool.getUUID() + "','"
				+ doc_id + "','" + contract_id + "','" + pay_type + "','"
				+ fee_type + "','" + fee_name + "','" + (fee_num + 1) + "','"
				+ plan_date + "','未核销','" + plan_money + "','" + plan_money
				+ "','" + currency + "','" + pay_obj + "',";
		sqlstr += "'" + pay_bank_name + "','" + pay_bank_no + "','"
				+ plan_bank_name + "','" + plan_bank_no + "','" + pay_way
				+ "','" + fpnote + "','" + dqczy + "','" + datestr + "','"
				+ dqczy + "','" + datestr + "'";

		LogWriter.logDebug("保费资金计划sql：" + sqlstr);

		return sqlstr;
	}

	
	/**
	 * 创建插入Sql2
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param bfM
	 * @param czId
	 * @param cust_name
	 * @return
	 */
	private String getInsurSql2(String contract_id, String doc_id, double bfM,
			 String dqczy, String cust_name) {
		String sqlstr = "";
		erpDataSource = new ERPDataSource();

		// 计算保费金额

		// 获取资金计划数据参数
		String id = "";
		String pay_way = "付款";// 款项方式
		String fee_type = "26";// 款项内容

		// 保费不做超过判断 2012-3-27 Jaffe
		// 2.1先查询出已经生产资金计划的金额
		int fee_num = 0;
		sqlstr = "select count(fee_num) as fee_num from contract_fund_fund_charge_plan_bxf_temp";
		sqlstr += " where contract_id='" + contract_id + "' and doc_id='"
				+ doc_id + "' and fee_type='" + fee_type + "'";
		try {
			rs = erpDataSource.executeQuery(sqlstr);
			if (rs.next()) {
				fee_num = rs.getInt("fee_num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		String fee_name = "自付保险费" + fee_num;
		String pay_obj = "0870060127"; // 159 1032 2128
		String pay_bank_name = "建行北京阜成路支行";
		String pay_bank_no = "11001085400059611337";
		String plan_bank_name = "";
		String plan_bank_no = "";
		String datestr = CommonTool.getSysDate("yyyy-MM-dd");
		String plan_date = datestr;
		String currency = "currency_type1";
		String plan_money = String.valueOf(bfM * 2);
		String pay_type = "01";
		String fpnote = ".";

		// 2.3插入资金计划
		sqlstr = "insert into contract_fund_fund_charge_plan_bxf_temp(make_contract_id,payment_id,doc_id,contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
		sqlstr += " pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)";
		// 付款 -- 设备款
		sqlstr += " select '" + id + "','" + CommonTool.getUUID() + "','"
				+ doc_id + "','" + contract_id + "','" + pay_type + "','"
				+ fee_type + "','" + fee_name + "','" + (fee_num + 1) + "','"
				+ plan_date + "','未核销','" + plan_money + "','" + plan_money
				+ "','" + currency + "','" + pay_obj + "',";
		sqlstr += "'" + pay_bank_name + "','" + pay_bank_no + "','"
				+ plan_bank_name + "','" + plan_bank_no + "','" + pay_way
				+ "','" + fpnote + "','" + dqczy + "','" + datestr + "','"
				+ dqczy + "','" + datestr + "'";

		LogWriter.logDebug("保费资金计划sql：" + sqlstr);

		return sqlstr;
	}
	
	/**
	 * 计算保费金额
	 * 
	 * @param item1
	 * @param item2
	 * @return
	 */
	private double calcInsurMoney(String item1, String item2) {
		// 目前天安针对我司的医疗、教育、印刷传媒相关设备，投保一切险的“年费率”为a=0.02% 。
		double aI = 0.0002;
		// 1.判断投保期限关系
		int tbQx = Integer.parseInt(item2);
		double bfM = 0d;
		if (tbQx < 12) {// 投保期限小于1年
			System.out.println(" 投保期限小于1年 ");
			// 当一次性投保期限n<1年时，比如一个月，参照短期费率表，投保一个月“年费率的百分比”为10%，
			// 则保险费计算如下，先计算M*(a*10%)/2，四舍五入小数点后保留两位结果为N，2*N为保费金额。
			double pa2 = 0d;
			switch (tbQx) {
			case 1:
				pa2 = 0.1;
			case 2:
				pa2 = 0.2;
			case 3:
				pa2 = 0.3;
			case 4:
				pa2 = 0.4;
			case 5:
				pa2 = 0.5;
			case 6:
				pa2 = 0.6;
			case 7:
				pa2 = 0.7;
			case 8:
				pa2 = 0.8;
			case 9:
				pa2 = 0.85;
			case 10:
				pa2 = 0.90;
			case 11:
				pa2 = 0.95;
			case 12:
				pa2 = 1;

			default:
				pa2 = 0.1;
			}

			bfM = MathExtend.parseDouble(MathExtend.divide((MathExtend
					.multiply(item1, String.valueOf(aI * pa2))), "2", 2));
		} else if (tbQx % 12 == 0) {// 整年
			System.out.println(" 整年 ");
			// 当一次性投保期限n为整年，比如n=1或2或3……，则保险费计算如下，
			// 先计算M*(n*a)/2元，四舍五入小数点后保留两位结果为N，2*N为保费金额。
			bfM = MathExtend.parseDouble(MathExtend
					.divide((MathExtend.multiply(item1, String.valueOf(aI
							* (tbQx / 12)))), "2", 2));
			System.out.println((tbQx / 12)
					+ "cesuan sad"
					+ MathExtend.multiply(item1, String
							.valueOf(0.0022 * (tbQx / 12))));

		} else {// 非整年有余数
			System.out.println(" 非整年有余数 ");
			// 当一次性投保期限不为整年且大于1年时，比如一次性投保期限为n年1个月，参照短期费率表，
			// 则保险费计算如下，先计算M*(n+10%)*a /2，四舍五入小数点后保留两位结果为N，2*N为保费金额。
			double pa2 = 0d;
			switch (tbQx % 12) {
			case 1:
				pa2 = 0.1;
			case 2:
				pa2 = 0.2;
			case 3:
				pa2 = 0.3;
			case 4:
				pa2 = 0.4;
			case 5:
				pa2 = 0.5;
			case 6:
				pa2 = 0.6;
			case 7:
				pa2 = 0.7;
			case 8:
				pa2 = 0.8;
			case 9:
				pa2 = 0.85;
			case 10:
				pa2 = 0.90;
			case 11:
				pa2 = 0.95;
			case 12:
				pa2 = 1;

			default:
				pa2 = 0.1;
			}

			bfM = MathExtend.parseDouble(MathExtend.divide(
					(MathExtend.multiply(item1, String.valueOf(aI
							* ((tbQx / 12) + pa2)))), "2", 2));
		}
		System.out.println("保费计算金额：" + bfM + "  期限：" + item2);

		return bfM;
	}

}
