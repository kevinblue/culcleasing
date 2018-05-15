package com.service;

import java.util.Hashtable;

import com.nineorange.service.BusinessService;
import com.nineorange.service.BusinessServiceProxy;
import com.parse.xml.ParseXMLConfigFactory;

public class SMSService {

	private BusinessService businessService;
    
    private static String account = "rixinsdk";
    
    private static String password = "123456";
    
    private static String url = "http://61.152.182.249:8080/NOSmsPlatform/services/BusinessService";
    
    static{
    	ParseXMLConfigFactory parse = new ParseXMLConfigFactory();
		String admin = "";
		Hashtable ht = new Hashtable();
		try{
			ht = parse.getConfiguration();
			account = (String)ht.get("smsaccount");
			password = (String)ht.get("smspassword");
			url = (String)ht.get("smsurl");
		}catch(Exception e){
			System.out.println(e);
		}
    }
    
    public SMSService() {
    	BusinessServiceProxy businessServiceProxy = new BusinessServiceProxy();
        businessServiceProxy.setEndpoint(url);
        //businessServiceProxy.setEndpoint("http://127.0.0.1:8080/SMSWSServer/services/BusinessService");
        businessService = businessServiceProxy;
        System.out.println("url:"+url);
        System.out.println("account:"+account);
    	System.out.println("password:"+password);
        try{
	        int nRet = businessService.validateUser(account, password);
			if(nRet != 1) {
				System.out.println("µÇÂ¼Ê§°Ü£¡");
				return;
			}
    	}catch(Exception e){
    		System.out.println("µÇÂ¼Òì³££¡"+e);
    	}
		System.out.println("µÇÂ¼³É¹¦£¡");
    }
    
    public int sendMessage(String mobile,String message) {
    	int rt=-100;
        try {
        	
            rt = businessService.sendMessage(account, password, mobile, message);
            System.out.println(rt);
        } catch(Exception ex) {
        	System.out.println(ex);
            ex.printStackTrace();
        }
        return rt;
    }
    
    public int  sendBatchMessage(String batchMobile,String message) {
    	int rt=0;
    	try {
            rt = businessService.sendBatchMessage(account, password, batchMobile, message);
            System.out.println(rt);
        } catch(Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }

    public String  getReceivedMsg() {
    	String rt = "0";
        try {
            int taskid = 507291191;
            rt = businessService.getReceivedMsg(account, password, taskid);
            System.out.println(rt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }

    public String  getReceipt() {
    	String rt = "0";
        try {
            int taskid = 334247670;
            rt = businessService.getReceipt(account, password, taskid);
            System.out.println(rt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }
    
    public int sendTimelyMessage(String date,String mobile,String message) {
    	int rt=0;
    	try {
            rt = businessService.sendTimelyMessage(account, password, date, mobile, message);
            System.out.println(rt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }
    
    public String getTimelySendStatus(String date) {
    	String rt = "0";
        try {
            rt = businessService.getTimelySendStatus(account, password, date, null);
            System.out.println(rt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }
    
    public String getUserInfo() {
    	String rt = "0";
        try {
            rt = businessService.getUserInfo(account, password);
            System.out.println(rt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }
    
    public int modifyPassword(String newPassword) {
    	int rt = 0;
        try {
            rt = businessService.modifyPassword(account, password, newPassword);
            System.out.println(rt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rt;
    }
    
    public static void main(String[] args) {
    	SMSService myService = new SMSService();
        myService.sendMessage("13120700089","ÕâÊÇÒ»¸ö²âÊÔ");        
    }

}
