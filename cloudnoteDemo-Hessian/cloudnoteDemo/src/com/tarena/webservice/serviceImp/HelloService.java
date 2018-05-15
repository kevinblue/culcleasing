/**
 * 
 */
package com.tarena.webservice.serviceImp;

import com.tarena.webservice.bean.User;
import com.tarena.webservice.service.IHelloService;

/**
 * @author 公共
 *
 */
public class HelloService implements IHelloService{

	public String sayHello(String name){  
        return "Hello, "+name;  
    }  
    public User getUser(User user) {  
        User userNew = new User();  
        userNew.setId("new:"+user.getId());  
        userNew.setName("new:"+user.getName());  
        return userNew;  
    }  

}
