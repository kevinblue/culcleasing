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
 * ����ӿ�����ͬ��Servlet��֧�ֲ�ͬ���ݲ�ͬʱ��ѭ��ͬ��
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
					"�ʽ��ո��ƻ���Ϣͬ��");
		}
		if (invokeTimerGlobalInterestSubsidy != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalInterestSubsidy,
					"��Ϣ������Ϣͬ��");
		}
		if (invokeTimerGlobalPaied != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalPaied, "�����Ϣͬ��");
		}
		if (invokeTimerGlobalProjectEnd != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalProjectEnd,
					"��ͬ������Ϣͬ��");
		}
		if (invokeTimerGlobalReceive != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalReceive, "�տ��Ϣͬ��");
		}
		if (invokeTimerGlobalStartRent != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalStartRent, "������Ϣͬ��");
		}
		if (invokeTimerGlobalInterest != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalInterest, "������Ϣ��Ϣͬ��");
		}
	    
		
		if (invokeTimerGlobalConfirm != null) {
			InvokeUtilTimer.cancelInvoke(invokeTimerGlobalConfirm, "������Ϣ��Ϣͬ��");
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
		// ==========1.�ʽ��ո��ƻ� ����ͬ����ʱ������============
		
		String startTaskGlobalFundPlan = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalFundPlan");
		// �ӳ�ʱ��
		long delayGlobalFundPlan = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalFundPlan"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalFundPlan = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalFundPlan"));
		// ������ʱ��
			invokeTimerGlobalFundPlan = new Timer(true);
			invokeTaskGlobalFundPlan = new GlobalFundPlanInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalFundPlan,
					invokeTaskGlobalFundPlan, delayGlobalFundPlan,
					periodGlobalFundPlan * 60 * 1000, "�ʽ��ո��ƻ���Ϣͬ��");// period
		System.out.println("-----------------------���Զ�ʱ------------�ʽ��ո��ƻ�---------");	
		
		// ==========2.��Ϣ���� ����ͬ����ʱ������============
		String startTaskGlobalInterestSubsidy = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalInterestSubsidy");
		// �ӳ�ʱ��
		long delayGlobalInterestSubsidy = Long
				.parseLong((String) FIDConfigReader
						.getResultByKey("delayTimeGlobalInterestSubsidy"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalInterestSubsidy = Long
				.parseLong((String) FIDConfigReader
						.getResultByKey("periodTimeGlobalInterestSubsidy"));
		// ������ʱ��
			invokeTimerGlobalInterestSubsidy = new Timer(true);
			invokeTaskGlobalInterestSubsidy = new GlobalInterestSubsidyInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalInterestSubsidy,
					invokeTaskGlobalInterestSubsidy,
					delayGlobalInterestSubsidy,
					periodGlobalInterestSubsidy * 60 * 1000, "��Ϣ������Ϣͬ��");// period

			System.out.println("-----------------------���Զ�ʱ------------�ʽ��ո��ƻ�---------");	
			// ==========3.����� ����ͬ����ʱ������============
		String startTaskGlobalPaied = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalPaied");
		// �ӳ�ʱ��
		long delayGlobalIPaied = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalPaied"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalPaied = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalPaied"));
		// ������ʱ��
		
			invokeTimerGlobalPaied = new Timer(true);
			invokeTaskGlobalPaied = new GlobalPaiedInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalPaied,
					invokeTaskGlobalPaied, delayGlobalIPaied,
					periodGlobalPaied * 60 * 1000, "�����Ϣͬ��");// period
			System.out.println("-----------------------���Զ�ʱ------------�ʽ��ո��ƻ�---------");	
		// ==========4.��ͬ���� ����ͬ����ʱ������============
		String startTaskGlobalProjectEnd = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalProjectEnd");
		// �ӳ�ʱ��
		long delayGlobalIProjectEnd = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalProjectEnd"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalProjectEnd = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalProjectEnd"));
		// ������ʱ��
			invokeTimerGlobalProjectEnd = new Timer(true);
			invokeTaskGlobalProjectEnd = new GlobalProjectEndInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalProjectEnd,
					invokeTaskGlobalProjectEnd, delayGlobalIProjectEnd,
					periodGlobalProjectEnd * 60 * 1000, "��ͬ������Ϣͬ��");// period
			System.out.println("-----------------------���Զ�ʱ------------��Ϣ���� ---------");	
		// ==========5.�տ ����ͬ����ʱ������============
		String startTaskGlobalReceive = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalReceive");
		// �ӳ�ʱ��
		long delayGlobalIReceive = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalReceive"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalReceive = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalReceive"));
		// ������ʱ��
			invokeTimerGlobalReceive = new Timer(true);
			invokeTaskGlobalReceive = new GlobalReceiveInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalReceive,
					invokeTaskGlobalReceive, delayGlobalIReceive,
					periodGlobalReceive * 60 * 1000, "�տ��Ϣͬ��");// period
			System.out.println("-----------------------���Զ�ʱ------------�տ---------");	
		// ==========6.���� ����ͬ����ʱ������============
		String startTaskGlobalStartRent = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalStartRent");
		// �ӳ�ʱ��
		long delayGlobalIStartRent = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalStartRent"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalStartRent = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalStartRent"));
		// ������ʱ��
			invokeTimerGlobalStartRent = new Timer(true);
			invokeTaskGlobalStartRent = new GlobalStartRentInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalStartRent,
					invokeTaskGlobalStartRent, delayGlobalIStartRent,
					periodGlobalStartRent * 60 * 1000, "������Ϣͬ��");// period
			System.out.println("-----------------------���Զ�ʱ------------����---------");	
		// ==========7.������Ϣ ����ͬ����ʱ������============
		String startTaskGlobalInterest = (String) FIDConfigReader
				.getResultByKey("startTaskGlobalInterest");
		// �ӳ�ʱ��
		long delayGlobalIInterest = Long.parseLong((String) FIDConfigReader
				.getResultByKey("delayTimeGlobalInterest"));
		// ��ʱˢ��ʱ��(����)
		long periodGlobalInterest = Long.parseLong((String) FIDConfigReader
				.getResultByKey("periodTimeGlobalInterest"));
		// ������ʱ��
			invokeTimerGlobalInterest = new Timer(true);
			invokeTaskGlobalInterest = new GlobalInterestInvokeTask();
			InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalInterest,
					invokeTaskGlobalInterest, delayGlobalIInterest,
					periodGlobalInterest * 60 * 1000, "������Ϣ��Ϣͬ��");// period
			
			// ==========8.��ͬ��ֹ��Ϣ ����ͬ����ʱ������============
			String startTaskGlobalConfirm = (String) FIDConfigReader
					.getResultByKey("startTaskGlobalConfirm");
			// �ӳ�ʱ��
			long delayTimeGlobalConfirm = Long.parseLong((String) FIDConfigReader
					.getResultByKey("delayTimeGlobalConfirm"));
			// ��ʱˢ��ʱ��(����)
			long periodTimeGlobalConfirm = Long.parseLong((String) FIDConfigReader
					.getResultByKey("periodTimeGlobalConfirm"));
			// ������ʱ��
			    invokeTimerGlobalConfirm = new Timer(true);
			    invokeTaskGlobalConfirm = new GlobalConfirmInvokeTask();
				InvokeUtilTimer.antoInvokeTimer(invokeTimerGlobalConfirm,
						invokeTaskGlobalConfirm, delayTimeGlobalConfirm,
						periodTimeGlobalConfirm * 60 * 1000, "��ͬ��ֹ��Ϣͬ��");// period
			System.out.println("-----------------------���Զ�ʱ------------������Ϣ---------");	
			
			
	}	
}
