package com.webService.dao;

import java.text.NumberFormat;

public class test {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args){
		try {
			name();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("3");
		}
	};
	public static void name() throws Exception {
		Double cny = Double.parseDouble("3810190.10");
		NumberFormat numberFormat1 = NumberFormat.getNumberInstance();
		System.out.println(numberFormat1.format(cny)); //½á¹ûÊÇ11,122.33
	}

}
