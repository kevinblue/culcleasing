package com.tenwa.culc.financing.util.interestDateFormula;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.tenwa.culc.util.ERPDataSource;

//import dbconn.Conn;

public class T15 {
	
	/**
	 * 根据T15方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT15Interest(String drawings_id ,String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T15 T15 = new T15();
		//Date date = T15.getSearchDate(searchDateStr, drawings_id );
		Date date = T15.getRefundDate(drawings_id , searchDateStr);
		
		PBCRateInterest rateInterest = new PBCRateInterest();
		double interest = rateInterest.getPBCRateInterest(date, adjustNumber, interestType);
		
		return interest;
	}
	
	public Date getRefundDate(String drawings_id , String searchDateStr) throws Exception {
		Date date = new Date();
		//Conn db = new Conn();
		StringBuffer sql =  new StringBuffer();
		sql.append("select CONVERT(varchar(10),max(refund_plan_date), 120 ) as refund_plan_date");
		sql.append(" from financing_refund_plan");
		sql.append(" where 1=1  and drawings_id = '" + drawings_id +"'");
		sql.append(" and refund_interest >0");
		sql.append(" and refund_plan_date <= '" + searchDateStr +"'");
		
		ERPDataSource erp = new ERPDataSource();
		ResultSet rs = erp.executeQuery(sql.toString());
		if(rs.next()){
			date = rs.getDate("refund_plan_date");
		}
		rs.close();
		erp.close();
		
		return date;
	}
	
	/**
	 * 获取需要查询利率的日期
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @return
	 * @throws Exception
	 */
	public Date getSearchDate(String inputDateStr , String drawings_id ) throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
		Date inputDate = sdf.parse(inputDateStr);
		Date drawingDate = this.getRefundDate(drawings_id, inputDateStr);
		
		//获取提款日期年份
		Calendar drawingCal = Calendar.getInstance();
		drawingCal.setTime(drawingDate);
		int drawingDateYear = drawingCal.get(Calendar.YEAR);
		
		//如果查询日期小于提款日下一年的1月1日，则选取提款日
		//否则选取查询日期对应年的1月1日
		String compareDateStr = drawingDateYear+1+"-01-01";
		Date compareDate = sdf.parse(compareDateStr);
		
		//获取需要查询的利率日期
		Date searchDate = new Date();
		if(inputDate.getTime() < compareDate.getTime()){
			searchDate = drawingDate;
		}else{
			//获取查询日期年份
			Calendar inputCal = Calendar.getInstance();
			inputCal.setTime(inputDate);
			int inputDateYear = inputCal.get(Calendar.YEAR);
			String searchDateString = inputDateYear+"-01-01";
			searchDate = sdf.parse(searchDateString);
		}
		return searchDate;
	}
}
