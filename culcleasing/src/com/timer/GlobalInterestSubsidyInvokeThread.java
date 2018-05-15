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
			// ִ�д��� -��Ϣ����ͬ��
			int amount = GlobalInterestSubsidyService.dataSync();
			LogWriter.logDebug("����ͬ��[��Ϣ����]��Ϣ���� [" + amount + "]����");
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
