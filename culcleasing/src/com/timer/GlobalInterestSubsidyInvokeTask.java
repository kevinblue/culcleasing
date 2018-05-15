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
 * 
 * @author zhangqi 2012-02-24
 * 
 */
public class GlobalInterestSubsidyInvokeTask extends TimerTask {
	/**
	 * ִ�е��� ��Ϣ���� ����ͬ������
	 */
	public void run() {
		// �жϵ�ǰִ�е���Чʱ��
		Calendar cale = Calendar.getInstance();
		cale.setTime(new Date());
		int monTh = cale.get(Calendar.DAY_OF_MONTH);
		int hourTh = cale.get(Calendar.HOUR_OF_DAY);
		
		//��������ÿһ�ζ���ȡ���µ������ļ�����ȡ���µ�������
		Properties properties = new Properties();
		String realpath = FIDConfigReader.class.getClassLoader().getResource("/FIDConfig.properties").getPath();
		InputStream is = null;
		String startTaskGlobalInterestSubsidy = "" ;
		try {
			is = new FileInputStream(realpath);
			properties.load(is);
			startTaskGlobalInterestSubsidy = properties.getProperty("startTaskGlobalInterestSubsidy");
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
		System.out.println("&&&&&&startTaskGlobalInterestSubsidy&&&& :  "+startTaskGlobalInterestSubsidy);
		// 1.�ж��Ƿ���Чʱ���� - ÿ��10��ÿ��2��
		if (monTh == 10 && hourTh==2 && "on".equals(startTaskGlobalInterestSubsidy)) {
			// ʹ�ö��̵߳���WebService
			GlobalInterestSubsidyInvokeThread invokeThread = new GlobalInterestSubsidyInvokeThread(
					"======[[GlobalInterestSubsidy Task Thread]]=========");
			invokeThread.setPriority(5);// �����߳����ȼ���
			invokeThread.start();
		} else {
			LogWriter.logDebug("[��Ϣ���� ����ͬ������]����Чʱ����ִ�д���nc");
		}
	}
}
