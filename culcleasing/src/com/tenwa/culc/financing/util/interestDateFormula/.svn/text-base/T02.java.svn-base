package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T02 {
	
	/**
	 * 根据T02方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT02Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T02 t02 = new T02();
		Date date = t02.getSearchDate(searchDateStr, drawingDateStr);
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
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1; //Calendar月份从0开始
		
		//如果查询日期小于提款日下一个公历季度首日，则选取提款日对应日对应档次的基准利率与调整系数乘积。
		//否则选取查询日期对应公历季度首日对应档次的基准利率与调整系数乘积。
		int month = (drawingDateMonth+2)/3*3+1;
		String compareDateStr = drawingDateYear+"-"+month+"-01";
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
			int searchMonth = (inputDateMonth+2)/3*3-2;
			String searchDateString = inputDateYear+"-"+searchMonth+"-01";
			searchDate = sdf.parse(searchDateString);
		}
		return searchDate;
	}
}
