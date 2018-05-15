/**
 * com.tenwa.filter
 */
package com.tenwa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.tenwa.log.LogWriter;

/**
 * @author Jaffe
 * 
 * Date:Jul 20, 2011 12:05:18 PM Email:JaffeHe@hotmail.com
 */
public class SessionFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// 判断会话是否过期
		HttpServletRequest req = (HttpServletRequest) request;
		String dqczy = (String) req.getSession().getAttribute("czyid");
		if (dqczy == null || "".equals(dqczy)) {
			LogWriter.logDebug("当前为非法访问！");
			req.getRequestDispatcher("../public\\relogin.jsp").forward(request,
					response);
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {

	}
}
