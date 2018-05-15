package test;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;

import org.apache.log4j.Logger;
public class WordToPDFUtil {
	private  static Logger logger = Logger.getLogger(WordToPDFUtil.class);
	// 将word格式的文件转换为pdf格式
	      public synchronized static Boolean Word2Pdf(String srcPath, String desPath) throws Exception {
	          // 源文件目录
	          File inputFile = new File(srcPath);
	          if (!inputFile.exists()) {
	              System.out.println("源文件不存在！");
	              return false;
	          }
	          // 输出文件目录
	         File outputFile = new File(desPath);
	         if (!outputFile.getParentFile().exists()) {
	             outputFile.getParentFile().exists();
	         }
	         Process process = null;
        	 //获取当前时间的毫秒数
			 long start= System.currentTimeMillis();
			 logger.info("============转换pdf开始============");
	         try{
				 String cmd = "C:\\Program Files\\LibreOffice 5\\program\\soffice --headless -invisible --convert-to pdf "+srcPath+" --outdir "+desPath;
				 System.out.println(cmd);
				 logger.info("python:"+cmd);
				 process = Runtime.getRuntime().exec(cmd);
				 String cmdMsg = "";
				 BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(process.getInputStream()));
				 while((cmdMsg=bufferedReader.readLine()) !=null){
					logger.info(cmdMsg);
				 }
				 process.waitFor();
	         }catch(Exception e){
	        	 e.printStackTrace();
	        	 return false;
	         }finally{
	        	 if(null!=process){
						process.destroy();
			     }
		         long end = System.currentTimeMillis();
					//输出转换pdf所需毫秒数
				 logger.info(end-start+"毫秒");
				 logger.info("============转换pdf结束============");
	         }
	         return true;
	     }
	      
	      public static void main(String[] args) throws Exception {
	    	  WordToPDFUtil.Word2Pdf("e:\\aa.docx", "e:\\woqu");
		}
}
