package com.servlet;

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

import com.Tools;
import com.sun.net.httpserver.HttpContext;
import com.tenwa.culc.service.CheckExcleContent;
import com.tenwa.culc.service.ImportExcleContent;

public class FinanceCheckUploadServlet extends HttpServlet {    

	// �ϴ��ļ��洢Ŀ¼
    private static final String UPLOAD_DIRECTORY = "upload_ssss";
  
    // �ϴ�����
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
		System.out.println("У���ϴ��ļ���ʼ��"+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		 request.setCharacterEncoding("gbk");		 
		 response.setCharacterEncoding("gbk");
		 response.setContentType("text/html;charset=gbk");
		// Content-type:application/javascript; charset=utf-8
		
		 String message="";
		 String custId=request.getParameter("custId");
			String userId=request.getParameter("userId");
		 // �����ϴ�����
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // �����ڴ��ٽ�ֵ - �����󽫲�����ʱ�ļ����洢����ʱĿ¼��
	        factory.setSizeThreshold(MEMORY_THRESHOLD);
	        // ������ʱ�洢Ŀ¼
	        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));  
	        ServletFileUpload upload = new ServletFileUpload(factory);
	          
	        // ��������ļ��ϴ�ֵ
//	        upload.setFileSizeMax(MAX_FILE_SIZE);          
	        // �����������ֵ (�����ļ��ͱ�����)
	        upload.setSizeMax(MAX_REQUEST_SIZE);
	  
	        // ������ʱ·�����洢�ϴ����ļ�
	        // ���·����Ե�ǰӦ�õ�Ŀ¼
	        String uploadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
	        System.out.println("У��getServletContext().getRealPath "+getServletContext().getRealPath("./") );
	        System.out.println("У��File.separator�� "+File.separator );
	        System.out.println("У��uploadPath��"+uploadPath);
	        // ���Ŀ¼�������򴴽�
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }
	        try {
	            // ���������������ȡ�ļ�����
	            @SuppressWarnings("unchecked")
	            List<FileItem> formItems = upload.parseRequest(request);
	  
	            if (formItems != null && formItems.size() > 0) {
	            	System.out.println("У����ļ���Ϊ��");
	                // ����������
	                for (FileItem item : formItems) {
	                    // �����ڱ��е��ֶ�
	                    if (!item.isFormField()) {
	                        String fileName = new File(item.getName()).getName();
	                        //�޸��ļ�����
	                        fileName=custId+Tools.getSystemDate(3)+".xls";
	                        System.out.println("У��fileName:"+fileName);
	                        String filePath = uploadPath + File.separator + fileName;	                        
	                        File storeFile = new File(filePath);                    	                        
	                        System.out.println("У���ļ�"+storeFile);
	                        // �ڿ���̨����ļ����ϴ�·��
	                        System.out.println("У��"+filePath);
	                        // �����ļ���Ӳ��
	                        item.write(storeFile);	                        
	                     
	                     message=CheckExcleContent.checkAllFinancial(filePath, custId, userId);
	                     if(message.isEmpty()){
	                    	 message="����У��OK��";
	                     }
	                     request.setAttribute("message",message);
	                     System.out.println("У�鷵����Ϣ"+message);
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
	            request.setAttribute("c","������Ϣ: " + ex.getMessage());
	            System.out.println("У�������Ϣ");
	            message="У��ʧ�ܣ�";
	            response.getWriter().print(message);
	            
	        }     
	           
	    }  

		 

		      
        
	


	
	public void init() throws ServletException {
		System.out.println("DownloadServlet init(000)");
		// Put your code here
	}

}
