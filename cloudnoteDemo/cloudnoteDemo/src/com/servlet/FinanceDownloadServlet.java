package com.servlet;

import java.io.*;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FinanceDownloadServlet extends HttpServlet {    

	// 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "template";
  
    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
	    
	public FinanceDownloadServlet() {
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
		
			System.out.println("财报模板下载开始");
			String current_date =request.getParameter("current_date"); 
			
			String fileName ="finance_report_timplite.xls";
	        String downloadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
	        System.out.println("getServletContext().getRealPath "+getServletContext().getRealPath("./") );
	        System.out.println("File.separator： "+File.separator );
	        System.out.println("uploadPath："+downloadPath);
	        System.out.println("servlet_current_date："+current_date);
	        
            String tempfile = downloadPath + File.separator + fileName;  
            String targetFile=downloadPath + File.separator +"finance_report_timpltag.xls";
            String message="";                   
              try {
            	  WriteFinanceTemplate.writeDatatoTempl(tempfile, targetFile,current_date);
				message="1";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				message=e.getMessage();
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
