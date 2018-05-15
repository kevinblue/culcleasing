package com.tenwa.culc.calc.zjcs;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tenwa.culc.util.ERPDataSource;

/**
 * XIrr计算
 * @author toybaby
 * Date:Oct 31, 20115:54:45 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class XIrrCal {

	// 公共参数
	private ERPDataSource erpDataSource=null;
	private ResultSet rs = null;
	
	/**
	 * XIRR计算公式
	 * @param l_inflow_pour  现金流List
	 * @param l_date		 对应的日期List
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getXIRR(List l_inflow_pour,List l_date) {
		BigDecimal tmp = new BigDecimal("1");
		BigDecimal irr = new BigDecimal("0");
		BigDecimal tmp1 = new BigDecimal("0");
		BigDecimal tmp2 = new BigDecimal("100");
		BigDecimal bigdec_1 = new BigDecimal("1");
		BigDecimal bigdec_2 = new BigDecimal("2");
		int j = 0;
		try {
			while (tmp.abs().doubleValue() > 0.0000000001 && j < 100) {
				tmp = new BigDecimal(l_inflow_pour.get(0).toString());
				String date0 = l_date.get(0).toString();
				for (int i = 1; i < l_inflow_pour.size(); i++) {
					Long quot = getQuot(l_date.get(i).toString(),date0);
					BigDecimal rate2 = new BigDecimal(quot/365.0);
					tmp = tmp.add(new BigDecimal(l_inflow_pour.get(i)
							.toString()).divide(new BigDecimal(Math.pow(irr
							.add(bigdec_1).doubleValue(),rate2.doubleValue())), 20,
							BigDecimal.ROUND_HALF_UP));
				}
				System.out.println("j="+j+"\ttmp="+tmp);
				if (tmp.doubleValue() > 0) {
					tmp1 = irr;
					irr = irr.add(tmp2).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				if (tmp.doubleValue() < 0) {
					tmp2 = irr;
					irr = irr.add(tmp1).divide(bigdec_2, 20,
							BigDecimal.ROUND_HALF_UP);
				}
				j++;
			}
			return irr.toString().equals("") ? "0" : irr.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}
	/**
	 * 获得日期的天数差
	 * @param time1
	 * @param time2
	 * @return
	 */
	public  static long getQuot(String time1,String time2){
		long quot = 0;	
	SimpleDateFormat ft = new SimpleDateFormat("yyyy/MM/dd");
	  try {
	   Date date1 = ft.parse( time1 );
	   Date date2 = ft.parse( time2 );
	   quot = date1.getTime() - date2.getTime();
	   quot = quot / 1000 / 60 / 60 / 24;
	  } catch (ParseException e) {
	   e.printStackTrace();
	  }
	  return quot;
	}
	
	/**
	 * 计算每个合同的XIRR
	 * @param contract_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getXIrrByContractId(String contract_id){
		String XIrr = "";
		List l_rent = new ArrayList();//现金流
		List l_date = new ArrayList();//对应的日期
		String sql = "select sum(plan_money) plan_money,plan_date from vi_cash_flow where " +
				"contract_id = '"+contract_id+"' group by plan_date";
			try {
				erpDataSource=new ERPDataSource();
				rs = erpDataSource.executeQuery(sql);
				while(rs.next()){
					l_rent.add(rs.getString("plan_money"));
					l_date.add(rs.getString("plan_date"));
				}
				erpDataSource.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//调用XIRR计算方法，计算XIRR
			XIrr = getXIRR(l_rent, l_date);
		return XIrr;
	}
}
