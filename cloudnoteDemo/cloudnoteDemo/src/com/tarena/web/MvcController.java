package com.tarena.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.tarena.entity.Puser;
import com.tarena.entity.User;

@Controller
public class MvcController {

	private static  final String SUCCESS="success";
	/**
	 * redirect:
	 * forword
	 * @return
	 */
	@RequestMapping("/springmvc/testRedirect.do")
	public String testRedirect(){
		System.out.println("testredirect");
		
		return "redirect:/index.jsp";
	}
	
	/**
	 * 1.自定义一个helloview的试图
	 * 注意不要忘记把视图添加到ioc容器中。。通过@Component注解来实现
	 * 2配置BeanNameViewResolver
	 * @return
	 */
	@RequestMapping("/springmvc/testView.do")
	public String testView(){
		System.out.println("testView");
		
		return "helloView";
	}
	/**
	 * SpringMvc 会按请求参数名和POJO属性名进行自动分配
	 * 自动为改对象添加属性值，支持级联属性	
	 * @param puser
	 * @return
	 */
	@RequestMapping(value="/springmvc/testPojo.do")
	public String testPojo(Puser puser){
		
		System.out.println("Puser"+puser);
		return SUCCESS;
	}
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
		}catch (IOException e) {
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
	 * 数据模型 方式2
	 * @param map
	 * @return
	 */
     @RequestMapping(value="/springmvc/testMap.do",method=RequestMethod.GET)
	public String testMap(Map<String,Object> map){
		map.put("names", Arrays.asList("tom","Jerry","mike"));
		return SUCCESS;
	}
	/**
	 * 数据模型 方式1
	 * @return
	 */
   
	@RequestMapping(value="/springmvc/testModelAndView.do",method=RequestMethod.GET)
	public ModelAndView testModelAndView(){
		String viewname=SUCCESS;
		ModelAndView modelAndView=new  ModelAndView(viewname);
		modelAndView.addObject("time", new Date());
		modelAndView .addObject("name", "你很牛逼，modelandview");
		modelAndView .addObject("attention", "注意点：1.记得先创建一个modelandview，然后指定跳转的页面，</tr>2.在使用requestMapping不要复制别人的路径，容易出错，自己手打");
		return modelAndView;
	}
	
	
	
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
	
		
	@RequestMapping(value="/springmvc/testRestmodel.do",method=RequestMethod.POST)
	public ModelAndView testRestmodel(){
		String viewName=SUCCESS;
		ModelAndView model=new ModelAndView(viewName);	
		
		Map<String,Object> map = new HashMap<String,Object>();  
         
            map.put("courtName","123");  
            map.put("reservations","你很溜");  
          
		model.addObject("time", new Date());
		System.out.println("testRest  POST");		
		return model;
	}
	@RequestMapping(value="/springmvc/testRest.do",method=RequestMethod.POST)
	public String testRest(){
		
		Map<String ,String>  map =new HashMap();
		map.put("name","hhhhhhhhhhhhhhhhhhhhhhhhh");
		System.out.println("testRest  POST");		
		return SUCCESS;
	}
	
	@RequestMapping(value="/testRestGet/{id}.do",method=RequestMethod.GET)
	public String testRestGet(@PathVariable("id") Integer id){
		System.out.println("testRest  GET"+id);		
		return SUCCESS;
	}
	

}
