package com.condition;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Tools;
import com.rent.calc.bg.RentCalc;
import com.rent.calc.bg.RentDelayCalc;
import com.rent.calc.bg.RentDelayGraceCalc;
import com.rent.calc.bg.RentGraceCalc;

import dbconn.Conn;


/**
 * <p>将租金测算的SAVE页面的租金测算条件全部都封装到后台类中来。</p>
 * @author 小谢
 * <p>Oct 22, 2010</p>
 */
public class Rent_Conditions {
	
	@SuppressWarnings("unchecked")
	public List fz_Conditions(Map<String,String> map,String type){
		Conn db = new Conn();
		Tools tools = new Tools();
		List new_rent = new ArrayList<List<String>>();
		
		RentCalc rent = new RentCalc();
		//第一部分测算条件
		rent.setYear_rate(map.get("year_rate")); //年利率  0 
		rent.setIncome_number(map.get("income_number"));//期数 
		rent.setLease_money(map.get("lease_money"));//租赁本金 （租赁本金 = 设备金额 - 首付款）
		rent.setFuture_money(map.get("nominalprice"));//留购价   
		rent.setPeriod_type(map.get("period_type"));//1,期初 0,期未的值  
		rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2   
		rent.setScale("8");//irr的小数位数 暂时就是8位   
		rent.setLease_interval(map.get("income_number_year"));//租金间隔 (付租方式)  
		rent.setPlan_date(map.get("now_start_date"));//每月偿付日 替换 起租日 的具体日期  
		rent.setContract_id(map.get("proj_id"));//计算具体项目现金流的KEY 
		rent.setRentScale(map.get("rentScale"));//圆整到   
		//第二部分测算条件
		Double mon = Double.parseDouble(map.get("net_lease_money"))+ Double.parseDouble(map.get("caution_money"));
		rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
		rent.setCauti_Money(map.get("caution_money"));//保证金
		rent.setFuture_money(map.get("nominalprice"));//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
		rent.setStart_date(map.get("now_start_date"));//保证金的流入时间
		//第三部分测算条件
		//租金测算的现金流封装 主要是 租赁本金，手续费，咨询费 等
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
		Double list_mon =( Double.parseDouble(map.get("net_lease_money")) + Double.parseDouble(map.get("caution_money")) )*-1;
		llist_case.add(list_mon.toString());
		list_date.add(map.get("start_date"));
		rent.setPreCash(llist_case);//
	    rent.setPreDate(list_date);//
		System.out.println("净融资额为==>"+map.get("net_lease_money"));
		System.out.println("保证金==>"+map.get("caution_money"));
		System.out.println("设备款==>"+map.get("equip_amt"));
		System.out.println("值为==>"+map.get("list_mon)"));
		System.out.println("日期==>"+map.get("start_date"));
		List rent_list = new ArrayList();
		List l_plan_date_ = new ArrayList();
		/* 具体测算 */
		//delay	int 延迟期数//grace int宽限期数
		//RentDelayGraceCalc延迟付款,宽限期规则租金测算//RentGraceCalc宽限期规则租金测算//RentDelayCalc延迟付款规则租金测算
		int tem_delay = Integer.parseInt(map.get("delay"));//延迟期数
		int tem_grace = Integer.parseInt(map.get("grace"));//宽限期数
		if(type.equals("正常")){
			//‘规则’情况下，租金具体测算如下：
			rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
			l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
		}
		else if(type.equals("宽大于0延等于0")){
			RentGraceCalc rent2 = new RentGraceCalc();
			rent_list = rent2.eqRentList(rent.getYear_rate(),tem_grace);// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			l_plan_date_ = rent2.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
		}
		else if(type.equals("宽等于0延大于0")){
			RentDelayCalc rent3 = new RentDelayCalc();
			//‘规则’情况下，租金具体测算如下：
			rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
			l_plan_date_ = rent3.getPlanDateList(rent_list, rent.getPeriod_type(),tem_delay);// 计划时间 
		}else{//宽>0延>0
			 RentDelayGraceCalc  rent4 = new RentDelayGraceCalc();
		}
		
		//参数说明 getHashRentPlan(参数一,参数二,参数三) 
		//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表  参数三 l_plan_date_ 上方数组 封装时间的结果集
		String m_type = tools.getStr(map.get("measure_type"));
		if ("0".equals(m_type)) {
			m_type="1";
		}
		HashMap hm;
		try {
			hm = rent.getHashRentPlan(m_type, rent_list, l_plan_date_);
			//租金测算程序
			List l_plan_date = new ArrayList();
			List l_rent = new ArrayList();
			List l_corpus = new ArrayList();
			List l_interest = new ArrayList();
			List l_corpus_overage = new ArrayList();
			//取值
			l_plan_date = (List)hm.get("plan_date");//租金偿还日期
			l_rent = (List)hm.get("rent");//租金
			l_corpus = (List)hm.get("corpus");//本金
			l_interest = (List)hm.get("interest");//利息
			l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
			//计算irr  
			Double irr = Double.parseDouble(rent.getV_irr())*100;
			//市场IRR 
			Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
			//修改‘拟商务条件’表中计划IRR的值
			String sqlstr = "update proj_condition_temp set plan_irr="+irr+",market_irr = "+Markirr+"   where proj_id='"+map.get("proj_id")+"' and measure_id = '"+map.get("doc_id")+"' ";
			db.executeUpdate(sqlstr);
			//* 得到 市场的租金计划的一些信息
			//* 
			//* @param p_year_rate //每一期的利息 (市场IRR/100/12(月份))*租金间隔
			//* @param rent_c_list 租金 list       l_rent
			//* @param lease_money_p  所要测算的本金   等同于 租赁本金lease_money 这个字段
			//* @param period_type_p  期初或期末      
			//* @return
			//*/
			Double temp_num = (Double.parseDouble(map.get("year_rate"))/100/12)*Double.parseDouble(map.get("income_number_year"));
			//新增三个字段【市场本金，市场利息，市场本金余额】
			HashMap hx = rent.getPlanMarketByEqRent(String.valueOf(temp_num),l_rent,map.get("lease_money"),map.get("period_type"));
			List l_corpus_market = new ArrayList();
			List l_interest_market = new ArrayList();
			List l_corpus_overage_market = new ArrayList();
			l_corpus_market = (List) hx.get("corpus_market");//市场本金
			l_interest_market = (List) hx.get("interest_market");//市场利息
		    l_corpus_overage_market = (List) hx.get("corpus_overage_market");//市场本金余额
			//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
			sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+map.get("proj_id")+"' and measure_id='"+map.get("doc_id")+"'";
			db.executeUpdate(sqlstr);
			//插入到列表
			for(int i=0;i<l_rent.size();i++){
				//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
				sqlstr="insert into fund_rent_plan_proj_temp"+
				       "(measure_id,proj_id,"+
				       "rent_list,plan_date,plan_status,rent,corpus,"+
				       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
				       "select '"+map.get("doc_id")+"','"+map.get("proj_id")+"',"+(i+1)+","+
				       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
				       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
				       ""+l_corpus_overage.get(i)+","+map.get("year_rate")+","+
				       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
				System.out.println("^^^^^^^^^^^^^^^租金添加sql=====> "+sqlstr);
				db.executeUpdate(sqlstr);
			}
			//现金流用到的2个list
			List l_RentDetails = new ArrayList(); 
			//现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(l_rent,map.get("caution_money"));
			//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
			new_rent = rent.getRentCautNew(l_rent,map.get("caution_money"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new_rent;
		
	}	
}
