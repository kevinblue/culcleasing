package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T02 {
	
	/**
	 * ����T02��ʽ��ѯ����
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
		int drawingDateMonth = drawingCal.get(Calendar.MONTH)+1; //Calendar�·ݴ�0��ʼ
		
		//�����ѯ����С���������һ�������������գ���ѡȡ����ն�Ӧ�ն�Ӧ���εĻ�׼���������ϵ���˻���
		//����ѡȡ��ѯ���ڶ�Ӧ�����������ն�Ӧ���εĻ�׼���������ϵ���˻���
		int month = (drawingDateMonth+2)/3*3+1;
		String compareDateStr = drawingDateYear+"-"+month+"-01";
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
			int searchMonth = (inputDateMonth+2)/3*3-2;
			String searchDateString = inputDateYear+"-"+searchMonth+"-01";
			searchDate = sdf.parse(searchDateString);
		}
		return searchDate;
	}
}
