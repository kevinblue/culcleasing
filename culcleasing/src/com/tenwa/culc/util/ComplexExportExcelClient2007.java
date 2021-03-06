package com.tenwa.culc.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * 拒绝件报表生成类.
 * 
 * @author caoyb
 * @version $Revision:$
 */
public class ComplexExportExcelClient2007 {

	private static XSSFWorkbook wb = new XSSFWorkbook();

	private static XSSFSheet sheet = wb.createSheet();

	public static void main(String[] args) {

		ExportExcel2007 exportExcel = new ExportExcel2007(wb, sheet);

		// 创建列标头LIST
		List fialList = new ArrayList();

		fialList.add("申请人未提供任何联系方式");
		fialList.add("无工作单位信息且未提供收入来源信息");
		fialList.add("有工作单位但未提供单位地址或电话");
		fialList.add("家庭地址缺失");
		fialList.add("客户身份证明资料缺");
		fialList.add("签名缺失或签名不符合要求");
		fialList.add("其它");

		List errorList = new ArrayList();

		errorList.add("客户主动取消");
		errorList.add("个人征信不良");
		errorList.add("欺诈申请");
		errorList.add("申请人基本条件不符");
		errorList.add("申请材料不合规");
		errorList.add("无法正常完成征信");
		errorList.add("重复申请");
		errorList.add("其他");

		// 计算该报表的列数
		int number = 2 + fialList.size() * 2 + errorList.size() * 2;

		// 给工作表列定义列宽(实际应用自己更改列数)
		for (int i = 0; i < number; i++) {
			sheet.setColumnWidth((short) i, (short) 3000);

		}

		// 创建单元格样式
		XSSFCellStyle cellStyle = wb.createCellStyle();

		// 指定单元格居中对齐
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);

		// 指定单元格垂直居中对齐
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);

		// 指定当单元格内容显示不下时自动换行
		cellStyle.setWrapText(true);

		// 设置单元格字体
		XSSFFont font = wb.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setFontHeight((short) 200);
		cellStyle.setFont(font);

		// 创建报表头部
		exportExcel.createNormalHead("南京地区申请资料拒件分析统计", number);

		// 设置第二行
		String[] params = new String[] { " 年 月 日", " 年 月 日" };
		exportExcel.createNormalTwoRow(params, number);

		// 设置列头
		XSSFRow row2 = sheet.createRow(2);

		XSSFCell cell0 = row2.createCell((short) 0);
		cell0.setCellStyle(cellStyle);
		cell0.setCellValue(new XSSFRichTextString("机构代码"));

		XSSFCell cell1 = row2.createCell((short) 1);
		cell1.setCellStyle(cellStyle);
		cell1.setCellValue(new XSSFRichTextString("支行名称"));

		XSSFCell cell2 = row2.createCell((short) 2);
		cell2.setCellStyle(cellStyle);
		cell2.setCellValue(new XSSFRichTextString("无效件"));

		XSSFCell cell3 = row2.createCell((short) (2 * fialList.size() + 2));
		cell3.setCellStyle(cellStyle);
		cell3.setCellValue(new XSSFRichTextString("拒绝件"));

		XSSFRow row3 = sheet.createRow(3);

		// 设置行高
		row3.setHeight((short) 800);

		XSSFCell row3Cell = null;
		int m = 0;
		int n = 0;

		// 创建不同的LIST的列标题
		for (int i = 2; i < number; i = i + 2) {

			if (i < 2 * fialList.size() + 2) {
				row3Cell = row3.createCell((short) i);
				row3Cell.setCellStyle(cellStyle);
				row3Cell.setCellValue(new XSSFRichTextString(fialList.get(m)
						.toString()));
				m++;
			} else {
				row3Cell = row3.createCell((short) i);
				row3Cell.setCellStyle(cellStyle);
				row3Cell.setCellValue(new XSSFRichTextString(errorList.get(n)
						.toString()));
				n++;
			}

		}

		// 创建最后一列的合计列
		row3Cell = row3.createCell((short) number);
		row3Cell.setCellStyle(cellStyle);
		row3Cell.setCellValue(new XSSFRichTextString("合计"));

		// 合并单元格
		XSSFRow row4 = sheet.createRow(4);

		// 合并第三行到第五行的第一列
		sheet.addMergedRegion(new CellRangeAddress(2, (short) 0, 4, (short) 0));

		// 合并第三行到第五行的第二列
		sheet.addMergedRegion(new CellRangeAddress(2, (short) 1, 4, (short) 1));

		// 合并第三行的第三列到第AA指定的列
		int aa = 2 * fialList.size() + 1;
		sheet
				.addMergedRegion(new CellRangeAddress(2, (short) 2, 2,
						(short) aa));

		int start = aa + 1;

		sheet.addMergedRegion(new CellRangeAddress(2, (short) start, 2,
				(short) (number - 1)));

		// 循环合并第四行的行，并且是每2列合并成一列
		for (int i = 2; i < number; i = i + 2) {
			sheet.addMergedRegion(new CellRangeAddress(3, (short) i, 3,
					(short) (i + 1)));
		}

		// 根据列数奇偶数的不同创建不同的列标题
		for (int i = 2; i < number; i++) {
			if (i < 2 * fialList.size() + 2) {

				if (i % 2 == 0) {
					XSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new XSSFRichTextString("无效量"));
				} else {
					XSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new XSSFRichTextString("占比"));
				}
			} else {
				if (i % 2 == 0) {
					XSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new XSSFRichTextString("拒绝量"));
				} else {
					XSSFCell cell = row4.createCell((short) i);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(new XSSFRichTextString("占比"));
				}
			}

		}

		// 循环创建中间的单元格的各项的值
		for (int i = 5; i < number; i++) {
			XSSFRow row = sheet.createRow((short) i);
			for (int j = 0; j <= number; j++) {
				exportExcel
						.createCell(wb, row, (short) j,
								XSSFCellStyle.ALIGN_CENTER_SELECTION, String
										.valueOf(j));
			}

		}

		// 创建最后一行的合计行
		String[] cellValue = new String[number - 1];
		for (int i = 0; i < number - 1; i++) {
			cellValue[i] = String.valueOf(i);

		}
		exportExcel.createLastSumRow(1, cellValue, "数据合计");
		//
		// String project = "凯晨世贸中心";
		// String year = "2011";
		// String startMonth = "01";
		// String endMonth = "05";
		//
		// List titleList = new ArrayList();
		// titleList.add("序号");
		// titleList.add("位置");
		// titleList.add("公司名称");
		// titleList.add("建筑面积(㎡)");
		// titleList.add("收费起始日");
		// titleList.add("最新合同期间");
		// titleList.add("年收费额");
		// titleList.add("收费比重");
		//
		// titleList.add(startMonth + "-" + endMonth + "月应收");
		// titleList.add(startMonth + "-" + endMonth + "月实收");
		//
		// titleList.add("实收比率");
		// titleList.add("收款周期");
		// titleList.add("欠费金额");
		// titleList.add("欠费月份");
		//
		// int number = titleList.size();
		// // 创建报表头部
		// exportExcel.createNormalHead(project + "客户情况表（" + year + "年"
		// + startMonth + "-" + endMonth + "月）", number);
		// // 设置第二行
		// exportExcel
		// .createTwoRow(
		// "导出日期："
		// + new SimpleDateFormat("yyyy-MM-dd")
		// .format(new Date()), number);
		//
		// // 设置列头
		// exportExcel.createColumHeader(titleList);
		try {
			exportExcel.outputExcel("c:\\Ttt2441344.xlsx");
			System.out.println("c:\\Ttt24412007.xls 生成完成");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}