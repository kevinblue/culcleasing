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
 * ��Ϣ������2010-08-03
 * 
 * @author Administrator
 * 
 */
public class TransRateNew {

	

	

//	/**
//	 * 
//	 * @param adjustId
//	 *            ��Ϣ���id
//	 * @param projs
//	 *            ����Ӧ����Ŀ
//	 * @throws Exception
//	 */
//	@SuppressWarnings("unchecked")
//	public void processInterest(String adjustId, List projs) throws Exception {
//		// ���������ʸ�������,���������ʼӵ�,�̶����������,���ֲ���
////		// // 0,1,2,3
//
//		Conn conn = new Conn();
//		// ѭ��ҳ�洫��������Ŀ
//		for (int i = 0; i < projs.size(); i++) {
//			if (getContractFloatType(projs.get(i).toString())) {// ����ͬ����Ҫ����ʱ
//				continue;
//			}
//
//			// ������Ҫ������id���õ����ʵ�������Ϣ
//			HashMap adjust_map = this.getAdjustInterInfo(adjustId);
//
//			// �жϸ���Ŀ�Ƿ���Խ��е�Ϣ
//			HashMap rent_list_map = CalcUtil.getQcInfo(projs.get(i).toString(),
//					adjust_map.get("start_date").toString());
//
//			// ���ܵ��������ڻ���ں�����Ҫ��������ʱ
//			if (Integer.parseInt(rent_list_map.get("nextTerm").toString()) <= Integer
//					.parseInt(rent_list_map.get("totalTerm").toString())) {
//
//				// �������������,�õ��������ʸ������� ,�õ����Ľ��׽ṹ��Ϣ
//				HashMap condtion_info = CalcUtil
//						.getProj_ConditionInfoByProj_id(
//								projs.get(i).toString(), rent_list_map.get(
//										"nextTerm").toString());
//
//				String flo_type = condtion_info.get("rate_float_type")
//						.toString();
//
//				// �ȶ��ʱ����������
//				if ("2".equals(condtion_info.get("measure_type").toString())) {
//					continue;
//				}
//
//				// --����ǰ�����ƻ������Ϣ��ʷ
//				String sql = "	insert into dbo.fund_rent_plan_his(interest_market,corpus_market,corpus_overage_market,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select interest_market,corpus_market,corpus_overage_market, contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'��Ϣ','"
//						+ adjustId
//						+ "','ǰ' from fund_rent_plan 	 where contract_id='"
//						+ projs.get(i).toString() + "'";
//				conn.executeUpdate(sql);
//
//				boolean is_fix_value = false;// �ǲ��Ǹ�ÿһ�ڵ������ӹ̶���ֵ
//
//				// ���������ʸ�������,���������ʼӵ�,�̶����������,���ֲ���
//				// // 0,1,2,3,4
//				String retu_vale = "0.0";
//				if ("0".equals(flo_type)) {// ���������ʸ�������
//					retu_vale = this.getRateByBaseRate(condtion_info.get(
//							"lease_term").toString(), adjust_map, condtion_info
//							.get("rate_float_amt").toString());
//
//				} else if ("1".equals(flo_type)) {// ���������ʼӵ�
//					retu_vale = this.getRateByPoint(condtion_info.get(
//							"lease_term").toString(), condtion_info.get(
//							"rate_float_amt").toString(), adjust_map);
//
//				} else if ("2".equals(flo_type)) {// �̶����������
//					retu_vale = this.getFixed(condtion_info.get("lease_term")
//							.toString(), condtion_info.get("rate_float_amt")
//							.toString(), adjust_map);
//					is_fix_value = true;//
//				}
//
//				System.out.println("=�����ʣ�=" + retu_vale);
//				if (!is_fix_value) {// ���ǹ̶�������ʱ
//
//					condtion_info.put("retu_vale", retu_vale);// ���ʵ���ֵ
//					condtion_info.put("proj_id", projs.get(i).toString());// ��ͬ��
//					condtion_info.put("start_date", adjust_map
//							.get("start_date").toString());// ��Ϣ��
//					condtion_info.put("nextTerm", rent_list_map.get("nextTerm")
//							.toString());// ��Ҫ�����ĵ�һ�ڵ��ڴ�
//					condtion_info.put("rem_rent_list", rent_list_map
//							.get("remTerm"));// ʣ������Ҫ����������
//
//					// �õ���Ϣ�еĿ����ڵ�����
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
//					// �����ڣ��ӳٸ�������
//					condtion_info.put("igrace", igrace);
//					// ////////////////////////////////////////////////////////
//					// �ж���������ʽ�ǲ��ǳ���
//					if ("".equals(condtion_info.get("ajdustStyle").toString())
//							|| condtion_info.get("ajdustStyle").toString()
//									.length() == 0) {// �����Ϣ
//						// �������ƻ�
//						// ����Ĳ�����
//						RentTxNormal rtnormal = new RentTxNormal();
//						rtnormal.calRentByNew(condtion_info, projs.get(i)
//								.toString());
//
//					} else {// ����������ʽ
//						// ������,������,������,������,ƽϢ�� 0,1,2,3,4
//						// ���ð�����������
//						RentTxAdjustStyle rtadjust = new RentTxAdjustStyle();
//						rtadjust.calRentByAdjustStyle(condtion_info);
//					}
//
//					// //////////////////////////////////////////
//
//					// --�޸ĵ�Ϣ��Ŀ��,��ӵ�Ϣ��Ŀ��Ϣ
//					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,before_rate,after_rate,rent_list_start,adjust_id,contract_id) select '��',";
//					ins_sql += "'" + condtion_info.get("year_rate").toString()
//							+ "','" + retu_vale + "','"
//							+ rent_list_map.get("nextTerm").toString() + "','"
//							+ adjustId + "','" + projs.get(i).toString() + "'";
//					conn.executeUpdate(ins_sql);
//
//				} else {// ��ÿһ�ڹ̶���һ��ֵʱ
//
//					this.addRent(projs.get(i).toString(), rent_list_map.get(
//							"nextTerm").toString(), retu_vale);
//
//					// --�޸ĵ�Ϣ��Ŀ��
//					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,rent_list_start,adjust_id,contract_id,adjust_amt)  select '��','";
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
//			// --�����󳥻��ƻ������Ϣ��ʷ,���º�ͬ���׽ṹ��
//			String upd_sql = "  insert into dbo.fund_rent_plan_his(interest_market,corpus_market,corpus_overage_market,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select interest_market,corpus_market,corpus_overage_market, contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'��Ϣ','"
//					+ adjustId
//					+ "','��' from fund_rent_plan where contract_id='"
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
