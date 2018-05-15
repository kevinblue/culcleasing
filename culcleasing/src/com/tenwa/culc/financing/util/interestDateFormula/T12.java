package com.tenwa.culc.financing.util.interestDateFormula;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class T12 {
	
	/**
	 * ����T12��ʽ��ѯ����
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
		
		//��Ϣ����Ϊÿ��������ڶ�Ӧ���ڣ������ѯ����С������ն�Ӧ���ڣ���ȡ��һ��ȵ�����ն�Ӧ���ڶ�Ӧ���εĻ�׼���������ϵ���˻���
		//������ȡ����ȵ�����ն�Ӧ���ڶ�Ӧ���εĻ�׼���������ϵ���˻�
		
		String compareDateStr = inputDateYear+"-"+drawingDateMonth+"-"+drawingDateDay;
		Date compareDate = sdf.parse(compareDateStr);
		
		//��ȡ��Ҫ��ѯ����������
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
