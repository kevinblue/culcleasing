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
 * @desc (读取EXECL的工具类,主要是通过索引单元格的读取)
 */
public class ReadExecl {
	private Workbook book = null;
	private Map<String, String> bookNames = new HashMap<String, String>();// 名称管理
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
	 * (获得指定命名单元格的列下标)
	 * 
	 * @param cellName
	 *            命名单元格的名字
	 * @return 下标
	 */
	public int getCellColNum(String cellName) throws Exception {
		int colNum = 0;
		try {
			System.out.println(this.getCellReference(cellName));
			colNum = this.getCell(this.getCellReference(cellName)).getCol_num();

		} catch (Exception e) {
			// Auto-generated catch block
			throw new Exception("读excel名称" + cellName + "出错");
		}
		return colNum;
	}
	/**
	 * 
	 * (获得命名单元格的绝对位置)
	 * 
	 * @param cellName
	 *            命名单元格的名字
	 * @return 命名单元格的绝对位置
	 */
	public String getCellReference(String cellName) {
		String reference = "";
		if (this.checkCellName(cellName)) {
			reference = bookNames.get(cellName);
		} else {
			//log.error("没有找到(" + cellName + ")命名单元格!");
		}
		return reference;
	}
	/**
	 * 
	 * (通过传入EXECL的绝对地址 如Sheet1!$A$1 获得对应的ExeclBean )
	 * 
	 * @param reference
	 *            EXECL的绝对地址
	 * @return ExeclBean
	 */
	public ExeclBean getCell(String reference) {
		String reference_t = reference;
		ExeclBean execl = new ExeclBean();
		if (this.checkReference(reference)) {// 验证绝对地址
			execl.setSheet_name(reference_t.substring(0, reference_t.indexOf("!")));
			execl.setCol_name(reference_t.substring(reference_t.indexOf("!$") + 2, reference_t.indexOf("$", reference_t.indexOf("!$") + 2)));
			execl.setRow_name(reference_t.substring(reference_t.indexOf("$", reference_t.indexOf("!$") + 2) + 1));
			execl.setSheet_index(book.getSheetIndex(execl.getSheet_name()));
		} else {
			//log.error("error:reference=" + reference + ";不是个正确的execl绝对地址!");
		}
		return execl;
	}
	/**
	 * 
	 * (验证绝对地址的正确与否)
	 * 
	 * @param reference
	 *            execl中的绝对地址
	 * @return 返回boolean true 为 正确地址
	 */
	public boolean checkReference(String reference) {
		Pattern p = Pattern.compile(".+[!][$][A-Z]+[$]\\d+");
		Matcher m = p.matcher(reference);
		boolean r = m.matches();
		return r;
	}
	/**
	 * 
	 * (验证命名单元格是否存在)
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
				//log.error("验证命名单元格失败!");
				e.printStackTrace();
				//log.error(e.toString());
				return false;
			}
		} else {
			//log.info("error:请输入命名单元格名称");
			return false;
		}
	}
	/**
	 * 
	 * (获得指定命名单元格的行下标)
	 * 
	 * @param cellName
	 *            命名单元格的名字
	 * @return 下标
	 */
	public int getCellRowNum(String cellName) throws Exception {
		int colNum = 0;
		try {
			colNum = this.getCell(this.getCellReference(cellName)).getRow_num();
		} catch (Exception e) {
			// Auto-generated catch block
			throw new Exception("读excel名称" + cellName + "出错");
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
