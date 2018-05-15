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
		System.out.println("�ϴ�servlet���ܷ���������·��+�ͻ�ID+�û�ID("+path+","+custId+","+userId+")");
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
			String uuid = UUID.randomUUID().toString().replace("-", "");//�������кţ�Ϊ3�����񱨱�Ĺ�ͬ�ֶ�
			executeSqlStr(wb,custId, userId, is,uuid);
			System.out.println("����excle�����ɹ�������");
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
			//��ɾ���󱣴浼������
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
			System.out.println("ִ��ɾ��������������");
		} catch (Exception e) {
			e.printStackTrace();			
			System.out.println("������Ϣe.getMessage()"+e.getMessage());
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
					System.out.println("���Ͳ�һ�²���aaaaaaaaaa");
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
								.getNumericCellValue());// ��ȡ��DATE����
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
	 * ��ȡ��ǰʱ�� 
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
		String year=getNowYear()+"��";
		String sql="delete from dbo.financial_base_info  where cust_id="+
		"'"+custId+"' and  financial_year  = '"+year+"'";
		System.out.println("��ɾ���ͻ�������Ϣ��"+sql);
		st.addBatch(sql);
		//st.executeBatch();
	}
	public static void deleteFinancialManage(Sheet sheet, String custId,Statement st) throws Exception {
		String sqlstr="";
		String data="";
		for(int k=1;k<5;k++){
			Row yearrows=sheet.getRow(1);//�����ڵ���
			Cell cell = yearrows.getCell(k);//��
			data=getCellValue(cell);//�����ڵ�������
			sqlstr="delete from dbo.financial_manage_info  where cust_id='"+custId+"'"+
			"and financial_year  = '"+data+"'";
			System.out.println("��ɾ���ͻ�����Ӫ��Ϣ��"+sqlstr);
			st.addBatch(sqlstr);
		}	
		//st.executeBatch();
	}
	
	public static void deleteFinancialResource(Sheet sheet, String custId,Statement st) throws Exception {
		String sqlstr="";
		String data="";
		for(int k=2;k<8;k++){	
//			if(k==5){
				Row yearrows=sheet.getRow(1);//�����ڵ���
				Cell cell = yearrows.getCell(k);//��
				data=getCellValue(cell);//�����ڵ�������
				sqlstr="delete from dbo.financial_resource_info  where cust_id='"+custId+"'"+
				"and financial_year  = '"+data+"'";
				System.out.println("��ɾ���ͻ��ط�������Ϣ��"+sqlstr);
				st.addBatch(sqlstr);
				
/*			}else{
				Row yearrows=sheet.getRow(1);//�����ڵ���
				Cell cell = yearrows.getCell(k);//��
				data=getCellValue(cell);//�����ڵ�������
				sqlstr="delete from dbo.financial_resource_info where cust_id='"+custId+"'"+
				"and financial_year like '%"+data.substring(0, 5)+"%'";
				System.out.println("��ɾ���ͻ��ط�������Ϣ��"+sqlstr);
				st.addBatch(sqlstr);
			}*/
		}	
		//st.executeBatch();
	}
	public static String saveFinancialBase(Sheet sheet, String custid,String userid,
			InputStream is,String uuid,Statement st) throws Exception {
		String sql = "";// ��Ҫִ�е�SQL--���»��߲������
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
		//�ж������Ƿ�Ϊ��ֵ
		if(!Tools.isDouble(total_population)&&!total_population.isEmpty()){
			throw new Exception("[�������˿�(����)]����ֵ:["+total_population+"]������ֵ����ȷ�ϣ�");
		}
		if(!Tools.isDouble(financial_gdp)&&!financial_gdp.isEmpty()){
			throw new Exception("[[GDP����Ԫ��]����ֵ:["+financial_gdp+"]������ֵ����ȷ�ϣ�");
		}
		if(!Tools.isDouble(outstand_principal)&&!outstand_principal.isEmpty()){
			throw new Exception("[�����ۼ�δ��������Ԫ��]����ֵ:["+outstand_principal+"]������ֵ����ȷ�ϣ�");
		}
		if(!Tools.isDouble(towner_disposable_inconme)&&!towner_disposable_inconme.isEmpty()){
			throw new Exception("[��������֧�����루Ԫ��]����ֵ:["+towner_disposable_inconme+"]������ֵ����ȷ�ϣ�");
		}
		if(!Tools.isDouble(farmer_inconme)&&!farmer_inconme.isEmpty()){
			throw new Exception("[ũ�����루Ԫ��]����ֵ:["+farmer_inconme+"]������ֵ����ȷ�ϣ�");
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
		String financial_year=getNowYear()+"��";
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
		StringBuffer sql = new StringBuffer();// ��Ҫִ�е�SQL--���»��߲������
		sql.append("insert into dbo.financial_manage_info(cust_id,uuid,index_meaning,financial_subject,financial_subdata,"+
		"financial_year,financial_average,row_num,column_num,creator,create_date,modify_date,modificator) values");
		int sumRowNum=92;//������
		String data="";
		int indexkey=12;//ָ��������
		for(int k=1;k<5;k++){
			Row yearrows=sheet.getRow(1);//�����ڵ���
			Cell cell = yearrows.getCell(k);//��
			data=getCellValue(cell);//�����ڵ�������
			
			String index_meaning="";//ָ�꺬��--ǰ92��û��ֵ
			String financial_subject="";//��Ŀ
			String financial_subdata="";//��Ŀ����
			String financial_year=getCellValue(cell);//���
			String financial_average="";//ƽ��ֵ--ǰ92��û��ֵ
			String row_num="";//������
			String column_num="";//������
			
			for(int i=2;i<=sumRowNum;i++){
				Row row = sheet.getRow(i);//��
				Cell titlecell = row.getCell(0);//��Ŀ��
				Cell celldata = row.getCell(k);//��	
				
				row_num=i-1+"";//��--����
				column_num=k+"";//��--����
				financial_subject=getCellValue(titlecell);//��Ŀ
				financial_subdata=getCellValue(celldata);//��Ŀ����
				if(!"ҵ��ͳ������".equals(financial_subject)&&!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]������:["+financial_subdata+"]������ֵ����ȷ�ϣ�");
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
				//System.out.println(data+"��ĿΪ��"+getCellValue(titlecell)+"����Ϊ��"+getCellValue(celldata)+"�к�Ϊ��"+i);
				if(i==sumRowNum){					
					String index_meaningstr="";
                    for(int t=1;t<28;t++){
                    	Row rows = sheet.getRow(t+1);//��
                    	
                    	Cell keytitle1 = rows.getCell(6);//ָ����  
                    	Cell keytitle2 = rows.getCell(7);//ָ����  
                    	Cell keytitle3 = rows.getCell(indexkey);//ָ���� ƽ��ֵ
        				Cell ratecelldata = rows.getCell(7+k);//��
        				
        				if(getCellValue(keytitle1).length()!=0){
        					index_meaningstr=getCellValue(keytitle1);
        				}
        				row_num=t+91+"";//��--����
        				column_num=k+7+"";//��--����
        				index_meaning=index_meaningstr;//ָ��
        				financial_year=data;//���
        				financial_subject=getCellValue(keytitle2);//��Ŀ
        				financial_subdata=getCellValue(ratecelldata);//����
        				financial_average=getCellValue(keytitle3);//ƽ��ֵ
        				
        				System.out.println("ƽ��ֵ��"+financial_average+";���ͣ�"+keytitle3.getCellType());
    					if(!Tools.isDouble(financial_subdata)&&!financial_subdata.isEmpty()){
    						throw new Exception("["+financial_subject+"]������:["+financial_subdata+"]������ֵ����ȷ�ϣ�");
    					}
    					if(!Tools.isDouble(financial_average)&&!financial_average.isEmpty()){
    						throw new Exception("["+financial_subject+"]��ƽ��ֵ:["+financial_average+"]������ֵ����ȷ�ϣ�");
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
        			//System.out.println(data+"��ĿΪ1��"+index_meaning+"��Ŀ2��"+getCellValue(keytitle2)+"����Ϊ��"+getCellValue(ratecelldata)+"�к�Ϊ��"+(t+i)+"ƽ��ֵ"+getCellValue(keytitle3));
                    	
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
		int sumRowNum1=34;//������
		String data="";
		int indexkey=7;//ָ��������
		for(int k=2;k<8;k++){	
			String index_title="";//����
			String financial_subject="";//��Ŀ
			String financial_subdata="";//��Ŀ����
			String financial_year="";//���
			String financial_rise_rate="";//��������
			String row_num="";//������
			String column_num="";//������
			int rownum=0;
			
			Row yearrows=sheet.getRow(1);//�����ڵ���
			Cell cell = yearrows.getCell(k);//��
			data=getCellValue(cell);//�����ڵ�������
			
			financial_year=data;
			for(int i=2;i<=34;i++){							
				Row row = sheet.getRow(i);//��
				Cell titlecell = row.getCell(1);//��Ŀ��
				Cell celldata = row.getCell(k);//��	
				
				rownum++;
				row_num=rownum+"";//��--����
				column_num=k+"";//��--����
				index_title=getCellValue(sheet.getRow(0).getCell(1));//����
				financial_subject=getCellValue(titlecell);//��Ŀ
				financial_subdata=getCellValue(celldata);//��Ŀ����
				//�ж������Ƿ�����
				if(!(k==7&&(i>30&&i<35))&&!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]������:["+financial_subdata+"]������ֵ����ȷ�ϣ�");
					}
				}
			 sqlstr="insert into dbo.financial_resource_info(cust_id,uuid,index_title,financial_subject,financial_subdata,"+
					"financial_year,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_title+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"��ĿΪ��"+getCellValue(titlecell)+"����Ϊ��"+getCellValue(celldata)+"�к�Ϊ��"+i);	
			}
			for(int i=38;i<=46;i++){
				Row row = sheet.getRow(i);//��
				Cell titlecell = row.getCell(1);//��Ŀ��
				Cell celldata = row.getCell(k);//��	
				
				rownum++;
				row_num=rownum+"";//��--����
				column_num=k+"";//��--����
				index_title=getCellValue(sheet.getRow(36).getCell(1));//����
				financial_subject=getCellValue(titlecell);//��Ŀ
				financial_subdata=getCellValue(celldata);//��Ŀ����
				//�ж������Ƿ�����
				if(!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]������:["+financial_subdata+"]������ֵ����ȷ�ϣ�");
					}
				}
			
			 sqlstr="insert into dbo.financial_resource_info(cust_id,uuid,index_title,financial_subject,financial_subdata,"+
					"financial_year,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_title+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"��ĿΪ��"+getCellValue(titlecell)+"����Ϊ��"+getCellValue(celldata)+"�к�Ϊ��"+i);	
			}
			
			for(int i=50;i<=53;i++){
				Row row = sheet.getRow(i);//��
				Cell titlecell = row.getCell(1);//��Ŀ��
				Cell celldata = row.getCell(k);//��	
				
				rownum++;
				row_num=rownum+"";//��--����
				column_num=k+"";//��--����
				index_title=getCellValue(sheet.getRow(48).getCell(1));//����
				financial_subject=getCellValue(titlecell);//��Ŀ
				financial_subdata=getCellValue(celldata);//��Ŀ����
				//�ж������Ƿ�����
				if(!financial_subdata.isEmpty()){
					if(!Tools.isDouble(financial_subdata)){
						throw new Exception("["+financial_subject+"]������:["+financial_subdata+"]������ֵ����ȷ�ϣ�");
					}
				}
				
			 sqlstr="insert into dbo.financial_resource_info(cust_id,uuid,index_title,financial_subject,financial_subdata,"+
					"financial_year,row_num,column_num,creator,create_date,modify_date,modificator)"+
					"values('"+custid+"','"+uuid+"','"+index_title+"','"+financial_subject+"','"+financial_subdata+
					"','"+financial_year+"','"+row_num+"','"+column_num+"','"+userid+"','"+create_datestr+"',"+null+","+null
					+")";
				 st.addBatch(sqlstr);	
				//System.out.println(data+"��ĿΪ��"+getCellValue(titlecell)+"����Ϊ��"+getCellValue(celldata)+"�к�Ϊ��"+i);	
			}
	
		}
	}

}
