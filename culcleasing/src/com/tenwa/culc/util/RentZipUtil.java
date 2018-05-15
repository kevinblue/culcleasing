/**
 * com.tenwa.util.RentZipUtil
 * create by JavaJeffe.
 * date Oct 21, 2010
 */
package com.tenwa.culc.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

/**
 * @author JavaJeffe
 * 
 * date ---- 2:21:52 PM
 */
public class RentZipUtil {

	/**
	 * 将服务器指定文件夹下的文件压缩为zip下载
	 * 
	 * @param filePath
	 *            服务器名称
	 * @param fileName
	 *            下载的文件名
	 * @param zipResponse
	 * @param pageContext
	 * @throws Exception
	 */
	public static void downRenZip(String filePath, String fileName,
			HttpServletResponse zipResponse, PageContext pageContext)
			throws Exception {
		// 设置头信息描述此是下载文件
		String zipName = "rent_notice_" + fileName + "_v1.zip";
		zipName = URLDecoder.decode(zipName, "UTF-8");

		zipResponse.reset();
		zipResponse.setContentType("application/zip");
		zipResponse.addHeader("Content-Disposition", "attachment;filename="
				+ zipName);// 默认下载文件名称

		// 把流程定义里面的文件都给打包 默认名称为 name_version.zip格式
		ZipOutputStream outputStream = new ZipOutputStream(zipResponse
				.getOutputStream());// 输出到浏览器

		compress(outputStream, filePath);// 压缩文件

		outputStream.close();// 关闭流
	}

	/**
	 * 将指定文件夹下文件压缩到outputStream里
	 * 
	 * @param outputStream
	 * @param filePath
	 * @throws IOException 
	 */
	public static void compress(ZipOutputStream outputStream, String filePath) throws IOException {
		//压缩文件
		File deptFile = new File(filePath);
		FileInputStream inputStream = null;
		
		if(!deptFile.isDirectory()){
			System.out.println("不是文件夹");
		}else{
			System.out.println("压缩文件夹=="+filePath+"==下文件");
			String[] fileList = deptFile.list();
			
			for( int i=0; i<fileList.length; i++ ){
				File readFile = new File(filePath+"/"+fileList[i]);
				if(!readFile.isDirectory()){
					System.out.println("path=" + readFile.getPath()); 
		            System.out.println("absolutepath=" + readFile.getAbsolutePath()); 
		            System.out.println("name=" + readFile.getName()); 
		            //压缩文件名
		            outputStream.putNextEntry(new ZipEntry(fileList[i]));
		            //压缩文件字节
		            inputStream = new FileInputStream(readFile);
		            byte[] tempBytes = new byte[1024];
					int fileLen = 0;
					
					while( (fileLen = inputStream.read(tempBytes))!=-1 ){
						outputStream.write(tempBytes, 0, fileLen);
					}
					//关闭流
					inputStream.close();
					outputStream.closeEntry();
				}
			}
		}
	}
}
