package com.servlet;

import java.io.*;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.tenwa.culc.service.CheckExcleContent;
import com.tenwa.culc.service.CheckInvoiceInfo;
import com.tenwa.culc.service.FundInvoiceConfirmInfo;
import com.tenwa.culc.service.ImportExcleContent;
import com.tenwa.culc.service.RentInvoiceConfirmInfo;

public class InvoiceCheckServlet extends HttpServlet {    


	    
	public InvoiceCheckServlet() {
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
		 request.setCharacterEncoding("GBK");		 
		 response.setCharacterEncoding("GBK");
		 response.setContentType("text/html;charset=GBK");
		 
		 System.out.println("发票确认校验");
		 String invoice_flag=request.getParameter("invoice_flag");		
		String id_list=request.getParameter("id_list");
		String plid_list=request.getParameter("plid_list");
		String rent_list_list=request.getParameter("rent_list_list");
		String userId=request.getParameter("userId");
	
		 String message=""; 
		 String flag="";
		 if("rent_receipt".equals(invoice_flag)){
			CheckInvoiceInfo cii=new CheckInvoiceInfo();
			 //租金收据退回时校验处理y
			 flag=cii.checkInvoice(plid_list, rent_list_list);
		 }
		 if("fund_invoice_confirm".equals(invoice_flag)){
			 //资金发票确认
			 FundInvoiceConfirmInfo fici=new FundInvoiceConfirmInfo();
			 flag=fici.confirmFundInvoice(id_list, userId);
		 }
		 if("fund_invoice_back".equals(invoice_flag)){
			 //资金发票退回
			 FundInvoiceConfirmInfo fici=new FundInvoiceConfirmInfo();
			 flag=fici.backFundInvoice(id_list);
		 }
		 
		 if("rent_invoice_confirm".equals(invoice_flag)){
			 //租金发票确认
			 RentInvoiceConfirmInfo rici=new RentInvoiceConfirmInfo();
			 flag=rici.confirmRentInvoice(id_list, userId);
		 }
		 if("rent_invoice_back".equals(invoice_flag)){
			 //租金发票退回
			 RentInvoiceConfirmInfo rici=new RentInvoiceConfirmInfo();
			 flag=rici.backRentInvoice(id_list, plid_list, rent_list_list);
		 }      
		 if(flag.isEmpty()){
	        	message="success!";
          }else{
         	message="failure:"+flag;
          } 

         System.out.println("message:"+message);
         PrintWriter writer = response.getWriter(); 	                      
         writer.print(message);                
         writer.close();


        
	}
	public void init() throws ServletException {
		System.out.println("DownloadServlet init(000)");
		// Put your code here
	}

}
