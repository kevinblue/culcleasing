package com.tenwa.leasing.util;

import org.apache.log4j.Logger;

public class LogInfo {
	/* 得到 logger 对象 */
	private static Logger logger = Logger.getLogger(LogInfo.class);

	public static void main(String[] args) {
		logger.info("test");
	}

}
