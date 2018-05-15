package com.rent.calc.bg;

import java.util.ArrayList;
import java.util.List;

import com.Tools;



public class CommUtil {

	@SuppressWarnings("unchecked")
	public List getPlanDateList(List rentList, String perType, String delay,
			String lease_interval, String plan_date) {
		
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = this.getFirstDate(perType, plan_date,
				lease_interval);
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
			day = plan_date.substring(plan_date.lastIndexOf("-") + 1, plan_date
					.length());
		}
		List l_date = new ArrayList();

		// �Ƚ������ڵĴ���
		String delayDate = "";
		for (int i = 0; i < Integer.parseInt(delay); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date);
			delayDate = getNewDate(addDate, day);
		}

		if ("".equals(delayDate)) {
			delayDate = start_date;
		}
		
		int icount =1;
		int isize = rentList.size();
		if (Integer.parseInt(delay)==0) {
			icount = 0;
			isize=isize-1;
		}
		// ������������ƻ�ʱ��
		for (int i = icount; i <=isize ; i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), delayDate);
			addDate = getNewDate(addDate, day);

			l_date.add(addDate);
		}

		return l_date;
	}

	private String getNewDate(String start_date, String day) {

		// �������µõ��������һ��
		String year = start_date.substring(0, start_date.indexOf("-"));
		String month = start_date.substring(start_date.indexOf("-") + 1,
				start_date.lastIndexOf("-"));
		String lastDay = Tools.getLastDayOfMonth(year, month);
		String u_day = "";

		u_day = day;
		if (Integer.parseInt(lastDay) <= Integer.parseInt(day)) {
			u_day = lastDay;
		}

		return year + "-" + month + "-" + u_day;
	}

	public String getFirstDate(String type, String plan_date,
			String lease_interval) {
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = plan_date;
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
			day = start_date.substring(start_date.lastIndexOf("-") + 1,
					start_date.length());
		}

		if (type.equals("0")) {
			String s = "";
			start_date = getNewDate(start_date, day);
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("��һ��ʱ��:" + start_date);
		return start_date;
	}

	/**
	 * ����ӳ������ƻ�
	 * 
	 * @param rentList
	 * @param delay
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getDelayRent(List rentList, String delay) {
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		List delay_list = new ArrayList();
		for (int i = 0; i < Integer.parseInt(delay); i++) {
			delay_list.add("0");
		}
		for (int i = 0; i < rentList.size(); i++) {
			delay_list.add(rentList.get(i));
		}
		return delay_list;
	}

	/**
	 * �ӳ������ƻ�ʱ��
	 * 
	 * @param rentList
	 * @param perType
	 * @param delay
	 * @param lease_interval
	 * @param plan_date
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getDelayPlanDateList(List rentList, String perType,
			String delay, String lease_interval, String plan_date) {
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		// �������ĩ���һ���������=�ſ�����+�������
		String start_date = this.getFirstDate(perType, plan_date,
				lease_interval);
		String day = "";
		if (start_date.indexOf("-") > -1) {// �õ���
			day = plan_date.substring(plan_date.lastIndexOf("-") + 1, plan_date
					.length());
		}
		List l_date = new ArrayList();

		// �Ƚ������ڵĴ���
		String delayDate = "";
		for (int i = 0; i < Integer.parseInt(delay); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date);
			delayDate = getNewDate(addDate, day);
			l_date.add(delayDate);
		}

		// ������������ƻ�ʱ��
		for (int i = 1; i <= rentList.size(); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), delayDate);
			addDate = getNewDate(addDate, day);

			l_date.add(addDate);
		}

		return l_date;
	}

	public static void main(String[] args) {

		CommUtil cu = new CommUtil();
		List l = new ArrayList();
		l.add("1");
		l.add("1");
		l.add("1");
		l.add("1");
		List list = cu.getDelayPlanDateList(l, "1", "3", "3", "2010-12-09");
		List list1 = cu.getPlanDateList(l, "1", "3", "3", "2010-12-09");
		List l1 = cu.getDelayRent(l, "3");
		for (int i = 0; i < list.size(); i++) {
			System.out.println("==" + list.get(i).toString()+"=="+l1.get(i).toString());
		}
		
		for (int j = 0; j < list1.size(); j++) {
			System.out.println("=="+list1.get(j).toString());
		}
	}

}
