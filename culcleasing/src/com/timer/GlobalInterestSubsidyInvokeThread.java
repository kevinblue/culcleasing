package com.timer;

import com.tenwa.log.LogWriter;
import com.webService.service.GlobalInterestSubsidyService;


public class GlobalInterestSubsidyInvokeThread extends Thread{
	/**
	 * no parameters
	 */
	public GlobalInterestSubsidyInvokeThread() {
		super();
	}

	/**
	 * Build Thread
	 * 
	 * @param threadName
	 */
	public GlobalInterestSubsidyInvokeThread(String threadName) {
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
			// 执行代码 -利息补贴同步
			int amount = GlobalInterestSubsidyService.dataSync();
			LogWriter.logDebug("本次同步[利息补贴]信息数据 [" + amount + "]条！");
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
