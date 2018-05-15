package com.tarena.view;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.View;

/**
 * 注意不要忘记把视图添加到ioc容器中。。通过@Component注解来实现
 * @author 公共
 *
 */
@Component //把视图放到ioc容器中
public class HelloView implements View{

	@Override//返回内容类型
	public String getContentType() {
		// TODO Auto-generated method stub
		return "text/html";
	}

	@Override//返回内容
	public void render(Map<String, ?> arg0, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.getWriter().print("hello view,time:"+new Date());
	}

}
