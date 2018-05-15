package com.timer;

import com.tenwa.log.LogWriter;
import com.webService.service.GlobalProjectEndService;


public class GlobalProjectEndInvokeThread extends Thread{

	/**
	 * no parameters
	 */
	public GlobalProjectEndInvokeThread() {
		super();
	}

	/**
	 * Build Thread
	 * 
	 * @param threadName
	 */
	public GlobalProjectEndInvokeThread(String threadName) {
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
			int amount =GlobalProjectEndService.dataSync();
			LogWriter.logDebug("本次同步[合同结清]信息数据 [" + amount + "]条！");
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
