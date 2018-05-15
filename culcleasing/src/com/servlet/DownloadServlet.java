package com.servlet;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Tools;
import com.container.*;
import com.service.*;

public class DownloadServlet extends HttpServlet {    

	/**
	 * Constructor of the object.
	 */     
	public DownloadServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doProcess(request,response);                                 
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doProcess(request,response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occure
	 */
	public void init() throws ServletException {
		System.out.println("DownloadServlet init(000)");
		// Put your code here
	}
	
	public void doProcess(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
		
		System.out.println("DownloadServlet.doProcess");
		String czyid = (String)request.getSession().getAttribute("czyid");
		String cert_date_start = Tools.getStr(request.getParameter("cert_date_start"));
		String cert_date = Tools.getStr(request.getParameter("cert_date"));
		String process_name = Tools.getStr(request.getParameter("process_name"));
		String res = getMessage(czyid,cert_date_start,cert_date,process_name);
		String filename = "evidence"+Tools.getSystemDate(3)+process_name+".txt";
		
		String path = request.getSession().getServletContext().getRealPath("/");
		if(res!=null){
			BufferedInputStream bis   =   null;   
			BufferedOutputStream bos   =   null;
			File file = null;
			FileWriter fw = null;
			try {
				response.reset();
				response.setContentType("text/plain");   
				response.setHeader("Content-disposition",   "attachment;   filename=\""   +   new String(filename.getBytes("GBK"), "ISO-8859-1")  +"\"");   
				file = new File(filename);
				if(file.exists()){
					file.delete();
				}
				fw=new   FileWriter(file,true);
				String   writeStr="";   
				writeStr=res;    
				fw.write(writeStr,0,writeStr.length());   
				fw.flush();
				fw.close();
				//复制
				String newFile = path+"\\pz\\"+filename;
				String url = "\\pz\\"+filename;
				copyFile(file,newFile);
				addFileList(url,czyid);
//				FileInputStream fis = new FileInputStream(file);
//				bis   =   new   BufferedInputStream(fis);  
//				ServletOutputStream out = response.getOutputStream();
//				bos   =   new   BufferedOutputStream(out);
//				byte   abyte0[]   =   new   byte[2048];
//				int   i;   
//				while((i   =   bis.read(abyte0,   0,   abyte0.length))   >0)  {
//				bos.write(abyte0,   0,   i);
//				}
//				fis.close();
//				bos.flush();
//				out.close();
//				response.flushBuffer();
			}catch(IOException   ioexception){
				throw ioexception;
			} finally {  
				try{ 
					if(bis   !=   null)   
					        bis.close();   
					if(bos   !=   null)   
					        bos.close();
				}catch(IOException e){
					throw e;
				} 
				
			} 
			response.sendRedirect(request.getContextPath()+"/pzxz/pzxz/pzxz_download.jsp");
		}
	}
	
	private void addFileList(String url, String czyid) {
		// TODO Auto-generated method stub
		String sql = "insert into inter_evidence_download(down_date,down_url,create_date,creator,delete_flag,export_flag) values (getdate(),'"+url+"',getdate(),'"+czyid+"','有效','未导出')";
		System.out.println("DownloadServlet.addFileList=="+sql);
		InterEvidence inter = new InterEvidence();
		inter.update(sql);
	}                                                 

	public String getMessage(String czyid,String cert_date_start,String cert_date,String process_name){
		String message = "";
		//表头
		message = "\"凭证输出\",\"V800\",\"002\",\"恒信金融租赁有限公司\",\""+Tools.getSystemDate(0)+"\",\"F1日期F2类别\",\"F3凭证号F4附单据数\",\"F5摘要F6科目编码\",\"F7借方F8贷方\",\"F9数量F10外币\",\"F11汇率\",\"F12制单人\",\"F13结算方式\",\"F14票号\",\"F15发生日期\",\"F16部门编码\",\"F17个人编码\",\"F18客户编码\",\"F19供应商编码\",\"F20业务员\",\"F21项目编码\",\"F22自定义项1\",\"F23自定义项2\",\"F24自由项1\",\"F25自由项2\",\"F26自由项3\",\"F27自由项4\",\"F28自由项5\",\"F29自由项6\",\"F30自由项7\",\"F31自由项8\",\"F32自由项9\",\"F33自由项10\",\"F34外部系统标识\",\"F35业务类型\",\"F36单据类型\",\"F37单据日期\",\"F38单据号\",\"F39凭证是否可改\",\"F40分录是否可增删\",\"F41合计金额是否保值\",\"F42数值是否可改\",\"F43科目是否可改\",\"F44受控科目\",\"F45往来是否可改\",\"F46部门是否可改\",\"F47项目是否可改\",\"F48往来项是否必输\",\"F49账套号\",\"F50核算单位\",\"F51会计年度\",\"F52会计期间\",\"F53类别顺序号\",\"F54凭证号\",\"F55审核人\",\"F56记账人\",\"F57是否记账\",\"F58出纳人\",\"F59行号\",\"F60外币名称\",\"F61单价\",\"F62科目名称\",\"F63部门名称\",\"F64个人名称\",\"F65客户简称\",\"F66供应商简称\",\"F67项目名称\",\"F68项目大类编码\",\"F69项目大类名称\",\"F70对方科目\",\"F71银行两清标志\",\"F72往来两清标志\",\"F73银行核销标志\",\"F74外部系统名称\",\"F75外部账套号\",\"F76外部会计年度\",\"F77外部会计期间\",\"F78外部制单日期\",\"F79外部系统版本\",\"F80凭证标识\",\"F81分录自动编号\",\"F82唯一标识\",\"F83主管签字\",\"F84自由项11\",\"F85自由项12\",\"F86自由项13\",\"F87自由项14\",\"F88自由项15\",\"F89自由项16\"\r\n";
		String sql = "";
		sql = "SELECT     id, create_date, evidence_type, evidence_number, invoice_number, SUBSTRING(cast(evidence_summary as text), 1, 60) AS evidence_summary, subject_number, debit, credit, happen_date, client_id, vndr_id, acc_set_number, accounting_unit, acc_year, acc_month, type_number, line_number, subject_name, client_abbr,  vndr_addr, subject_opposite, process_name, status, exp_flag, exp_date, exp_staff, generate_date FROM inter_evidence_info where status='有效' and exp_flag='否'";
		if(cert_date_start!=null&&!cert_date_start.equals("")){
			sql+=" and convert(varchar(10),create_date,21)>='"+cert_date_start+"'";
		}
		if(cert_date!=null&&!cert_date.equals("")){
			sql+=" and convert(varchar(10),create_date,21)<='"+cert_date+"'";
		}
		if(process_name!=null&&!process_name.equals("")){
			sql+=" and process_name='"+process_name+"'";
		}
		sql+=" order by evidence_number,line_number";
		System.out.println("DownloadServlet.getMessage=========================="+sql);
		InterEvidence inter = new InterEvidence();
		ResultValue rv = inter.getInterEvidence(sql);
		String eid="";
		//\r\n回车换行符
		while (rv.next()){          
			//1
			message += ""+Tools.getDBDateStr(rv.getValue("create_date"))+"";
			//2
			message += ","+Tools.getDBStr(rv.getValue("evidence_type"))+"";
			//3
			message += ","+Tools.getDBStr(rv.getValue("evidence_number"))+"";
			//4
			message +=","+Tools.getDBStr(rv.getValue("invoice_number"));
			//5
			message += ","+Tools.getDBStr(rv.getValue("evidence_summary"))+"";
			//6
			message += ","+Tools.getDBStr(rv.getValue("subject_number"))+"";
			//7
			message += ","+Tools.formatNumberDoubleTwo(rv.getValue("debit"));
			//8
			message += ","+Tools.formatNumberDoubleTwo(rv.getValue("credit"));
			//9-17
			message +=",,,,,,";
			message+=","+Tools.getDBDateStr(rv.getValue("happen_date"));
			message+=",,";
			//18
			message +=","+Tools.getDBStr(rv.getValue("client_id"))+"";
			message +=","+Tools.getDBStr(rv.getValue("vndr_id"))+"";
			//20-48
			message +=",,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
			//49
			message +=",002";
			//50
			message +=",恒信金融租赁有限公司";
			//51-53  f53类别顺序号 字符型 or 数字型
			message +=","+Tools.getDBStr(rv.getValue("acc_year"));
			message +=","+Tools.getDBStr(rv.getValue("acc_month"));
			message +=","+Tools.getDBStr(rv.getValue("type_number"));
			//54-58
			message +=",,,,,";
			//59
			message +=","+Tools.getDBStr(rv.getValue("line_number"));
			//60-61
			message +=",,";
			//62
			message +=","+Tools.getDBStr(rv.getValue("subject_name"))+"";
			//63-64
			message +=",,";
			//65
			message +=","+Tools.getDBStr(rv.getValue("client_abbr"))+"";
			//66
			message +=","+Tools.getDBStr(rv.getValue("vndr_addr"))+"";
			//67-69
			message +=",,,";
			//70
			message +=","+Tools.getDBStr(rv.getValue("subject_opposite"))+"";
			//71-89
			message +=",,,,,,,,,,,,,,,,,,,";
			//\r\n回车换行符
			message +="\r\n";
			eid+=Tools.getDBStr(rv.getValue("id"))+",";
		}
		eid+="0";

		//sql = "update inter_evidence_info set exp_flag='是',exp_date=getdate(),exp_staff='"+czyid+"' where status='有效' and exp_flag='否'";
		//if(cert_date!=null&&!cert_date.equals("")){
		//	sql+="and convert(varchar(10),create_date,21)='"+cert_date+"'";
		//}
		//if(process_name!=null&&!process_name.equals("")){
		//	sql+=" and process_name='"+process_name+"'";
		//}
		
		sql="update inter_evidence_info set exp_flag='是',exp_date=getdate(),exp_staff='"+czyid+"' where id in ("+eid+")";
		System.out.println(sql);
		InterEvidence interEvi = new InterEvidence();
		interEvi.update(sql);
		return message;
	}
	
	 public void copyFile(File oldPath, String newPath) { 
	       try { 
	           int bytesum = 0; 
	           int byteread = 0; 
	           if (oldPath.exists()) { //文件存在时 
	               InputStream inStream = new FileInputStream(oldPath); //读入原文件 
	               FileOutputStream fs = new FileOutputStream(newPath); 
	               byte[] buffer = new byte[1444]; 
	               int length; 
	               while ( (byteread = inStream.read(buffer)) != -1) { 
	                   bytesum += byteread; //字节数 文件大小 
	                   System.out.println(bytesum); 
	                   fs.write(buffer, 0, byteread); 
	               } 
	               inStream.close(); 
	               fs.close();
	           } 
	       } 
	       catch (Exception e) { 
	           System.out.println("复制单个文件操作出错"); 
	           e.printStackTrace(); 

	       } 

	   } 


}
