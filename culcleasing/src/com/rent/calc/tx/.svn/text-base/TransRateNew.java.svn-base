package com.rent.calc.tx;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * 调息测算类2010-08-03
 * 
 * @author Administrator
 * 
 */
public class TransRateNew {

	

	

//	/**
//	 * 
//	 * @param adjustId
//	 *            调息表的id
//	 * @param projs
//	 *            所对应的项目
//	 * @throws Exception
//	 */
//	@SuppressWarnings("unchecked")
//	public void processInterest(String adjustId, List projs) throws Exception {
//		// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变
////		// // 0,1,2,3
//
//		Conn conn = new Conn();
//		// 循环页面传过来的项目
//		for (int i = 0; i < projs.size(); i++) {
//			if (getContractFloatType(projs.get(i).toString())) {// 当合同不需要调整时
//				continue;
//			}
//
//			// 根据所要调整的id，得到利率调整的信息
//			HashMap adjust_map = this.getAdjustInterInfo(adjustId);
//
//			// 判断该项目是否可以进行调息
//			HashMap rent_list_map = CalcUtil.getQcInfo(projs.get(i).toString(),
//					adjust_map.get("start_date").toString());
//
//			// 当总的期数大于或等于后面所要调的期数时
//			if (Integer.parseInt(rent_list_map.get("nextTerm").toString()) <= Integer
//					.parseInt(rent_list_map.get("totalTerm").toString())) {
//
//				// 计算出的年利率,得到他的利率浮动类型 ,得到他的交易结构信息
//				HashMap condtion_info = CalcUtil
//						.getProj_ConditionInfoByProj_id(
//								projs.get(i).toString(), rent_list_map.get(
//										"nextTerm").toString());
//
//				String flo_type = condtion_info.get("rate_float_type")
//						.toString();
//
//				// 等额本金时，不做讨论
//				if ("2".equals(condtion_info.get("measure_type").toString())) {
//					continue;
//				}
//
//				// --调整前偿还计划插入调息历史
//				String sql = "	insert into dbo.fund_rent_plan_his(interest_market,corpus_market,corpus_overage_market,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select interest_market,corpus_market,corpus_overage_market, contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'调息','"
//						+ adjustId
//						+ "','前' from fund_rent_plan 	 where contract_id='"
//						+ projs.get(i).toString() + "'";
//				conn.executeUpdate(sql);
//
//				boolean is_fix_value = false;// 是不是给每一期的租金添加固定的值
//
//				// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变
//				// // 0,1,2,3,4
//				String retu_vale = "0.0";
//				if ("0".equals(flo_type)) {// 按央行利率浮动比率
//					retu_vale = this.getRateByBaseRate(condtion_info.get(
//							"lease_term").toString(), adjust_map, condtion_info
//							.get("rate_float_amt").toString());
//
//				} else if ("1".equals(flo_type)) {// 按央行利率加点
//					retu_vale = this.getRateByPoint(condtion_info.get(
//							"lease_term").toString(), condtion_info.get(
//							"rate_float_amt").toString(), adjust_map);
//
//				} else if ("2".equals(flo_type)) {// 固定调整租金金额
//					retu_vale = this.getFixed(condtion_info.get("lease_term")
//							.toString(), condtion_info.get("rate_float_amt")
//							.toString(), adjust_map);
//					is_fix_value = true;//
//				}
//
//				System.out.println("=新利率：=" + retu_vale);
//				if (!is_fix_value) {// 不是固定添加租金时
//
//					condtion_info.put("retu_vale", retu_vale);// 利率调整值
//					condtion_info.put("proj_id", projs.get(i).toString());// 合同号
//					condtion_info.put("start_date", adjust_map
//							.get("start_date").toString());// 调息日
//					condtion_info.put("nextTerm", rent_list_map.get("nextTerm")
//							.toString());// 所要调整的第一期的期次
//					condtion_info.put("rem_rent_list", rent_list_map
//							.get("remTerm"));// 剩余所有要调整的期数
//
//					// 得到调息中的宽限期的期数
//					sql = " select isnull(count(*),0) c from fund_rent_plan where convert(varchar(10),plan_date,120) > '"
//							+ adjust_map.get("start_date").toString()
//							+ "'  and isnull(corpus,0)=0   and contract_id='"
//							+ projs.get(i).toString()
//							+ "' having(count(*)<"
//							+ condtion_info.get("grace").toString() + ") ";
//
//					ResultSet rs = null;
//					int igrace = 0;
//					rs = conn.executeQuery(sql);
//					if (rs.next()) {
//						igrace = rs.getInt(1);
//					}
//
//					// 宽限期，延迟付款期数
//					condtion_info.put("igrace", igrace);
//					// ////////////////////////////////////////////////////////
//					// 判断租金调整方式是不是常规
//					if ("".equals(condtion_info.get("ajdustStyle").toString())
//							|| condtion_info.get("ajdustStyle").toString()
//									.length() == 0) {// 常规调息
//						// 更新租金计划
//						// 常规的测算类
//						RentTxNormal rtnormal = new RentTxNormal();
//						rtnormal.calRentByNew(condtion_info, projs.get(i)
//								.toString());
//
//					} else {// 按租金调整方式
//						// 按次日,按次月,按次期,按次年,平息法 0,1,2,3,4
//						// 调用按租金调整的类
//						RentTxAdjustStyle rtadjust = new RentTxAdjustStyle();
//						rtadjust.calRentByAdjustStyle(condtion_info);
//					}
//
//					// //////////////////////////////////////////
//
//					// --修改调息项目表,添加调息项目信息
//					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,before_rate,after_rate,rent_list_start,adjust_id,contract_id) select '是',";
//					ins_sql += "'" + condtion_info.get("year_rate").toString()
//							+ "','" + retu_vale + "','"
//							+ rent_list_map.get("nextTerm").toString() + "','"
//							+ adjustId + "','" + projs.get(i).toString() + "'";
//					conn.executeUpdate(ins_sql);
//
//				} else {// 给每一期固定加一定值时
//
//					this.addRent(projs.get(i).toString(), rent_list_map.get(
//							"nextTerm").toString(), retu_vale);
//
//					// --修改调息项目表
//					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,rent_list_start,adjust_id,contract_id,adjust_amt)  select '是','";
//					ins_sql += rent_list_map.get("nextTerm").toString() + "','"
//							+ adjustId + "','" + projs.get(i).toString()
//							+ "','" + retu_vale + "'";
//
//					conn.executeUpdate(ins_sql);
//
//				}
//
//			}
//
//			// --调整后偿还计划插入调息历史,更新合同交易结构表
//			String upd_sql = "  insert into dbo.fund_rent_plan_his(interest_market,corpus_market,corpus_overage_market,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select interest_market,corpus_market,corpus_overage_market, contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'调息','"
//					+ adjustId
//					+ "','后' from fund_rent_plan where contract_id='"
//					+ projs.get(i).toString() + "'";
//			conn.executeUpdate(upd_sql);
//
//		}
//
//	}
//
//	
//
//	

	

}
