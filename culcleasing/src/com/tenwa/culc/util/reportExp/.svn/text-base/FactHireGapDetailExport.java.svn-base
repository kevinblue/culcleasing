package com.tenwa.culc.util.reportExp;

import java.beans.Statement;
import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.tenwa.culc.util.ExportExcel;
import com.tenwa.culc.util.ExportExcel2007;

import dbconn.Conn;

public class FactHireGapDetailExport {
	public XSSFWorkbook export(String wherestr) throws Exception {
		// 基础参数
		Conn db = new Conn();
		Conn db1 = new Conn();
		Conn db2 = new Conn();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;

		List list = new ArrayList();// 表头List
		List dataList = new ArrayList();// 数据List
		List oneRow = null;// 每行数据
		String sqlstr = "";
		sqlstr = "Select * from vi_report_penal_gap_d where 1=1 " + wherestr;
		System.out.println("输出partSql" + sqlstr);

		// 2.TitleList赋值 表头
		list.add("项目名称");
		list.add("客户名称");
		list.add("板块");
		list.add("签约时间");
		list.add("部门");
		list.add("项目经理");
		list.add("医院等级");
		list.add("医院收入");
		list.add("是否规则");
		list.add("合同租金间隔（天）");
		list.add("单个客户累计逾期期数");
		list.add("单个客户累计逾期天数");
		list.add("单个客户目前正在逾期的累计期数");
		list.add("单个客户目前正在逾期的累计天数");

		String partSql = "";
		int hireAmount = 0;
		partSql = " SELECT max(hire_list) AS amount FROM fund_rent_income where begin_id IN( select begin_id from ("
				+ sqlstr + ") as temp )";
		System.out.println("test======" + partSql);
		rs = db.executeQuery(partSql);
		if (rs.next()) {
			hireAmount = rs.getInt("amount");
		}
		rs.close();

		for (int index = 2; index <= hireAmount; index++) {
			list.add("第" + (index - 1) + "间隔差异（天）");
		}

		// 3.DataList数据赋值
		String x1I = "";// 元素
		String x2I = "";
		String x3I = "";
		String x4I = "";
		String x5I = "";
		String x6I = "";
		String x7I = "";
		String x8I = "";
		String x9I = "";
		String x10I = "";
		String x11I = "";
		String x12I = "";
		String x13I = "";
		String x14I = "";
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

			// 四列
			partSql = "select dbo.report_getYQSC ('" + rs.getString("cust_id")
					+ "','LJQS') as ljqs,";
			partSql += "dbo.report_getYQSC ('" + rs.getString("cust_id")
					+ "','LJTS') as ljts,";
			partSql += "dbo.report_getYQSC ('" + rs.getString("cust_id")
					+ "','ZZQS') as zzqs,";
			partSql += "dbo.report_getYQSC ('" + rs.getString("cust_id")
					+ "','ZZTS') as zzts";
			rs2 = db2.executeQuery(partSql);
			if (rs2.next()) {
				x11I = rs2.getString("ljqs");
				x12I = rs2.getString("ljts");
				x13I = rs2.getString("zzqs");
				x14I = rs2.getString("zzts");
				oneRow.add(String.valueOf(x11I));
				oneRow.add(String.valueOf(x12I));
				oneRow.add(String.valueOf(x13I));
				oneRow.add(String.valueOf(x14I));
				// System.out.println("aaaa");
			}
			// 后面N列
			float hire_gap = 0;
			int leas_gap = rs.getInt("leas_gap");
			for (int index = 2; index <= hireAmount; index++) {
				partSql = "Select [dbo].[Lease_BB_getHKGap]('"
						+ rs.getString("begin_id") + "'," + index
						+ ") as amount";
				rs1 = db1.executeQuery(partSql);
				if (rs1.next()) {
					hire_gap = rs1.getFloat("amount") - leas_gap;
					oneRow.add(String.valueOf(hire_gap));
				}
			}

			// 添加到DataList中
			dataList.add(oneRow);
		}

		// 4.导出
		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet("sheet1");

		ExportExcel2007 exportExcel = new ExportExcel2007(wb, sheet);
		int number = list.size();
		// 列的长度
		for (int i = 0; i < number; ++i) {
			if (i > 12) {
				sheet.setColumnWidth((short) i, (short) 6000);
			} else {
				sheet.setColumnWidth((short) i, (short) 3000);
			}
		}

		XSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(cellStyle.ALIGN_CENTER);

		// 创建第一行
		exportExcel.createNormalHead("逾期时长项目明细表", number);
		// 第二行
		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		String time = formater.format(new Date());
		exportExcel.createTwoRow("导出日期：" + time, number);
		// 第三行标题
		exportExcel.createColumHeader(list);

		// 第4行及以后
		int rowStart = 3;
		XSSFRow row = null;
		for (int i = 0; i < dataList.size(); ++i) {
			row = sheet.createRow(rowStart);
			List dataRow = (List) dataList.get(i);

			for (int j = 0; j < dataRow.size(); ++j) {
				if (j == 3) {
					exportExcel.createDateCell(wb, row, j, cellStyle
							.getAlignment(), String.valueOf(dataRow.get(j)));
					// } else if (j == 7 || j >= 9) {
					// exportExcel.createNumberCell(wb, row, j, cellStyle
					// .getAlignment(), String.valueOf(dataRow.get(j)));
				} else {
					exportExcel.createCell(wb, row, j,
							cellStyle.getAlignment(), String.valueOf(dataRow
									.get(j)));
				}
			}
			++rowStart;
		}
		// 指定合并区域
		return wb;
	}

}
