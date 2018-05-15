package com.servlet;

import java.io.*;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.table.util.ImportExcleContent;



public class FinanceUploadServlet extends HttpServlet {    

	// 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "upload_ssss";
  
    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
	    
	public FinanceUploadServlet() {
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
		
			System.out.println("请求财报上传servlet的do post方法开始");
			String custId=request.getParameter("custId");
			String userId=request.getParameter("userId");
		    //String fileName =URLDecoder.decode(request.getParameter("fileName"),"GBK");  
			String fileName =request.getParameter("fileName");  
			
	        // 构造临时路径来存储上传的文件
	        // 这个路径相对当前应用的目录
	        String uploadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
	        System.out.println("getServletContext().getRealPath "+getServletContext().getRealPath("./") );
	        System.out.println("File.separator： "+File.separator );
	        System.out.println("uploadPath："+uploadPath);
	        // 如果目录不存在则创建
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }                
	        System.out.println("fileName:"+fileName);
            String filePath = uploadPath + File.separator + fileName;         
            String message="";            
            String flaguuid=ImportExcleContent.upload(filePath, custId, userId);
            File file=new File(filePath);
           
            file.delete();
            if("1".equals(flaguuid)){
	        	message="success!";
             }else{
            	message="failure:"+flaguuid;
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
