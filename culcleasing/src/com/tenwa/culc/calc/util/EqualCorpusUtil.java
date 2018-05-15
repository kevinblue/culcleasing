package com.tenwa.culc.calc.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.tenwa.culc.calc.zjcs.RentCalc;
import com.tenwa.culc.calc.zjcs.RentCaleCommonTools;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentInfoBox;
import com.tenwa.culc.bean.RentPlanBean;
/**
 * 
 * 
 * @author toybaby
 * Date: Jul 13, 2011 
 */
public class EqualCorpusUtil {

	/**
	 * 测算
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static List<RentPlanBean> calc(ConditionBean conditionBean){
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static RentInfoBox  getRentInfoBox(ConditionBean conditionBean) {
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * 先测算出相关的List数据
		 * </pre>
		 * 
		 * =======================================================
		 */
		RentInfoBox rentInfoBox = new RentInfoBox();
		String contract_id = conditionBean.getContract_id();
		List l_RentDetails = new ArrayList();
		List l_plan_date = new ArrayList();
		//Irr计算条件
		String firstMoney= String.valueOf("-"+conditionBean.getActual_fund());//现金流第一期流量
		String lease_interval = conditionBean.getIncome_number_year();//租金间隔
		String caution_money=conditionBean.getCaution_money();//保证金
//		String Other_expenditure = conditionBean.getOther_expenditure();//其它支出
		String Other_expenditure = conditionBean.getNominalprice();//残值收入
		String assets_value = conditionBean.getAssets_value();//资产余值
		String type = conditionBean.getPeriod_type();
		// 租金测算程序
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		// *****************************************************************************************************
		// *** 等额本金 租金测算 ****
		// *****************************************************************************************************
		// 情况一 正常情况下
		// 租金测算之封装租金测算条件 9个
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

		// 新增四个字段 【**************** 测算市场IRR所需的附加条件
		// *****************】【修改时间2011-07-13】
		Double mon = Double.parseDouble(conditionBean.getLease_money())
				- Double.parseDouble(conditionBean.getAssets_value());
		//System.out.println("实际本金Cle_cau_Money="+mon);
		rent.setCle_cau_Money(mon.toString());// 租凭本金 lease_money- 资产余值Nominalprice
		// caution_money
		rent.setCauti_Money(conditionBean.getCaution_money());// 保证金
		rent.setFuture_money(conditionBean.getNominalprice());// 期末残值
		rent.setStart_date(conditionBean.getStart_date());// 保证金的流入时间

		// 租金测算的现金流封装 主要是 租赁本金，手续费，咨询费 等
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		// 修改：-净融资额 net_lease_money-保证金 caution_money 算财务IRR
		Double list_mon = (Double.parseDouble(conditionBean.getActual_fund()) + Double
				.parseDouble(conditionBean.getCaution_money()))
				* -1;
		llist_case.add(list_mon.toString());
		list_date.add(conditionBean.getStart_date());

		//rent.setPreCash(llist_case);//
		//rent.setPreDate(list_date);//

		System.out.println("净融资额为==>" + conditionBean.getActual_fund());
		System.out.println("保证金==>" + conditionBean.getCaution_money());
		System.out.println("设备款==>" + conditionBean.getEquip_amt());
		System.out.println("值为==>" + list_mon);
		System.out.println("日期==>" + conditionBean.getStart_date());

		// ==============具体测算租金===============

		// 封装HashMap 获得所有租金计划
		HashMap hm = null;
		try {
			hm = rent.getPlanByEqCorpus();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 取值
		l_plan_date = (List) hm.get("plan_date");// 租金偿还日期
		l_rent = (List) hm.get("rent");// 租金
		l_corpus = (List) hm.get("corpus");// 本金
		l_interest = (List) hm.get("interest");// 利息
		l_corpus_overage = (List) hm.get("corpus_overage");// 剩余本金
		for(int i=0;i<l_rent.size();i++){
			System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
					"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));

		}

		
		/*/////////////////
		 * 现金流及IRR测算
		 */////////////////
		RentCaleCommonTools  calcTools = new RentCaleCommonTools();
		// irr
		String irr = calcTools.getIrr(firstMoney, l_rent, caution_money, assets_value, Other_expenditure, lease_interval, type);
		System.out.println("Irr==="+irr);
		// 得到保证金抵扣租金List rent_list 租金List,caut_money 保证金
		 l_RentDetails = calcTools.getRentDetails(firstMoney,l_rent,l_plan_date,conditionBean);
		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_Plan_date(l_plan_date);
		rentInfoBox.setL_Rent(l_rent);
		rentInfoBox.setL_Corpus(l_corpus);
		rentInfoBox.setL_Inter(l_interest);
		rentInfoBox.setL_CorpusOverge(l_corpus_overage);
		rentInfoBox.setL_RentDetails(l_RentDetails);
		rentInfoBox.setIrr(irr);//irr未乘以100


	
		/**
		 * =======================================================
		 * 开始更新数据库表数据（交易结构临时表、项目租金计划临时表、项目租金现金流临时表）
		 * =======================================================
		 */
		System.out.println("数据库操作开始(等额本金测算)================================");
//		RentDBOperation.execDBOperation(contract_id, conditionBean, irr,
//				l_plan_date, l_rent, l_corpus, l_interest, l_corpus_overage,
//				l_RentDetails, rent, new_rent);
		return rentInfoBox;

		
	}		
	
}
