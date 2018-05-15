package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T13 {
	
	/**
	 * 根据T13方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT13Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T13 T13 = new T13();
		Date date = T13.getSearchDate(searchDateStr, drawingDateStr);
		
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
		int drawingDateDay = drawingCal.get(Calendar.DATE);
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1;//Calendar月份从0开始
		
		int adjustMonthBase = drawingDateMonth - drawingDateMonth/3*3 +1 ;
		
		//如果查询日期属于（提款日期+1个月，提款日期+4个月，提款日期+7个月，提款日期+10个月）两两区间，
		//则取提款日期+1个月/提款日期+4个月/提款日期+7个月/提款日期+10个月对应日对应档次的基准利率与调整系数乘
		
		String compareDateStr1 = inputDateYear+"-"+adjustMonthBase+"-"+drawingDateDay;
		Date compareDate1 = sdf.parse(compareDateStr1);
		
		int adjustMonth3 = adjustMonthBase + 3 ;
		String compareDateStr2 = inputDateYear+"-"+adjustMonth3+"-"+drawingDateDay;
		Date compareDate2 = sdf.parse(compareDateStr2);
		
		//获取需要查询的利率日期
		Date searchDate = new Date();
		String searchDateString = "" ;
		if(inputDate.getTime() < compareDate1.getTime()){
			int adjustMonth = adjustMonthBase -3 ;  
			searchDateString = inputDateYear+"-"+adjustMonth+"-"+drawingDateDay;
		}else{
			if(inputDate.getTime() >= compareDate1.getTime() && inputDate.getTime() < compareDate2.getTime()){
				searchDateString = inputDateYear+"-"+adjustMonthBase+"-"+drawingDateDay;
			}else{
				int adjustMonth6 = adjustMonthBase + 6 ; 
				String compareDateStr3 = inputDateYear+"-"+adjustMonth6+"-"+drawingDateDay;
				Date compareDate3 = sdf.parse(compareDateStr3);
				if(inputDate.getTime() >= compareDate2.getTime() && inputDate.getTime() < compareDate3.getTime()){
					searchDateString = inputDateYear+"-"+adjustMonth3+"-"+drawingDateDay;
				}else{
					int adjustMonth9 = adjustMonthBase + 9 ; 
					String compareDateStr4 = inputDateYear+"-"+adjustMonth9+"-"+drawingDateDay;
					Date compareDate4 = sdf.parse(compareDateStr4);
					if(inputDate.getTime() >= compareDate3.getTime() && inputDate.getTime() < compareDate4.getTime()){
						searchDateString = inputDateYear+"-"+adjustMonth6+"-"+drawingDateDay;
					}else{
						int adjustMonth12 = adjustMonthBase + 12 ; 
						String compareDateStr5 = inputDateYear+"-"+adjustMonth12+"-"+drawingDateDay;
						Date compareDate5 = sdf.parse(compareDateStr5);
						if(inputDate.getTime() >= compareDate4.getTime() && inputDate.getTime() < compareDate5.getTime()){
							searchDateString = inputDateYear+"-"+adjustMonth9+"-"+drawingDateDay;
						}
					}
				}
			}
		}
		System.out.println(searchDateString);
		searchDate = sdf.parse(searchDateString);
		
		return searchDate;
	}
}
