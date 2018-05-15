package com.service;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.container.ResultValue;

import dbconn.Conn;

public class InterEvidence {   

	public ResultValue getInterEvidence(String sql){
		//sql = "select * from inter_evidence_info where status='ÓÐÐ§' and exp_flag='·ñ' order by evidence_number";
		Conn db = new Conn();
		ResultSet result = null;
		ResultValue rv = null;
		int iColCount=-1;
		int iRowCount = 0;
		try{
			result = db.executeQuery(sql);
			result.last();
			int rowcount = result.getRow();
			result.beforeFirst();
			ResultSetMetaData rsmd = result.getMetaData();
			iColCount = rsmd.getColumnCount();
			rv = new ResultValue(rowcount,iColCount);
			rv.setColsize(iColCount);
			for(int i=0;i<iColCount;i++){
				rv.setRowName(i, rsmd.getColumnName(i+1));
			}
			while(result.next()){
				for(int i=0;i<iColCount;i++){
					rv.setResultData(iRowCount, i, result.getString(i+1));
				}
				iRowCount++;
			}
		}catch(Exception e){
			System.out.println(e);
		}finally{
			try{
				if(result!=null){
					result.close();
				}
			}catch(SQLException sqle){
				
			}
			if(db!=null){
				db.close();
			}
		}
		return rv;
	}
	
	public void update(String sql){
		Conn db = new Conn();
		try{
			db.executeUpdate(sql);
		}catch(Exception e){
			System.out.println(e);
		}finally{
			if(db!=null){
				db.close();
			}
		}
	}
	public static void main(String[] args) {
		InterEvidence ie = new InterEvidence();
		ResultValue rv=ie.getInterEvidence("select * from fund_rent_income");
		
	}
}
