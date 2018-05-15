package com.service;

import java.util.ArrayList;

import com.Tools;
import com.container.ResultValue;

public class SMSThread extends Thread{
	
	private SMSService SMSservice;
	private String searchKey;
	private String searchType;
	private String searchDel;
	private String searchPhone;
	private String searchAddTime;
	private String searchActualTime;
	private String searchPerformTime;
	private String count;
	private String searchAddTimeBegin;
	private String searchAddTimeEnd;
	private String searchActualTimeBegin;
	private String searchActualTimeEnd;
	private String searchPerformTimeBegin;
	private String searchPerformTimeEnd;
	
	public String getSearchActualTimeBegin() {
		return searchActualTimeBegin;
	}

	public void setSearchActualTimeBegin(String searchActualTimeBegin) {
		this.searchActualTimeBegin = searchActualTimeBegin;
	}

	public String getSearchActualTimeEnd() {
		return searchActualTimeEnd;
	}

	public void setSearchActualTimeEnd(String searchActualTimeEnd) {
		this.searchActualTimeEnd = searchActualTimeEnd;
	}

	public String getSearchAddTimeBegin() {
		return searchAddTimeBegin;
	}

	public void setSearchAddTimeBegin(String searchAddTimeBegin) {
		this.searchAddTimeBegin = searchAddTimeBegin;
	}

	public String getSearchAddTimeEnd() {
		return searchAddTimeEnd;
	}

	public void setSearchAddTimeEnd(String searchAddTimeEnd) {
		this.searchAddTimeEnd = searchAddTimeEnd;
	}

	public String getSearchPerformTimeBegin() {
		return searchPerformTimeBegin;
	}

	public void setSearchPerformTimeBegin(String searchPerformTimeBegin) {
		this.searchPerformTimeBegin = searchPerformTimeBegin;
	}

	public String getSearchPerformTimeEnd() {
		return searchPerformTimeEnd;
	}

	public void setSearchPerformTimeEnd(String searchPerformTimeEnd) {
		this.searchPerformTimeEnd = searchPerformTimeEnd;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public void run(){
		
		try{
			ResultValue rv = readSQL();
			
			while(rv.next()){
				performSMS(rv.getValue("id"),rv.getValue("mobile_phone").replaceAll("-", ""),Tools.smsReplace(rv.getValue("sms_message")));
				sleep(500);
			}
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	public ResultValue readSQL(){
		String strwhere = "";
		strwhere=" where 1=1 ";
		if(searchKey!=null&&!searchKey.equals("")){
			if(searchKey.equals("全部")){
				strwhere +=" and perform_flag<=0 ";
			}else if(searchKey.equals("待发送")){
				strwhere +=" and perform_flag<=0 ";
			}else if(searchKey.equals("发送中")){
				strwhere +=" and perform_flag=0 and perform_time is not null and actual_time is null ";
			}else if(searchKey.equals("未发送")){
				strwhere +=" and perform_flag=0 and perform_time is null";
			}else {
				strwhere +=" and perform_flag<=0 ";
			}
		}else{
			strwhere +=" and perform_flag<=0 ";
		}
		if(searchType!=null&&!searchType.equals("")){
			strwhere +=" and type='"+searchType+"'";
		}
		strwhere +=" and delete_flag='0'";
		if(searchPhone!=null&&!searchPhone.equals("")){
			strwhere +=" and mobile_phone like '%"+searchPhone+"%'";
		}
		if(searchAddTimeBegin!=null&&!searchAddTimeBegin.equals("")){
			strwhere +=" and convert(char(10),add_time,21) >= '"+searchAddTimeBegin+"'";
		}
		if(searchAddTimeEnd!=null&&!searchAddTimeEnd.equals("")){
			strwhere +=" and convert(char(10),add_time,21) <= '"+searchAddTimeEnd+"'";
		}
		if(searchActualTimeBegin!=null&&!searchActualTimeBegin.equals("")){
			strwhere +=" and convert(char(10),actual_time,21) >= '"+searchActualTimeBegin+"'";
		}
		if(searchActualTimeEnd!=null&&!searchActualTimeEnd.equals("")){
			strwhere +=" and convert(char(10),actual_time,21) <= '"+searchActualTimeEnd+"'";
		}
		if(searchPerformTimeBegin!=null&&!searchPerformTimeBegin.equals("")){
			strwhere +=" and convert(char(10),perform_time,21) >= '"+searchPerformTimeBegin+"'";
		}
		if(searchPerformTimeEnd!=null&&!searchPerformTimeEnd.equals("")){
			strwhere +=" and convert(char(10),perform_time,21) <= '"+searchPerformTimeEnd+"'";
		}
		String sql = "";
		InterEvidence ie = new InterEvidence();
		sql = "select count(*) as count from sms_info "+strwhere;
		System.out.println(sql);
		ResultValue rvCount = ie.getInterEvidence(sql);
		if(rvCount.next()){
			count = rvCount.getValue("count");
		}
		sql = "select * from sms_info "+strwhere;
		System.out.println(sql);
		ResultValue rv = ie.getInterEvidence(sql);
		sql = "update sms_info set perform_time = getdate() "+strwhere;
		System.out.println(sql);
		ie.update(sql);
		return rv;
	}
	
	public void performSMS(String id,String mobile,String mesage){
		int int_return = sendSMS(mobile,mesage);
		updateSQL(String.valueOf(id),String.valueOf(int_return));
		//updateSQL(String.valueOf(id),String.valueOf(123456));
	}
	
	public void updateSQL(String id,String preform_flag){
		String sql = "";
		sql = "update sms_info set perform_flag="+preform_flag+",actual_time=getdate() where id="+id+" and delete_flag='0'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ie.update(sql);
	}
	
	public int sendSMS(String mobile,String message){
		SMSservice = new SMSService();
		return SMSservice.sendMessage(mobile, message);
	}

	public String getSearchActualTime() {
		return searchActualTime;
	}

	public void setSearchActualTime(String searchActualTime) {
		this.searchActualTime = searchActualTime;
	}

	public String getSearchAddTime() {
		return searchAddTime;
	}

	public void setSearchAddTime(String searchAddTime) {
		this.searchAddTime = searchAddTime;
	}

	public String getSearchDel() {
		return searchDel;
	}

	public void setSearchDel(String searchDel) {
		this.searchDel = searchDel;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	public String getSearchPerformTime() {
		return searchPerformTime;
	}

	public void setSearchPerformTime(String searchPerformTime) {
		this.searchPerformTime = searchPerformTime;
	}

	public String getSearchPhone() {
		return searchPhone;
	}

	public void setSearchPhone(String searchPhone) {
		this.searchPhone = searchPhone;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	

}
