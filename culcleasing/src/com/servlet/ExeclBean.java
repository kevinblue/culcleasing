package com.servlet;

/**
 * 
 * @author SCLICX
 * @version 1.0
 * @copyright (C) Tenwa 2011
 * @date Mar 20, 2011
 * @desc  (ExeclBean:��һ�����һ����Ԫ��Ķ���,���� �õ�Ԫ������е���Ϣ)
 */
public class ExeclBean {
	int sheet_index = 0;// �������±�
	String sheet_name = "sheet1";// ����������
	int row_num = 0;// ���±�
	String row_name = "";// �к�
	int col_num = 0;// ���±�
	String col_name = "@";// ������

	public ExeclBean() {
		super();
		//  Auto-generated constructor stub
	}

	/**
	 * ��ù������±�
	 * 
	 * @return
	 */
	public int getSheet_index() {
		return sheet_index;
	}

	public void setSheet_index(int sheet_index) {
		this.sheet_index = sheet_index;
	}

	/**
	 * ��ù���������
	 * 
	 * @return
	 */
	public String getSheet_name() {
		return sheet_name;
	}

	public void setSheet_name(String sheet_name) {
		this.sheet_name = sheet_name;
	}

	/**
	 * ������±�
	 * 
	 * @return
	 */
	public int getRow_num() {
		return Integer.parseInt(row_name) - 1;
	}

	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}

	/**
	 * ���������
	 * 
	 * @return
	 */
	public String getRow_name() {
		return row_name;
	}

	public void setRow_name(String row_name) {
		this.row_name = row_name;
	}

	/**
	 * ������±�
	 * 
	 * @return
	 */
	public int getCol_num() {
		int colNum = -1;
		char t = 'A';
		t = col_name.charAt(0);
		colNum = (int) t - 64;
		if (col_name.length() > 1) {
			for(int i=1;i<col_name.length();i++){
				t = col_name.charAt(i);
				colNum = colNum * 26 + (int) t - 64;
			}
		}
		return colNum - 1;
	}

	public void setCol_num(int col_num) {
		this.col_num = col_num;
	}

	/**
	 * ���������
	 * 
	 * @return
	 */
	public String getCol_name() {
		return col_name;
	}

	public void setCol_name(String col_name) {
		this.col_name = col_name;
	}

	@Override
	public String toString() {
		String t = "";
		t = "sheet_index:" + this.getSheet_index() + "\nsheet_name:" + this.getSheet_name() + "\nrow_num:" + this.getRow_num() + "\nrow_name:" + this.getRow_name() + "\ncol_num:" + this.getCol_num() + "\ncol_name:" + this.getCol_name();
		return t;
	}

}
