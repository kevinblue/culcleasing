package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T01 {
	
	/**
	 * 根据T01方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT01Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T01 t01 = new T01();
		Date date = t01.getSearchDate(searchDateStr, drawingDateStr);
		
		System.out.println("****date= "+date);
		
		PBCRateInterest rateInterest = new PBCRateInterest();
		double interest = rateInterest.getPBCRateInterest(date, adjustNumber, interestType);
		System.out.println("****interest= "+interest);
		return interest;
	}
	
	/**
	 * 获取需要查询利率的日期
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @return
	 * @throws Exception
	 */
	public Date getSearchDate(String inputDateStr , String drawingDateStr) throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
		Date inputDate = sdf.parse(inputDateStr);
		Date drawingDate = sdf.parse(drawingDateStr); 
		
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
