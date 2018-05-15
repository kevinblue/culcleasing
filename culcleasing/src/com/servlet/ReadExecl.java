package com.servlet;

import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * 
 * @author SCLICX
 * @version 1.0
 * @copyright (C) Tenwa 2011
 * @date Mar 13, 2011
 * @desc (��ȡEXECL�Ĺ�����,��Ҫ��ͨ��������Ԫ��Ķ�ȡ)
 */
public class ReadExecl {
	private Workbook book = null;
	private Map<String, String> bookNames = new HashMap<String, String>();// ���ƹ���
	Logger log = null;
	public ReadExecl(String fileAddr) {
		log = Logger.getLogger(this.getClass());
		if (fileAddr != null) {
			try {
				if (fileAddr.endsWith("xlsx")) {
					book = readWorkbook(fileAddr, ExcelVersionEnum.VERSION2007);
				} else {
					book = readWorkbook(fileAddr, ExcelVersionEnum.VERSION2003);
				}
				for (int i = 0; i < book.getNumberOfNames(); i++) {
					bookNames.put(book.getNameAt(i).getNameName(), book.getNameAt(i).getRefersToFormula());
				}
			} catch (Exception e) {
				log.error(e);
			}
		}
	}

	/**
	 * 
	 * (���ָ��������Ԫ������±�)
	 * 
	 * @param cellName
	 *            ������Ԫ�������
	 * @return �±�
	 */
	public int getCellColNum(String cellName) throws Exception {
		int colNum = 0;
		try {
			System.out.println(this.getCellReference(cellName));
			colNum = this.getCell(this.getCellReference(cellName)).getCol_num();

		} catch (Exception e) {
			// Auto-generated catch block
			throw new Exception("��excel����" + cellName + "����");
		}
		return colNum;
	}
	/**
	 * 
	 * (���������Ԫ��ľ���λ��)
	 * 
	 * @param cellName
	 *            ������Ԫ�������
	 * @return ������Ԫ��ľ���λ��
	 */
	public String getCellReference(String cellName) {
		String reference = "";
		if (this.checkCellName(cellName)) {
			reference = bookNames.get(cellName);
		} else {
			//log.error("û���ҵ�(" + cellName + ")������Ԫ��!");
		}
		return reference;
	}
	/**
	 * 
	 * (ͨ������EXECL�ľ��Ե�ַ ��Sheet1!$A$1 ��ö�Ӧ��ExeclBean )
	 * 
	 * @param reference
	 *            EXECL�ľ��Ե�ַ
	 * @return ExeclBean
	 */
	public ExeclBean getCell(String reference) {
		String reference_t = reference;
		ExeclBean execl = new ExeclBean();
		if (this.checkReference(reference)) {// ��֤���Ե�ַ
			execl.setSheet_name(reference_t.substring(0, reference_t.indexOf("!")));
			execl.setCol_name(reference_t.substring(reference_t.indexOf("!$") + 2, reference_t.indexOf("$", reference_t.indexOf("!$") + 2)));
			execl.setRow_name(reference_t.substring(reference_t.indexOf("$", reference_t.indexOf("!$") + 2) + 1));
			execl.setSheet_index(book.getSheetIndex(execl.getSheet_name()));
		} else {
			//log.error("error:reference=" + reference + ";���Ǹ���ȷ��execl���Ե�ַ!");
		}
		return execl;
	}
	/**
	 * 
	 * (��֤���Ե�ַ����ȷ���)
	 * 
	 * @param reference
	 *            execl�еľ��Ե�ַ
	 * @return ����boolean true Ϊ ��ȷ��ַ
	 */
	public boolean checkReference(String reference) {
		Pattern p = Pattern.compile(".+[!][$][A-Z]+[$]\\d+");
		Matcher m = p.matcher(reference);
		boolean r = m.matches();
		return r;
	}
	/**
	 * 
	 * (��֤������Ԫ���Ƿ����)
	 * 
	 * @param cellName
	 * @return
	 */
	public boolean checkCellName(String cellName) {
		if (!cellName.equals("")) {
			try {
				String t = bookNames.get(cellName);
				if (t.length() > 1) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				//log.error("��֤������Ԫ��ʧ��!");
				e.printStackTrace();
				//log.error(e.toString());
				return false;
			}
		} else {
			//log.info("error:������������Ԫ������");
			return false;
		}
	}
	/**
	 * 
	 * (���ָ��������Ԫ������±�)
	 * 
	 * @param cellName
	 *            ������Ԫ�������
	 * @return �±�
	 */
	public int getCellRowNum(String cellName) throws Exception {
		int colNum = 0;
		try {
			colNum = this.getCell(this.getCellReference(cellName)).getRow_num();
		} catch (Exception e) {
			// Auto-generated catch block
			throw new Exception("��excel����" + cellName + "����");
		}
		return colNum;
	}
	public static Workbook readWorkbook(String filepath, ExcelVersionEnum excelVersionEnum) throws Exception {
		Workbook wb = null;
		switch (excelVersionEnum) {
		case VERSION2003: {
			wb = new HSSFWorkbook(new FileInputStream(filepath));
			break;
		}
		case VERSION2007: {
			wb = new XSSFWorkbook(new FileInputStream(filepath));
			break;
		}
		}
		return wb;
	}
}
