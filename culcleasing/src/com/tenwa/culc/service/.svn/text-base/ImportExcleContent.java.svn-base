package com.tenwa.culc.service;

import java.io.File;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
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

public class ImportExcleContent {
	public ImportExcleContent(){
		
	}
	public static void main(String[] args) {
		String year=getNowYear();
		System.out.println(year);
	}
	
	public static String upload(String path,String custId,String userId) {	
		System.out.println("上传servlet接受方法参数：路径+客户ID+用户ID("+path+","+custId+","+userId+")");
		String flag="1";	
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
			String uuid = UUID.randomUUID().toString().replace("-", "");//生成序列号，为3个财务报表的共同字段
			executeSqlStr(wb,custId, userId, is,uuid);
			System.out.println("导入excle方法成功结束！");
		} catch (Exception e) {
			e.printStackTrace();
			flag=e.getMessage();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
				flag=e.getMessage();
			}
		}		
		return flag;
	}
	
	public static void executeSqlStr(Workbook wb,String custId,String userid,
			InputStream is,String uuid) throws Exception{
		//Conn conn=null;
		ERPDataSource  conn=null;
		Connection conet=null;
		Statement st=null;
		
		try {
		//	conn=new Conn();
			conn=new ERPDataSource();
			conet=conn.getConnection();
			conet.setAutoCommit(false);
			st=conet.createStatement();
			//先删除后保存导入数据
			deleteFinancialBase(custId, st);
			saveFinancialBase(wb.getSheetAt(0), custId, userid, is,uuid,st);
			st.executeBatch();			
			st.clearBatch();
			
			deleteFinancialManage(wb.getSheetAt(1), custId, st);
			saveFinancialManage(wb.getSheetAt(1), custId, userid, is,uuid,st);
			st.executeBatch();			
			st.clearBatch();
			
			deleteFinancialResource(wb.getSheetAt(2), custId, st);
			saveFinancialResource(wb.getSheetAt(2), custId, userid, is,uuid,st);
			st.executeBatch();

			conet.commit();
			System.out.println("执行删除插入语句结束！");
		} catch (Exception e) {
			e.printStackTrace();			
			System.out.println("错误信息e.getMessage()"+e.getMessage());
			try {
				conet.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}	
			throw new Exception(e.getMessage());
		}finally{
			conn.close();
		}
		
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
	public static String  getNowYear() {
		   Date datenow = new Date();
		   SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		   String dateString = formatter.format(datenow);		
		   return dateString;
	
		}
	public static void deleteFinancialBase(String custId,Statement st) throws Exception {
		String year=getNowYear()+"年";
		String sql="delete from dbo.financial_base_info  where cust_id="+
		"'"+custId+"' and  financial_year  = '"+year+"'";
		System.out.println("先删除客户基础信息："+sql);
		st.addBatch(sql);
		//st.executeBatch();
	}
	public static void deleteFinancialManage(Sheet sheet, String custId,Statement st) throws Exception {
		String sqlstr="";
		String data="";
		for(int k=1;k<5;k++){
			Row yearrows=sheet.getRow(1);//年所在的行
			Cell cell = yearrows.getCell(k);//列
			data=getCellValue(cell);//年所在的行数据
			sqlstr="delete from dbo.financial_manage_info  where cust_id='"+custId+"'"+
			"and financial_year  = '"+data+"'";
			System.out.println("先删除客户财务经营信息："+sqlstr);
			st.addBatch(sqlstr);
		}	
		//st.executeBatch();
	}
	
	public static void deleteFinancialResource(Sheet sheet, String custId,Statement st) throws Exception {
		String sqlstr="";
		String data="";
		for(int k=2;k<8;k++){	
//			if(k==5){
				Row yearrows=sheet.getRow(1);//年所在的行
				Cell cell = yearrows.getCell(k);//列
				data=getCellValue(cell);//年所在的行数据
				sqlstr="delete from dbo.financial_resource_info  where cust_id='"+custId+"'"+
				"and financial_year  = '"+data+"'";
				System.out.println("先删除客户地方财力信息："+sqlstr);
				st.addBatch(sqlstr);
				
/*			}else{
				Row yearrows=sheet.getRow(1);//年所在的行
				Cell cell = yearrows.getCell(k);//列
				data=getCellValue(cell);//年所在的行数据
				sqlstr="delete from dbo.financial_resource_info where cust_id='"+custId+"'"+
				"and financial_year like '%"+data.substring(0, 5)+"%'";
				System.out.println("先删除客户地方财力信息："+sqlstr);
				st.addBatch(sqlstr);
			}*/
		}	
		//st.executeBatch();
	}
	public static String saveFinancialBase(Sheet sheet, String custid,String userid,
			InputStream is,String uuid,Statement st) throws Exception {
		String sql = "";// 需要执行的SQL--更新或者插入语句
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
		//判断数据是否为数值
		if(!Tools.isDouble(total_population)&&!total_population.isEmpty()){
			throw new Exception("[当地总人口(万人)]的数值:["+total_population+"]不是数值，请确认！");
		}
		if(!Tools.isDouble(financial_gdp)&&!financial_gdp.isEmpty()){
			throw new Exception("[[GDP（亿元）]的数值:["+financial_gdp+"]不是数值，请确认！");
		}
		if(!Tools.isDouble(outstand_principal)&&!outstand_principal.isEmpty()){
			throw new Exception("[地区累计未还本金（万元）]的数值:["+outstand_principal+"]不是数值，请确认！");
		}
		if(!Tools.isDouble(towner_disposable_inconme)&&!towner_disposable_inconme.isEmpty()){
			throw new Exception("[城镇居民可支配收入（元）]的数值:["+towner_disposable_inconme+"]不是数值，请确认！");
		}
		if(!Tools.isDouble(farmer_inconme)&&!farmer_inconme.isEmpty()){
			throw new Exception("[农民纯收入（元）]的数值:["+farmer_inconme+"]不是数值，请确认！");
		}

		BigDecimal  total_populationbig=new BigDecimal(total_population.length()==0?"0":total_population);
		BigDecimal  financial_gdpbig=new BigDecimal(financial_gdp.length()==0?"0":financial_gdp);
		BigDecimal  outstand_principalbig=new BigDecimal(outstand_principal.length()==0?"0":outstand_principal);
		BigDecimal  towner_disposable_inconmebig=new BigDecimal(towner_disposable_inconme.length()==0?"0":towner_disposable_inconme);
		BigDecimal  farmer_inconmebig=new BigDecimal(farmer_inconme.length()==0?"0":farmer_inconme);

		String credit_blemish=getCellValue(sheet.getRow(6).getCell(5));
		
		String business_department=getCellValue(sheet.getRow(7).getCell(1));
		String risk_evaluation_manager=getCellValue(sheet.getRow(7).getCell(5));
		String government=getCellValue(sheet.getRow(10).getCell(0));
		String people_congress=getCellValue(sheet.getRow(10).getCell(1));
		String finance_bureau=getCellValue(sheet.getRow(10).getCell(2));
		String health_bureau=getCellValue(sheet.getRow(10).getCell(3));
		String city_investment_guarantee=getCellValue(sheet.getRow(10).getCell(4));
		String city_bond=getCellValue(sheet.getRow(10).getCell(5));
		String financial_year=getNowYear()+"年";
		String creator=userid;
		String create_datestr=getNowDate();
		sql="insert into dbo.financial_base_info("+
				"[uuid],[cust_id],[cust_name],[guarantor_one],[guarantor_two],[province],"+
				"[city],[county],[total_population],[financial_gdp],[outstand_principal],"+
				"[towner_disposable_inconme],[farmer_inconme],[credit_blemish],[business_department],"+
				"[risk_evaluation_manager],[government],[people_congress],[finance_bureau],"+
				"[health_bureau],[city_investment_guarantee],[city_bond],[financial_year],[creator],"+
				"[create_date],[modify_date],[modificator]) values('"+uuid+"',"+"'"+cust_id+"',"+
				"'"+cust_name+"','"+guarantor_one+"','"+guarantor_two+"',"+
				"'"+province+"','"+city+"','"+county+"','"+total_population+"','"+
				financial_gdp+"','"+outstand_principal+"','"+towner_disposable_inconme+"','"+
				farmer_inconme+"','"+credit_blemish+"','"+business_department+"','"+risk_evaluation_manager+"','"+government+"','"+people_congress+"'"+
				",'"+finance_bureau+"','"+health_bureau+"','"+city_investment_guarantee+"',"+
				"'"+city_bond+"','"+financial_year+"','"+creator+"','"+create_datestr+"',"+null+","+null+
				")";
			st.addBatch(sql);	
		return  sql;

	}
	
	public static String saveFinancialManage(Sheet sheet, String custid,String userid,
			InputStream is,String uuid,Statement st) throws Exception {
		String create_datestr=getNowDate();
		String sqlstr="";
		StringBuffer sql = new StringBuffer();// 需要执行的SQL--更新或者插入语句
		sql.append("insert into dbo.financial_manage_info(cust_id,uuid,index_meaning,financial_subject,financial_subdata,"+
		"financial_year,financial_average,row_num,column_num,creator,create_date,modify_date,modificator) values");
		int sumRowNum=92;//总行数
		String data="";
		int indexkey=12;//指标列总列
		for(int k=1;k<5;k++){
			Row yearrows=sheet.getRow(1);//年所在的行
			Cell cell = yearrows.getCell(k);//列
			data=getCellValue(cell);//年所在的行数据
			
			String index_meaning="";//指标含义--前92行没有值
			String financial_subject="";//科目
			String financial_subdata="";//科目数据
			String financial_year=getCellValue(cell);//年份
			String financial_average="";//平均值--前92行没有值
			String row_num="";//数据行
			String column_num="";//数据列
			
			for(int i=2;i<=sumRowNum;i++){
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(0);//科目列
				Cell celldata = row.getCell(k);//列	
				
				row_num=i-1+"";//行--数据
				column_num=k+"";//列--数据
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				if(!"业务统计数据".equals(financial_subject)&&!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]的数据:["+financial_subdata+"]不是数值，请确认！");
					}
				}
				sql.append("('"+custid+"','"+uuid+"','"+index_meaning+"','"+financial_subject+"','"+financial_subdata+
						"','"+financial_year+"','"+financial_average+"','"+row_num+"','"+column_num+"','"+userid+"',getDate()"+"','"+"null"+"','"+"null"
						+"),");
			 sqlstr="insert into dbo.financial_manage_info(cust_id,uuid,index_meaning,financial_subject,financial_subdata,"+
					"financial_year,financial_average,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_meaning+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+financial_average+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"科目为："+getCellValue(titlecell)+"数据为："+getCellValue(celldata)+"行号为："+i);
				if(i==sumRowNum){					
					String index_meaningstr="";
                    for(int t=1;t<28;t++){
                    	Row rows = sheet.getRow(t+1);//行
                    	
                    	Cell keytitle1 = rows.getCell(6);//指标列  
                    	Cell keytitle2 = rows.getCell(7);//指标列  
                    	Cell keytitle3 = rows.getCell(indexkey);//指标列 平均值
        				Cell ratecelldata = rows.getCell(7+k);//列
        				
        				if(getCellValue(keytitle1).length()!=0){
        					index_meaningstr=getCellValue(keytitle1);
        				}
        				row_num=t+91+"";//行--数据
        				column_num=k+7+"";//列--数据
        				index_meaning=index_meaningstr;//指标
        				financial_year=data;//年份
        				financial_subject=getCellValue(keytitle2);//科目
        				financial_subdata=getCellValue(ratecelldata);//数据
        				financial_average=getCellValue(keytitle3);//平均值
        				
        				System.out.println("平均值："+financial_average+";类型："+keytitle3.getCellType());
    					if(!Tools.isDouble(financial_subdata)&&!financial_subdata.isEmpty()){
    						throw new Exception("["+financial_subject+"]的数据:["+financial_subdata+"]不是数值，请确认！");
    					}
    					if(!Tools.isDouble(financial_average)&&!financial_average.isEmpty()){
    						throw new Exception("["+financial_subject+"]的平均值:["+financial_average+"]不是数值，请确认！");
    					}
        				
        				sql.append("('"+custid+"','"+uuid+"','"+index_meaning+"','"+financial_subject+"','"+financial_subdata+
        						"','"+financial_year+"','"+financial_average+"','"+row_num+"','"+column_num+"','"+userid+"',getDate()"+"','"+"null"+"','"+"null"
        						+"),");
        				 sqlstr="insert into dbo.financial_manage_info(cust_id,uuid,index_meaning,financial_subject,financial_subdata,"+
     					"financial_year,financial_average,row_num,column_num,creator,create_date,modify_date,modificator)"+
     					"values('"+custid+"','"+uuid+"','"+index_meaning+"','"+financial_subject+"','"+financial_subdata+
     					"','"+financial_year+"','"+financial_average+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
     					+")";
     				 st.addBatch(sqlstr);
        			//System.out.println(data+"科目为1："+index_meaning+"科目2："+getCellValue(keytitle2)+"数据为："+getCellValue(ratecelldata)+"行号为："+(t+i)+"平均值"+getCellValue(keytitle3));
                    	
                    }
				}
			}
		}
		//st.executeBatch();
		return  sql.toString();
	}
	
	public static void saveFinancialResource(Sheet sheet, String custid,String userid,
			InputStream is,String uuid,Statement st) throws Exception {
		String create_datestr=getNowDate();
		String sqlstr="";
		int sumRowNum1=34;//总行数
		String data="";
		int indexkey=7;//指标列总列
		for(int k=2;k<8;k++){	
			String index_title="";//标题
			String financial_subject="";//科目
			String financial_subdata="";//科目数据
			String financial_year="";//年份
			String financial_rise_rate="";//年增长率
			String row_num="";//数据行
			String column_num="";//数据列
			int rownum=0;
			
			Row yearrows=sheet.getRow(1);//年所在的行
			Cell cell = yearrows.getCell(k);//列
			data=getCellValue(cell);//年所在的行数据
			
			financial_year=data;
			for(int i=2;i<=34;i++){							
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(1);//科目列
				Cell celldata = row.getCell(k);//列	
				
				rownum++;
				row_num=rownum+"";//行--数据
				column_num=k+"";//列--数据
				index_title=getCellValue(sheet.getRow(0).getCell(1));//标题
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				//判断数据是否正常
				if(!(k==7&&(i>30&&i<35))&&!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]的数据:["+financial_subdata+"]不是数值，请确认！");
					}
				}
			 sqlstr="insert into dbo.financial_resource_info(cust_id,uuid,index_title,financial_subject,financial_subdata,"+
					"financial_year,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_title+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"科目为："+getCellValue(titlecell)+"数据为："+getCellValue(celldata)+"行号为："+i);	
			}
			for(int i=38;i<=46;i++){
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(1);//科目列
				Cell celldata = row.getCell(k);//列	
				
				rownum++;
				row_num=rownum+"";//行--数据
				column_num=k+"";//列--数据
				index_title=getCellValue(sheet.getRow(36).getCell(1));//标题
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				//判断数据是否正常
				if(!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]的数据:["+financial_subdata+"]不是数值，请确认！");
					}
				}
			
			 sqlstr="insert into dbo.financial_resource_info(cust_id,uuid,index_title,financial_subject,financial_subdata,"+
					"financial_year,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_title+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"科目为："+getCellValue(titlecell)+"数据为："+getCellValue(celldata)+"行号为："+i);	
			}
			
			for(int i=50;i<=53;i++){
				Row row = sheet.getRow(i);//行
				Cell titlecell = row.getCell(1);//科目列
				Cell celldata = row.getCell(k);//列	
				
				rownum++;
				row_num=rownum+"";//行--数据
				column_num=k+"";//列--数据
				index_title=getCellValue(sheet.getRow(48).getCell(1));//标题
				financial_subject=getCellValue(titlecell);//科目
				financial_subdata=getCellValue(celldata);//科目数据
				//判断数据是否正常
				if(!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]的数据:["+financial_subdata+"]不是数值，请确认！");
					}
				}
				
			 sqlstr="insert into dbo.financial_resource_info(cust_id,uuid,index_title,financial_subject,financial_subdata,"+
					"financial_year,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_title+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"科目为："+getCellValue(titlecell)+"数据为："+getCellValue(celldata)+"行号为："+i);	
			}
	
		}
	}

}
