package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T09 {
	
	/**
	 * 根据T09方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT09Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T09 T09 = new T09();
		Date date = T09.getSearchDate(searchDateStr, drawingDateStr);
		
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
		
		//获取提款日期年份,月份
		Calendar drawingCal = Calendar.getInstance();
		drawingCal.setTime(drawingDate);
		int drawingDateYear = drawingCal.get(Calendar.YEAR);
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1;//Calendar月份从0开始
		int drawingDateDay = drawingCal.get(Calendar.DATE);
		
		//如果查询日期小于提款日下一个半年度对应日，则选取则选取提款日对应日对应档次的基准利率与调整系数乘积。
		//否则选取查询日期上一半年度对应日期对应档次的基准利率与调整系数乘积。
		
		int month = drawingDateMonth + 6;
		String compareDateStr = drawingDateYear+"-"+month+"-"+drawingDateDay;
		Date compareDate = sdf.parse(compareDateStr);
		
		//获取需要查询的利率日期
		Date searchDate = new Date();
		if(inputDate.getTime() < compareDate.getTime()){
			searchDate = drawingDate;
		}else{
			//获取查询日期年份,月份
			Calendar inputCal = Calendar.getInstance();
			inputCal.setTime(inputDate);
			int inputDateYear = inputCal.get(Calendar.YEAR);
			int inputDateMonth = inputCal.get(Calendar.MONTH)+1;//Calendar月份从0开始
			int inputDateDay = inputCal.get(Calendar.DATE);
			int searchMonth = inputDateMonth-6;
			String searchDateString = inputDateYear+"-"+searchMonth+"-"+inputDateDay;
			searchDate = sdf.parse(searchDateString);
		}
		return searchDate;
	}
}
