package com.tarena.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tarena.entity.User;

@Controller
public class MvcController {

	private static  final String SUCCESS="success";
	@RequestMapping("/testrequestmapping.do")
	public  String testrequestmapping(HttpServletRequest request, 
			HttpServletResponse response){
		User user = (User) request.getSession().getAttribute("user");
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		Writer witer;
		try {
			witer = response.getWriter();
			witer.write("{\"status\":1,\"message\":\"hhhh登录.\"}");
			witer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    
		System.out.println(user);
	
		return SUCCESS;
	}
	
	/**
	 * method指定请求方式
	 * @return
	 */
	@RequestMapping(value="/testMethod.do",method=RequestMethod.POST)
	public String testMethod(){
		System.out.println("testmethod");
		
		return SUCCESS;
	}
	/**
	 * 请求参数请求头
	 * @return
	 */
	@RequestMapping(value="/testParamAndHeaders.do", params={"username","age!=10"})
	public String testParamAndHeaders(){
		
		System.out.println("testParamAndHeaders");
		return SUCCESS;
	}
	
	/**
	 * 占位符
	 * @return
	 */
	@RequestMapping(value="/testPathVariable/{id}.do")
	public String testPathVariable(@PathVariable("id") Integer id){
		
		System.out.println("testPathVariable:"+id);
		return SUCCESS;
	}
	
	/**Rest风格的URL--增删改
	 * 以CRUD为例：
	 * 新增：/order POST
	 * 修改：/order/1 PUT     update?id=1
	 * 获取：/order/1 GET     get?id=1
	 * 删除：/order/1 DELETE  delete?id=1
	 * 
	 *如何发送PUT请求和Delete请求
	 *1.需要配置HiddenHttpMethodFilter
	 *2.需要发送POST请求
	 *3.需要在发送POST请求时携带一个name="_method"的隐藏域，值为Delete/PUT
	 * 
	 * 
	 *在springmvc的目标方法中如何得到id值？
	 *使用@PathVariable来获取
	 */
	
	
	@RequestMapping(value="/springmvc/testRest/{id}.do",method=RequestMethod.PUT)
	public String testMethodPUT(@PathVariable("id") Integer id){
		System.out.println("testRest  PUT"+id);		
		return SUCCESS;
	}
	
	@RequestMapping(value="/springmvc/testRest/{id}.do",method=RequestMethod.DELETE)
	public String testMethodDelete(@PathVariable("id") Integer id){
		System.out.println("testRest  DELETE"+id);		
		return SUCCESS;
	}
	
	@RequestMapping(value="/springmvc/testRest.do",method=RequestMethod.POST)
	public String testRest(){
		System.out.println("testRest  POST");		
		return SUCCESS;
	}
	
	@RequestMapping(value="/testRestGet/{id}.do",method=RequestMethod.GET)
	public String testRestGet(@PathVariable("id") Integer id){
		System.out.println("testRest  GET"+id);		
		return SUCCESS;
	}
	

}
