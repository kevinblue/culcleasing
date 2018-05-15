package com.timer;

import com.tenwa.log.LogWriter;
import com.webService.service.GlobalReceiveService;


public class GlobalReceiveInvokeThread extends Thread {
	/**
	 * no parameters
	 */
	public GlobalReceiveInvokeThread() {
		super();
	}

	/**
	 * Build Thread
	 * 
	 * @param threadName
	 */
	public GlobalReceiveInvokeThread(String threadName) {
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
			// ִ�д��� - ��е��Ʒ��ͬ��
			int amount =GlobalReceiveService.dataSync();
			LogWriter.logDebug("����ͬ��[�տ]��Ϣ���� [" + amount + "]����");
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
