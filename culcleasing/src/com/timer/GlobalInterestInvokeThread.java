package com.timer;

import com.tenwa.log.LogWriter;
import com.webService.service.GlobalInterestService;

/**
 * 
 * @author zhangqi
 * 2012-01-17
 *
 */
public class GlobalInterestInvokeThread extends Thread{
	/**
	 * no parameters
	 */
	public GlobalInterestInvokeThread() {
		super();
	}

	/**
	 * Build Thread
	 * 
	 * @param threadName
	 */
	public GlobalInterestInvokeThread(String threadName) {
		super(threadName);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Thread#run()
	 */
	public synchronized void run() {
		super.run();
		try {
			// 执行代码 - 机械产品库同步
			int amount = 0;
			GlobalInterestService.dataSync();
			System.out.println("代码执行service"+amount);
			LogWriter.logDebug("本次同步[计提利息]信息数据 [" + amount + "]条！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				sleep(1000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}
	}
}
