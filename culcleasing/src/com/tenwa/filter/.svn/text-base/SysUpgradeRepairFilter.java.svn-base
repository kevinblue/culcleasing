/**
 * cn.tenwa.filter.SysUpgradeRepairFilter
 * create by JavaJeffe.
 * date Jun 21, 2010
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

import com.tenwa.util.ConfigReader;


/**
 * @author JavaJeffe
 * 
 * date ---- 3:00:30 PM
 */
public class SysUpgradeRepairFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// 系统开发维护中
		String re = (String) ConfigReader.getResultByKey("sysUpgradeRepair");
		if ("open".equals(re.trim())) {// open -- close
			HttpServletRequest req = (HttpServletRequest) request;
			System.out.println(re+"filter==zhuanfa");
			req.getRequestDispatcher(
					(String) ConfigReader.getResultByKey("repairPath"))
					.forward(request, response);
		} else if ("close".equals(re.trim())) {//
			chain.doFilter(request, response);
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {

	}

}
