package com.tenwa.leasing.util.excel;

import java.io.File;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

 
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class UploadExecl {
	
	public UploadExecl(){
		HSSFWorkbook wb = null;
		HSSFSheet templateSheet = null;
		HSSFRow templateRow = null;
		HSSFCell cell = null;
		String [][]obj = null;
		String[] rowName = null;
		boolean flag=true;
		errMsg = "";
	}

	public void setExecl(String fileName) {
		flag = true;
		if(fileName!=null){
			File file = new File(fileName);
			FileInputStream fis = null;
			try{
			fis = new FileInputStream(file);
			wb = new HSSFWorkbook(fis);
			}catch(Exception e){
				System.out.println(e);
			}
			templateSheet = wb.getSheetAt(0);
			
			
			int iLastRow = templateSheet.getPhysicalNumberOfRows();
			int iLastCol = templateSheet.getRow(0).getPhysicalNumberOfCells();
			obj = new String[iLastRow-1][iLastCol];
			rowName = new String[iLastCol];
			HSSFRow firstRow = templateSheet.getRow(0);
			
			for(int i=0;i<iLastCol;i++){
				
				rowName[i] = firstRow.getCell(i).getStringCellValue();
			}
			for (int j=1; j<iLastRow;j++){
				templateRow=templateSheet.getRow(j);
				for(int k=0;k<iLastCol;k++){
					
					cell = templateRow.getCell(k);
					if(cell!=null){
						
						
						
						String strValue = "";
						int iType = cell.getCellType();
						if(iType==HSSFCell.CELL_TYPE_STRING){
							strValue = cell.getStringCellValue();
						}else if(iType==HSSFCell.CELL_TYPE_NUMERIC){
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								strValue = dateToString(cell.getDateCellValue(), "yyyy-MM-dd HH:mm");
							}else{
								strValue = String.valueOf(cell.getNumericCellValue());
							}
						}else if(iType == HSSFCell.CELL_TYPE_FORMULA ){
							
							System.out.println("==:"+cell.getCellFormula());
							System.out.println("==:"+ String.valueOf(cell.getRichStringCellValue()));
							
							
							strValue = String.valueOf(cell.getCellFormula());
						}else if (iType == HSSFCell.CELL_TYPE_BOOLEAN){
							strValue = String.valueOf(cell.getBooleanCellValue());
						}else if (iType == HSSFCell.CELL_TYPE_BLANK){
							strValue = String.valueOf("");
						}else if(iType == HSSFCell.CELL_TYPE_ERROR){
							strValue = "";
						}else{
							
						
							
							
							flag = false;
							errMsg="第"+(j)+"行，第"+(k+1)+"列";
						}
						obj[j-1][k] = strValue;
					}else{
						obj[j-1][k] = "";
					}
				}
			}
		}
	}
	
	public String dateToString(Date date, String pattern) {
	    DateFormat format = new SimpleDateFormat(pattern); 
	    String str = format.format(date);
	    return str;
	}
	
	public String getErrMsg(){
		return errMsg;
	}

	public boolean getFlag(){
		return flag;
	}

	public String getObjectValue (int row,int col){
		return obj[row][col].toString();
	}
	
	public String[][] getObject(){
		return obj;
	}
	
    public void deleteFile(String fileName){
    	File file = new File(fileName);
    	if(file.exists()){
    		if(file.isFile()){
    			file.delete();
    		}
    	}
    }
	
	public String getValue(int iRow,String varName){
		int iFlag = -1;
		for(int i=0;i<rowName.length;i++){
			if(varName.equals(rowName[i])){
				iFlag = i;break;
			}
		}
		if(iFlag!=-1){
			return obj[iRow][iFlag].toString();
		}else{
			return null;
		}
	}
	
	private HSSFWorkbook wb;
	private HSSFSheet templateSheet;
	private HSSFRow templateRow;
	private HSSFCell cell;
	private String [][]obj;
	private String[] rowName;
	private boolean flag;
	private String errMsg;
}
