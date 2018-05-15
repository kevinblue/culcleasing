package com.tenwa.culc.util;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * EXCEL报表工具类.
 * 
 * @author JavaJeffe
 * 
 * date ---- 10:00:25 AM
 */
public class ExportExcel2007 {
	private XSSFWorkbook wb = null;

	private XSSFSheet sheet = null;

	/**
	 * @param wb
	 * @param sheet
	 */
	public ExportExcel2007(XSSFWorkbook wb, XSSFSheet sheet) {
		super();
		this.wb = wb;
		this.sheet = sheet;
	}

	/**
	 * @return the sheet
	 */
	public XSSFSheet getSheet() {
		return sheet;
	}

	/**
	 * @param sheet
	 *            the sheet to set
	 */
	public void setSheet(XSSFSheet sheet) {
		this.sheet = sheet;
	}

	/**
	 * @return the wb
	 */
	public XSSFWorkbook getWb() {
		return wb;
	}

	/**
	 * @param wb
	 *            the wb to set
	 */
	public void setWb(XSSFWorkbook wb) {
		this.wb = wb;
	}

	/**
	 * 创建通用EXCEL头部
	 * 
	 * @param headString
	 *            头部显示的字符
	 * @param colSum
	 *            该报表的列数
	 */
	public void createNormalHead(String headString, int colSum) {
		XSSFRow row = sheet.createRow(0);

		// 设置第一行
		XSSFCell cell = row.createCell((short) 0);
		row.setHeight((short) 400);

		// 定义单元格为字符串类型
		cell.setCellType(XSSFCell.CELL_TYPE_STRING);
		cell.setCellValue(new XSSFRichTextString(headString));

		// 指定合并区域
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0,(colSum - 1)));

		XSSFCellStyle cellStyle = wb.createCellStyle();

		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// // 设置单元格的填充方式，以及前景颜色和背景颜色
		// // 三点注意：
		// // 1.如果需要前景颜色或背景颜色，一定要指定填充方式，两者顺序无所谓；
		// // 2.如果同时存在前景颜色和背景颜色，前景颜色的设置要写在前面；
		// // 3.前景颜色不是字体颜色。
		// cellStyle.setFillPattern(XSSFCellStyle.DIAMONDS);
		// cellStyle.setFillForegroundColor(HSSFColor.RED.index);
		// cellStyle.setFillBackgroundColor(HSSFColor.LIGHT_YELLOW.index);
		// // 设置单元格底部的边框及其样式和颜色
		// // 这里仅设置了底边边框，左边框、右边框和顶边框同理可设
		// cellStyle.setBorderBottom(XSSFCellStyle.BORDER_SLANTED_DASH_DOT);
		// cellStyle.setBottomBorderColor(HSSFColor.DARK_RED.index);

		// 设置单元格字体
		XSSFFont font = wb.createFont();
		font.setFontName("宋体");
		font.setColor(XSSFFont.COLOR_RED);
		font.setFontHeightInPoints((short) 20);
		font.setFontHeight((short) 300);
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);

		// 将字体对象赋值给单元格样式对象
		cellStyle.setFont(font);

		cell.setCellStyle(cellStyle);
	}

	/**
	 * 创建通用报表第二行
	 * 
	 * @param params
	 *            统计条件数组
	 * @param colSum
	 *            需要合并到的列索引
	 */
	public void createNormalTwoRow(String[] params, int colSum) {
		XSSFRow row1 = sheet.createRow(1);
		row1.setHeight((short) 300);

		XSSFCell cell2 = row1.createCell((short) 0);

		cell2.setCellType(XSSFCell.CELL_TYPE_STRING);
		cell2.setCellValue(new XSSFRichTextString("统计时间：" + params[0] + "至 "
				+ params[1]));

		// 指定合并区域
		sheet.addMergedRegion(new CellRangeAddress(1,1,0, (colSum - 1)));

		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 设置单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		// font.setColor(HSSFColor.TEAL.index);
		font.setColor(new XSSFColor(Color.BLUE));
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cell2.setCellStyle(cellStyle);

	}

	/**
	 * 创建通用报表第二行
	 * 
	 * @param params
	 *            统计条件数组
	 * @param colSum
	 *            需要合并到的列索引
	 */
	public void createTwoRow(String param, int colSum) {
		XSSFRow row1 = sheet.createRow(1);
		row1.setHeight((short) 300);

		XSSFCell cell2 = row1.createCell((short) 0);

		cell2.setCellType(XSSFCell.CELL_TYPE_STRING);
		cell2.setCellValue(new XSSFRichTextString(param));

		// 指定合并区域
		sheet.addMergedRegion(new CellRangeAddress(1, 1,(short) 0, 
				(short) (colSum - 1)));

		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 设置单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		// font.setColor(HSSFColor.TEAL.index);
		font.setColor(new XSSFColor(Color.BLUE));
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cell2.setCellStyle(cellStyle);

	}

	/**
	 * 设置报表标题
	 * 
	 * @param columHeader
	 *            标题字符串数组
	 */
	public void createColumHeader(List columHeader) {
		// 设置列头
		XSSFRow row2 = sheet.createRow(2);

		// 指定行高
		row2.setHeight((short) 300);

		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setFontHeight((short) 200);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(new XSSFColor(Color.black));
		cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		// 设置单元格背景色
		cellStyle.setFillForegroundColor(new XSSFColor(Color.YELLOW));
		cellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);

		XSSFCell cell3 = null;

		for (int i = 0; i < columHeader.size(); i++) {
			cell3 = row2.createCell(i);
			cell3.setCellType(XSSFCell.CELL_TYPE_STRING);
			cell3.setCellStyle(cellStyle);
			cell3.setCellValue(new XSSFRichTextString(columHeader.get(i)
					.toString()));
		}

	}

	public void createColumHeader(List columHeader, int height) {
		// 设置列头
		XSSFRow row2 = sheet.createRow(2);

		// 指定行高
		row2.setHeight((short) height);

		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setFontHeight((short) 200);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		// 设置单元格背景色
		cellStyle.setFillForegroundColor(new XSSFColor(Color.YELLOW));
		cellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);

		XSSFCell cell3 = null;

		for (int i = 0; i < columHeader.size(); i++) {
			cell3 = row2.createCell((short) i);
			cell3.setCellType(XSSFCell.CELL_TYPE_STRING);
			cell3.setCellStyle(cellStyle);
			cell3.setCellValue(new XSSFRichTextString(columHeader.get(i)
					.toString()));
		}

	}

	/**
	 * 创建内容单元格
	 * 
	 * @param wb
	 *            HSSFWorkbook
	 * @param row
	 *            XSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createCell(XSSFWorkbook wb, XSSFRow row, int col, short align,
			String val) {
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_STRING);
		if (val != null && !"".equals(val) && !"null".equals(val)) {
			cell.setCellValue(new XSSFRichTextString(val));
		} else {
			cell.setCellValue(new XSSFRichTextString(""));
		}

		XSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		cellstyle.setAlignment(align);

		cellstyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellstyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellstyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellstyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellstyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		cell.setCellStyle(cellstyle);
	}

	/**
	 * 创建内容单元格
	 * 
	 * @param wb
	 *            XSSFWorkbook
	 * @param row
	 *            XSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createCell(XSSFWorkbook wb, XSSFRow row, int col, short align,
			String val, XSSFCellStyle cellstyle) {
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_STRING);
		if (val != null && !"".equals(val) && !"null".equals(val)) {
			cell.setCellValue(new XSSFRichTextString(val));
		} else {
			cell.setCellValue(new XSSFRichTextString(""));
		}
		cellstyle.setAlignment(align);
		cell.setCellStyle(cellstyle);
		cellstyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	}

	/**
	 * 创建内容单元格
	 * 
	 * @param wb
	 *            XSSFWorkbook
	 * @param row
	 *            XSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createCell(XSSFWorkbook wb, XSSFRow row, int col, String val,
			XSSFCellStyle cellstyle) {
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_STRING);
		if (val != null && !"".equals(val) && !"null".equals(val)) {
			cell.setCellValue(new XSSFRichTextString(val));
		} else {
			cell.setCellValue(new XSSFRichTextString(""));
		}

		cell.setCellStyle(cellstyle);
	}

	/**
	 * 创建数字内容单元格
	 * 
	 * @param wb
	 *            XSSFWorkbook
	 * @param row
	 *            XSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createNumberCell(XSSFWorkbook wb, XSSFRow row, int col,
			short align, String val) {
		val = ConvertUtil.parseNumber(val, 2);
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_NUMERIC);
		if (val == null || "".equals(val) || val.equals("null")) {
			cell.setCellValue(Double.parseDouble("0"));
		} else {
			cell.setCellValue(Double.parseDouble(val));
		}
		XSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 垂直位置
		cellstyle.setAlignment(align);// 水平位置

		cellstyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellstyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellstyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellstyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellstyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		cell.setCellStyle(cellstyle);
	}

	/**
	 * 创建数字内容单元格
	 * 
	 * @param wb
	 *            XSSFWorkbook
	 * @param row
	 *            XSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createNumberCell(XSSFWorkbook wb, XSSFRow row, int col,
			short align, String val, XSSFCellStyle cellstyle) {
		val = ConvertUtil.parseNumber(val, 2);
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_NUMERIC);
		if (val == null || "".equals(val) || val.equals("null")) {
			cell.setCellValue(Double.parseDouble("0"));
		} else {
			cell.setCellValue(Double.parseDouble(val));
		}

		cellstyle.setAlignment(align);
		cell.setCellStyle(cellstyle);
		cellstyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	}

	/**
	 * 创建数字内容单元格
	 * 
	 * @param wb
	 *            XSSFWorkbook
	 * @param row
	 *            XSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createNumberCell(XSSFWorkbook wb, XSSFRow row, int col,
			String val, XSSFCellStyle cellstyle) {
		val = ConvertUtil.parseNumber(val, 2);
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_NUMERIC);
		if (val == null || "".equals(val) || val.equals("null")) {
			cell.setCellValue(Double.parseDouble("0"));
		} else {
			cell.setCellValue(Double.parseDouble(val));
		}

		cell.setCellStyle(cellstyle);
	}

	/**
	 * 创建日期格式列
	 * 
	 * @param wb
	 * @param row
	 * @param col
	 * @param align
	 * @param val
	 */
	public void createDateCell(XSSFWorkbook wb, XSSFRow row, int col,
			short align, String val) {
		XSSFCell cell = row.createCell((short) col);
		cell.setCellType(XSSFCell.CELL_TYPE_STRING);
		if (val != null && !"".equals(val) && val.length() > 10) {
			cell.setCellValue(new XSSFRichTextString(val.substring(0, 10)));
		} else {
			cell.setCellValue(new XSSFRichTextString(""));
		}

		XSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		cellstyle.setAlignment(align);

		cellstyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellstyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellstyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellstyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellstyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		cell.setCellStyle(cellstyle);
	}

	/**
	 * 创建合计行
	 * 
	 * @param colSum
	 *            需要合并到的列索引
	 * @param cellValue
	 *            合计列数组值
	 * @param sumName
	 *            合计列名称
	 */
	public void createLastStrSumRow(int colSum, List cellValue, String sumName) {
		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(new XSSFColor(Color.BLUE));
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		XSSFRow lastRow = sheet.createRow((short) (sheet.getLastRowNum() + 1));
		XSSFCell sumCell = lastRow.createCell((short) 0);

		sumCell.setCellValue(new XSSFRichTextString(sumName));
		sumCell.setCellStyle(cellStyle);
		sheet.addMergedRegion(new CellRangeAddress(sheet.getLastRowNum(),
				(short) 0, sheet.getLastRowNum(), (short) colSum));// 指定合并区域

		for (int i = colSum; i < (cellValue.size() + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellValue(new XSSFRichTextString(cellValue.get(
					i - colSum).toString()));
		}
	}

	/**
	 * 创建合计行-数字列
	 * 
	 * @param colSum
	 *            需要合并到的列索引
	 * @param cellValue
	 *            合计列数组值
	 * @param sumName
	 *            合计列名称
	 */
	public void createLastSumRow(int colSum, List cellValue, String sumName) {
		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(new XSSFColor(Color.BLUE));
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		XSSFRow lastRow = sheet.createRow((short) (sheet.getLastRowNum() + 1));
		XSSFCell sumCell = lastRow.createCell((short) 0);

		sumCell.setCellValue(new XSSFRichTextString(sumName));
		sumCell.setCellStyle(cellStyle);
		sheet.addMergedRegion(new CellRangeAddress(sheet.getLastRowNum(),
				(short) 0, sheet.getLastRowNum(), (short) colSum));// 指定合并区域

		for (int i = colSum; i < (cellValue.size() + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellType(XSSFCell.CELL_TYPE_NUMERIC);// 数字格式
			// sumCell.setCellValue(new XSSFRichTextString(cellValue.get(
			// i - colSum).toString()));
			if (cellValue.get(i - colSum) != null) {
				sumCell.setCellValue(Double.parseDouble(cellValue.get(
						i - colSum).toString()));
			} else {
				sumCell.setCellValue(new XSSFRichTextString(""));
			}
		}
	}

	/**
	 * 输入EXCEL文件
	 * 
	 * @param fileName
	 *            文件名
	 * @throws IOException
	 */
	public void outputExcel(String fileName, XSSFWorkbook wb,
			HttpServletResponse excelResponse, PageContext pageContext)
			throws IOException {
		excelResponse.reset();
		excelResponse.setContentType("application/x-msexcel;charset=gbk");
		excelResponse.setHeader("Content-disposition", "attachment; filename="
				+ fileName + ".xls");
		// String path = pageContext.getServletContext().getRealPath("/");

		OutputStream os = excelResponse.getOutputStream();
		wb.write(os);
		os.close();
	}

	/**
	 * 输入EXCEL文件
	 * 
	 * @param fileName
	 *            文件名
	 * @throws IOException
	 */
	public void outputExcel(String fileName) throws IOException {
		File s = new File(fileName);

		FileOutputStream fileO = new FileOutputStream(s);

		wb.write(fileO);

		fileO.close();
	}

	public void createLastSumRow(int colSum, String[] cellValue, String sumName) {
		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(new XSSFColor(Color.BLUE));
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(new XSSFColor(Color.BLACK)); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(new XSSFColor(Color.BLACK));
		cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(new XSSFColor(Color.BLACK));

		XSSFRow lastRow = sheet.createRow((short) (sheet.getLastRowNum() + 1));
		XSSFCell sumCell = lastRow.createCell((short) 0);

		sumCell.setCellValue(new XSSFRichTextString(sumName));
		sumCell.setCellStyle(cellStyle);
		sheet.addMergedRegion(new CellRangeAddress(sheet.getLastRowNum(),
				(short) 0, sheet.getLastRowNum(), (short) colSum));// 指定合并区域

		for (int i = colSum; i < (cellValue.length + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellType(XSSFCell.CELL_TYPE_NUMERIC);// 数字格式
			// sumCell.setCellValue(new XSSFRichTextString(cellValue.get(
			// i - colSum).toString()));
			if (cellValue[i - colSum] != null) {
				sumCell.setCellValue(Double.parseDouble(cellValue[i - colSum]));
			} else {
				sumCell.setCellValue(new XSSFRichTextString(""));
			}
		}
	}
}
