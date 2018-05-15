package com.servlet;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hpsf.examples.WriteTitle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import com.tenwa.culc.service.ExcelVersionEnum;

public class WriteFinanceTemplate {
	
	public static void writeDatatoTempl(String tempfile,String targetFile,String year) throws Exception {
		Row templateRow;
		Cell cell;
		Workbook wb=null;
		try {
			if (tempfile.endsWith("xlsx")) {
				wb = readWorkbook(tempfile, ExcelVersionEnum.VERSION2007);
			} else {
				wb = readWorkbook(tempfile, ExcelVersionEnum.VERSION2003);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("加载excel时出错"+e.getMessage());
		}
		ReadExecl readExecl=null;
		Sheet templateSheet=null;
		Sheet templateSheet1=null;
		try {
			readExecl = new ReadExecl(tempfile);
			templateSheet = wb.getSheetAt(0);
			templateSheet1 = wb.getSheetAt(1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("加载readExecl时出");
		}
		   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		   Date date = null; 
		   try { 
		    date = format.parse(year); 
		   } catch (ParseException e) { 
		    e.printStackTrace(); 
		   } 
		 String  year0=year.substring(0,4);
		int time0= Integer.parseInt(year0);
		String  month=year.substring(5,7);
		String time1=(time0-3)+"年";
		String time2=(time0-2)+"年";
		String time3=(time0-1)+"年";
		String time4=time0+"年"+month+"月";//2018年1-（近期月）完成
		
		String time5=time0+"年"+"1-（近期月）完成";
		String time6=(time0-2)+"年增长率";
		String time7=(time0-1)+"年增长率";
		   
		templateSheet = wb.getSheetAt(readExecl.getCell(readExecl.getCellReference("year_01")).getSheet_index());
		int col_index = readExecl.getCellColNum("year_01");
		int row_index = readExecl.getCellRowNum("year_01");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time1);
		 col_index = readExecl.getCellColNum("year_02");
		 row_index = readExecl.getCellRowNum("year_02");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time2);
		 col_index = readExecl.getCellColNum("year_03");
		 row_index = readExecl.getCellRowNum("year_03");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time3);
		 col_index = readExecl.getCellColNum("year_04");
		 row_index = readExecl.getCellRowNum("year_04");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time4);
		
		templateSheet1= wb.getSheetAt(readExecl.getCell(readExecl.getCellReference("year_05")).getSheet_index());
		col_index = readExecl.getCellColNum("year_05");
		row_index = readExecl.getCellRowNum("year_05");
		templateRow = templateSheet1.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time1);
		 col_index = readExecl.getCellColNum("year_06");
		 row_index = readExecl.getCellRowNum("year_06");
		templateRow = templateSheet1.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time2);
		 col_index = readExecl.getCellColNum("year_07");
		 row_index = readExecl.getCellRowNum("year_07");
		templateRow = templateSheet1.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time3);
		 col_index = readExecl.getCellColNum("year_08");
		 row_index = readExecl.getCellRowNum("year_08");
		templateRow = templateSheet1.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time5);
		 col_index = readExecl.getCellColNum("year_09");
		 row_index = readExecl.getCellRowNum("year_09");
		templateRow = templateSheet1.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time6);
		 col_index = readExecl.getCellColNum("year_10");
		 row_index = readExecl.getCellRowNum("year_10");
		templateRow = templateSheet1.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue(time7);
		
		OutputStream osServer = new FileOutputStream(targetFile);
		templateSheet.setForceFormulaRecalculation(true);//刷新当前excle 的公式
		templateSheet1.setForceFormulaRecalculation(true);//刷新当前excle 的公式
		wb.write(osServer);
		
		osServer.close();
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
