package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.datasync.FIDConfigReader;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;
import com.timer.GlobalConfirmInvokeTask;
import com.timer.GlobalFundPlanInvokeTask;
import com.timer.GlobalInterestInvokeTask;
import com.timer.GlobalInterestSubsidyInvokeTask;
import com.timer.GlobalPaiedInvokeTask;
import com.timer.GlobalProjectEndInvokeTask;
import com.timer.GlobalReceiveInvokeTask;
import com.timer.GlobalStartRentInvokeTask;
import com.timer.InvokeUtilTimer;


/**
 * 财务接口数据同步Servlet，支持不同数据不同时间循环同步
 * 
 * @author Jaffe
 * 
 * Date:Oct 8, 2011 11:40:44 PM Email:JaffeHe@hotmail.com
 */

public class FIDataSyncCulcServlet extends HttpServlet {

	/**
	 * UUID
	 */
	private static final long serialVersionUID = -2659387534650694789L;
	private Timer invokeTimerGlobalFundPlan = null;
	private TimerTask invokeTaskGlobalFundPlan = null;
	private Timer invokeTimerGlobalInterestSubsidy = null;
	private TimerTask invokeTaskGlobalInterestSubsidy = null;
	private Timer invokeTimerGlobalPaied = null;
	private TimerTask invokeTaskGlobalPaied = null;
	private Timer invokeTimerGlobalProjectEnd = null;
	private TimerTask invokeTaskGlobalProjectEnd = null;
	private Timer invokeTimerGlobalReceive = null;
	private TimerTask invokeTaskGlobalReceive = null;
	private Timer invokeTimerGlobalStartRent = null;
	private TimerTask invokeTaskGlobalStartRent = null;
	private Timer invokeTimerGlobalInterest = null;
	private TimerTask invokeTaskGlobalInterest = null;	
	private Timer invokeTimerGlobalConfirm = null;
	private TimerTask invokeTaskGlobalConfirm = null;
	
	
	public void destroy() {
		super.destroy();
		if (invokeTimerGlobalFundPlan != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalFundPlan,
					"资金收付计划信息同步");
		}
		if (invokeTimerGlobalInterestSubsidy != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalInterestSubsidy,
					"利息补贴信息同步");
		}
		if (invokeTimerGlobalPaied != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalPaied, "付款单信息同步");
		}
		if (invokeTimerGlobalProjectEnd != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalProjectEnd,
					"合同结清信息同步");
		}
		if (invokeTimerGlobalReceive != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalReceive, "收款单信息同步");
		}
		if (invokeTimerGlobalStartRent != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalStartRent, "起租信息同步");
		}
		if (invokeTimerGlobalInterest != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalInterest, "计提利息信息同步");
		}
	    
		
		if (invokeTimerGlobalConfirm != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalConfirm, "计提利息信息同步");
		}
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String status = request.getParameter("status");
		if(status != null && !"".equals(status)){
			try {
				Method method = this.getClass().getMethod(status,
						HttpServletRequest.class, HttpServletResponse.class);
				method.invoke(this, request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// ==========1.资金收付计划 数据同步定时器设置============
		
		String startTaskGlobalFundPlan = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalFundPlan");
		// 延迟时间
		long delayGlobalFundPlan = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalFundPlan"));
		// 定时刷新时间(分钟)
		long periodGlobalFundPlan = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalFundPlan"));
		// 启动定时器
			invokeTimerGlobalFundPlan = new Timer(true);
			invokeTaskGlobalFundPlan = new GlobalFundPlanInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalFundPlan,
					invokeTaskGlobalFundPlan, delayGlobalFundPlan,
					periodGlobalFundPlan * 60 * 1000, "资金收付计划信息同步");// period
		System.out.println("-----------------------测试定时------------资金收付计划---------");	
		
		// ==========2.利息补贴 数据同步定时器设置============
		String startTaskGlobalInterestSubsidy = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalInterestSubsidy");
		// 延迟时间
		long delayGlobalInterestSubsidy = Long
				.parseLong((String) FIDConfigReader
						.getResultByKey("delayTimeGlobalInterestSubsidy"));
		// 定时刷新时间(分钟)
		long periodGlobalInterestSubsidy = Long
				.parseLong((String) FIDConfigReader
						.getResultByKey("periodTimeGlobalInterestSubsidy"));
		// 启动定时器
			invokeTimerGlobalInterestSubsidy = new Timer(true);
			invokeTaskGlobalInterestSubsidy = new GlobalInterestSubsidyInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalInterestSubsidy,
					invokeTaskGlobalInterestSubsidy,
					delayGlobalInterestSubsidy,
					periodGlobalInterestSubsidy * 60 * 1000, "利息补贴信息同步");// period

			System.out.println("-----------------------测试定时------------资金收付计划---------");	
			// ==========3.利付款单 数据同步定时器设置============
		String startTaskGlobalPaied = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalPaied");
		// 延迟时间
		long delayGlobalIPaied = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalPaied"));
		// 定时刷新时间(分钟)
		long periodGlobalPaied = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalPaied"));
		// 启动定时器
		
			invokeTimerGlobalPaied = new Timer(true);
			invokeTaskGlobalPaied = new GlobalPaiedInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalPaied,
					invokeTaskGlobalPaied, delayGlobalIPaied,
					periodGlobalPaied * 60 * 1000, "付款单信息同步");// period
			System.out.println("-----------------------测试定时------------资金收付计划---------");	
		// ==========4.合同结清 数据同步定时器设置============
		String startTaskGlobalProjectEnd = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalProjectEnd");
		// 延迟时间
		long delayGlobalIProjectEnd = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalProjectEnd"));
		// 定时刷新时间(分钟)
		long periodGlobalProjectEnd = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalProjectEnd"));
		// 启动定时器
			invokeTimerGlobalProjectEnd = new Timer(true);
			invokeTaskGlobalProjectEnd = new GlobalProjectEndInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalProjectEnd,
					invokeTaskGlobalProjectEnd, delayGlobalIProjectEnd,
					periodGlobalProjectEnd * 60 * 1000, "合同结清信息同步");// period
			System.out.println("-----------------------测试定时------------利息补贴 ---------");	
		// ==========5.收款单 数据同步定时器设置============
		String startTaskGlobalReceive = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalReceive");
		// 延迟时间
		long delayGlobalIReceive = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalReceive"));
		// 定时刷新时间(分钟)
		long periodGlobalReceive = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalReceive"));
		// 启动定时器
			invokeTimerGlobalReceive = new Timer(true);
			invokeTaskGlobalReceive = new GlobalReceiveInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalReceive,
					invokeTaskGlobalReceive, delayGlobalIReceive,
					periodGlobalReceive * 60 * 1000, "收款单信息同步");// period
			System.out.println("-----------------------测试定时------------收款单---------");	
		// ==========6.起租 数据同步定时器设置============
		String startTaskGlobalStartRent = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalStartRent");
		// 延迟时间
		long delayGlobalIStartRent = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalStartRent"));
		// 定时刷新时间(分钟)
		long periodGlobalStartRent = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalStartRent"));
		// 启动定时器
			invokeTimerGlobalStartRent = new Timer(true);
			invokeTaskGlobalStartRent = new GlobalStartRentInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalStartRent,
					invokeTaskGlobalStartRent, delayGlobalIStartRent,
					periodGlobalStartRent * 60 * 1000, "起租信息同步");// period
			System.out.println("-----------------------测试定时------------起租---------");	
		// ==========7.计提利息 数据同步定时器设置============
		String startTaskGlobalInterest = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalInterest");
		// 延迟时间
		long delayGlobalIInterest = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalInterest"));
		// 定时刷新时间(分钟)
		long periodGlobalInterest = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalInterest"));
		// 启动定时器
			invokeTimerGlobalInterest = new Timer(true);
			invokeTaskGlobalInterest = new GlobalInterestInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalInterest,
					invokeTaskGlobalInterest, delayGlobalIInterest,
					periodGlobalInterest * 60 * 1000, "计提利息信息同步");// period
			
			// ==========8.合同终止利息 数据同步定时器设置============
			String startTaskGlobalConfirm = (String) FIDConfigReader
					.getResultByKey("startTaskGlobalConfirm");
			// 延迟时间
			long delayTimeGlobalConfirm = Long.parseLong((String) FIDConfigReader
					.getResultByKey("delayTimeGlobalConfirm"));
			// 定时刷新时间(分钟)
			long periodTimeGlobalConfirm = Long.parseLong((String) FIDConfigReader
					.getResultByKey("periodTimeGlobalConfirm"));
			// 启动定时器
			    invokeTimerGlobalConfirm = new Timer(true);
			    invokeTaskGlobalConfirm = new GlobalConfirmInvokeTask();
				InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalConfirm,
						invokeTaskGlobalConfirm, delayTimeGlobalConfirm,
						periodTimeGlobalConfirm * 60 * 1000, "合同终止信息同步");// period
			System.out.println("-----------------------测试定时------------计提利息---------");	
			
			
	}	
}
