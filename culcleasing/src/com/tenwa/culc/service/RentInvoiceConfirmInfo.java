package com.tenwa.culc.service;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.tenwa.culc.util.ERPDataSource;
public class RentInvoiceConfirmInfo {
	/**
	 * ���Ʊȷ��--�޸�״̬������dowanload��
	 * @param plid_list
	 * @param rent_list_list
	 * @return
	 */
	public  String  confirmRentInvoice(String id_list,String userId){	
		System.out.println("��Ʊȷ�Ͽ�ʼ");
		String message="";
		message=updateRentInvoice(id_list, userId);
		return  message;
	}
	/**
	 * ����fund_invoice_info��ͬʱ����Ӧ�ļ�¼���뵽fund_invoice_dowanload_info��
	 * @param id_list
	 * @param num
	 * @return
	 * @throws Exception
	 */
	public String updateRentInvoice(String id_list,String userId){
		String [] id_arr=id_list.split("#");
		String message="";
		//Conn conn=null;
		ERPDataSource conn=null;
		Connection conet=null;
		Statement st=null;
		try {
			//conn=new Conn();
			conn=new ERPDataSource();			
			conet=conn.getConnection();
			conet.setAutoCommit(false);
			st=conet.createStatement();	
			BigDecimal number=getDateNum();//��ʼ����һ����ʼ�Ĵ�����
			for(int i=0;i<id_arr.length;i++){
				System.out.println("��Ʊȷ�ϸ��¿�ʼ");
				getUpdateSql(id_arr[i], st);//���·�Ʊ�����
				System.out.println("��Ʊȷ�ϲ��뿪ʼ");
				insertRentInvoice(id_arr[i], st, userId,number,i);//���뵽��Ʊ��
				System.out.println("��Ʊȷ��һ�ν���");
			}
			conet.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conet.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}	
			message=e.getMessage();
		}finally{
			conn.close();
		}
		return message;
	}
	/**
	 * ��ȡ���·�Ʊ������SQL
	 * @param id_list
	 * @param st
	 */
	public void getUpdateSql(String id_list, Statement st)throws Exception{
		System.out.println("����first");
		String sql="update  rent_invoice_info  set  invoice_status='3' where id='"+id_list+"'";
			try {
				st.clearBatch();
				st.executeUpdate(sql);
				st.clearBatch();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
				throw new Exception(getErrorMessage(id_list, st));
			}
	}
	/**
	 * ִ�в���rent_invoice_download_info������ÿ�����ݣ�һ��һ���Ĳ�
	 * @param id_list
	 * @return
	 * @throws Exception
	 */
	public String insertRentInvoice(String id_list,Statement st,String userId,BigDecimal number,int num)throws Exception{
		System.out.println("������俪ʼ");
		String message="";
		ResultSet rs=null;
		String sql="select *  from vi_rent_receipt_confirm where id='"+id_list+"'";
		try {
			rs=st.executeQuery(sql);
			st.clearBatch();
			getDownloadSql(rs, st, userId,number,num);	
			st.executeBatch();
		} catch (Exception e) {
			e.printStackTrace();			
			throw new Exception(getErrorMessage(id_list, st));
		}
		return message;
	}
	/**
	 * ��ȡ�����SQL��ִ��SQL���
	 * @param rs
	 * @param st
	 * @return
	 * @throws Exception
	 */
	public void getDownloadSql(ResultSet rs,Statement st,String userId,BigDecimal number,int num)throws Exception{
		String sql="";
		while(rs.next()){
			System.out.println(rs.getString("invoice_money"));
			BigDecimal invoice_money=new BigDecimal(rs.getString("invoice_money").replaceAll(",", ""));
			System.out.println(invoice_money);
			BigDecimal stand_normal=new BigDecimal("1000000");
			BigDecimal stand_special=new BigDecimal("100000");
			String tax_type_invoice=rs.getString("tax_type_invoice");
			if("��ֵ˰��ͨ��Ʊ".equals(tax_type_invoice)){
				sql=setInvoiceMoney(rs, invoice_money, stand_normal,number,num,userId);
			}else{
				sql=setInvoiceMoney(rs, invoice_money, stand_special,number,num,userId);
			}
			System.out.println("sqlaaaaaaaaaaaaaaaaaaa:"+sql);
			st.addBatch(sql);
			
		}	
		st.executeBatch();
	}
	/**
	 * ���ò��뷢Ʊ���н��
	 * @param rs
	 * @param sql
	 * @param invoice_money
	 * @param stand_money
	 * @throws Exception
	 */
	public String  setInvoiceMoney(ResultSet rs,BigDecimal invoice_money,
			BigDecimal stand_money,BigDecimal  number,int num,String userId )throws Exception{
		System.out.println("�������ò������Ľ��");
		BigDecimal demo_money=invoice_money;
		String create_datestr=getNowDate();
		String  sql="";
		int count=0;
		while(true){
			System.out.println("ѭ����ʼ");
			count+=1;
			//number=number.add(new BigDecimal("1"));
			if(demo_money.compareTo(stand_money)>0){
				sql+="insert  into rent_invoice_download_info(rent_invoice_id,out_no,invoice_money,invoice_type,";
				sql+="tax_reg_code,tax_addr,tax_bank,tax_acc,tax_tel,tax_rate,export_user,export_date,is_export) values(";
				sql+="'"+rs.getString("id")+"',";
				sql+="'"+"PR"+number.toString()+num+count+"',";
				sql+="'"+stand_money.toString()+"',";
				sql+="'"+rs.getString("tax_type_invoice")+"',";
				sql+="'"+rs.getString("tax_payer_no")+"',";
				sql+="'"+rs.getString("address")+"',";
				sql+="'"+rs.getString("bank_name")+"',";
				sql+="'"+rs.getString("bank_no")+"',";
				sql+="'"+rs.getString("tel")+"',";
				sql+="'"+rs.getString("tax_rate")+"',";
				sql+="'"+userId+"',";
				sql+="'"+create_datestr+"',";
				sql+="'"+"0"+"')";
				
			}else{
				sql+="insert  into rent_invoice_download_info(rent_invoice_id,out_no,invoice_money,invoice_type,";
				sql+="tax_reg_code,tax_addr,tax_bank,tax_acc,tax_tel,tax_rate,export_user,export_date,is_export) values(";
				sql+="'"+rs.getString("id")+"',";
				sql+="'"+"PR"+number.toString()+num+count+"',";
				sql+="'"+demo_money.toString()+"',";
				sql+="'"+rs.getString("tax_type_invoice")+"',";
				sql+="'"+rs.getString("tax_payer_no")+"',";
				sql+="'"+rs.getString("address")+"',";
				sql+="'"+rs.getString("bank_name")+"',";
				sql+="'"+rs.getString("bank_no")+"',";
				sql+="'"+rs.getString("tel")+"',";
				sql+="'"+rs.getString("tax_rate")+"',";
				sql+="'"+userId+"',";
				sql+="'"+create_datestr+"',";
				sql+="'"+"0"+"')";
			}	
			System.out.println("ѭ��һ�ν���");
			
			if(demo_money.compareTo(stand_money)<=0){
				break;
			}
			demo_money=demo_money.subtract(stand_money);
			
		}
		return sql;

	}
	
	/**
	 * ��ȡ��ǰʱ��  --"yyyy-MM-dd HH:mm:ss"
	 * @return
	 */
	public  String  getNowDate() {
		   Date datenow = new Date();
		   SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   String dateString = formatter.format(datenow);		
		   return dateString;
	
		}
	/**
	 * ��ȡ��ǰʱ���Ӧ������
	 */
	  public  BigDecimal getDateNum(){
			String date=getNowDate();
			String regEx="[^0-9]";  
			Pattern p = Pattern.compile(regEx);  
			Matcher m = p.matcher(date);  
			String date_target=m.replaceAll("").trim();
			return new BigDecimal(date_target+"000");
	  }
	/**
	 * ��ȡ��Ʊȷ��--ʧ�ܵ���Ϣ
	 * @param id_list
	 * @return
	 * @throws Exception
	 */
	public String getErrorMessage(String id_list,Statement st){
		String message="";
		ResultSet rs=null;
		String sql="select *  from vi_rent_receipt_confirm where id='"+id_list+"'";
		try {
			st.clearBatch();
			rs=st.executeQuery(sql);
			while(rs.next()){
				message="������"+rs.getString("begin_id")+"��"+rs.getString("rent_list")+"��"+
				rs.getString("rent_type")+"ȷ��ʧ��!";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message=e.getMessage();
		}
		return message;
	}
	
	
	
	/**
	 * ���Ʊ�˻�
	 * @param id_list
	 * @param plid_list
	 * @param rent_list_list
	 * @return
	 */
	public  String  backRentInvoice(String id_list,String plid_list,String rent_list_list){	
		System.out.println("��Ʊ�˻ؿ�ʼ");
		String [] id_arr=id_list.split("#");
		String [] plid_arr=plid_list.split("#");
		String message="";
		String checkFlag="";
		//Conn conn=null;ERPDataSource
		ERPDataSource conn=null;
		Connection conet=null;
		Statement st=null;
		try {
			//conn=new Conn();
			conn=new ERPDataSource();
			conet=conn.getConnection();
			conet.setAutoCommit(false);
			st=conet.createStatement();	
			//ִ�����Ʊ�˻�ʱ����У�����״̬
			checkFlag=checkAllRentInvoice(plid_list, rent_list_list);
			if(checkFlag.isEmpty()){//Ϊ��ʱ�Ż�����˻ز���
				for(int i=0;i<id_arr.length;i++){
					System.out.println("��Ʊ�˻ظ��¿�ʼ");
					getBackUpdateSql(id_arr[i],plid_arr[i], st);//���·�Ʊ�����
				}
			}else{
				message=checkFlag;
			}
			conet.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conet.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}	
			message=e.getMessage();
		}finally{
			conn.close();
		}
		return message;
	}
	public void getBackUpdateSql(String id_list,String plid_list, Statement st)throws Exception{
		System.out.println("����first");
		String sql="update  rent_invoice_info  set  invoice_status='1' where contract_fund_rent_plan='"+plid_list+"'";
			try {
				st.clearBatch();
				st.executeUpdate(sql);
				st.clearBatch();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
				throw new Exception(getErrorMessage(id_list, st));
			}
	}
	/**
	 * У�����ñ��ڴ��Ƿ��ѵ��������������˻�
	 * @param plid_list
	 * @param rent_list_list
	 * @return
	 */
	public  String  checkAllRentInvoice(String plid_list,String rent_list_list){	
		String message="";
		String flag="";
		String [] plid_arr=plid_list.split("#");
		String [] rent_list_arr=rent_list_list.split("#");
		for(int i=0;i<plid_arr.length;i++){
			try {
				flag=this.checkRentInvoice(plid_arr[i], rent_list_arr[i]);
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
	public String checkRentInvoice(String plid,String  rent_list)throws Exception{
		System.out.println("У�����ʼ");//ͬһ�ƻ�ͬһ�ڴ��µĲ�ͬ������һ����ȷ�ϣ��ѵ��������򱾴����벻���˻أ�ֻ��ȷ��
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
				if("��ȷ��".equals(invoice_statues)){
					message="������"+rs.getString("begin_id")+"�ĵ�"+rs.getString("rent_list")+"��"+
					rs.getString("rent_type")+"��ȷ�ϣ��������벻���˻�!";
					break;
				}
			}
			System.out.println("У��������");
			System.out.println("У�����message:"+message);
			return message;
			
		} catch (Exception e) {
			e.printStackTrace();			
			throw new Exception(e.getMessage());
		}finally{			
			conn.close();
			
		}
		
	}
	
}
