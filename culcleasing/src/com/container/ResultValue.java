package com.container;

import java.sql.ResultSet;

/**
 * @author HAIFENG.ZHANG  2008-01-03
 */
public class ResultValue {

	private String[][] resultData;
	
	private String[] rowName;
	
	private int colsize;
	
	private String[] primaryKey;
	
	private int cursor;
	
	public ResultValue(){
		resultData = new String[10][10];
		rowName = new String[10];
		primaryKey = new String[10];
		cursor = 0;
	}
	
	public ResultValue(int iRow,int iCols){
		resultData = new String[iRow][iCols];
		rowName = new String[iCols];
		primaryKey = new String[iRow];
		cursor = 0;
	}
	
	public boolean next(){
		if(cursor<resultData.length){
			cursor++;
			return true;
		}
		return false;
	}
	
	public String getValue(String varName){
		int iFlag = -1;
		for(int i=0;i<rowName.length;i++){
			if(varName.equals(rowName[i])){
				iFlag = i;break;
			}
		}
		if(iFlag!=-1){
			return resultData[cursor-1][iFlag];
		}else{
			return null;
		}
	}
	
	public String getValue(int iVar){
		return resultData[cursor-1][iVar];
	}
	
	public String getValue(int iRow,int iVar){
		return resultData[iRow][iVar];
	}
	
	public String getValue(int iRow,String varName){
		int iFlag = -1;
		for(int i=0;i<rowName.length;i++){
			if(varName.equals(rowName[i])){
				iFlag = i;break;
			}
		}
		if(iFlag!=-1){
			return resultData[iRow][iFlag];
		}else{
			return null;
		}
	}
	
	public void setResultData(int iRow,int iVar,String value){
		resultData[iRow][iVar] = value;
		if(iVar==0){
			primaryKey[iRow] = value;
		}
	}
	
	public void setRowName(int iVar,String value){
		rowName[iVar] = value;
	}
	
	public int size(){
		return resultData.length;
	}

	public int getColsize() {
		return colsize;
	}

	public void setColsize(int colsize) {
		this.colsize = colsize;
	}
	
	public boolean isExist(String value){
		boolean flag = false;
		for(int i=0;i<primaryKey.length;i++){
			if(value.equals(primaryKey[i])){
				flag = true;break;
			}
		}
		return flag;
	}
	
	public boolean isExistValue(){
		boolean flag = false;
		if(resultData.length>0){
			flag = true;
		}
		return flag;
	}
	
	public void clear(){
		resultData = null;
		rowName=null;
		primaryKey=null;
	}
	
}
