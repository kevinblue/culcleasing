package com.tenwa.culc.financing.util;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import com.tenwa.culc.financing.util.interestDateFormula.T01;
import com.tenwa.culc.financing.util.interestDateFormula.T02;
import com.tenwa.culc.financing.util.interestDateFormula.T03;
import com.tenwa.culc.financing.util.interestDateFormula.T04;
import com.tenwa.culc.financing.util.interestDateFormula.T05;
import com.tenwa.culc.financing.util.interestDateFormula.T06;
import com.tenwa.culc.financing.util.interestDateFormula.T07;
import com.tenwa.culc.financing.util.interestDateFormula.T08;
import com.tenwa.culc.financing.util.interestDateFormula.T09;
import com.tenwa.culc.financing.util.interestDateFormula.T10;
import com.tenwa.culc.financing.util.interestDateFormula.T11;
import com.tenwa.culc.financing.util.interestDateFormula.T12;
import com.tenwa.culc.financing.util.interestDateFormula.T13;
import com.tenwa.culc.financing.util.interestDateFormula.T14;
import com.tenwa.culc.financing.util.interestDateFormula.T15;
import com.tenwa.culc.util.ERPDataSource;

public class FinancingReportUtil {
	public static void main(String[] args){
		System.out.println("main");
	}
	/**
	 * 获取已还本金（原币）
	 * @param drawings_id
	 * @param date
	 * @return
	 * @throws NumberFormatException
	 * @throws SQLException
	 */
	public static double getDrawingsRefundCorpus(String drawings_id,String date) throws NumberFormatException, SQLException{
		String sqlStr = "Select isnull(sum(refund_corpus),0) as drawings_refund_corpus from financing_refund_income where drawings_id='"+drawings_id+"' and refund_fact_date <='"+date+"'";
		ERPDataSource erp = new ERPDataSource();
		System.out.println(sqlStr);
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp = Double.valueOf(rs.getString("drawings_refund_corpus")).doubleValue();
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	/**
	 * 获取剩余本金（原币）
	 * @param drawings_id
	 * @param date
	 * @param drawings_money
	 * @return
	 * @throws NumberFormatException
	 * @throws SQLException
	 */
	public static double getDrawingsLeftCorpus(String drawings_id,String date) throws SQLException{
		String sqlStr = " select isnull(SUM(refund_corpus),0) as refund_corpus from financing_refund_plan where refund_plan_date > '"+date+"' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp = Double.valueOf(rs.getString("refund_corpus")).doubleValue();
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	/**
	 * 获取即期剩余本金（原币）
	 * @param drawings_id
	 * @param date
	 * @return
	 * @throws SQLException
	 * @throws ParseException 
	 */
	public static double getDrawingsLeftSightAmount(String drawings_id, String date) throws SQLException, ParseException{
		DateFormat df= new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar =GregorianCalendar.getInstance();
		calendar.setTime(df.parse(date));
		calendar.add(Calendar.YEAR, 1);
		String sightAmount = df.format(calendar.getTime());
		String sqlStr = " select isnull(SUM(refund_corpus),0) as sight_amount from financing_refund_plan where refund_plan_date > '"+date+"' and refund_plan_date<= '"+sightAmount+"' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp= Double.valueOf(rs.getString("sight_amount")).doubleValue();
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	
	/**
	 * 获取非即期剩余本金（原币）
	 * @param drawings_id
	 * @param date
	 * @return
	 * @throws SQLException
	 * @throws ParseException 
	 */
	public static double getDrawingsLeftNoSightAmount(String drawings_id, String date) throws SQLException, ParseException{
		DateFormat df= new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar =GregorianCalendar.getInstance();
		calendar.setTime(df.parse(date));
		calendar.add(Calendar.YEAR, 1);
		String sightAmount = df.format(calendar.getTime());
		String sqlStr = " select isnull(SUM(refund_corpus),0) as non_sight_amount from financing_refund_plan where refund_plan_date > '"+sightAmount+"' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp = Double.valueOf(rs.getString("non_sight_amount")).doubleValue();
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	/**
	 * 原币转人民币
	 * @param drawingsLeftCorpus
	 * @param rate
	 * @return
	 */
	public static double getCurrencyToRMB(double drawingsLeftCorpus,double rate){
		return drawingsLeftCorpus*rate;
	}

	/**
	 * 获取费用未摊销余额（人民币）
	 * @param drawings_id
	 * @param date
	 * @param rate
	 * @return
	 * @throws SQLException
	 */
	public static double getNonAmortizationRMB(String drawings_id,String date,double rate) throws SQLException{
		String sqlStr = " select isnull(SUM(Non_amortization_balance),0) as Non_amortization_balance from financing_amortize where amortize_date > '"+date+"' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp = Double.valueOf(rs.getString("Non_amortization_balance")).doubleValue()*rate;
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	/**
	 * 获取即期费用未摊销余额（人民币）
	 * @param drawings_id
	 * @param date
	 * @param rate
	 * @return
	 * @throws SQLException
	 * @throws ParseException 
	 */
	public static double getNonAmortizationRMBSightAmount(String drawings_id,String date,double rate) throws SQLException, ParseException{
		DateFormat df= new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar =GregorianCalendar.getInstance();
		calendar.setTime(df.parse(date));
		calendar.add(Calendar.YEAR, 1);
		String sightAmount = df.format(calendar.getTime());
		String sqlStr = " select isnull(SUM(Non_amortization_balance),0) as sight_amount from financing_amortize where amortize_date > '"+date+"' and amortize_date <= '"+sightAmount+"' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp = Double.valueOf(rs.getString("sight_amount")).doubleValue()*rate;
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	/**
	 * 获取非即期费用未摊销余额（人民币）
	 * @param drawings_id
	 * @param date
	 * @param rate
	 * @return
	 * @throws SQLException
	 * @throws ParseException 
	 */
	public static double getNonAmortizationRMBNoSightAmount(String drawings_id,String date,double rate) throws SQLException, ParseException{
		DateFormat df= new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar =GregorianCalendar.getInstance();
		calendar.setTime(df.parse(date));
		calendar.add(Calendar.YEAR, 1);
		String sightAmount = df.format(calendar.getTime());
		String sqlStr = " select isnull(SUM(Non_amortization_balance),0) as non_sight_amount from financing_amortize where amortize_date > '"+sightAmount+"' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);
		double temp = 0d;
		if(rs.next()){
			temp = Double.valueOf(rs.getString("non_sight_amount")).doubleValue()*rate;
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return temp;
	}
	
	/**
	 * 获取当前利率
	 * @param drawings_id
	 * @param date
	 * @return
	 * @throws SQLException 
	 */
	public static double getCurrentRate(String drawings_id , String date) throws Exception{
		System.out.println("%%%%"+drawings_id+"----"+ date);
		Map<String,String> formulaMap = new HashMap<String,String>();
		formulaMap.put("公历按年首日", "T01");
		formulaMap.put("公历按季首日", "T02");
		formulaMap.put("公历按月首日", "T03");
		formulaMap.put("公历按半年首日", "T04");
		formulaMap.put("调息日按日", "T05");
		formulaMap.put("调息日按月", "T06");
		formulaMap.put("调息日按季", "T07");
		formulaMap.put("调息日按年", "T08");
		formulaMap.put("调息日按半年首日", "T09");
		formulaMap.put("提款日按月", "T10");
		formulaMap.put("提款日按季", "T11");
		formulaMap.put("提款日按年", "T12");
		formulaMap.put("提款日按季次月", "T13");
		formulaMap.put("提款日按半年", "T14");
		formulaMap.put("调息日后第一个结息日次日调息", "T15");
		formulaMap.put("固定利率不调息", "T16");
		
		
		Map<String,String> interestTypeMap = new HashMap<String,String>();
		interestTypeMap.put("6个月基准利率", "base_rate_one");
		interestTypeMap.put("1年期基准利率", "base_rate_one");
		interestTypeMap.put("1-3年期基准利率", "base_rate_three");
		interestTypeMap.put("3年期基准利率", "base_rate_three");
		interestTypeMap.put("3-5年期基准利率", "base_rate_five");
		interestTypeMap.put("5年期基准利率", "base_rate_five");
		interestTypeMap.put("5年期以上基准利率", "base_rate_abovefiv");
		
			/*--报表二
			 select refund_plan_date,drawings_id,refund_interest from financing_refund_plan
			 where 1=1
			 and drawings_id = '2-1'
			 and refund_interest >0
			 and refund_plan_date <='2011-11-11'
	
			 select CONVERT(varchar(10),max(refund_plan_date), 120 ) as refund_plan_date  from financing_refund_plan
			 where 1=1
			 and drawings_id = '2-1'
			 and refund_interest >0
			 and refund_plan_date <='2011-11-11'
			 如果为空 就是	提款日期
			 */
		
		double temp = 0d;
		
		String sqlStr = " select drawings_id,drawings_date,drawings_rate_para1,drawings_rate_para2,drawings_rate_para3,drawings_rate_float_type,drawings_fixed_rate from financing_drawings where currency = '人民币' and drawings_id = '"+drawings_id+"' ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlStr);//date 查询日期
		String drawingsDate = "";//提款日期
		String drawingsRatePara1 = "";//利率类型
		String drawingsRatePara2 = "";//利率计算符号（*，+）
		String drawingsRatePara3 = "";//调整利率支值
		String drawingsRateFloatType = "";//算法
		String drawingsFixedRate = "";//固定利率；
		if(rs.next()){
			drawingsDate = rs.getString("drawings_date");
			drawingsRatePara1 = rs.getString("drawings_rate_para1");
			drawingsRatePara2 = rs.getString("drawings_rate_para2");
			drawingsRatePara3 = rs.getString("drawings_rate_para3");
			drawingsRateFloatType = rs.getString("drawings_rate_float_type");
			drawingsFixedRate = rs.getString("drawings_fixed_rate");
		}
		
		if(drawingsDate != null && !drawingsDate.equals("")){
			int index = drawingsDate.indexOf(" 00:");
			drawingsDate = drawingsDate.substring(0, index);
		}
		
		System.out.println("drawingsRateFloatType:   "+drawingsRateFloatType);
		System.out.println("date="+date);
		System.out.println("drawingsDate="+drawingsDate);
		System.out.println("result="+drawingsDate+formulaMap.get(drawingsRateFloatType)+drawingsRatePara1+drawingsRatePara2+drawingsRatePara3+drawingsFixedRate);
		System.out.println("drawingsFixedRate="+drawingsFixedRate);
		System.out.println("drawings_id="+drawings_id);
		
		
		
		//准备调用16种算法
		
//        int adjustRangeInt = 0;
//        if(drawingsRatePara3 != null && !drawingsRatePara3.equals("")){
//        	adjustRangeInt = Integer.valueOf(drawingsRatePara3);
//        }
        
        double adjustRangeInt = 0;
        if(drawingsRatePara3 != null && !drawingsRatePara3.equals("")){
        	adjustRangeInt = Double.valueOf(drawingsRatePara3);
        	System.out.println("****adjustRangeInt= "+adjustRangeInt);
        }
        
        double adjustNumber = 1;
        BigDecimal bd = new BigDecimal(Double.toString(100)); 
        BigDecimal tempBD = null;
        
		if(drawingsRatePara2 != null && !drawingsRatePara2.equals("")){
			if(drawingsRatePara2.equals("+")){
				tempBD = new BigDecimal(Double.toString(100 + adjustRangeInt));
			}else if(drawingsRatePara2.equals("-")){
				tempBD = new BigDecimal(Double.toString(100 - adjustRangeInt));
			}else if(drawingsRatePara2.equals("*")){
				tempBD = new BigDecimal(Double.toString(adjustRangeInt));
			}else if(drawingsRatePara2.equals("/")){
				//暂时没有此类数据，算法待定
			}else{
				tempBD = new BigDecimal(Double.toString(100));
			}
			adjustNumber = tempBD.divide(bd,4,BigDecimal.ROUND_HALF_UP).doubleValue();
		}
		
		System.out.println("****adjustNumber= "+adjustNumber);

		String formula = "" ;		//获取对应算法名称
		if(drawingsRateFloatType == null){
			return  temp ;	
		}else{
			formula = formulaMap.get(drawingsRateFloatType);
			if(formula == null){
				return temp ;
			}
		}
		System.out.println("****formula= "+formula);
		
		String interestType = interestTypeMap.get(drawingsRatePara1);  //获取利率类型
		
		System.out.println("****interestType= "+interestType);
		
		if(interestType == null && !formula.equals("T16")){
			return temp ;
		}
		
		if(formula.equals("T01")){
			T01 t01 = new T01();
			temp = t01.getT01Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T02")){
			T02 t02 = new T02();
			temp = t02.getT02Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T03")){
			T03 t03 = new T03();
			temp = t03.getT03Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T04")){
			T04 t04 = new T04();
			temp = t04.getT04Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T05")){
			T05 t05 = new T05();
			temp = t05.getT05Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T06")){
			T06 t06 = new T06();
			temp = t06.getT06Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T07")){
			T07 t07 = new T07();
			temp = t07.getT07Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T08")){
			T08 t08 = new T08();
			temp = t08.getT08Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T09")){
			T09 t09 = new T09();
			temp = t09.getT09Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T10")){
			T10 t10 = new T10();
			temp = t10.getT10Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T11")){
			T11 t11 = new T11();
			temp = t11.getT11Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T12")){
			T12 t12 = new T12();
			temp = t12.getT12Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T13")){
			T13 t13 = new T13();
			temp = t13.getT13Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T14")){
			T14 t14 = new T14();
			temp = t14.getT14Interest(date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T15")){
			T15 t15 = new T15();
			temp = t15.getT15Interest(drawings_id , date, drawingsDate, adjustNumber, interestType);
		}else if(formula.equals("T16")){
			//T16 t16 = new T16();
			//temp = t16.getT16Interest(date, drawingsDate, adjustNumber, interestType);
			double tempDouble = 0;
			if(drawingsFixedRate != null && !drawingsFixedRate.equals("")){
				tempDouble = Double.parseDouble(drawingsFixedRate)/100;
			}
			BigDecimal   tempDoubleBD   =   new   BigDecimal(tempDouble);  
	        temp  =   tempDoubleBD.setScale(6,   BigDecimal.ROUND_HALF_UP).doubleValue();
		} 
		
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		System.out.println("****final= "+temp);
		return temp;
	}
	
}