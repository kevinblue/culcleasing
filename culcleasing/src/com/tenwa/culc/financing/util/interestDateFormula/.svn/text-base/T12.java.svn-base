package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T12 {
	
	/**
	 * 根据T12方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT12Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T12 T12 = new T12();
		Date date = T12.getSearchDate(searchDateStr, drawingDateStr);
		
		PBCRateInterest rateInterest = new PBCRateInterest();
		double interest = rateInterest.getPBCRateInterest(date, adjustNumber, interestType);
		
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
		
		//获取查询日期年份,月份
		Calendar inputCal = Calendar.getInstance();
		inputCal.setTime(inputDate);
		int inputDateYear = inputCal.get(Calendar.YEAR);
		
		
		//获取提款日期年份,月份
		Calendar drawingCal = Calendar.getInstance();
		drawingCal.setTime(drawingDate);
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1;//Calendar月份从0开始
		int drawingDateDay = drawingCal.get(Calendar.DATE);
		
		//调息日期为每年提款日期对应日期，如果查询日期小于提款日对应日期，则取上一年度的提款日对应日期对应档次的基准利率与调整系数乘积。
		//否则，则取本年度的提款日对应日期对应档次的基准利率与调整系数乘积
		
		String compareDateStr = inputDateYear+"-"+drawingDateMonth+"-"+drawingDateDay;
		Date compareDate = sdf.parse(compareDateStr);
		
		//获取需要查询的利率日期
		Date searchDate = new Date();
		String searchDateString = "" ;
		if(inputDate.getTime() < compareDate.getTime()){
			int searchYear = inputDateYear -1;
			searchDateString = searchYear+"-"+drawingDateMonth+"-"+drawingDateDay;
		}else{
			searchDateString = inputDateYear+"-"+drawingDateMonth+"-"+drawingDateDay;
		}
		searchDate = sdf.parse(searchDateString);
		
		return searchDate;
	}
}
