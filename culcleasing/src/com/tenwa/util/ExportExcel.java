package com.tenwa.util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;

/**
 * EXCEL报表工具类.
 * 
 * @author JavaJeffe
 * 
 * date ---- 10:00:25 AM
 */
public class ExportExcel {
	private HSSFWorkbook wb = null;

	private HSSFSheet sheet = null;

	/**
	 * @param wb
	 * @param sheet
	 */
	public ExportExcel(HSSFWorkbook wb, HSSFSheet sheet) {
		super();
		this.wb = wb;
		this.sheet = sheet;
	}

	/**
	 * @return the sheet
	 */
	public HSSFSheet getSheet() {
		return sheet;
	}

	/**
	 * @param sheet
	 *            the sheet to set
	 */
	public void setSheet(HSSFSheet sheet) {
		this.sheet = sheet;
	}

	/**
	 * @return the wb
	 */
	public HSSFWorkbook getWb() {
		return wb;
	}

	/**
	 * @param wb
	 *            the wb to set
	 */
	public void setWb(HSSFWorkbook wb) {
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

		HSSFRow row = sheet.createRow(0);

		// 设置第一行
		HSSFCell cell = row.createCell((short) 0);
		row.setHeight((short) 400);

		// 定义单元格为字符串类型
		cell.setCellType(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue(new HSSFRichTextString(headString));

		// 指定合并区域
		sheet
				.addMergedRegion(new Region(0, (short) 0, 0,
						(short) (colSum - 1)));

		HSSFCellStyle cellStyle = wb.createCellStyle();

		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// // 设置单元格的填充方式，以及前景颜色和背景颜色
		// // 三点注意：
		// // 1.如果需要前景颜色或背景颜色，一定要指定填充方式，两者顺序无所谓；
		// // 2.如果同时存在前景颜色和背景颜色，前景颜色的设置要写在前面；
		// // 3.前景颜色不是字体颜色。
		// cellStyle.setFillPattern(HSSFCellStyle.DIAMONDS);
		// cellStyle.setFillForegroundColor(HSSFColor.RED.index);
		// cellStyle.setFillBackgroundColor(HSSFColor.LIGHT_YELLOW.index);
		// // 设置单元格底部的边框及其样式和颜色
		// // 这里仅设置了底边边框，左边框、右边框和顶边框同理可设
		// cellStyle.setBorderBottom(HSSFCellStyle.BORDER_SLANTED_DASH_DOT);
		// cellStyle.setBottomBorderColor(HSSFColor.DARK_RED.index);

		// 设置单元格字体
		HSSFFont font = wb.createFont();
		font.setFontName("宋体");
		font.setColor(HSSFColor.RED.index);
		font.setFontHeightInPoints((short) 20);
		font.setFontHeight((short) 300);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

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
		HSSFRow row1 = sheet.createRow(1);
		row1.setHeight((short) 300);

		HSSFCell cell2 = row1.createCell((short) 0);

		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellValue(new HSSFRichTextString("统计时间：" + params[0] + "至 "
				+ params[1]));

		// 指定合并区域
		sheet
				.addMergedRegion(new Region(1, (short) 0, 1,
						(short) (colSum - 1)));

		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 设置单元格字体
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(HSSFColor.TEAL.index);
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
		HSSFRow row1 = sheet.createRow(1);
		row1.setHeight((short) 300);

		HSSFCell cell2 = row1.createCell((short) 0);

		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellValue(new HSSFRichTextString(param));

		// 指定合并区域
		sheet
				.addMergedRegion(new Region(1, (short) 0, 1,
						(short) (colSum - 1)));

		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 设置单元格字体
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(HSSFColor.TEAL.index);
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
	@SuppressWarnings("unchecked")
	public void createColumHeader(List columHeader) {
		// 设置列头
		HSSFRow row2 = sheet.createRow(2);

		// 指定行高
		row2.setHeight((short) 300);

		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setFontHeight((short) 200);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(HSSFColor.BLACK.index);

		// 设置单元格背景色
		cellStyle.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

		HSSFCell cell3 = null;

		for (int i = 0; i < columHeader.size(); i++) {
			cell3 = row2.createCell((short) i);
			cell3.setCellType(HSSFCell.ENCODING_UTF_16);
			cell3.setCellStyle(cellStyle);
			cell3.setCellValue(new HSSFRichTextString(columHeader.get(i)
					.toString()));
		}

	}

	/**
	 * 创建内容单元格
	 * 
	 * @param wb
	 *            HSSFWorkbook
	 * @param row
	 *            HSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createCell(HSSFWorkbook wb, HSSFRow row, int col, short align,
			String val) {
		HSSFCell cell = row.createCell((short) col);
		cell.setCellType(HSSFCell.ENCODING_UTF_16);
		if (val != null && !"".equals(val) && !"null".equals(val)) {
			cell.setCellValue(new HSSFRichTextString(val));
		} else {
			cell.setCellValue(new HSSFRichTextString(""));
		}

		HSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellstyle.setAlignment(align);

		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellstyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(HSSFColor.BLACK.index);

		cell.setCellStyle(cellstyle);
	}

	/**
	 * 创建数字内容单元格
	 * 
	 * @param wb
	 *            HSSFWorkbook
	 * @param row
	 *            HSSFRow
	 * @param col
	 *            short型的列索引
	 * @param align
	 *            对齐方式
	 * @param val
	 *            列值
	 */
	public void createNumberCell(HSSFWorkbook wb, HSSFRow row, int col,
			short align, String val) {
		HSSFCell cell = row.createCell((short) col);
		cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
		if (val==null || "".equals(val) || val.equals("null")) {
			cell.setCellValue(Double.parseDouble("0"));
		} else {
			cell.setCellValue(Double.parseDouble(val));
		}
		HSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直位置
		cellstyle.setAlignment(align);// 水平位置

		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellstyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(HSSFColor.BLACK.index);

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
	public void createDateCell(HSSFWorkbook wb, HSSFRow row, int col,
			short align, String val) {
		HSSFCell cell = row.createCell((short) col);
		cell.setCellType(HSSFCell.ENCODING_UTF_16);
		if (val != null && !"".equals(val) && val.length()>10 ) {
			cell.setCellValue(new HSSFRichTextString(val.substring(0, 10)));
		} else {
			cell.setCellValue(new HSSFRichTextString(""));
		}

		HSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellstyle.setAlignment(align);

		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellstyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(HSSFColor.BLACK.index);

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
	@SuppressWarnings("unchecked")
	public void createLastStrSumRow(int colSum, List cellValue, String sumName) {
		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(HSSFColor.ROYAL_BLUE.index);
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(HSSFColor.BLACK.index);

		HSSFRow lastRow = sheet.createRow((short) (sheet.getLastRowNum() + 1));
		HSSFCell sumCell = lastRow.createCell((short) 0);

		sumCell.setCellValue(new HSSFRichTextString(sumName));
		sumCell.setCellStyle(cellStyle);
		sheet.addMergedRegion(new Region(sheet.getLastRowNum(), (short) 0,
				sheet.getLastRowNum(), (short) colSum));// 指定合并区域

		for (int i = colSum; i < (cellValue.size() + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellValue(new HSSFRichTextString(cellValue.get(
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
	@SuppressWarnings("unchecked")
	public void createLastSumRow(int colSum, List cellValue, String sumName) {
		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行

		// 单元格字体
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setColor(HSSFColor.ROYAL_BLUE.index);
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单无格的边框为粗体
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(HSSFColor.BLACK.index);

		HSSFRow lastRow = sheet.createRow((short) (sheet.getLastRowNum() + 1));
		HSSFCell sumCell = lastRow.createCell((short) 0);

		sumCell.setCellValue(new HSSFRichTextString(sumName));
		sumCell.setCellStyle(cellStyle);
		sheet.addMergedRegion(new Region(sheet.getLastRowNum(), (short) 0,
				sheet.getLastRowNum(), (short) colSum));// 指定合并区域

		for (int i = colSum; i < (cellValue.size() + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);// 数字格式
			// sumCell.setCellValue(new HSSFRichTextString(cellValue.get(
			// i - colSum).toString()));
			if (cellValue.get(i - colSum) != null) {
				sumCell.setCellValue(Double.parseDouble(cellValue.get(
						i - colSum).toString()));
			} else {
				sumCell.setCellValue(new HSSFRichTextString(""));
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
	public void outputExcel(String fileName, HSSFWorkbook wb,
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
}
