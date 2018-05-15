package test;

import java.net.MalformedURLException;

import com.caucho.hessian.client.HessianProxyFactory;
import com.tarena.hession.service.TestHessianService;

public class demo {

	 public static void main(String[] args) { 
	     String url = "http://localhost:8080/clouddemo/remote/testHessianService";    
         HessianProxyFactory factory = new HessianProxyFactory();  
      
		try {
			TestHessianService helloService = (TestHessianService) factory.create(    
					TestHessianService.class, url);
	         System.out.println(helloService.saveTestCustomerChageInfo("", "", null, null));
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}    
	 }
	
	
	
	
	
   
}
