package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T01 {
	
	/**
	 * ����T01��ʽ��ѯ����
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
		
		//��ȡ����������
		Calendar drawingCal = Calendar.getInstance();
		drawingCal.setTime(drawingDate);
		int drawingDateYear = drawingCal.get(Calendar.YEAR);
		
		//�����ѯ����С���������һ���1��1�գ���ѡȡ�����
		//����ѡȡ��ѯ���ڶ�Ӧ���1��1��
		String compareDateStr = drawingDateYear+1+"-01-01";
		Date compareDate = sdf.parse(compareDateStr);
		
		//��ȡ��Ҫ��ѯ����������
		Date searchDate = new Date();
		if(inputDate.getTime() < compareDate.getTime()){
			searchDate = drawingDate;
		}else{
			//��ȡ��ѯ�������
			Calendar inputCal = Calendar.getInstance();
			inputCal.setTime(inputDate);
			int inputDateYear = inputCal.get(Calendar.YEAR);
			String searchDateString = inputDateYear+"-01-01";
			searchDate = sdf.parse(searchDateString);
		}
		return searchDate;
	}
}
