package com.tenwa.culc.calc.util;

import java.util.List;

import com.tenwa.culc.calc.zjcs.RentCalc;
import com.tenwa.culc.calc.zjcs.RentCaleCommonTools;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentCashBean;
import com.tenwa.culc.bean.RentInfoBox;

import com.tenwa.culc.calc.zjcs.SetLawRentCaleUtil;

public class SettleLawUtil {

	/**
	 * @author toybaby 2011-07-20
	 * @param conditionBean
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static RentInfoBox getRentInfoBox(ConditionBean conditionBean) {

		RentInfoBox rentInfoBox = new RentInfoBox();
		String contract_id = conditionBean.getContract_id();
		String leaseMoney = String.valueOf(conditionBean.getLease_money());// 租赁本金
		String income_number = String.valueOf(conditionBean.getIncome_number());// 还租次数
		String yearRate = String.valueOf(conditionBean.getYear_rate());// 年利率
		String lease_interval = conditionBean.getIncome_number_year();// 租金间隔
		String caution_money = conditionBean.getCaution_money();// 保证金
//		String Other_expenditure = conditionBean.getOther_expenditure();// 其它支出
		String Other_expenditure = conditionBean.getNominalprice();// 残值收入
		String assets_value = conditionBean.getAssets_value();// 资产余值
		String rentScale = "0";// 租金精确度
		String newScale = "2";
		String grace = "0";
		String delay = "0";
		String type = "0";// 期末
		conditionBean.setPeriod_type("0");
		String plan_date = conditionBean.getStart_date();// 起租日期
		String firstMoney = String
				.valueOf("-" + conditionBean.getActual_fund());// 现金流第一期流量
		// 现金流部分调用
		// 装租金测算条件 9个
		RentCalc rent = new RentCalc();
		rent.setYear_rate(conditionBean.getYear_rate()); // 年利率
		rent.setIncome_number(conditionBean.getIncome_number());// 期数
		rent.setLease_money(conditionBean.getLease_money());// 租赁本金 （租赁本金 = 设备金额
		// - 首付款）
		rent.setFuture_money(conditionBean.getAssets_value());// 留购价
		rent.setPeriod_type(conditionBean.getPeriod_type());// 1,期初 0,期未的值
		rent.setIrr_type("2");// 1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		rent.setScale("8");// irr的小数位数 暂时就是8位
		rent.setLease_interval(conditionBean.getIncome_number_year());// 租金间隔
		// (付租方式)
		rent.setPlan_date(conditionBean.getStart_date());// 每月偿付日 替换 起租日的具体日期
		if ("".equals(contract_id) || contract_id == null) {
			rent.setContract_id(conditionBean.getProj_id());// 计算具体项目现金流的KEY
		} else {
			rent.setContract_id(conditionBean.getContract_id());// 计算具体项目现金流的KEY
		}
		rent.setRentScale("4");// 圆整到

		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		// 2010-12-08 rentScale-->newScale 除了租金之外的
		// 租金列表
		List rent_list = slrcu.getRentList(leaseMoney, assets_value,
				income_number, yearRate, lease_interval, rentScale, grace,
				delay);
		System.out.println("租金计算完成");
		// 利息列表
		List inter_list = slrcu.getInterMarket(rent_list, leaseMoney, yearRate,
				lease_interval, rentScale);
		System.out.println("利息计算完成");
		// 得到本金list
		List corpus_market = slrcu.getCorpusList(rent_list, inter_list,
				leaseMoney, assets_value, newScale);
		// 重新计算利息 目的为了处理最后一期剩余本金不为0的情况
		inter_list = slrcu.getNewInterList(rent_list, corpus_market,
				inter_list, rentScale);
		// 得到本金余额
		List corpusOverge_market = slrcu.getCorpusOvergeList(String
				.valueOf(conditionBean.getLease_money()), corpus_market,
				newScale);
		// 计划日期
		List date_list = slrcu.getPlanDateList(rent_list, type, lease_interval,
				plan_date, grace, delay);

		/*
		 * ///////////////// 现金流及IRR测算
		 */// //////////////
		RentCaleCommonTools calcTools = new RentCaleCommonTools();
		// irr
		String irr = calcTools.getIrr(firstMoney, rent_list, caution_money,
				assets_value, Other_expenditure, lease_interval, type);
		// 得到保证金抵扣租金List rent_list 租金List,caut_money 保证金
		List l_RentDetails = calcTools.getRentDetails(firstMoney, rent_list,
				date_list, conditionBean);
		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_Plan_date(date_list);
		rentInfoBox.setL_Rent(rent_list);
		rentInfoBox.setL_Corpus(corpus_market);
		rentInfoBox.setL_Inter(inter_list);
		rentInfoBox.setL_CorpusOverge(corpusOverge_market);
		rentInfoBox.setL_RentDetails(l_RentDetails);
		rentInfoBox.setIrr(irr);// irr未乘以100

		System.out.println("irr==" + irr);
		for (int i = 0; i < l_RentDetails.size(); i++) {
			RentCashBean a = (RentCashBean) l_RentDetails.get(i);
			System.out.println(
			// date_list.get(i)+" rent="+rent_list.get(i)+"
					// cor="+corpus_market.get(i)
					// +" inte="+inter_list.get(i)+"
					// cor_ovg="+corpusOverge_market.get(i));
					// " Details="+l_RentDetails.get(i)
					a.getPlan_date() + "  " + a.getFollow_in() + "  "
							+ a.getFollow_in_detail() + "  "
							+ a.getFollow_out() + "  "
							+ a.getFollow_out_detail() + "  "
							+ a.getNet_follow()

					);

		}

		/**
		 * =======================================================
		 * 开始更新数据库表数据（交易结构临时表、项目租金计划临时表、项目租金现金流临时表）
		 * =======================================================
		 */
		System.out.println("数据库操作开始(均息法测算)================================");
		// RentDBOperation.execDBOperation(contract_id, conditionBean, irr,
		// date_list, rent_list, corpus_market, inter_list, corpusOverge_market,
		// l_RentDetails, rent, new_rent);

		return rentInfoBox;

	}

}
