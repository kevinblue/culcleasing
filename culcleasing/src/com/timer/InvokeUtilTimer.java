/**
 * 
 */
package com.timer;

import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;

/**
 * 调用定时器
 * 
 * @author Jaffe
 * 
 * Nov 29, 2010 email:JaffeHe@hotmail.com
 */
public class InvokeUtilTimer {

	private static Logger log = Logger.getLogger(InvokeUtilTimer.class);

	/**
	 * 安排指定的任务从指定的延迟后开始进行重复的固定延迟执行
	 * 
	 * @param invokeTimer
	 * @param invokeTask
	 * @param delay
	 * @param period
	 * @param type
	 */
	public static void antoInvokeTimer(Timer invokeTimer, TimerTask invokeTask,
			long delay, long period, String type) {
		if (log.isInfoEnabled()) {
			log.info(type + "_定时器任务开始，延迟" + delay + "秒后，以" + period
					+ "毫秒的固定速率重复执行");
		}
		invokeTimer.schedule(invokeTask, delay, period);
	}

	/**
	 * 退出任务
	 * 
	 * @param invokeTimer
	 */
	public static void cancelInvoke(Timer invokeTimer, String type) {
		invokeTimer.cancel();
		if (log.isInfoEnabled()) {
			log.info(type + "定时器任务关闭");
		}
	}
}
