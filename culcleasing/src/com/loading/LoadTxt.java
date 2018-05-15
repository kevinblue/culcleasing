package com.loading;

import java.io.File;
import java.io.FileWriter;
import java.sql.ResultSet;

import dbconn.Conn;
import com.Tools;

public class LoadTxt {
	private String czy = "";

	private String exp_str = "";

	public void create_txt(String path) throws Exception {
		path+="\\upload\\txt\\"+getFileName();
		String info=getInfo();
		File file = new File(path);
		
		FileWriter fw=new   FileWriter(file,true);
		fw.write(info,0,info.length());   
		fw.flush();
		fw.close();
		
		String batch_no = getBatchNo();
		String curr_date = Tools.getSystemDate(0);
		Conn db=new Conn();
		String sqlstr="insert into export_no select '租金','"+curr_date+"','"+batch_no+"'";
		db.executeUpdate(sqlstr);
		db.close();
	}

	public String getInfo() throws Exception{
		String info="";
		
		String detail_no = getDetailNo();
		String batch_no = getBatchNo();
		String curr_date = Tools.getSystemDate(0);
		String sqlstr="select * from ebank_out_head where batch_no='"+batch_no+"' and consign_date='"+curr_date+"'";
		Conn db=new Conn();
		ResultSet rs=db.executeQuery(sqlstr);
		if(rs.next()){
			info+=Tools.getDBStr(rs.getString("busi_code"))+"|";
			info+=Tools.getDBStr(rs.getString("batch_no"))+"|";
			info+=Tools.getDBStr(rs.getString("flag"))+"|";
			info+="|";
			info+=Tools.getDBDateStr(rs.getString("consign_date"))+"|";
			info+=Tools.getDBStr(rs.getString("total_amt"))+"|";
			info+=Tools.getDBStr(rs.getString("total_number"))+"|";
			info+=Tools.getDBStr(rs.getString("id"))+"|";
			info +="\r\n";
		}rs.close();
		
		sqlstr="select * from ebank_out_body where detail_no='"+detail_no+"' and create_date='"+curr_date+"'";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			info+=Tools.getDBStr(rs.getString("detail_no"))+"|";
			info+="156|";
			info+=Tools.getDBStr(rs.getString("proj_amt"))+"|";
			info+="|";
			info+="|";
			info+=Tools.getDBStr(rs.getString("cust_acc"))+"|";
			info+=Tools.getDBStr(rs.getString("cust_name"))+"|";
			info+="|";
			info+=Tools.getDBStr(rs.getString("credent_type"))+"|";
			info+=Tools.getDBStr(rs.getString("credent_no"))+"|";
			info+="|";
			info+="|";
			info+=Tools.getDBStr(rs.getString("proj_id"))+"|";
			info+=Tools.getDBStr(rs.getString("proj_list"));
			info +="\r\n";
		}rs.close();
		db.close();
		return info;
	}
	public void insertsql(String path) throws Exception {
		if (!exp_str.equals("") && !czy.equals("")) {
			// 插入文件体
			
			String detail_no = getDetailNo();
			String curr_date = Tools.getSystemDate(0);
			String sqlstr = "insert into ebank_out_body(detail_no,creator,create_date,proj_id,proj_list,proj_amt,cust_acc,cust_name,credent_type,credent_no)";
			sqlstr += " select '" + detail_no + "','" + czy + "','" + curr_date
					+ "',a.* from (" + exp_str + ")a";
			Conn db = new Conn();
			db.executeUpdate(sqlstr);
			// 插入文件头
			
			String busi_code = getBusinessCode();
			String batch_no = getBatchNo();
			String flag = "0";
			String consign_date = curr_date;
			String total_amt = "0";
			String total_number = "0";
			//path+="\\upload\\txt\\"+getFileName();
			path="<a href=../../upload/txt/"+getFileName()+" target=_blank>"+getFileName()+"</a><br>";
			sqlstr = "select isnull(sum(proj_amt),0) as total_amt,count(*) as total_number from ebank_out_body where detail_no='"
					+ detail_no + "' and create_date='" + curr_date + "'";

			ResultSet rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				total_amt = Tools.getDBStr(rs.getString("total_amt"));
				total_number = Tools.getDBStr(rs.getString("total_number"));
			}
			rs.close();
			sqlstr = "insert into ebank_out_head(creator,down_link,busi_code,batch_no,flag,consign_date,total_amt,total_number)select '"+czy+"','"+path+"','"
					+ busi_code
					+ "','"
					+ batch_no
					+ "','"
					+ flag
					+ "','"
					+ consign_date + "'," + total_amt + "," + total_number;
			//System.out.println("sqlstr1========================="+sqlstr);
			db.executeUpdate(sqlstr);
			
			sqlstr = "update ebank_out_body set head_id=(select max(id) from ebank_out_head where batch_no='"
					+ batch_no
					+ "' and consign_date='"
					+ consign_date
					+ "') where detail_no='"
					+ detail_no
					+ "' and create_date='" + curr_date + "'";
			//System.out.println("sqlstr2========================="+sqlstr);
			db.executeUpdate(sqlstr);
			db.close();
		}
	}

	public String getDetailNo() {
		String detail_no = "";
		String business_code = getBusinessCode();
		detail_no = business_code.substring(4, 8)
				+ business_code.substring(business_code.length() - 4,
						business_code.length());
		detail_no += "000000" + getBatchNo();
		return detail_no;
	}

	public String getFileName() {
		String file_name = "DK" + getBusinessCode() + "_" + getHandlingDate()
				+ "_" + getBatchNo() + ".txt";
		return file_name;
	}

	public String getBusinessCode() {
		String business_code = "";// 商务代码
		String sqlstr = "select * from ifelc_conf_dictionary where name='busi_code'";
		Conn db = new Conn();
		try {
			ResultSet rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				business_code = Tools.getDBStr(rs.getString("title"));
			}
			rs.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close();
		}
		return business_code;
	}

	public String getHandlingDate() {
		String handling_date = "";// 处理日期
		handling_date += Tools.getSystemDate(0).substring(2)
				.replaceAll("-", "");
		return handling_date;
	}

	public String getBatchNo() {
		String batch_no = "";// 批次号
		String sqlstr = "select count(*)+1 as no from export_no where export_type='租金' and export_date='"
				+ Tools.getSystemDate(0) + "'";
		Conn db = new Conn();
		try {
			ResultSet rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				batch_no += Tools.getDBStr(rs.getString("no"));
			}
			rs.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close();
		}
		return batch_no;
	}

	public void createTxt() {

	}

	public String getCzy() {
		return czy;
	}

	public void setCzy(String czy) {
		this.czy = czy;
	}

	public String getExp_str() {
		return exp_str;
	}

	public void setExp_str(String exp_str) {
		this.exp_str = exp_str;
	}

	public static void main(String[] args) {
		LoadTxt txt = new LoadTxt();
	}
}
