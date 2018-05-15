package com.rent.calc.tx.bg;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.condition.CashFlow;
import com.condition.Tx_Init;
import com.rent.calc.settlaw.SettlawTranRate;

import dbconn.Conn;

/**
 * 调息测算类2010-08-03
 * 
 * @author Administrator
 * 
 */
public class TransRateNew {

	/**
	 * 
	 * @param adjustId
	 *            调息表的id
	 * @param projs
	 *            所对应的项目
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void processInterest(String adjustId, List projs, String creator)
			throws Exception {
		// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变 0,1,2,3
		CoditionInfo ci = new CoditionInfo();

		// 根据所要调整的id，得到利率调整的信息
		FundStanInter fsi = new FundStanInter();
		Hashtable adjust_map = fsi.getAdjustInterInfo(adjustId);

		
		//2011-04-08财务凭证生成
		Vouchers vc = new Vouchers();
		String vouchNumber = vc.getVouchNumber();
		
		System.out.println("财务凭证号："+vouchNumber);
		
		int icount =1;
		
		// 保留单一的合同用于现金流明细的处理
		List list = new ArrayList();
		// 循环页面传过来的项目
		for (int i = 0; i < projs.size(); i++) {

			// 先判断该合同是否可以进行调息
			if (ci.getContractFloatType(projs.get(i).toString())) {// 当合同不需要调整时
				continue;
			}

			// 添加要处理明细的合同
			list.add(projs.get(i).toString());

			// --调整前偿还计划插入调息历史
			FundRentHis frh = new FundRentHis();
			frh.addRentHisBeforeInfo(adjustId, projs.get(i).toString());

			// 添加现金流明细历史记录
			Tx_Init tx_Init = new Tx_Init();

			// 2011-01-12修改
			// 第一步：先建现金流的2张his表 fund_contract_plan_his
			// fund_contract_plan_mark_his
			// 前半部分字段和fund_contract_plan,fund_contract_plan_mark一致，
			// 在增加字段：mod_reason 修改原因（调息）,measure_id,status（前）
			tx_Init.insert_HisTable_First(list, adjustId);

			boolean is_fix_value = false;// 是不是给每一期的租金添加固定的值

			// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变 0,1,2,3
			String retu_vale = "0";
			Hashtable htb = getReturnRateValueByContract_id(projs.get(i)
					.toString(), adjustId);
			retu_vale = htb.get("retu_vale").toString();
			is_fix_value = Boolean.parseBoolean(htb.get("is_fix_value")
					.toString());

			System.out.println("=新利率：=" + retu_vale);

			String start_term = getStartTerm(projs.get(i).toString(),
					adjust_map.get("start_date").toString());

			if (!is_fix_value) {// 不是固定添加租金时
				getCalcStyle(projs.get(i).toString(), adjust_map.get(
						"start_date").toString(), start_term, retu_vale,
						adjustId);

			} else {// 给每一期固定加一定值时

				this.addRent(projs.get(i).toString(), start_term, retu_vale,
						adjust_map.get("start_date").toString());
				// --修改调息项目表
				fsi.insertFixValueData(start_term, adjustId, projs.get(i)
						.toString(), retu_vale);
			}
			// --调整后偿还计划插入调息历史,更新合同交易结构表
			frh.addRentHisAfterInfo(adjustId, projs.get(i).toString());

			// 添加现金流明细记录 新算现金流明细
			CashFlow cashFlow = new CashFlow();
			cashFlow.addCashFlow(list, adjustId);

			// 往2张his表 fund_contract_plan_his fund_contract_plan_mark_his插入数据
			// 状态为（后），数据从fund_contract_plan,fund_contract_plan_mark中取 插入之前先删除
			tx_Init.insert_HisTable_End(list, adjustId);

			// 更新调息信息 创建人，创建时间等 2011-01-06

			String sql = " update  fund_adjust_interest_contract set  create_date = getdate(),creator = '"
					+ creator + "' ";
			sql = sql + " where  adjust_id = '" + adjustId + "'";
			sql = sql + " and  contract_id = '" + projs.get(i).toString() + "'";
			System.out.println("sql--->" + sql);
			
			
			//2010-04-08修改，财务凭证处数据写入
			
			String endInterest = vc.getContractInterBalance(projs.get(i).toString(),adjustId);
			if (Double.parseDouble(endInterest)>0) {
				//借方
				vc.processVouch(projs.get(i).toString(), "", vouchNumber, "", "", "", "1", String.valueOf(icount), "153101", adjustId);
				icount++;
				//贷方
				vc.processVouch(projs.get(i).toString(), "", vouchNumber, "", "", "", "2", String.valueOf(icount), "153201", adjustId);
				icount++;
			}
			

			Conn conn = new Conn();
			conn.executeUpdate(sql);
			ToolUtil.closeRSOrConn(null, conn);

			// 清理list元素
			list.clear();

		}

	}


	/**
	 * 根据合同号，调息方式，调息日期 得到他的最小的期次
	 * 
	 * @param contractId
	 * @param type
	 * @param txrq
	 * @return
	 * @throws Exception
	 */
	public String getStartTerm(String contractId, String txrq) throws Exception {

		FundRentPlan frp = new FundRentPlan();
		// 合同号得到调息方式
		CoditionInfo ci = new CoditionInfo();
		String adjustType = ci.getAdjustSty(contractId);
		// 按次日,按次月,按次期,按次年0,1,2,3

		String sdate = txrq;
		if ("3".equals(adjustType)) {
			// 根据调息日得到他的下一年
			sdate = ToolUtil.getYearFirstDate(txrq);
		}
		if ("1".equals(adjustType)) {
			// 月的第一天
			sdate = ToolUtil.getFirstDayByDate(txrq);
		}
		String start_term = frp.getAdjustMinRentList(contractId, sdate);
		return start_term;

	}


	/**
	 * 判断调息的类型 调用相应的测算类
	 * 
	 * @param contract_id
	 * @param txrq
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void getCalcStyle(String contract_id, String txrq,
			String start_term, String rateValue, String adjustId)
			throws Exception {

		CoditionInfo ci = new CoditionInfo();
		String adjust_style = ci.getAdjustSty(contract_id);

		// 判断调息方式 2010-12-08
		Hashtable htc = ci.getRateType(contract_id);
		// 根据合同号得到延迟期 数
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		if ("5".equals(ht.get("measure_type").toString())) {// 平息法调息时（单体项目）

			// 分从宽限期开始调 grace，正常的调息
			// if (ht.get("grace") != null
			// && Integer.parseInt(ht.get("grace").toString()) >= Integer
			// .parseInt(start_term)) {// 当宽限期大于等于开始调息日期时
			//				
			//				
			//				
			//
			// } else {// 正常时
			// 按次日,按次月,按次期,按次年 0,1,2,3
			SettlawTranRate str = new SettlawTranRate();
			str.calRentBySettled(contract_id, txrq, start_term, rateValue,
					adjust_style);
			// 平息法变更都是从下一期才开始发生的利率的变更所以开始期项得加1,除了次期之外
			if (!"2".equals(adjust_style)) {// 非次期时
				start_term = String.valueOf(Integer.parseInt(start_term) + 1);
			}

			// }

		} else {

			// 分从宽限期开始调 grace，正常的调息
			if ("".equals(adjust_style) || adjust_style.length() == 0) {// 常规调息
				adjust_style = "0";// 次日调息
			}// else {// 按租金调整方式
			// 按次日,按次月,按次期,按次年 0,1,2,3调用按租金调整的类
			// RentTxAdjustStyle rtadjust = new RentTxAdjustStyle();
			// rtadjust.calRentByAdjustStyle(contract_id, txrq, start_term,
			// rateValue, adjust_style);
			// }
			// 判断租金调整方式是不是常规

			// if (ht.get("grace") != null
			// && Integer.parseInt(ht.get("grace").toString()) >= Integer
			// .parseInt(start_term)) {// 当宽限期大于等于开始调息日期时
			//				
			//				
			//				
			//
			// } else {// 正常时
			RentTxAdjustStyle rtadjust = new RentTxAdjustStyle();
			rtadjust.calRentByAdjustStyle(contract_id, txrq, start_term,
					rateValue, adjust_style);

			// }

		}

		FundStanInter fsi = new FundStanInter();
		// --修改调息项目表,添加调息项目信息
		fsi.insertValueData(start_term, adjustId, contract_id, rateValue, ci
				.getYearRate(contract_id));

	}


	/**
	 * 固定值时添加每一期的租金
	 * 
	 * 本金不变，利息增加
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param add_value
	 * @throws Exception
	 */
	public void addRent(String proj_id, String start_term, String add_value,
			String txrq) throws Exception {
		// 更新市场的租金计划值
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.processMarketRentPlan(proj_id, start_term, add_value);
		// 更新财务的
		FinacRentPlan frp = new FinacRentPlan();
		// 固定加值是从次期开始的
		frp.proceFinaceInfo(proj_id, String.valueOf(Integer
				.parseInt(start_term) + 1), txrq);
	}


	/**
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getReturnRateValueByContract_id(String contract_id,
			String txid) throws Exception {
		// rate_float_type
		Hashtable ht = new Hashtable();

		// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变，平息法 0,1,2,3,4
		CoditionInfo ci = new CoditionInfo();
		Hashtable htc = ci.getRateType(contract_id);

		FundStanInter fsi = new FundStanInter();
		Hashtable adjust_ht = fsi.getAdjustInterInfo(txid);

		boolean is_fix_value = false;
		String flo_type = htc.get("rate_float_type").toString();

		String retu_vale = "0";
		if ("0".equals(flo_type)) {// 按央行利率浮动比率
			retu_vale = fsi.getRateByBaseRate(htc.get("lease_term").toString(),
					adjust_ht, htc.get("rate_float_amt").toString());

		} else if ("1".equals(flo_type)) {// 按央行利率加点
			retu_vale = fsi.getRateByPoint(htc.get("lease_term").toString(),
					htc.get("rate_float_amt").toString(), adjust_ht);

		} else if ("2".equals(flo_type)) {// 固定调整租金金额
			retu_vale = fsi.getFixed(htc.get("lease_term").toString(), htc.get(
					"rate_float_amt").toString(), adjust_ht);
			is_fix_value = true;//
		} else if ("4".equals(flo_type)) {// 平息法调息时（单体项目）

			retu_vale = fsi.getRateBySett(ci.getYearRate(contract_id), htc.get(
					"lease_term").toString(), adjust_ht);

		}
		ht.put("is_fix_value", is_fix_value);
		ht.put("retu_vale", retu_vale);
		return ht;

	}

}
