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
	 * ��������ָ���ļ����µ��ļ�ѹ��Ϊzip����
	 * 
	 * @param filePath
	 *            ����������
	 * @param fileName
	 *            ���ص��ļ���
	 * @param zipResponse
	 * @param pageContext
	 * @throws Exception
	 */
	public static void downRenZip(String filePath, String fileName,
			HttpServletResponse zipResponse, PageContext pageContext)
			throws Exception {
		// ����ͷ��Ϣ�������������ļ�
		String zipName = "rent_notice_" + fileName + "_v1.zip";
		zipName = URLDecoder.decode(zipName, "UTF-8");

		zipResponse.reset();
		zipResponse.setContentType("application/zip");
		zipResponse.addHeader("Content-Disposition", "attachment;filename="
				+ zipName);// Ĭ�������ļ�����

		// �����̶���������ļ�������� Ĭ������Ϊ name_version.zip��ʽ
		ZipOutputStream outputStream = new ZipOutputStream(zipResponse
				.getOutputStream());// ����������

		compress(outputStream, filePath);// ѹ���ļ�

		outputStream.close();// �ر���
	}

	/**
	 * ��ָ���ļ������ļ�ѹ����outputStream��
	 * 
	 * @param outputStream
	 * @param filePath
	 * @throws IOException 
	 */
	public static void compress(ZipOutputStream outputStream, String filePath) throws IOException {
		//ѹ���ļ�
		File deptFile = new File(filePath);
		FileInputStream inputStream = null;
		
		if(!deptFile.isDirectory()){
			System.out.println("�����ļ���");
		}else{
			System.out.println("ѹ���ļ���=="+filePath+"==���ļ�");
			String[] fileList = deptFile.list();
			
			for( int i=0; i<fileList.length; i++ ){
				File readFile = new File(filePath+"/"+fileList[i]);
				if(!readFile.isDirectory()){
					System.out.println("path=" + readFile.getPath()); 
		            System.out.println("absolutepath=" + readFile.getAbsolutePath()); 
		            System.out.println("name=" + readFile.getName()); 
		            //ѹ���ļ���
		            outputStream.putNextEntry(new ZipEntry(fileList[i]));
		            //ѹ���ļ��ֽ�
		            inputStream = new FileInputStream(readFile);
		            byte[] tempBytes = new byte[1024];
					int fileLen = 0;
					
					while( (fileLen = inputStream.read(tempBytes))!=-1 ){
						outputStream.write(tempBytes, 0, fileLen);
					}
					//�ر���
					inputStream.close();
					outputStream.closeEntry();
				}
			}
		}
	}
}
