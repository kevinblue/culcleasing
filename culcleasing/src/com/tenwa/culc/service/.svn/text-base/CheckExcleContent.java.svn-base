package com.tenwa.culc.service;

import java.io.File;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.Tools;
import com.tenwa.culc.util.ERPDataSource;


import dbconn.Conn;

public class CheckExcleContent {
	public static void main(String[] args) {
		String path="C:\\Users\\Administrator\\Desktop\\医院项目工作底稿--民权县.xls";
		String message=checkAllFinancial(path, "0835010117","");
		System.out.println(message);
	}
	public CheckExcleContent(){
	
	}
	public static String checkAllFinancial(String path,String custId,String userId) {	
		System.out.println("上传servlet接受方法参数：路径+客户ID+用户ID("+path+","+custId+","+userId+")");
		String flag="";	
		InputStream is = null;
		Workbook wb = null;
		try {
			File sourcefile = new File(path);
			is = new FileInputStream(sourcefile);
			if (sourcefile.getName().endsWith("xlsx")) {// 2007				
				wb = readWorkbook(is, ExcelVersionEnum.VERSION2007);
			} else {// 2003				
				wb = readWorkbook(is, ExcelVersionEnum.VERSION2003);			
			}
			
			flag=receiveCheckInfo(wb,custId);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}		
		return flag;
	}
	
	public static String  receiveCheckInfo(Workbook wb,String custId) throws Exception{
			String  message="";
			message+=checkFinancialBase(wb.getSheetAt(0),custId);	
			message+=checkFinancialManage(wb.getSheetAt(1), custId);
			message+=checkFinancialResource(wb.getSheetAt(2), custId);
		return message;
	}

	public static Workbook readWorkbook(InputStream is,
			ExcelVersionEnum excelVersionEnum) throws Exception {
		Workbook wb = null;
		switch (excelVersionEnum) {
		case VERSION2003: {
			wb =new HSSFWorkbook(is);
			break;
		}
		case VERSIONM: {
			wb = WorkbookFactory.create(is);
			break;
		}
		case VERSION2007: {
			wb = new XSSFWorkbook(is);
			break;
		}
		}
		return wb;
	}

	public static String getCellValue(Cell cell) {
		if (null == cell) {
			return "";
		}
		String value = "";
		try {
			switch (cell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC: {
				try {
					if (isCellDateFormatted(cell)) {
						SimpleDateFormat sdf = new SimpleDateFormat(
								"yyyy-MM-dd");
						value = sdf.format(
								getJavaDate(cell.getNumericCellValue()))
								.toString();
					} else {
						value = decimal(cell.getNumericCellValue(), 10);
					}
				} catch (Exception e) {
					System.out.println("类型不一致测试aaaaaaaaaa");
					e.printStackTrace();
					value = cell.getStringCellValue() + "";
					value = decimal(Double.parseDouble(value
							.replaceAll(",", "")), 10);
				}
				break;
			}
			case Cell.CELL_TYPE_STRING: {
				value = cell.getStringCellValue() + "";
				break;
			}
			case Cell.CELL_TYPE_BOOLEAN: {
				value = cell.getBooleanCellValue() + "";
				break;
			}
			case Cell.CELL_TYPE_FORMULA: {
				try {
					if (HSSFDateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat dateformat = new SimpleDateFormat(
								"yyyy-MM-dd");
						Date dt = HSSFDateUtil.getJavaDate(cell
								.getNumericCellValue());// 获取成DATE类型
						value = dateformat.format(dt);
					} else {
						value = String.valueOf(cell.getNumericCellValue());
						BigDecimal bd = new BigDecimal(value);
						value = bd.toPlainString();
					}
				} catch (IllegalStateException e) {
					try {
						value = String.valueOf(cell.getRichStringCellValue());
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						value = String.valueOf(cell.getBooleanCellValue());
					}
				}
			}
			}
		} catch (Exception e) {
			value = "";
		}
		value = value.trim();
		return value;
	}

	public static boolean isCellDateFormatted(Cell cell) throws Exception {
		return DateUtil.isCellDateFormatted(cell);
	}

	public static Date getJavaDate(double cellvalue) throws Exception {
		return DateUtil.getJavaDate(cellvalue);
	}

	public static String decimal(double number, int scale) {
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(scale);
		nf.setRoundingMode(RoundingMode.HALF_UP);
		return nf.format(number).replaceAll(",", "");
	}
	/**
	 * 获取当前时间 
	 * @return
	 */
	public static String  getNowDate() {
		   Date datenow = new Date();
		   SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   String dateString = formatter.format(datenow);		
		   return dateString;
	
		}
	public static String checkFinancialBase(Sheet sheet, String custid) throws Exception {
		String message = "";// 需要返回的消息
		String financial_year=ImportExcleContent.getNowYear()+"年";
		String cust_id=custid;
		String cust_name=getCellValue(sheet.getRow(1).getCell(1));
		String guarantor_one=getCellValue(sheet.getRow(2).getCell(1));
		String guarantor_two=getCellValue(sheet.getRow(3).getCell(1));
		String province=getCellValue(sheet.getRow(4).getCell(1));
		String city=getCellValue(sheet.getRow(4).getCell(3));
		String county=getCellValue(sheet.getRow(4).getCell(5));
		String total_population=getCellValue(sheet.getRow(5).getCell(1));
		String financial_gdp=getCellValue(sheet.getRow(5).getCell(3));
		String outstand_principal=getCellValue(sheet.getRow(5).getCell(5));
		String towner_disposable_inconme=getCellValue(sheet.getRow(6).getCell(1));				
		String farmer_inconme=getCellValue(sheet.getRow(6).getCell(3));
		String credit_blemish=getCellValue(sheet.getRow(6).getCell(5));	
		String business_department=getCellValue(sheet.getRow(7).getCell(1));
		String risk_evaluation_manager=getCellValue(sheet.getRow(7).getCell(5));
		String government=getCellValue(sheet.getRow(10).getCell(0));
		String people_congress=getCellValue(sheet.getRow(10).getCell(1));
		String finance_bureau=getCellValue(sheet.getRow(10).getCell(2));
		String health_bureau=getCellValue(sheet.getRow(10).getCell(3));
		String city_investment_guarantee=getCellValue(sheet.getRow(10).getCell(4));
		String city_bond=getCellValue(sheet.getRow(10).getCell(5));
		
		message+=checkBaseData(cust_id,financial_year, "cust_name", cust_name);
		message+=checkBaseData(cust_id,financial_year, "guarantor_one", guarantor_one);
		message+=checkBaseData(cust_id,financial_year, "guarantor_two", guarantor_two);
		message+=checkBaseData(cust_id,financial_year, "province", province);
		message+=checkBaseData(cust_id,financial_year, "city", city);
		message+=checkBaseData(cust_id,financial_year, "county", county);
		message+=checkBaseData(cust_id,financial_year, "total_population", total_population);
		message+=checkBaseData(cust_id,financial_year, "financial_gdp", financial_gdp);
		message+=checkBaseData(cust_id,financial_year, "outstand_principal", outstand_principal);
		message+=checkBaseData(cust_id,financial_year, "towner_disposable_inconme", towner_disposable_inconme);
		message+=checkBaseData(cust_id,financial_year, "farmer_inconme", farmer_inconme);
		message+=checkBaseData(cust_id,financial_year, "credit_blemish", credit_blemish);
		message+=checkBaseData(cust_id,financial_year, "business_department", business_department);
		message+=checkBaseData(cust_id,financial_year, "risk_evaluation_manager", risk_evaluation_manager);
		message+=checkBaseData(cust_id,financial_year, "government", government);
		message+=checkBaseData(cust_id,financial_year, "people_congress", people_congress);
		message+=checkBaseData(cust_id,financial_year, "finance_bureau", finance_bureau);
		message+=checkBaseData(cust_id,financial_year, "health_bureau", health_bureau);
		message+=checkBaseData(cust_id,financial_year, "city_investment_guarantee", city_investment_guarantee);
		message+=checkBaseData(cust_id,financial_year, "city_bond", city_bond);
	return message;

	}
	
	public static String checkFinancialManage(Sheet sheet, String custid) throws Exception {
		String message="";
		int sumRowNum=92;//总行数
		String data="";
		int indexkey=12;//指标列总列
		for(int k=1;k<5;k++){
			Row yearrows=sheet.getRow(1);//年所在的行
			Cell cell = yearrows.getCell(k);//列
			data=getCellValue(cell);//年所在的行数据
			String financial_subject="";//科目
			String financial_subdata="";//科目数据
			String financial_year=getCellValue(cell);//年份
			String financial_average="";//平均值--前92行没有值
			String row_num="";//数据行
			for(int i=2;i<=sumRowNum;i++){
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(0);//科目列
				Cell celldata = row.getCell(k);//列	
				row_num=i-1+"";//行--数据
				
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				message+=checkData(custid, "financial_manage_info", financial_year, financial_subject,"financial_subdata", financial_subdata,row_num);
				
				if(i==sumRowNum){				
                    for(int t=1;t<28;t++){
                    	Row rows = sheet.getRow(t+1);//行
                    	
                    	Cell keytitle1 = rows.getCell(6);//指标列  
                    	Cell keytitle2 = rows.getCell(7);//指标列  
                    	Cell keytitle3 = rows.getCell(indexkey);//指标列 平均值
        				Cell ratecelldata = rows.getCell(7+k);//列
        				row_num=t+91+"";//行--数据
        				
        				financial_year=data;//年份
        				financial_subject=getCellValue(keytitle2);//科目
        				financial_subdata=getCellValue(ratecelldata);//数据
        				financial_average=getCellValue(keytitle3);//平均值
        				message+=checkData(custid, "financial_manage_info",financial_year,financial_subject,"financial_subdata",financial_subdata, row_num);
        				message+=checkData(custid, "financial_manage_info",financial_year,financial_subject,"financial_average",financial_average, row_num);

                    }
				}
			}
		}
		return  message;
	}
	
	public static String  checkFinancialResource(Sheet sheet, String custid) throws Exception {
		String message="";
		String tablename="financial_resource_info";
		String data="";
		for(int k=2;k<8;k++){	
			String financial_subject="";//科目
			String financial_subdata="";//科目数据
			String financial_year="";//年份			
			Row yearrows=sheet.getRow(1);//年所在的行
			Cell cell = yearrows.getCell(k);//列
			data=getCellValue(cell);//年所在的行数据
			String row_num="";//数据行
			int rownum=0;
			financial_year=data;
			for(int i=2;i<=34;i++){							
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(1);//科目列
				Cell celldata = row.getCell(k);//列	
				
				rownum++;
				row_num=rownum+"";//行--数据
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				message=checkData(custid, tablename, financial_year, financial_subject,"financial_subdata", financial_subdata,row_num);
				
				}
			for(int i=38;i<=46;i++){
				rownum++;
				row_num=rownum+"";//行--数据
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(1);//科目列
				Cell celldata = row.getCell(k);//列	
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				message=checkData(custid, tablename, financial_year, financial_subject,"financial_subdata", financial_subdata,row_num);
				
			}			
			for(int i=50;i<=53;i++){
				rownum++;
				row_num=rownum+"";//行--数据
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(1);//科目列
				Cell celldata = row.getCell(k);//列	
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				message=checkData(custid, tablename, financial_year, financial_subject,"financial_subdata", financial_subdata,row_num);
			}	
		}
		return message;
	}

	public static String  checkBaseData(String custId,String financial_year,String financial_subject,String financial_subdata){
		String data="";
		String message="";
		ERPDataSource conn=null;
		Connection conet=null;
		Statement st=null;
		ResultSet rs = null;
		String sql = "select  * from financial_base_info where cust_id='"+custId+"' and financial_year='"+financial_year +"'";
		try {
			conn=new ERPDataSource(); 
			conet=conn.getConnection();
			st=conet.createStatement();			
			rs=st.executeQuery(sql);
            while(rs.next()){
                //rs.get+数据库中对应的类型+(数据库中对应的列别名)
            	data=rs.getString(financial_subject);
            	 if(!financial_subdata.equals(data)){
            		 message+= financial_year+"的'"+financial_subject+"'现值为'"+financial_subdata+"'与原值'"+data+"'不同;\\n";
            	 }else{
            		 
            	 }            	
            }
				
		} catch (Exception e) {
			e.printStackTrace();			
		}finally{
			conn.close();
		}
		return message;
	}

	public static String  checkData(String custId,String tablename,String financial_year,
			String financial_subject,String financial_subdatalie,String financial_subdata,String row_num){
		String message="";
		String data="";
		ERPDataSource conn=null;
		Connection conet=null;
		Statement st=null;
		ResultSet rs = null;
		String sql = "select  * from "+tablename+" where cust_id='"+custId+"' and financial_year='"+
		financial_year +"' and financial_subject='"+financial_subject+"'and  row_num='"+row_num+"'";	
		try {
			conn=new ERPDataSource(); 
			conet=conn.getConnection();
			st=conet.createStatement();
			rs=st.executeQuery(sql);
            while(rs.next()){
            	data=rs.getString(financial_subdatalie);            	
            	 if(!Tools.formatNumberDoubleSix(financial_subdata).equals(Tools.formatNumberDoubleSix(data))){
            		 message+= financial_year+"的'"+financial_subject+"'现值为'"+financial_subdata+"'与原值'"+data+"'不同;\\n";
            	 }
            	 break;
            }
            
		} catch (Exception e) {
			e.printStackTrace();			
		}finally{
			conn.close();
		}
		return  message;
	}
}
