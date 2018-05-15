package com.webService.service;

import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

public class RequestNcServer {
	//通用请求用友财务系统服务方法
	public String requst_Nc_Finance(String datas,String dataa,String  request_xml) throws ServiceException, RemoteException{
		String returnXmlStr =  null;
			try {
				IService4BillPortType client = new IService4BillLocator()
						.getIService4BillSOAP11port_http();
				returnXmlStr = client.sendDatas(datas, dataa, request_xml);
			} catch (ServiceException e) {
				e.printStackTrace();
				throw e;
			} catch (RemoteException e) {
				e.printStackTrace();
				throw e;
			}
			return returnXmlStr;

   }
}