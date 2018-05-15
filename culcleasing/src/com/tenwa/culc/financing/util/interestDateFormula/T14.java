package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T14 {
	
	/**
	 * ����T14��ʽ��ѯ����
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT14Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T14 T14 = new T14();
		Date date = T14.getSearchDate(searchDateStr, drawingDateStr);
		
		PBCRateInterest rateInterest = new PBCRateInterest();
		double interest = rateInterest.getPBCRateInterest(date, adjustNumber, interestType);
		
		return interest;
	}
	
	/**
	 * ��ȡ��Ҫ��ѯ���ʵ�����
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @return
	 * @throws Exception
	 */
	public Date getSearchDate(String inputDateStr , String drawingDateStr) throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
		Date inputDate = sdf.parse(inputDateStr);
		Date drawingDate = sdf.parse(drawingDateStr); 
		
		//��ȡ��ѯ�������,�·�
		Calendar inputCal = Calendar.getInstance();
		inputCal.setTime(inputDate);
		int inputDateYear = inputCal.get(Calendar.YEAR);
		
		
		//��ȡ����������,�·�
		Calendar drawingCal = Calendar.getInstance();
		drawingCal.setTime(drawingDate);
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1;//Calendar�·ݴ�0��ʼ
		int drawingDateDay = drawingCal.get(Calendar.DATE);
				
		int adjustMonthBase = drawingDateMonth - drawingDateMonth/6*6;
		
		//�����ѯ�������ڣ�������ڣ��������+6���£��������䣬
		//��ȡ�������/�������+6���¶�Ӧ�ն�Ӧ���εĻ�׼���������ϵ���˻�
		
		String compareDateStr = inputDateYear+"-"+adjustMonthBase+"-"+drawingDateDay;
		Date compareDate = sdf.parse(compareDateStr);
		
		int adjustMonth2 = adjustMonthBase + 6;
		String compareDateStr2 = inputDateYear+"-"+adjustMonth2+"-"+drawingDateDay;
		Date compareDate2 = sdf.parse(compareDateStr2);
		
		//��ȡ��Ҫ��ѯ����������
		Date searchDate = new Date();
		String searchDateString = "" ;
		if(inputDate.getTime() >= compareDate.getTime() && inputDate.getTime() < compareDate2.getTime()){
			searchDateString = inputDateYear+"-"+adjustMonthBase+"-"+drawingDateDay;
		}else{
			if(inputDate.getTime() >= compareDate2.getTime()){
				searchDateString = compareDateStr2;
			}else{
				if(inputDate.getTime() < compareDate.getTime() ){
					int adjustMonth3 = adjustMonthBase - 6;
					searchDateString = inputDateYear+"-"+adjustMonth3+"-"+drawingDateDay;
				}
			} 
		}
		
		
		if(inputDate.getTime() < compareDate.getTime()){
			searchDateString = inputDateYear+"-"+adjustMonthBase+"-"+drawingDateDay;
		}else{
			int adjustMonth = adjustMonthBase+6;
			searchDateString = inputDateYear+"-"+adjustMonth+"-"+drawingDateDay;
		}
		searchDate = sdf.parse(searchDateString);
		
		return searchDate;
	}
}
