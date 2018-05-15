package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Date;

public class T05 {
	
	/**
	 * 根据T05方式查询利率
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT05Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T05 T05 = new T05();
		Date date = T05.getSearchDate(searchDateStr, drawingDateStr);
		
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
		
		//如选取查询日期对应日对应档次的基准利率与调整系数乘积。
		return inputDate;
	}
}
