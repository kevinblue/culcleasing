package com.webService.service;

import org.apache.axis.wsdl.WSDL2Java;

public class CreateWSClient {
	public static void main(String[] args) {
		String wsdl = "http://10.122.1.251:8099/uapws/service/nc.ws.webservice.IService4Bill?wsdl";
		WSDL2Java.main(new String[] { "-o", "src","-p","com.webService.service", wsdl });
	}
}