package com.test;

import java.util.UUID;

import com.invoiceSync.datasource.InvoiceZJKDataSource;
import com.tenwa.culc.service.FundInvoiceConfirmInfo;
import com.tenwa.culc.util.CommonTool;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



public class Test {

	public static void main(String[] args) throws Exception {
		
		double aa=105000000.00;
		String bb="150000000.00";
		String cc="10000";
		
		System.out.println(Double.parseDouble(bb) - aa - Double.parseDouble(cc));
		
	}

}
