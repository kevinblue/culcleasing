package com.tenwa.culc.util.reportExp;

import java.beans.Statement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.tenwa.culc.util.ExportExcel2007;

import dbconn.Conn;

public class FactHireGapDiffExport {

	public XSSFWorkbook export(String start_date, String end_date,
			String project_name, String cust_name, String board_name,
			String dept_name, String manage_name) throws Exception {
		// ��������
		Conn db = new Conn();
		Conn db1 = new Conn();
		String wherestr = "";
		ResultSet rs = null;
		ResultSet rs1 = null;

		List list = new ArrayList();// ��ͷList
		List dataList = new ArrayList();// ����List
		List oneRow = null;// ÿ������

		// 1��ȡ���ݲ���
		if (project_name != null && !"".equals(project_name)) {
			wherestr += " and project_name like '%" + project_name + "%'";
		}
		if (cust_name != null && !"".equals(cust_name)) {
			wherestr += " and cust_name like '%" + cust_name + "%'";
		}
		if (board_name != null && !"".equals(board_name)) {
			wherestr += " and board_name like '%" + board_name + "%'";
		}
		if (manage_name != null && !"".equals(manage_name)) {
			wherestr += " and manage_name like '%" + manage_name + "%'";
		}
		if (dept_name != null && !"".equals(dept_name)) {
			wherestr += " and dept_name like '%" + dept_name + "%'";
		}
		// ��ѯʱ����Ƿ�Ӱ����ʾ������ - �г�������Ŀ����ʱ��Ӱ��
		if (start_date != null && !"".equals(start_date) && end_date != null
				&& !"".equals(end_date)) {
			wherestr += " and exists(select id from fund_rent_income where convert(varchar(10),hire_date,21)>='"
					+ start_date + "'";
			wherestr += " and convert(varchar(10),hire_date,21)<='" + end_date
					+ "' and begin_id=vi_report_penal_gap.begin_id)";
		} else {
			wherestr += " and 1=2 ";
		}
		String sqlstr = "";
		sqlstr = "Select * from vi_report_penal_gap where 1=1 " + wherestr;
		System.out.println("���partSql" + sqlstr);

		// 2.TitleList��ֵ ��ͷ
		list.add("��Ŀ����");
		list.add("�ͻ�����");
		list.add("���");
		list.add("ǩԼʱ��");
		list.add("����");
		list.add("��Ŀ����");
		list.add("ҽԺ�ȼ�");
		list.add("ҽԺ����");
		list.add("�Ƿ����");
		list.add("��ͬ��������죩");

		String partSql = "";
		int hireAmount = 0;
		partSql = " SELECT max(hire_list) AS amount FROM fund_rent_income WHERE convert(varchar(10),hire_date,21)>='"
				+ start_date + "' ";
		partSql += " AND convert(varchar(10),hire_date,21)<='" + end_date
				+ "' AND begin_id IN( select begin_id from (" + sqlstr
				+ ") as temp )";
		System.out.println("test======" + partSql);
		rs = db.executeQuery(partSql);
		if (rs.next()) {
			hireAmount = rs.getInt("amount");
		}
		rs.close();

		for (int index = 2; index <= hireAmount; index++) {
			list.add("��" + (index - 1) + "������죨�죩");
		}

		// 3.DataList���ݸ�ֵ
		String x1I = "";// Ԫ��
		String x2I = "";
		String x3I = "";
		String x4I = "";
		String x5I = "";
		String x6I = "";
		String x7I = "";
		String x8I = "";
		String x9I = "";
		String x10I = "";
		rs = db.executeQuery(sqlstr);
		while (rs.next()) {
			x1I = rs.getString("project_name");
			x2I = rs.getString("cust_name");
			x3I = rs.getString("board_name");
			x4I = rs.getString("approve_date");
			x5I = rs.getString("dept_name");
			x6I = rs.getString("manage_name");
			x7I = rs.getString("qualification_grade");
			x8I = rs.getString("medical_revenue");
			x9I = rs.getString("role_way");
			x10I = rs.getString("leas_gap");
			oneRow = new ArrayList();
			oneRow.add(String.valueOf(x1I));
			oneRow.add(String.valueOf(x2I));
			oneRow.add(String.valueOf(x3I));
			oneRow.add(String.valueOf(x4I));
			oneRow.add(String.valueOf(x5I));
			oneRow.add(String.valueOf(x6I));
			oneRow.add(String.valueOf(x7I));
			oneRow.add(String.valueOf(x8I));
			oneRow.add(String.valueOf(x9I));
			oneRow.add(String.valueOf(x10I));
			// ����N��
			float hire_gap = 0;
			int leas_gap= rs.getInt("leas_gap" );
			for (int index = 2; index <= hireAmount; index++) {
				partSql = "Select [dbo].[Lease_BB_getHKGap]('"
						+ rs.getString("begin_id") + "'," + index
						+ ") as amount";
				rs1 = db1.executeQuery(partSql);
				if (rs1.next()) {
					hire_gap = rs1.getFloat("amount")-leas_gap;
					oneRow.add(String.valueOf(hire_gap));
				}
			}

			// ��ӵ�DataList��
			dataList.add(oneRow);
		}

		// 4.����
		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet("sheet1");

		ExportExcel2007 exportExcel = new ExportExcel2007(wb, sheet);
		int number = list.size();
		// �еĳ���
		for (int i = 0; i < number; ++i) {
			if (i > 8) {
				sheet.setColumnWidth((short) i, (short) 6000);
			} else {
				sheet.setColumnWidth((short) i, (short) 3000);
			}
		}

		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(cellStyle.ALIGN_CENTER);

		// ������һ��
		exportExcel.createNormalHead("����ʵ�ʼ�������", number);
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
			row = sheet.createRow(rowStart);
			List dataRow = (List) dataList.get(i);

			for (int j = 0; j < dataRow.size(); ++j) {
				if (j == 3) {
					exportExcel.createDateCell(wb, row, j, cellStyle
							.getAlignment(), String.valueOf(dataRow.get(j)));
				} else if (j == 7 || j >= 9) {
					exportExcel.createNumberCell(wb, row, j, cellStyle
							.getAlignment(), String.valueOf(dataRow.get(j)));
				} else {
					exportExcel.createCell(wb, row, j,
							cellStyle.getAlignment(), String.valueOf(dataRow
									.get(j)));
				}
			}
			++rowStart;
		}
		// ָ���ϲ�����
		return wb;
	}

	public static void main(String[] args) {
		FactHireGapExport t = new FactHireGapExport();

		try {
			t.export("2012-02-01", "2012-03-31", "", "", "", "", "");
			System.out.println("���ɳɹ���");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
