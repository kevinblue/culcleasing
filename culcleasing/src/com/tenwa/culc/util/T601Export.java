package com.tenwa.culc.util;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import dbconn.Conn;

public class T601Export {
	@SuppressWarnings({ "unchecked", "static-access" })
	public XSSFWorkbook  export(String date) throws Exception {
		Conn db = new Conn();

		ResultSet rs = null;
		List dataList = new ArrayList();
		List oneRow = null;

		double x1I = 0D;
		double x2I = 0D;
		double x3I = 0D;
		double x4I = 0D;
		double x5I = 0D;
		double x6I = 0D;
		double x7I = 0D;

		double x1TS = 0D;
		double x2TS = 0D;
		double x3TS = 0D;
		double x4TS = 0D;
		double x5TS = 0D;
		double x6TS = 0D;
		double x7TS = 0D;

		double x1TF = 0D;
		double x2TF = 0D;
		double x3TF = 0D;
		double x4TF = 0D;
		double x5TF = 0D;
		double x6TF = 0D;
		double x7TF = 0D;
		String partSql = "";
		for (int y = 1; y <= 12; ++y) {
			oneRow = new ArrayList();
			if (y == 1) {
				
				oneRow.add("现金收入");
				oneRow.add("租赁利息");
			} else if (y == 2) {
				oneRow.add("");
				oneRow.add("租赁本金");
			} else if (y == 3) {
				oneRow.add("");
				oneRow.add("保证金");
			} else if (y == 4) {
				oneRow.add("");
				oneRow.add("其他");
			} else if (y == 5) {
				oneRow.add("");
				oneRow.add("收入小计");
			} else if (y == 6) {
				oneRow.add("现金支出");
				oneRow.add("银行利息");
			} else if (y == 7) {
				oneRow.add("");
				oneRow.add("银行本金");
			} else if (y == 8) {
				oneRow.add("");
				oneRow.add("保证金返还");
			} else if (y == 9) {
				oneRow.add("");
				oneRow.add("设备款");
			} else if (y == 10) {
				oneRow.add("");
				oneRow.add("其他");
			} else if (y == 11) {
				oneRow.add("");
				oneRow.add("支出小计");
			} else if (y == 12) {
				oneRow.add("");
				oneRow.add("资金缺口");
			}
			if ((y != 5) && (y != 11) && (y != 12)) {
				partSql = "";
				for(int x=1;x<=7;x++){
					partSql += " dbo.Financ_BB_getDataT601('"+date+"',"+x+","+y+") as resVal"+x+",";
				}
				partSql = "Select "
						+ partSql.substring(0, partSql.length() - 1);
				System.out.println("partSql:" + partSql);
				rs = db.executeQuery(partSql);
				if (rs.next()) {
					x1I = rs.getDouble("resVal1");
					x2I = rs.getDouble("resVal2");
					x3I = rs.getDouble("resVal3");
					x4I = rs.getDouble("resVal4");
					x5I = rs.getDouble("resVal5");
					x6I = rs.getDouble("resVal6");
					x7I = rs.getDouble("resVal7");

					if (y < 5) {
						x1TS += x1I;
						x2TS += x2I;
						x3TS += x3I;
						x4TS += x4I;
						x5TS += x5I;
						x6TS += x6I;
						x7TS += x7I;
					} else if (y < 11) {
						x1TF += x1I;
						x2TF += x2I;
						x3TF += x3I;
						x4TF += x4I;
						x5TF += x5I;
						x6TF += x6I;
						x7TF += x7I;
					}
				}
				rs.close();
				System.out.println(x1I);	
				System.out.println(x2I);	
				System.out.println(x3I);	
				System.out.println(x4I);	
				System.out.println(x5I);	
				System.out.println(x6I);	
				System.out.println(x7I);	
				oneRow.add(Double.valueOf(x1I));
				oneRow.add(Double.valueOf(x2I));
				oneRow.add(Double.valueOf(x3I));
				oneRow.add(Double.valueOf(x4I));
				oneRow.add(Double.valueOf(x5I));
				oneRow.add(Double.valueOf(x6I));
				oneRow.add(Double.valueOf(x7I));

				dataList.add(oneRow);
			}
			if (y == 5) {
				oneRow.add(Double.valueOf(x1TS));
				oneRow.add(Double.valueOf(x2TS));
				oneRow.add(Double.valueOf(x3TS));
				oneRow.add(Double.valueOf(x4TS));
				oneRow.add(Double.valueOf(x5TS));
				oneRow.add(Double.valueOf(x6TS));
				oneRow.add(Double.valueOf(x7TS));
				dataList.add(oneRow);
			}
			if (y == 11) {
				oneRow.add(Double.valueOf(x1TF));
				oneRow.add(Double.valueOf(x2TF));
				oneRow.add(Double.valueOf(x3TF));
				oneRow.add(Double.valueOf(x4TF));
				oneRow.add(Double.valueOf(x5TF));
				oneRow.add(Double.valueOf(x6TF));
				oneRow.add(Double.valueOf(x7TF));
				dataList.add(oneRow);
			}
			if (y == 12) {
				oneRow.add(Double.valueOf(x1TS - x1TF));
				oneRow.add(Double.valueOf(x2TS - x2TF));
				oneRow.add(Double.valueOf(x3TS - x3TF));
				oneRow.add(Double.valueOf(x4TS - x4TF));
				oneRow.add(Double.valueOf(x5TS - x5TF));
				oneRow.add(Double.valueOf(x6TS - x6TF));
				oneRow.add(Double.valueOf(x7TS - x7TF));
				dataList.add(oneRow);
			}
		}

		List list = new ArrayList();

		list.add("项目");
		list.add("");
		list.add("1个月内");
		list.add("1-3个月");
		list.add("3-6个月");
		list.add("6-12个月");
		list.add("1-2年");
		list.add("2-3年");
		list.add("3年+");
		XSSFWorkbook wb = new XSSFWorkbook();

		XSSFSheet sheet = wb.createSheet("sheet1");

		ExportExcel2007 exportExcel = new ExportExcel2007(wb, sheet);

		int number = list.size();
		for (int i = 0; i < number; ++i) {
			sheet.setColumnWidth((short) i,(short)5000);
		}

		XSSFCellStyle cellStyle = wb.createCellStyle();

		cellStyle.setAlignment(cellStyle.ALIGN_CENTER);

		//创建第一行
		exportExcel.createNormalHead("资金期限结构统计表", number);
		//第二行
		exportExcel.createTwoRow("导出日期："+date, number);
		//第三行标题
		exportExcel.createColumHeader(list);

		//第4行及以后
		int rowStart = 3;
		XSSFRow row = null;
		for (int i = 0; i < dataList.size(); ++i) {
			System.out.println(dataList.size());
			row = sheet.createRow( rowStart);

			List dataRow = (List) dataList.get(i);
			System.out.println(dataRow.size());

			for (int j = 0; j < dataRow.size(); ++j) {
				exportExcel.createCell(wb, row, j, cellStyle.getAlignment(), String
						.valueOf(dataRow.get(j)));
			}

			++rowStart;
		}
		// 指定合并区域
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 0,1));
		sheet.addMergedRegion(new CellRangeAddress(3, 7, 0,0));
		sheet.addMergedRegion(new CellRangeAddress(8, 13, 0,0));
		//sheet.addMergedRegion(new CellRangeAddress(14, 14, 0,1));
		//exportExcel.outputExcel("c:\\zj.xlsx");
//		System.out.println("shencg cr");
		return wb;
	}

	public static void main(String[] args) {
		T601Export t = new T601Export();
		try {
			t.export(new Date().toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
