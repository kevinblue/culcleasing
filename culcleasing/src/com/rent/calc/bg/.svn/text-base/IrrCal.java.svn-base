package com.rent.calc.bg;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.Tools;



/**
 * irr的操作
 * 
 * @author Administrator
 * 
 */


public class IrrCal {

	private String chjg; // 偿还间隔，

	private String zjjg;// 租金间隔

	private String nhkcs;// 年还款次数
	

	private List cashList = new ArrayList();// 现金流集合

	private List dateList = new ArrayList();// 现金流时间

	public List getCashList() {
		return cashList;
	}

	public void setCashList(List cashList) {
		this.cashList = cashList;
	}

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getChjg() {
		return chjg;
	}

	public void setChjg(String chjg) {
		this.chjg = chjg;
	}

	public String getNhkcs() {
		return nhkcs;
	}

	public void setNhkcs(String nhkcs) {
		this.nhkcs = nhkcs;
	}

	public String getZjjg() {
		return zjjg;
	}

	public void setZjjg(String zjjg) {
		this.zjjg = zjjg;
	}

	/**
	 * 得到前期资金的现金流与时间
	 * 
	 * @param preDate
	 * @param preCash
	 * @return
	 */
	public void getPreCashFlow(List preDate, List preCash) {

		// 往总的现金流中添加前期付款流
		for (int i = 0; i < preDate.size(); i++) {
			cashList.add(preCash.get(i));
			dateList.add(preDate.get(i));
			System.out.println("preCash"+preCash.get(i)+"=="+preDate.get(i));
		}
	}

	/**
	 * 得到租金的现金流与时间
	 * 
	 * @param preDate
	 * @param preCash
	 * @return
	 */
	public void getRentCashFlow(List rentDate, List rentCash) {

		for (int i = 0; i < rentDate.size(); i++) {
			cashList.add(rentCash.get(i));
			dateList.add(rentDate.get(i));
			System.out.println("rentDate"+rentCash.get(i)+"=="+rentDate.get(i));
		}
	}
	/**
	 * 得到租金的现金流与时间
	 * 
	 * @param preDate
	 * @param preCash
	 * @param grace宽限期
	 * @return
	 */
	public void getRentCashFlow(List rentDate, List rentCash,String grace) {
		
		for (int i = Integer.parseInt(grace); i < rentDate.size(); i++) {
			cashList.add(rentCash.get(i));
			dateList.add(rentDate.get(i));
			System.out.println("rentDate"+rentCash.get(i)+"=="+rentDate.get(i));
		}
	}

	/**
	 * 添加租金后期的现金流
	 * 
	 * @param afterDate
	 * @param afterCash
	 * @return
	 */
	public void getRentAfterCashFlow(List afterDate, List afterCash) {
		for (int i = 0; i < afterDate.size(); i++) {
			cashList.add(afterCash.get(i));
			dateList.add(afterDate.get(i));
		}

	}

	/**
	 * 得到去除重复的时间集合，返回一个含有一个时间，对应他的现金集合的下标的键值对
	 * 
	 * @return
	 */
	public HashMap dateIdenInfo() {
		HashMap hmDate = new HashMap();
		List dtList = new ArrayList();
		String str = "";
		for (int i = 0; i < dateList.size(); i++) {

			if (!hmDate.containsKey(dateList.get(i).toString().substring(0, 7))) {
				hmDate.put(dateList.get(i).toString().substring(0, 7), String
						.valueOf(i));
				dtList.add(dateList.get(i));
			} else {
				str = (String) hmDate.get(dateList.get(i).toString().substring(
						0, 7));
				str = str + "," + String.valueOf(i);
				hmDate.put(dateList.get(i).toString().substring(0, 7), str);

			}

		}
		// 设置新的时间集合
		dateList = dtList;
		return hmDate;

	}

	/**
	 * 根据时间得到新的现金流集合
	 * 
	 */
	public void getUniqueByDate() {
		HashMap map = this.dateIdenInfo();
		List listNew = new ArrayList();

		Object[] obj = map.keySet().toArray();
		Arrays.sort(obj);

		for (int i = 0; i < obj.length; i++) {
			System.out.println("==" + obj[i].toString());
			System.out.println("===" + map.get(obj[i].toString()));
			String[] strArray = map.get(obj[i].toString()).toString()
					.split(",");

			// 总金额,得到同一时间的总金额d
			String total = "0";
			for (int j = 0; j < strArray.length; j++) {
				total = String.valueOf(Double.parseDouble(total)
						+ Double.parseDouble(cashList.get(
								Integer.parseInt(strArray[j].toString()))
								.toString()));
				total = Tools.formatNumberDoubleTwo(total);
			}
			listNew.add(total);
		
		}
		// 设置新的现金流
		cashList = listNew;
		
		
	}

	/**
	 * 
	 * @param type
	 *            1,每月的现金流来计算，2，为按已成的间隔来计算
	 * @return
	 */
	public List getCashInfoList(String type, String s_date, String e_date) {
		List list = new ArrayList();

		if ("1".equals(type)) {

		} else {

		}
		return null;
	}

	/**
	 * 
	 * @param s_date
	 *            起租开始时间，
	 * @param e_date
	 *            最后一期的结束时间
	 * @return
	 */
	public void getPreMonthCash(List rentList,List rentDtList) {

		String first_month = rentDtList.get(0).toString().substring(0, 7);
		String add_start = first_month;
		String last_month = rentDtList.get(rentList.size()-1).toString().substring(0, 7);

		

		int i_month = getDateDiffMonth(first_month + "-01", last_month + "-01");

		for (int i = 1; i < i_month+2; i++) {
			// 判断当前的时间是不是与已存在的是时间有类似的
			int pdI = this.isInDateList(first_month,rentDtList);
			if (pdI > -1) {
				cashList.add(rentList.get(pdI));
			} else {
				cashList.add("0");
			}
			dateList.add(first_month+"-01");
			first_month = getDateAdd(add_start + "-01", i, "mm").substring(0,
					7);
		}
		
		
	}

	/**
	 * 判断某个日期是不是在时间集合中
	 * 
	 * @param date
	 * @return
	 */
	public int isInDateList(String date,List inList) {
		for (int i = 0; i < inList.size(); i++) {
			if (date.equals(inList.get(i).toString().subSequence(0, 7))) {
				return i;
			}
		}
		return -1;
	}

	public int getDateDiffMonth(String bdate, String edate) {
		try {
			String[] barray = bdate.split("-");
			String[] earray = edate.split("-");
			return (Integer.parseInt(earray[0]) - Integer.parseInt(barray[0]))
					* 12
					+ (Integer.parseInt(earray[1]) - Integer
							.parseInt(barray[1]));
		} catch (Exception e) {

		}
		return 0;
	}

	public String getDateAdd(String strDate, int leng, String type) {
		Date addDate = null;
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = sdf.parse(strDate);
		} catch (Exception e) {
			System.out.println(e);
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		if (type.equals("yy")) {
			cal.add(Calendar.YEAR, leng);
		} else if (type.equals("mm")) {
			cal.add(Calendar.MONTH, leng);
		} else if (type.equals("we")) {
			cal.add(Calendar.WEEK_OF_YEAR, leng);
		} else if (type.equals("dd")) {
			cal.add(Calendar.DAY_OF_YEAR, leng);
		} else if (type.equals("hh")) {
			cal.add(Calendar.HOUR_OF_DAY, leng);
		} else if (type.equals("mi")) {
			cal.add(Calendar.MINUTE, leng);
		} else if (type.equals("ss")) {

		}
		addDate = cal.getTime();
		return sdf.format(addDate);
	}

	/**
	 * 现金流得到irr
	 * 
	 * @param l_inflow_pour
	 * @param chjg
	 * @param zjjg
	 * @param nhkcs
	 * @return
	 */

	public String getIRR(List l_inflow_pour, String chjg, String zjjg,
			String nhkcs) {
		chjg = chjg.equals("") ? "0" : chjg;
		zjjg = zjjg.equals("") ? "0" : zjjg;
		nhkcs = nhkcs.equals("") ? "0" : nhkcs;
		// 参数说明：l_inflow_pour=所有现金流入流出（流入为正，流出为负），chjg=偿还间隔，
		// zjjg=租金间隔,nhkcs=年还款次数
		// BigDecimal year_number = new BigDecimal("3");//偿还间隔
		BigDecimal year_number = new BigDecimal(chjg);// 偿还间隔
		// BigDecimal rent_interval = new BigDecimal("3");//每期租金间隔
		BigDecimal rent_interval = new BigDecimal(zjjg);// 每期租金间隔
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
				for (int i = 1; i < l_inflow_pour.size(); i++) {
					
					tmp = tmp.add(new BigDecimal(l_inflow_pour.get(i)
							.toString()).divide(new BigDecimal(Math.pow(irr
							.add(bigdec_1).doubleValue(), i)), 20,
							BigDecimal.ROUND_HALF_UP));
				}
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
			irr = irr.multiply(year_number).divide(rent_interval, 20,
					BigDecimal.ROUND_HALF_UP);
			// irr = irr.multiply(new BigDecimal("4"));
			irr = irr.multiply(new BigDecimal(nhkcs));
			return irr.toString().equals("") ? "0" : irr.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}

	/**
	 * 测试
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		//testOldIrr();//按每个租金间隔的内涵率
		testPreMonthIrr();
		
		
	}

	/**
	 * 测试按每个租金间隔的内涵率
	 *
	 */
	
	public static void testOldIrr() {
		IrrCal cal = new IrrCal();

		List l_rent_irr = new ArrayList();
		List l_plan_date = new ArrayList();
		String lease_money = "10000000";

		l_rent_irr.add("-" + lease_money);
		l_plan_date.add("2009-11-18");

		// 期前现金流
		String lease_interval = "3";

		// 每月只有一条记录在现资金流中
		cal.getPreCashFlow(l_plan_date, l_rent_irr);

		l_plan_date = new ArrayList();
		l_rent_irr = new ArrayList();

		for (int i = 0; i < 12; i++) {
			l_plan_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), "2009-12-18"));// 租金日期
			l_rent_irr.add("926457.00");
		}
		// 租金
		cal.getRentCashFlow(l_plan_date, l_rent_irr);
		// 时间，资金流的处理类
		cal.getUniqueByDate();

		System.out.println(cal.getIRR(cal.cashList, "3", "3", "4"));

	}
	
	/**
	 * 测试按每个租金间隔的内涵率
	 *
	 */
	
	public static void testPreMonthIrr() {
		IrrCal cal = new IrrCal();

		List l_rent_irr = new ArrayList();
		List l_plan_date = new ArrayList();
		String lease_money = "19740000";

		l_rent_irr.add("-" + lease_money);
		l_plan_date.add("2009-12-18");

		// 期前现金流
		String lease_interval = "3";

		
		cal.getPreCashFlow(l_plan_date, l_rent_irr);

		l_plan_date = new ArrayList();
		l_rent_irr = new ArrayList();

		for (int i = 0; i < 20; i++) {
			l_plan_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), "2009-12-18"));// 租金日期
			l_rent_irr.add("1198681.00");
		}
		// 租金
		cal.getRentCashFlow(l_plan_date,l_rent_irr);
		// 时间，资金流的处理类
		cal.getUniqueByDate();
		
		System.out.println(cal.getIRR(cal.cashList, "3", "3", "4"));

	}



}
