/**
 * com.tenwa.util.NormalCoreCalcuUtil
 * create by JavaJeffe.
 * date Aug 9, 2010
 */
package com.tenwa.util;

import java.sql.ResultSet;
import java.util.List;

import dbconn.Conn;
import com.tenwa.util.CommonUtil;

/**
 * 规则付款的租金测算核心类
 * 
 * @author JavaJeffe
 * 
 * date ---- 4:39:31 PM
 */
public class NormalPayCoreCalcuUtil {
	private Conn db = null;
	private ResultSet rs = null;
	private String sqlstr = "";
	
	String year_rate ="";//年利率
	String lease_interval ="";//租赁间隔 一般为一个月收一次
	String income_number ="";//还租次数 = 租赁期限
	String lease_money ="";//融资金额 （客户需要融资的金额，就是向银行贷款的金额）
	String period_first_date ="";//验收日期
	String period_type = "1";//期初（期末）支付

	String rent="";//
	String head_amt="";//1 起租租金
	String caution_money="";//2 保证金（承租人）
	//3 第一期租金
	String insurance_lessor="";//4 保险费
	String handling_charge="";//5 手续费
	String nominalprice="";//6 留购价款
	String supervision_fee="";//7 管理服务费
	String lessee_caution_money = "";//8 担保费
	String sale_caution_money = "";//9 DB保证金
	String hand_method="";// 值都为免除 （租前息是否免除）
	String settle_method="";// 首付款方式(网银、非网银)
	String first_rent_plan_date = "";// 第一期租金计划收取日期（首付款日期）
	
	/**
	 * 规则付款的租金测算
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public void calcuNormalPayRent(String proj_id, String doc_id) {
		
	}

}
