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


public class GlobalStartRentInvokeTask extends TimerTask{
	/**
	 * ִ�е��� ���� ����ͬ������
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
		String startTaskGlobalStartRent = "" ;
		try {
			is = new FileInputStream(realpath);
			properties.load(is);
			startTaskGlobalStartRent = properties.getProperty("startTaskGlobalStartRent");
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
		System.out.println("&&&&&&startTaskGlobalStartRent&&&& :  "+startTaskGlobalStartRent);
		// 1.�ж��Ƿ���Чʱ���� - ÿ��2��
		
		if (hourTh ==2 && "on".equals(startTaskGlobalStartRent)) {
			System.out.println("����ִ�е�===");
			// ʹ�ö��̵߳���WebService
			GlobalStartRentInvokeThread invokeThread = new GlobalStartRentInvokeThread(
					"======[[GlobalStartRent Task Thread]]=========");
			invokeThread.setPriority(5);// �����߳����ȼ���
			invokeThread.start();
		} else {
			LogWriter.logDebug("[���� ����ͬ������]����Чʱ����ִ�д���nc");
		}
	}
}
