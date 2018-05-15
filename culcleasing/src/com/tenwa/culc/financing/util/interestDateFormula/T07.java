package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T07 {
	
	/**
	 * ����T07��ʽ��ѯ����
	 * @param searchDateStr
	 * @param drawingDateStr
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception
	 */
	public double getT07Interest(String searchDateStr , String drawingDateStr ,double adjustNumber ,String interestType)  throws Exception{
		T07 T07 = new T07();
		Date date = T07.getSearchDate(searchDateStr, drawingDateStr);
		
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
		
		//��ȡ����������,�·�
		Calendar drawingCal = Calendar.getInstance();
		drawingCal.setTime(drawingDate);
		int drawingDateYear = drawingCal.get(Calendar.YEAR);
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1;//Calendar�·ݴ�0��ʼ
		int drawingDateDay = drawingCal.get(Calendar.DATE);
		
		//�����ѯ����С���������һ�����ȶ�Ӧ�գ���ѡȡ��ѡȡ����ն�Ӧ�ն�Ӧ���εĻ�׼���������ϵ���˻���
		//����ѡȡ��ѯ������һ���ȶ�Ӧ���ڶ�Ӧ���εĻ�׼���������ϵ���˻���
		
		int month = drawingDateMonth + 3;
		String compareDateStr = drawingDateYear+"-"+month+"-"+drawingDateDay;
		Date compareDate = sdf.parse(compareDateStr);
		
		//��ȡ��Ҫ��ѯ����������
		Date searchDate = new Date();
		if(inputDate.getTime() < compareDate.getTime()){
			searchDate = drawingDate;
		}else{
			//��ȡ��ѯ�������,�·�
			Calendar inputCal = Calendar.getInstance();
			inputCal.setTime(inputDate);
			int inputDateYear = inputCal.get(Calendar.YEAR);
			int inputDateMonth = inputCal.get(Calendar.MONTH)+1;//Calendar�·ݴ�0��ʼ
			int inputDateDay = inputCal.get(Calendar.DATE);
			int searchMonth = inputDateMonth-3;
			String searchDateString = inputDateYear+"-"+searchMonth+"-"+inputDateDay;
			searchDate = sdf.parse(searchDateString);
		}
		return searchDate;
	}
}
