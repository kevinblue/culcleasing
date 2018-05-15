package com.tenwa.culc.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;

/**
 * �ܾ�������������.
 * 
 * @author caoyb
 * @version $Revision:$
 */
public class ComplexExportExcelClient2003 {

	private static HSSFWorkbook wb = new HSSFWorkbook();

	private static HSSFSheet sheet = wb.createSheet();

	public static void main(String[] args) {

		ExportExcel2003 exportExcel = new ExportExcel2003(wb, sheet);

		// �����б�ͷLIST
		List fialList = new ArrayList();

		fialList.add("������δ�ṩ�κ���ϵ��ʽ");
		fialList.add("�޹�����λ��Ϣ��δ�ṩ������Դ��Ϣ");
		fialList.add("�й�����λ��δ�ṩ��λ��ַ��绰");
		fialList.add("��ͥ��ַȱʧ");
		fialList.add("�ͻ����֤������ȱ");
		fialList.add("ǩ��ȱʧ��ǩ��������Ҫ��");
		fialList.add("����");

		List errorList = new ArrayList();

		errorList.add("�ͻ�����ȡ��");
		errorList.add("�������Ų���");
		errorList.add("��թ����");
		errorList.add("�����˻�����������");
		errorList.add("������ϲ��Ϲ�");
		errorList.add("�޷������������");
		errorList.add("�ظ�����");
		errorList.add("����");

		// ����ñ��������
		int number = 2 + fialList.size() * 2 + errorList.size() * 2;

		// ���������ж����п�(ʵ��Ӧ���Լ���������)
		for (int i = 0; i < number; i++) {
			sheet.setColumnWidth((short) i, (short) 3000);

		}

		// ������Ԫ����ʽ
		HSSFCellStyle cellStyle = wb.createCellStyle();

		// ָ����Ԫ����ж���
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		// ָ����Ԫ��ֱ���ж���
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		// ָ������Ԫ��������ʾ����ʱ�Զ�����
		cellStyle.setWrapText(true);

		// ���õ�Ԫ������
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
		font.setFontHeight((short) 200);
		cellStyle.setFont(font);

		// ��������ͷ��
		exportExcel.createNormalHead("�Ͼ������������Ͼܼ�����ͳ��", number);

		// ���õڶ���
		String[] params = new String[] { " �� �� ��", " �� �� ��" };
		exportExcel.createNormalTwoRow(params, number);

		// ������ͷ
		HSSFRow row2 = sheet.createRow(2);

		HSSFCell cell0 = row2.createCell((short) 0);
		cell0.setCellStyle(cellStyle);
		cell0.setCellValue(new HSSFRichTextString("��������"));

		HSSFCell cell1 = row2.createCell((short) 1);
		cell1.setCellStyle(cellStyle);
		cell1.setCellValue(new HSSFRichTextString("֧������"));

		HSSFCell cell2 = row2.createCell((short) 2);
		cell2.setCellStyle(cellStyle);
		cell2.setCellValue(new HSSFRichTextString("��Ч��"));

		HSSFCell cell3 = row2.createCell((short) (2 * fialList.size() + 2));
		cell3.setCellStyle(cellStyle);
		cell3.setCellValue(new HSSFRichTextString("�ܾ���"));

		HSSFRow row3 = sheet.createRow(3);

		// �����и�
		row3.setHeight((short) 800);

		HSSFCell row3Cell = null;
		int m = 0;
		int n = 0;

		// ������ͬ��LIST���б���
		for (int i = 2; i < number; i = i + 2) {

			if (i < 2 * fialList.size() + 2) {
				row3Cell = row3.createCell((short) i);
				row3Cell.setCellStyle(cellStyle);
				row3Cell.setCellValue(new HSSFRichTextString(fialList.get(m)
						.toString()));
				m++;
			} else {
				row3Cell = row3.createCell((short) i);
				row3Cell.setCellStyle(cellStyle);
				row3Cell.setCellValue(new HSSFRichTextString(errorList.get(n)
						.toString()));
				n++;
			}

		}

		// �������һ�еĺϼ���
		row3Cell = row3.createCell((short) number);
		row3Cell.setCellStyle(cellStyle);
		row3Cell.setCellValue(new HSSFRichTextString("�ϼ�"));

		// �ϲ���Ԫ��
		HSSFRow row4 = sheet.createRow(4);

		// �ϲ������е������еĵ�һ��
		sheet.addMergedRegion(new Region(2, (short) 0, 4, (short) 0));

		// �ϲ������е������еĵڶ���
		sheet.addMergedRegion(new Region(2, (short) 1, 4, (short) 1));

		// �ϲ������еĵ����е���AAָ������
		int aa = 2 * fialList.size() + 1;
		sheet.addMergedRegion(new Region(2, (short) 2, 2, (short) aa));

		int start = aa + 1;

		sheet.addMergedRegion(new Region(2, (short) start, 2,
				(short) (number - 1)));

		// ѭ���ϲ������е��У�������ÿ2�кϲ���һ��
		for (int i = 2; i < number; i = i + 2) {
			sheet.addMergedRegion(new Region(3, (short) i, 3, (short) (i + 1)));

		}

		// ����������ż���Ĳ�ͬ������ͬ���б���
		for (int i = 2; i < number; i++) {
			if (i < 2 * fialList.size() + 2) {

				if (i % 2 == 0) {
					HSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new HSSFRichTextString("��Ч��"));
				} else {
					HSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new HSSFRichTextString("ռ��"));
				}
			} else {
				if (i % 2 == 0) {
					HSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new HSSFRichTextString("�ܾ���"));
				} else {
					HSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new HSSFRichTextString("ռ��"));
				}
			}

		}

		// ѭ�������м�ĵ�Ԫ��ĸ����ֵ
		for (int i = 5; i < number; i++) {
			HSSFRow row = sheet.createRow((short) i);
			for (int j = 0; j <= number; j++) {
				exportExcel
						.createCell(wb, row, (short) j,
								HSSFCellStyle.ALIGN_CENTER_SELECTION, String
										.valueOf(j));
			}

		}

		// �������һ�еĺϼ���
		String[] cellValue = new String[number - 1];
		for (int i = 0; i < number - 1; i++) {
			cellValue[i] = String.valueOf(i);

		}
		exportExcel.createLastSumRow(1, cellValue, "���ݺϼ�");
		//
		// String project = "������ó����";
		// String year = "2011";
		// String startMonth = "01";
		// String endMonth = "05";
		//
		// List titleList = new ArrayList();
		// titleList.add("���");
		// titleList.add("λ��");
		// titleList.add("��˾����");
		// titleList.add("�������(�O)");
		// titleList.add("�շ���ʼ��");
		// titleList.add("���º�ͬ�ڼ�");
		// titleList.add("���շѶ�");
		// titleList.add("�շѱ���");
		//
		// titleList.add(startMonth + "-" + endMonth + "��Ӧ��");
		// titleList.add(startMonth + "-" + endMonth + "��ʵ��");
		//
		// titleList.add("ʵ�ձ���");
		// titleList.add("�տ�����");
		// titleList.add("Ƿ�ѽ��");
		// titleList.add("Ƿ���·�");
		//
		// int number = titleList.size();
		// // ��������ͷ��
		// exportExcel.createNormalHead(project + "�ͻ������" + year + "��"
		// + startMonth + "-" + endMonth + "�£�", number);
		// // ���õڶ���
		// exportExcel
		// .createTwoRow(
		// "�������ڣ�"
		// + new SimpleDateFormat("yyyy-MM-dd")
		// .format(new Date()), number);
		//
		// // ������ͷ
		// exportExcel.createColumHeader(titleList);
		try {
			exportExcel.outputExcel("c:\\Ttt2441.xls");
			System.out.println("c:\\Ttt2441.xls �������");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}