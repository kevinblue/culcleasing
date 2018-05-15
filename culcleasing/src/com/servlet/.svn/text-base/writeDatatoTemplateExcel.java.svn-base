package com.servlet;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import com.tenwa.culc.service.ExcelVersionEnum;

public class writeDatatoTemplateExcel {
	public  void writeDatatoTemplateExcel(String tempfile,  String targetFile) throws Exception {
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
		try {
			readExecl = new ReadExecl(tempfile);
			templateSheet = wb.getSheetAt(0);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("加载readExecl时出");
		}
		
		templateSheet = wb.getSheetAt(readExecl.getCell(readExecl.getCellReference("year_01")).getSheet_index());
		int col_index = readExecl.getCellColNum("year_01");
		int row_index = readExecl.getCellRowNum("year_01");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue("xx01xx年");
		 col_index = readExecl.getCellColNum("year_02");
		 row_index = readExecl.getCellRowNum("year_02");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue("xx02xx年");
		 col_index = readExecl.getCellColNum("year_03");
		 row_index = readExecl.getCellRowNum("year_03");
		templateRow = templateSheet.getRow(row_index);
		cell = templateRow.getCell(col_index);
		cell.setCellValue("xx03xx年");
		
		
		
		OutputStream osServer = new FileOutputStream(targetFile);
		wb.write(osServer);
	    }
	public  Workbook readWorkbook(String filepath, ExcelVersionEnum excelVersionEnum) throws Exception {
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
