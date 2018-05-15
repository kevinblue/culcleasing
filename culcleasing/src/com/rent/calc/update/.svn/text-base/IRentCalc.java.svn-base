package com.rent.calc.update;

import java.util.Hashtable;
import java.util.List;

/**
 * 租金测算接口定义
 * 
 * @author Administrator
 * 
 */
public interface IRentCalc {

	// 等额租金时得到每一期的租金
	public String getEqRent(String calcRate, String lease_money,
			String period_type, String income_number, String future_money);

	// 等额得到租金List
	public List eqRentList(String rent, String income_number);

	// 等额得以利息
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm);

	// 等额 本金List
	public List getCorpusList(List rentList, List inteList);

	// 等额 本金余额
	public List getCorpusOvergeList(String leaseMoney, List corpusList);

	// 等本的每一期的本金
	public String getPreCorpus(String lease_money, String income_number);

	// 等本本金List
	public List eqCorpusList(String corpus, String income_number,
			String lease_money);

	// 等本的利息list
	public List getInterestByEqCorpus(List l_corpus_over, String cal_rate,
			List l_corpus_pre, String period_type);
	
	//等本的租金
	public List getRentByEqCorpus(List l_corpus, List l_inte);
	
	
	//得以租金回笼明细
	public Hashtable getRentPlanDetail() ;

}
