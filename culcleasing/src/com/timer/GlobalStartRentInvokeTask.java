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
	 * 执行调用 起租 数据同步任务
	 */
	public void run() {
		// 判断当前执行的有效时间
		Calendar cale = Calendar.getInstance();
		cale.setTime(new Date());
		int hourTh = cale.get(Calendar.HOUR_OF_DAY);
		
		//调度任务每一次都读取最新的配置文件，获取最新的配置项
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
					throw new RuntimeException("关闭FIDConfig层资源出现异常", e);
				}
			}
		}
		System.out.println("&&&&&&startTaskGlobalStartRent&&&& :  "+startTaskGlobalStartRent);
		// 1.判断是否有效时间内 - 每晚2点
		
		if (hourTh ==2 && "on".equals(startTaskGlobalStartRent)) {
			System.out.println("代码执行到===");
			// 使用多线程调用WebService
			GlobalStartRentInvokeThread invokeThread = new GlobalStartRentInvokeThread(
					"======[[GlobalStartRent Task Thread]]=========");
			invokeThread.setPriority(5);// 设置线程优先级别
			invokeThread.start();
		} else {
			LogWriter.logDebug("[起租 数据同步任务]非有效时间内执行代理nc");
		}
	}
}
