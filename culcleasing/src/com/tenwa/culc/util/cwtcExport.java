package com.tenwa.culc.util;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import dbconn.Conn;

public class cwtcExport {
	@SuppressWarnings( { "unchecked", "static-access" })
	public XSSFWorkbook export(String start_date, String end_date,
			String if_hire, String dept_no, String proj_manage,
			String proj_industry) throws Exception {
		Conn db = new Conn();

		ResultSet rs = null;
		List dataList = new ArrayList();

		double x1I = 0f;// Ԫ��
		double x2I = 0f;
		double x3I = 0f;
		double x4I = 0f;
		double x5I = 0f;
		double x6I = 0f;
		double x7I = 0f;
		double x8I = 0f;

		double x1O = 0f;// Ԫ��
		double x2O = 0f;
		double x3O = 0f;
		double x4O = 0f;
		double x5O = 0f;

		double xIH = 0f;// ����ϼ�
		double xOH = 0f;// ֧���ϼ�

		 double XZH = 0f;// ͷ���ܺ� = ���� - ����
		String partSql = "";

		partSql = " Exec dbo.Report_Lease_BB '" + start_date + "','" + end_date
				+ "','" + if_hire + "','" + dept_no + "','" + proj_manage
				+ "','" + proj_industry + "' ";
		System.out.println("���partSql" + partSql);
		db.executeQuery(partSql);
		
		
		partSql = "Select * from sys_tool";
		System.out.println("partSql:" + partSql);
		rs = db.executeQuery(partSql);
		if (rs.next()) {
			x1I = rs.getDouble("resVal01_I");
			x2I = rs.getDouble("resVal02_I");
		
			x4I = rs.getDouble("resVal04_I");
			x5I = rs.getDouble("resVal05_I");
			x6I = rs.getDouble("resVal06_I");
			x7I = rs.getDouble("resVal07_I");
			x8I = rs.getDouble("resVal08_I");

			x1O = rs.getDouble("resVal01_O");
			x2O = rs.getDouble("resVal02_O");
			x3O = rs.getDouble("resVal03_O");
			x4O = rs.getDouble("resVal04_O");
			x5O = rs.getDouble("resVal05_O");
		}
		x3I = x1I - x2I;
		xIH = x3I + x4I + x5I + x6I + x7I + x8I;
		xOH = x1O + x2O + x3O + x4O + x5O;
		XZH = xIH - xOH;
		
		List oneRow = new ArrayList();
		oneRow.add("�ֽ�����");
		oneRow.add("�������");
		oneRow.add(Double.valueOf(x1I));
		oneRow.add(Double.valueOf(0));
		dataList.add(oneRow);
		
		List oneRow2 = new ArrayList();
		oneRow2.add("");
		oneRow2.add("���б����������");
		oneRow2.add(Double.valueOf(x2I));
		oneRow2.add(Double.valueOf(0));
		dataList.add(oneRow2);
		
		List oneRow3 = new ArrayList();
		oneRow3.add("");
		oneRow3.add("�۳�������������");
		oneRow3.add(Double.valueOf(x3I));
		oneRow3.add(Double.valueOf(0));
		dataList.add(oneRow3);
		
		List oneRow4 = new ArrayList();
		oneRow4.add("�ʽ�����");
		oneRow4.add("������Ӫ��ֽ�����");
		oneRow4.add(Double.valueOf(x4I));
		oneRow4.add(Double.valueOf(0));
		dataList.add(oneRow4);
		
		List oneRow5 = new ArrayList();
		oneRow5.add("");
		oneRow5.add("���н���ʽ�����");
		oneRow5.add(Double.valueOf(x5I));
		oneRow5.add(Double.valueOf(0));
		dataList.add(oneRow5);
		
		List oneRow6 = new ArrayList();
		oneRow6.add("");
		oneRow6.add("�����л�������ֽ�����");
		oneRow6.add(Double.valueOf(x6I));
		oneRow6.add(Double.valueOf(0));
		dataList.add(oneRow6);
		
		
		List oneRow7 = new ArrayList();
		oneRow7.add("");
		oneRow7.add("�����ڲ�����ֽ�����");
		oneRow7.add(Double.valueOf(x7I));
		oneRow7.add(Double.valueOf(0));
		dataList.add(oneRow7);
		
		List oneRow8 = new ArrayList();
		oneRow8.add("");
		oneRow8.add("��������");
		oneRow8.add(Double.valueOf(x8I));
		oneRow8.add(Double.valueOf(0));
		dataList.add(oneRow8);
		
		List oneRow14 = new ArrayList();
		oneRow14.add("�ϼ�");
		oneRow14.add("�ϼ�");
		oneRow14.add(Double.valueOf(xIH));
		oneRow14.add(Double.valueOf(0));
		dataList.add(oneRow14);
		
		List oneRow9 = new ArrayList();
		oneRow9.add("�ֽ�����");
		oneRow9.add("��Ӫ��ֽ�����");
		oneRow9.add(Double.valueOf(0));
		oneRow9.add(Double.valueOf(x1O));
		dataList.add(oneRow9);
		
		List oneRow10 = new ArrayList();
		oneRow10.add("");
		oneRow10.add("��������𣨷Ǳ���");
		oneRow10.add(Double.valueOf(0));
		oneRow10.add(Double.valueOf(x2O));
		dataList.add(oneRow10);
		
		List oneRow11 = new ArrayList();
		oneRow11.add("");
		oneRow11.add("����������Ϣ���Ǳ���");
		oneRow11.add(Double.valueOf(0));
		oneRow11.add(Double.valueOf(x3O));
		dataList.add(oneRow11);
		
		List oneRow12 = new ArrayList();
		oneRow12.add("");
		oneRow12.add("����������");
		oneRow12.add(Double.valueOf(0));
		oneRow12.add(Double.valueOf(x4O));
		dataList.add(oneRow12);
		
		List oneRow13 = new ArrayList();
		oneRow13.add("");
		oneRow13.add("��������");
		oneRow13.add(Double.valueOf(0));
		oneRow13.add(Double.valueOf(x5O));
		dataList.add(oneRow13);

		
				
		
		List oneRow15 = new ArrayList();
		oneRow15.add("�ϼ�");
		oneRow15.add("�ϼ�");
		oneRow15.add(Double.valueOf(0));
		oneRow15.add(Double.valueOf(xOH));
		dataList.add(oneRow15);
			
		
		List oneRow16 = new ArrayList();
		oneRow16.add("ͷ��");
		oneRow16.add("ͷ��");
		oneRow16.add(Double.valueOf(XZH));
		oneRow16.add(Double.valueOf(XZH));
		dataList.add(oneRow16);
		
			

		List list = new ArrayList();

		list.add("��Ŀ");
		list.add("");
		list.add("����");
		list.add("����");
		XSSFWorkbook wb = new XSSFWorkbook();

		XSSFSheet sheet = wb.createSheet("sheet1");

		ExportExcel2007 exportExcel = new ExportExcel2007(wb, sheet);

		int number = list.size();
		for (int i = 0; i < number; ++i) {
			sheet.setColumnWidth((short) i, (short) 8000);
		}

		XSSFCellStyle cellStyle = wb.createCellStyle();

		cellStyle.setAlignment(cellStyle.ALIGN_CENTER);

		// ������һ��
		exportExcel.createNormalHead("ͷ��Ԥ���", number);
		// �ڶ���
		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		String time = formater.format(new Date());
		exportExcel.createTwoRow("�������ڣ�" + time, number);
		// �����б���
		exportExcel.createColumHeader(list);

		// ��4�м��Ժ�
		int rowStart = 3;
		XSSFRow row = null;
		for (int i = 0; i < dataList.size(); ++i) {
			System.out.println("���Գ���" + dataList.size());
			row = sheet.createRow(rowStart);

			List dataRow = (List) dataList.get(i);
			System.out.println("���" + dataList.get(i));
			System.out.println("test----------" + dataRow.size());

			for (int j = 0; j < dataRow.size(); ++j) {
				exportExcel.createCell(wb, row, j, cellStyle.getAlignment(),
						String.valueOf(dataRow.get(j)));
			}

			++rowStart;
		}

		// ָ���ϲ�����
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 1));
		sheet.addMergedRegion(new CellRangeAddress(11, 11, 0, 1));
		sheet.addMergedRegion(new CellRangeAddress(17, 17, 0, 1));
		sheet.addMergedRegion(new CellRangeAddress(18, 18, 0, 1));
		sheet.addMergedRegion(new CellRangeAddress(3, 5, 0, 0));
		sheet.addMergedRegion(new CellRangeAddress(6, 10, 0, 0));
		sheet.addMergedRegion(new CellRangeAddress(12, 16, 0, 0));
		sheet.addMergedRegion(new CellRangeAddress(18, 18, 2, 3));
		// exportExcel.outputExcel("c:\\zj.xlsx");
		// System.out.println("shencg cr");
		return wb;
	}

	public static void main(String[] args) {
		cwtcExport t = new cwtcExport();
		try {
			t.export("2012-01-01", new Date().toString(), "", "", "", "");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
