<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="java.util.*,java.io.*" %>
<%
	String filename = "ÍøÒøºËÏú.txt";  
	String res = "123";
 
	if(res!=null){
		File file = new File(filename);
		FileWriter   fw=new   FileWriter(file,true);   
		String   writeStr="";   
		writeStr=res;           
		fw.write(writeStr,0,writeStr.length());   
		fw.flush();
		fw.close();   
		response.setContentType("text/plain");   
		response.setHeader("Content-disposition",   "attachment;   filename=\""   +   new String(filename.getBytes("GBK"), "ISO-8859-1")  +"\"");   
		BufferedInputStream   bis   =   null;   
		BufferedOutputStream   bos   =   null;    
		try {   
			FileInputStream   fis   =   new   FileInputStream(file);  
			bis   =   new   BufferedInputStream(fis);   
			bos   =   new   BufferedOutputStream(response.getOutputStream());
			byte   abyte0[]   =   new   byte[2048];   
			int   i;   
			while((i   =   bis.read(abyte0,   0,   abyte0.length))   >0)  {
			bos.write(abyte0,   0,   i);
			}
			bos.flush();
		}catch(IOException   ioexception){   
		}catch(Exception e){
		} finally {  
			try{ 
				if(bis   !=   null)   
				        bis.close();   
				if(bos   !=   null)   
				        bos.close();  
			}catch(Exception e){
			} 
			response.flushBuffer();
		} 
		          
	}else{
		
  	}   
%>