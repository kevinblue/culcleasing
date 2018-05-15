package com.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tenwa.culc.calc.tx.util.DateUtils;

import timer.GlobalInterestInvokeTask;

public class FinanceInterfaceServlet extends HttpServlet{
	private Timer invokeTimer = null;
	private TimerTask invokeTask = null;
	public FinanceInterfaceServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
                              
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void init() throws ServletException {
		
		
		System.out.println("DownloadServlet init(000)");
		long delay = DateUtils.getTimer(2);
		invokeTimer = new Timer(true);
		invokeTask = new GlobalInterestInvokeTask();
		invokeTimer.schedule(invokeTask, 1000*60, 1000*60*60*24);
//		InvokeUtilTimer.antoInvokeTimer(invokeTimerEquipMedi,
//				invokeTaskEquipMedi, delayEquipMedi,
//				periodEquipMedi * 60 * 1000, "医疗事业产品库信息同步");		
//		// Put your code here
//	}
//	 */
//		public static void antoInvokeTimer(Timer invokeTimer, TimerTask invokeTask,
//				long delay, long period, String type) {
//			if (log.isInfoEnabled()) {
//				log.info(type + "_定时器任务开始，延迟" + delay + "秒后，以" + period
//						+ "毫秒的固定速率重复执行");
//			}
//			invokeTimer.schedule(invokeTask, delay, period);
		}
		public static void main(String[] args) {
			long hour = 60 * 60 * 1000;
			long time = System.currentTimeMillis();
			System.out.println(time);
			time += 8 * hour; 
			System.out.println(time);
			time %= 24 * hour;
			double ss = 24*hour-time+2*hour;
			System.out.println(ss/hour);
			System.out.printf("%02d:%02d\n", time / hour, time % hour / 60000);
			time = 24 * hour - time;
			System.out.printf("%02d:%02d\n", time / hour, time % hour / 60000);
		}
		

}
