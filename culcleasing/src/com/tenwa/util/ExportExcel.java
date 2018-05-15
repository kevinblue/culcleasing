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
 * EXCEL��������.
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
	 * ����ͨ��EXCELͷ��
	 * 
	 * @param headString
	 *            ͷ����ʾ���ַ�
	 * @param colSum
	 *            �ñ��������
	 */
	public void createNormalHead(String headString, int colSum) {

		HSSFRow row = sheet.createRow(0);

		// ���õ�һ��
		HSSFCell cell = row.createCell((short) 0);
		row.setHeight((short) 400);

		// ���嵥Ԫ��Ϊ�ַ�������
		cell.setCellType(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue(new HSSFRichTextString(headString));

		// ָ���ϲ�����
		sheet
				.addMergedRegion(new Region(0, (short) 0, 0,
						(short) (colSum - 1)));

		HSSFCellStyle cellStyle = wb.createCellStyle();

		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ָ����Ԫ����ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ָ����Ԫ��ֱ���ж���
		cellStyle.setWrapText(true);// ָ����Ԫ���Զ�����

		// // ���õ�Ԫ�����䷽ʽ���Լ�ǰ����ɫ�ͱ�����ɫ
		// // ����ע�⣺
		// // 1.�����Ҫǰ����ɫ�򱳾���ɫ��һ��Ҫָ����䷽ʽ������˳������ν��
		// // 2.���ͬʱ����ǰ����ɫ�ͱ�����ɫ��ǰ����ɫ������Ҫд��ǰ�棻
		// // 3.ǰ����ɫ����������ɫ��
		// cellStyle.setFillPattern(HSSFCellStyle.DIAMONDS);
		// cellStyle.setFillForegroundColor(HSSFColor.RED.index);
		// cellStyle.setFillBackgroundColor(HSSFColor.LIGHT_YELLOW.index);
		// // ���õ�Ԫ��ײ��ı߿�����ʽ����ɫ
		// // ����������˵ױ߱߿���߿��ұ߿�Ͷ��߿�ͬ�����
		// cellStyle.setBorderBottom(HSSFCellStyle.BORDER_SLANTED_DASH_DOT);
		// cellStyle.setBottomBorderColor(HSSFColor.DARK_RED.index);

		// ���õ�Ԫ������
		HSSFFont font = wb.createFont();
		font.setFontName("����");
		font.setColor(HSSFColor.RED.index);
		font.setFontHeightInPoints((short) 20);
		font.setFontHeight((short) 300);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

		// ���������ֵ����Ԫ����ʽ����
		cellStyle.setFont(font);

		cell.setCellStyle(cellStyle);
	}

	/**
	 * ����ͨ�ñ���ڶ���
	 * 
	 * @param params
	 *            ͳ����������
	 * @param colSum
	 *            ��Ҫ�ϲ�����������
	 */
	public void createNormalTwoRow(String[] params, int colSum) {
		HSSFRow row1 = sheet.createRow(1);
		row1.setHeight((short) 300);

		HSSFCell cell2 = row1.createCell((short) 0);

		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellValue(new HSSFRichTextString("ͳ��ʱ�䣺" + params[0] + "�� "
				+ params[1]));

		// ָ���ϲ�����
		sheet
				.addMergedRegion(new Region(1, (short) 0, 1,
						(short) (colSum - 1)));

		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ָ����Ԫ����ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ָ����Ԫ��ֱ���ж���
		cellStyle.setWrapText(true);// ָ����Ԫ���Զ�����

		// ���õ�Ԫ������
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
		font.setColor(HSSFColor.TEAL.index);
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cell2.setCellStyle(cellStyle);

	}

	/**
	 * ����ͨ�ñ���ڶ���
	 * 
	 * @param params
	 *            ͳ����������
	 * @param colSum
	 *            ��Ҫ�ϲ�����������
	 */
	public void createTwoRow(String param, int colSum) {
		HSSFRow row1 = sheet.createRow(1);
		row1.setHeight((short) 300);

		HSSFCell cell2 = row1.createCell((short) 0);

		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellValue(new HSSFRichTextString(param));

		// ָ���ϲ�����
		sheet
				.addMergedRegion(new Region(1, (short) 0, 1,
						(short) (colSum - 1)));

		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ָ����Ԫ����ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ָ����Ԫ��ֱ���ж���
		cellStyle.setWrapText(true);// ָ����Ԫ���Զ�����

		// ���õ�Ԫ������
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
		font.setColor(HSSFColor.TEAL.index);
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cell2.setCellStyle(cellStyle);

	}

	/**
	 * ���ñ������
	 * 
	 * @param columHeader
	 *            �����ַ�������
	 */
	@SuppressWarnings("unchecked")
	public void createColumHeader(List columHeader) {
		// ������ͷ
		HSSFRow row2 = sheet.createRow(2);

		// ָ���и�
		row2.setHeight((short) 300);

		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ָ����Ԫ����ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ָ����Ԫ��ֱ���ж���
		cellStyle.setWrapText(true);// ָ����Ԫ���Զ�����

		// ��Ԫ������
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
		font.setFontHeight((short) 200);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // ���õ��޸�ı߿�Ϊ����
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index); // ���õ�Ԫ��ı߿���ɫ��
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(HSSFColor.BLACK.index);

		// ���õ�Ԫ�񱳾�ɫ
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
	 * �������ݵ�Ԫ��
	 * 
	 * @param wb
	 *            HSSFWorkbook
	 * @param row
	 *            HSSFRow
	 * @param col
	 *            short�͵�������
	 * @param align
	 *            ���뷽ʽ
	 * @param val
	 *            ��ֵ
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

		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // ���õ��޸�ı߿�Ϊ����
		cellstyle.setBottomBorderColor(HSSFColor.BLACK.index); // ���õ�Ԫ��ı߿���ɫ��
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(HSSFColor.BLACK.index);

		cell.setCellStyle(cellstyle);
	}

	/**
	 * �����������ݵ�Ԫ��
	 * 
	 * @param wb
	 *            HSSFWorkbook
	 * @param row
	 *            HSSFRow
	 * @param col
	 *            short�͵�������
	 * @param align
	 *            ���뷽ʽ
	 * @param val
	 *            ��ֵ
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
		cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ��ֱλ��
		cellstyle.setAlignment(align);// ˮƽλ��

		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // ���õ��޸�ı߿�Ϊ����
		cellstyle.setBottomBorderColor(HSSFColor.BLACK.index); // ���õ�Ԫ��ı߿���ɫ��
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(HSSFColor.BLACK.index);

		cell.setCellStyle(cellstyle);
	}

	/**
	 * �������ڸ�ʽ��
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

		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // ���õ��޸�ı߿�Ϊ����
		cellstyle.setBottomBorderColor(HSSFColor.BLACK.index); // ���õ�Ԫ��ı߿���ɫ��
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setTopBorderColor(HSSFColor.BLACK.index);

		cell.setCellStyle(cellstyle);
	}

	/**
	 * �����ϼ���
	 * 
	 * @param colSum
	 *            ��Ҫ�ϲ�����������
	 * @param cellValue
	 *            �ϼ�������ֵ
	 * @param sumName
	 *            �ϼ�������
	 */
	@SuppressWarnings("unchecked")
	public void createLastStrSumRow(int colSum, List cellValue, String sumName) {
		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ָ����Ԫ����ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ָ����Ԫ��ֱ���ж���
		cellStyle.setWrapText(true);// ָ����Ԫ���Զ�����

		// ��Ԫ������
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
		font.setColor(HSSFColor.ROYAL_BLUE.index);
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // ���õ��޸�ı߿�Ϊ����
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index); // ���õ�Ԫ��ı߿���ɫ��
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
				sheet.getLastRowNum(), (short) colSum));// ָ���ϲ�����

		for (int i = colSum; i < (cellValue.size() + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellValue(new HSSFRichTextString(cellValue.get(
					i - colSum).toString()));
		}
	}

	/**
	 * �����ϼ���-������
	 * 
	 * @param colSum
	 *            ��Ҫ�ϲ�����������
	 * @param cellValue
	 *            �ϼ�������ֵ
	 * @param sumName
	 *            �ϼ�������
	 */
	@SuppressWarnings("unchecked")
	public void createLastSumRow(int colSum, List cellValue, String sumName) {
		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ָ����Ԫ����ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// ָ����Ԫ��ֱ���ж���
		cellStyle.setWrapText(true);// ָ����Ԫ���Զ�����

		// ��Ԫ������
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
		font.setColor(HSSFColor.ROYAL_BLUE.index);
		font.setFontHeight((short) 250);
		cellStyle.setFont(font);

		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // ���õ��޸�ı߿�Ϊ����
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index); // ���õ�Ԫ��ı߿���ɫ��
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
				sheet.getLastRowNum(), (short) colSum));// ָ���ϲ�����

		for (int i = colSum; i < (cellValue.size() + colSum); i++) {
			sumCell = lastRow.createCell((short) (i + 1));
			sumCell.setCellStyle(cellStyle);
			sumCell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);// ���ָ�ʽ
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
	 * ����EXCEL�ļ�
	 * 
	 * @param fileName
	 *            �ļ���
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
