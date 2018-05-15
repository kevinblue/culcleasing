package com;

import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

/**
 * 
 * @author toybaby Date:Aug 24, 201110:49:01 AM Email:
 *         toybaby@mail2.tenwa.com.cn
 */

public class ReadExcel2003 {

	private String[][] obj;
	private boolean flag;

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public String[][] getObj() {
		return obj;
	}

	public void setObj(String[][] obj) {
		this.obj = obj;
	}

	/**
	 * 读取上传的租金计划excel模板
	 * 
	 * @param fileName
	 */
	public void setExcel(String fileName) {
		jxl.Workbook rwb = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		try {
			System.out.println("filename=================" + fileName);
			InputStream is = new FileInputStream(fileName);
			rwb = Workbook.getWorkbook(is);
			Sheet rs = rwb.getSheet(0);
			double num_tmp=0.00;
			int num = 0;// 租金期次
			num_tmp = Double.parseDouble(rs.getCell(4, 4).getContents().toString())
					* Integer.parseInt(rs.getCell(4, 6).getContents().toString());
			if(String.valueOf(num_tmp).indexOf('.')>0){
				num = Integer.parseInt(String.valueOf(num_tmp).substring(0, String.valueOf(num_tmp)
						.indexOf('.')))+1;
			}else{
				num = Integer.parseInt(String.valueOf(num_tmp));
			}
			// int rsColumns=rs.getColumns();
			int rsRows = rs.getRows();
			System.out.println("rsRows====" + rsRows+"num==="+num+"--------");
//					new BigDecimal(rs.getCell(4, 4).getContents().toString()).setScale(0, BigDecimal.ROUND_HALF_UP));  
			this.obj = new String[12 + num + 2][8];

			this.flag = true;
			for (int i = 2; i < rsRows; i++) {
				if (i >= 4 && i <= 9) {// 商务条件部分
					for (int j = 1; j < 7; j++) {
						Cell cell = rs.getCell(j, i);
						if (cell.getContents().equals(null)
								|| cell.getContents().equals("")) {
							this.obj[i][j] = "0.00";
						} else {
							this.obj[i][j] = cell.getContents()
									.replace(",", "");
							if (i == 5 && j == 4) {// 年利率去掉百分号
								this.obj[i][j] = cell.getContents().substring(
										0, cell.getContents().length() - 1);
							}
						}
						// System.out.println(cell.getContents());
					}
				} else if (i == 11) {// 起租日期,
					Cell cell = rs.getCell(0, 11);
					this.obj[i][0] = sdf2.format('/'==cell.getContents().toString().charAt(4)?sdf1.
							parse(cell.getContents()) : sdf.parse(cell.getContents()));
					//System.out.println("-------------------"+cell.getContents()+"---"+sdf1.parse(cell.getContents()).toString().charAt(4));
					Cell cell2 = rs.getCell(5, 11);// 租赁本金
					this.obj[i][5] = cell2.getContents().replace(",", "");
					Cell cell3 = rs.getCell(6, 11);// 融资
					this.obj[i][6] = cell3.getContents().replace(",", "");
				} else if (i >= 12 && i < 12 + num) {// 租金计划日期
					for (int j = 0; j < 7; j++) {
						Cell cell = rs.getCell(j, i);

						if (j == 0) {// 租金计划日期
							this.obj[i][0] = sdf2.format('/'==cell.getContents().toString().charAt(4)?sdf1.
									parse(cell.getContents()) : sdf.parse(cell.getContents()));
						} else {// 租金，本金，利息...
							this.obj[i][j] = cell.getContents()
									.replace(",", "");
						}
					}
				} else if (i == 12 + num + 1) {// IRR
					Cell cell = rs.getCell(7, i);
					this.obj[7][7] = cell.getContents().substring(0,
							cell.getContents().length() - 1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		ReadExcel2003 readExcel = new ReadExcel2003();
		readExcel.setExcel("c:/等额租金后付.xls");
		String[][] str = readExcel.getObj();
		for (String[] strArray : str) {
			for (String ss : strArray) {
				System.out.println(ss);
			}
		}
		
		//System.out.println(new BigDecimal(1.52).setScale(0, BigDecimal.ROUND_HALF_UP)); 
	}

}