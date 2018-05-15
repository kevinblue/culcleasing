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

public class CheckInvoiceInfo {
	/**
	 * 检查租金计划是否已导出，导出则不能退回
	 * @param plid_list
	 * @param rent_list_list
	 * @return
	 */
	public  String  checkInvoice(String plid_list,String rent_list_list){		
		String message="";
		String flag="";
		String [] plid_arr=plid_list.split("#");
		String [] rent_list_arr=rent_list_list.split("#");
		for(int i=0;i<plid_arr.length;i++){
			try {
				flag=this.checkRentReceiptQuery(plid_arr[i], rent_list_arr[i]);
				if(!flag.isEmpty()){
					message=flag;
					break;
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				message=e.getMessage();
			}
		}		
		return  message;
	}

	public String checkRentReceiptQuery(String plid,String  rent_list)throws Exception{
		System.out.println("校验租金开始");
		String message="";
		String invoice_statues="";
		//Conn conn=null;
		ERPDataSource conn=null;
		Connection conet=null;
		Statement st=null;
		String sql="select * from vi_rent_receipt_confirm  where plid='"+plid+"' and "+
		"rent_list='"+rent_list+"'";
		ResultSet rs=null;
		try {
			//conn=new Conn();
			conn=new ERPDataSource();			
			conet=conn.getConnection();
			st=conet.createStatement();
			rs=st.executeQuery(sql);
			while(rs.next()){
				invoice_statues=rs.getString("invoice_statues");
				if("已确认".equals(invoice_statues)){
					message="起租编号"+rs.getString("begin_id")+"的第"+rs.getString("rent_list")+"期"+
					rs.getString("rent_type")+"已确认，本次申请不能退回!";
					break;
				}
			}
			System.out.println("校验租金收据结束");
			
		} catch (Exception e) {
			e.printStackTrace();			
			throw new Exception(e.getMessage());
		}finally{
			conn.close();
		}
		return message;
	}
	
	
	
}
