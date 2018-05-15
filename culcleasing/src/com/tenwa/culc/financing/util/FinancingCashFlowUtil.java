package com.tenwa.culc.financing.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.ERPDataSource;

public class FinancingCashFlowUtil {
	
	/**
	 * 主方法
	 * @param args
	 * @throws ParseException 
	 * @throws SQLException 
	 */
	public static void main(String[] args) throws SQLException, ParseException{
		System.out.println("主方法");
		String drawings = "2-4";
		String start = "2010-6-23";
		String end = "2024-3-22";
		Map<String,String> timeArea = checkTimeArea(start,end);
		start =timeArea.get("start");
		end =timeArea.get("end");
		
		/**-----------年测试----------------------------**/
		/*System.out.println("年测试"); 
		List<String> list=getTableExtHead( "year",start,end);
		for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			System.out.println("current="+current);;
		}
		for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			Map<String,Double> map =getTableCashFlow(drawings,"year",start,end,current);
			System.out.println("current="+current);
			System.out.println(map.get("refund_corpus")+"----------"+map.get("refund_interest"));
		}*/
		
		/**-----------月测试----------------------------**/
		/*System.out.println("月测试");
		List<String> list=getTableExtHead( "month",start,end);
		for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			System.out.println("current="+current);
		}
		for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			Map<String,Double> map =getTableCashFlow(drawings,"month",start,end,current);
			System.out.println("current="+current);
			System.out.println(map.get("refund_corpus")+"----------"+map.get("refund_interest"));

		}*/
		/**-----------日测试----------------------------**/
		System.out.println("日测试");
		List<String> list=getTableExtHead( "day",start,end);
		for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			System.out.println("current="+current);
		}
		for(Iterator<String> iter = list.iterator();iter.hasNext();){
			String current = iter.next();
			Map<String,Double> map =getTableCashFlow(drawings,"day",start,end,current);
			System.out.println("current="+current);
			System.out.println(map.get("refund_corpus")+"----------"+map.get("refund_interest"));

		}
		System.out.println("-------测试结束----------------");
	}
	
	/**
	 * 取得最大时间和最小时间
	 * @return
	 * @throws SQLException 
	 */
	private static Map<String,String> getMaxAndMinTime() throws SQLException{
		Map<String,String> map = new HashMap<String,String>();
		String sqlstr = " select convert(varchar(10), MIN(refund_plan_date), 120) as refund_plan_date_min,convert(varchar(10), MAX(refund_plan_date), 120) as refund_plan_date_max from financing_refund_plan ";
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sqlstr);
		if(rs.next()){
			map.put("max_date",rs.getString("refund_plan_date_max"));
			map.put("min_date",rs.getString("refund_plan_date_min"));
		}else{
			map.put("max_date","");
			map.put("min_date","");
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return map;
	}
	/**
	 * 矫正开始时间与结束时间
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException 
	 * @throws ParseException 
	 */
	public static Map<String,String> checkTimeArea(String start,String end) throws SQLException, ParseException{
		Map<String,String> map =  getMaxAndMinTime();//最大值与最小值
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = df.parse(start);
		Date endDate = df.parse(end);
		if("".equals(map.get("max_date"))){
			map.put("max_date", end);
		}
		if("".equals(map.get("min_date"))){
			map.put("min_date", start);
		}
		Date maxDate = df.parse(map.get("max_date"));
		Date minDate = df.parse(map.get("min_date"));
		if(startDate.before(minDate)){
			startDate = minDate;
		}
		if(endDate.after(maxDate)){
			endDate = maxDate;
		}
		if(endDate.before(startDate)){
			endDate = startDate;
		}
		map.put("start", df.format(startDate));
		map.put("end", df.format(endDate));
		return map;
	}
	
	/**
	 * 获取扩展表头
	 * @param cycle
	 * @param s tart
	 * @param end
	 * @return
	 * @throws ParseException 
	 * @throws SQLException 
	 */
	public static  List<String> getTableExtHead(String cycle,String start,String end) throws SQLException, ParseException{
//		Map<String,String> map = checkTimeArea(start,end);
//		start=map.get("start_date");
//		end=map.get("end_date");
		List<String> list=null;
		if("year".equals(cycle)){
			list = getTableExtHeadByYear( start, end);
		}
		if("month".equals(cycle)){
			list = getTableExtHeadByMonth( start, end);
		}
		if("day".equals(cycle)){
			list = getTableExtHeadByDay( start, end);
		}
		if(null == list){
			list = new ArrayList<String>();
		}
		return list;
	} 
	/**
	 * 获取年的表头
	 * @param start
	 * @param end
	 * @return
	 */
	private static  List<String> getTableExtHeadByYear(String start,String end){
		List<String> list = new ArrayList<String>();
		int startYear=Integer.parseInt( start.substring(0,4));
		int endYear=Integer.parseInt( end.substring(0, 4));
		for(int i=startYear;i<=endYear;i++){
			list.add(new Integer(i).toString());
		}
		return list;
	}
	/**
	 * 获取月的表头
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException 
	 */
	private static  List<String> getTableExtHeadByMonth(String start,String end) throws ParseException{
		List<String> list = new ArrayList<String>();
		String startStr = start.substring(0,7);
		String endStr = end.substring(0, 7);
		DateFormat df = new SimpleDateFormat("yyyy-MM");
		Calendar calendar = GregorianCalendar.getInstance();
		for(calendar.setTime(df.parse(startStr));!endStr.equals(df.format(calendar.getTime()));calendar.add(Calendar.MONTH, 1)){
			list.add(df.format(calendar.getTime()));
		} 
		list.add(endStr);
		return list;
	}
	/**
	 * 获取天的表头
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException 
	 * @throws SQLException 
	 */
	private static  List<String> getTableExtHeadByDay(String start,String end) throws ParseException, SQLException{
		List<String> list = new ArrayList<String>();
		/*DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = GregorianCalendar.getInstance();
		for(calendar.setTime(df.parse(start));!end.equals(df.format(calendar.getTime()));calendar.add(Calendar.DAY_OF_MONTH, 1)){
			list.add(df.format(calendar.getTime()));
		} 
		list.add(end);
		*/
		ERPDataSource erp = new ERPDataSource();
		String sqlStr = " select convert(varchar(10), refund_plan_date, 120) as plan_date from financing_refund_plan ";
		sqlStr += " where  refund_plan_date <='"+end+"' and refund_plan_date >= '"+start+"' group by convert(varchar(10), refund_plan_date, 120) ";
		ResultSet rs = erp.executeQuery(sqlStr);
		while(rs.next()){
			list.add(rs.getString("plan_date"));
		}
		if(rs!=null){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		// 或者 group by convert(varchar(10), refund_plan_date, 120)
		
		return list;
	}
	

	/**
	 * 获取financing_refund_plan--financing_refund_income 的查询时间区间(表中内容)
	 * @param cycle
	 * @param start
	 * @param end
	 * @param current
	 * @return
	 * @throws ParseException 
	 * @throws SQLException 
	 */
	static Map<String,String> getSearchArea(String cycle,String start,String end,String current) throws ParseException, SQLException{
//		Map<String,String> m = checkTimeArea(start,end);
//		start=m.get("start");
//		end=m.get("end");
		Map<String,String> map=null;
		if("year".equals(cycle)){
			map = getSearchAreaByYear(start,end,current);
		}
		if("month".equals(cycle)){
			map = getSearchAreaByMonth(start,end,current);
		}
		if("day".equals(cycle)){
			map = getSearchAreaByDay(start,end,current);
		}
		if(null == map){
			map = new HashMap<String,String>();
		}
		return map;
	}
	/**
	 * 获取年查询区间
	 * @param start
	 * @param end
	 * @param current
	 * @return
	 */
	private static Map<String,String> getSearchAreaByYear(String start,String end,String current){
		Map<String,String> map = new HashMap<String,String>();
		String startYear = start.substring(0,4);
		String endYear = end.substring(0,4);
		if(startYear.equals(endYear)){
			map.put("start", start);
			map.put("end", end);
		}else if(current.equals(startYear)){
			map.put("start", start);
			map.put("end", startYear+"-12-31");
		}else if(current.equals(endYear)){
			map.put("start", endYear+"-01-01");
			map.put("end", end);
		}else{
			map.put("start", current+"-01-01");
			map.put("end", current+"-12-31");
		}
		return map;
	}
	/**
	 * 获取月查询期间
	 * @param start
	 * @param end
	 * @param current
	 * @return
	 * @throws ParseException 
	 */
	private static Map<String,String> getSearchAreaByMonth(String start,String end,String current) throws ParseException{
		Map<String,String> map = new HashMap<String,String>();
		String startYearMonth = start.substring(0,7);
		String endYearMonth = end.substring(0,7);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = GregorianCalendar.getInstance();
		calendar.setTime(df.parse(current+"-01"));
		if(startYearMonth.equals(endYearMonth)){
			map.put("start", start);
			map.put("end", end);
		}else{
			if(current.equals(startYearMonth)){
				map.put("start", start);
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));  
				map.put("end", df.format(calendar.getTime()));
			}else if(current.equals(endYearMonth)){
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
				map.put("start", df.format(calendar.getTime()));
				map.put("end", end);
			}else{
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
				map.put("start", df.format(calendar.getTime()));
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
				map.put("end", df.format(calendar.getTime()));
			}
		} 
		return map;
	}
	/**
	 * 获取日查询区间
	 * @param start
	 * @param end
	 * @param current
	 * @return
	 */
	private static Map<String,String> getSearchAreaByDay(String start,String end,String current){
		Map<String,String> map = new HashMap<String,String>();
			map.put("start", current);
			map.put("end", current);
		return map;
	}
	
	
	/**
	 * 获取计划计划现金流
	 * @param drawings
	 * @param m
	 * @return
	 * @throws SQLException
	 */	 
	static Map<String,Double> getFinancingRefundPlan(String drawings,Map<String,String> m) throws SQLException{
		Map<String,Double> map = new HashMap<String,Double>();
		ERPDataSource erp = new ERPDataSource();
		String sqlStr = " select drawings_id,sum(refund_corpus) as refund_corpus,sum(refund_interest) as refund_interest from financing_refund_plan ";
		sqlStr += " where drawings_id = '"+drawings+"' and refund_plan_date <= '"+m.get("end")+"' and refund_plan_date >= '"+m.get("start")+"' ";
		sqlStr += " group by drawings_id ";
		System.out.println("sql="+sqlStr);
		ResultSet rs=erp.executeQuery(sqlStr);
		if(rs.next()){
			map.put("refund_corpus", rs.getDouble("refund_corpus"));
			map.put("refund_interest", rs.getDouble("refund_interest"));
		}else{
			map.put("refund_corpus", 0d);
			map.put("refund_interest", 0d);
		}
		if(rs != null ){
			rs.close();
		}
		if(erp!=null){
			erp.close();
		}
		return map;
	}
	/**
	 * 获取现金流
	 * @param drawings
	 * @param cycle
	 * @param start
	 * @param end
	 * @param current
	 * @return
	 * @throws SQLException
	 * @throws ParseException
	 */
	public static Map<String,Double> getTableCashFlow(String drawings,String cycle,String start,String end,String current) throws SQLException, ParseException{
		return getFinancingRefundPlan(drawings,getSearchArea(cycle,start,end,current));
	}
}	
