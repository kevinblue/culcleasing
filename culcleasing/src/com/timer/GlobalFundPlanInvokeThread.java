package com.timer;

import com.tenwa.log.LogWriter;
import com.webService.service.GlobalFundPlanService;
/**
 * 
 * @author zhangqi
 * 2012-01-17
 *
 */
public class GlobalFundPlanInvokeThread extends Thread{
	/**
	 * no parameters
	 */
	public GlobalFundPlanInvokeThread() {
		super();
	}

	/**
	 * Build Thread
	 * 
	 * @param threadName
	 */
	public GlobalFundPlanInvokeThread(String threadName) {
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
			// ִ�д��� - �ʽ��ո��ƻ�
			int amount =GlobalFundPlanService.dataSync();
			System.out.println("����ִ��service"+amount);
			LogWriter.logDebug("����ͬ��[�ʽ�ƻ�]��Ϣ���� [" + amount + "]����");
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
