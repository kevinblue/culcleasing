package com.table.upload;

import java.io.*;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import com.sun.net.httpserver.HttpContext;
import com.table.util.CheckExcleContent;
import com.table.util.Tools;


public class FinanceCheckUploadServlet extends HttpServlet {    

	// 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "upload_ssss";
  
    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
	    
	public FinanceCheckUploadServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
                              
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("校验上传文件开始："+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		 request.setCharacterEncoding("gbk");		 
		 response.setCharacterEncoding("gbk");
		 response.setContentType("text/html;charset=gbk");
		// Content-type:application/javascript; charset=utf-8
		
		 String message="";
		 String custId=request.getParameter("custId");
			String userId=request.getParameter("userId");
		 // 配置上传参数
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
	        factory.setSizeThreshold(MEMORY_THRESHOLD);
	        // 设置临时存储目录
	        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));  
	        ServletFileUpload upload = new ServletFileUpload(factory);
	          
	        // 设置最大文件上传值
//	        upload.setFileSizeMax(MAX_FILE_SIZE);          
	        // 设置最大请求值 (包含文件和表单数据)
	        upload.setSizeMax(MAX_REQUEST_SIZE);
	  
	        // 构造临时路径来存储上传的文件
	        // 这个路径相对当前应用的目录
	        String uploadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
	        System.out.println("校验getServletContext().getRealPath "+getServletContext().getRealPath("./") );
	        System.out.println("校验File.separator： "+File.separator );
	        System.out.println("校验uploadPath："+uploadPath);
	        // 如果目录不存在则创建
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }
	        try {
	            // 解析请求的内容提取文件数据
	            @SuppressWarnings("unchecked")
	            List<FileItem> formItems = upload.parseRequest(request);	  
	            if (formItems != null && formItems.size() > 0) {
	            	System.out.println("校验表单文件不为空");
	                // 迭代表单数据
	                for (FileItem item : formItems) {
	                    // 处理不在表单中的字段
	                    if (!item.isFormField()) {
	                        String fileName = new File(item.getName()).getName();
	                        //修改文件名称
	                        fileName=custId+Tools.getSystemDate(3)+".xls";
	                        System.out.println("校验fileName:"+fileName);
	                        String filePath = uploadPath + File.separator + fileName;	                        
	                        File storeFile = new File(filePath);                    	                        
	                        System.out.println("校验文件"+storeFile);
	                        // 在控制台输出文件的上传路径
	                        System.out.println("校验"+filePath);
	                        // 保存文件到硬盘
	                        item.write(storeFile);	                        
	                     
	                     message=CheckExcleContent.checkAllFinancial(filePath, custId, userId);
	                     if(message.isEmpty()){
	                    	 message="数据校验OK，";
	                     }
	                     request.setAttribute("message",message);
	                     System.out.println("校验返回信息"+message);
	                     PrintWriter writer = response.getWriter(); 	                     
	                     writer.print("{");  
	                     writer.print("msg:"+"\""+message+"\"");  
	                     writer.print(","); 
	                     writer.print("fileName:"+"\""+fileName+"\""); 
	                     writer.print(","); 
	                     writer.print("custId:"+"\""+custId+"\""); 
	                     writer.print("}");  
	                  
	                     writer.close();
	                     
	                    }
	                }
	            }
	          
	        } catch (Exception ex) {
	            request.setAttribute("c","错误信息: " + ex.getMessage());
	            System.out.println("校验错误信息");
	            message="校验失败！";
	            response.getWriter().print(message);
	            
	        }     
	           
	    }  

		 

		      
        
	


	
	public void init() throws ServletException {
		System.out.println("DownloadServlet init(000)");
		// Put your code here
	}

}
