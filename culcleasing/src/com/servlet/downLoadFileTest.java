package com.servlet;
public class downLoadFileTest {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		String downloadedFileFullPath = "D:/4客户财务报表(1).xls";//模板路径
		String FileFullPath = "D:/4客户财务报表(1)生成模板.xls";//生成文件路径

		
		writeDatatoTemplateExcel writeDatatoTemplateExcel = new writeDatatoTemplateExcel();
		writeDatatoTemplateExcel.writeDatatoTemplateExcel(downloadedFileFullPath, FileFullPath);
		/*File file=new File(downloadedFileFullPath);
		if(!file.isFile()){
			throw new Exception("没有下载文件：");
		}
		response.reset();
		response.setHeader("Content-disposition", "attachment; filename=" + fileTitleName);
		response.setContentType("text/html; charset=UTF-8");
		OutputStream out = response.getOutputStream();
		ResourceUtil.getFileUploadOperation().downloadFile(downloadedFileFullPath, out, null);*/
		
	}
	
	
	
}
