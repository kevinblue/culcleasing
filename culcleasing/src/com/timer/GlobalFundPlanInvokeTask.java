/**
 * com.tenwa.datasync.timer
 */
package com.timer;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.TimerTask;

import com.datasync.FIDConfigReader;
import com.tenwa.log.LogWriter;

/**
 * �ʽ��ո��ƻ� ����ͬ�����������
 * 
 * @author Jaffe
 * 
 * Date:Oct 8, 2011 11:41:55 PM Email:JaffeHe@hotmail.com
 */
public class GlobalFundPlanInvokeTask extends TimerTask {

	/**
	 * ִ�е��� �ʽ��ո��ƻ� ����ͬ������
	 */
	public void run() {
		// �жϵ�ǰִ�е���Чʱ��
		Calendar cale = Calendar.getInstance();
		cale.setTime(new Date());
		int hourTh = cale.get(Calendar.HOUR_OF_DAY);
		
		//��������ÿһ�ζ���ȡ���µ������ļ�����ȡ���µ�������
		Properties properties = new Properties();
		String realpath = FIDConfigReader.class.getClassLoader().getResource("/FIDConfig.properties").getPath();
		InputStream is = null;
		String startTaskGlobalFundPlan = "" ;
		try {
			is = new FileInputStream(realpath);
			properties.load(is);
			startTaskGlobalFundPlan = properties.getProperty("startTaskGlobalFundPlan");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					throw new RuntimeException("�ر�FIDConfig����Դ�����쳣", e);
				}
			}
		}
		System.out.println("&&&&&&startTaskGlobalFundPlan&&&& :  "+startTaskGlobalFundPlan);		
		// 1.�ж��Ƿ���Чʱ���� - 2��
		if (hourTh ==2 && "on".equals(startTaskGlobalFundPlan)) {
			System.out.println("����ִ�е�===");
			// ʹ�ö��̵߳���WebService
			GlobalFundPlanInvokeThread invokeThread = new GlobalFundPlanInvokeThread(
					"======[[GlobalFundPlan Task Thread]]=========");
			invokeThread.setPriority(5);// �����߳����ȼ���
			invokeThread.start();
			System.out.println("����ִ�е�aaaaaaaa");
		} else {
			LogWriter.logDebug("[�ʽ��ո��ƻ� ����ͬ������]����Чʱ����ִ�д���nc");
		}
	}
}
