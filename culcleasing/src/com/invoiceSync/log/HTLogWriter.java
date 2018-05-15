/**
 * cn.tenwa.log.LogWriter
 * create by JavaJeffe.
 * date Jun 18, 2010
 */
package com.invoiceSync.log;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.tenwa.util.ConfigReader;

/**
 * 日志处理API
 * 
 * @author JavaJeffe
 * 
 * date ---- 5:23:33 PM
 */
public final class HTLogWriter {

	/**
	 * 输出控制台信息，java代码中
	 * 
	 * @param info
	 */
	public static void logDebug(String info) {
		// debug信息
		if ("open".equals(ConfigReader.getResultByKey("outlog"))) {
			System.out.println(" Debug：" + info);
		}
	}

	/**
	 * 输出控制台信息，java代码中
	 * 
	 * @param info
	 */
	public static void logError(String info) {
		// debug信息
		if ("open".equals(ConfigReader.getResultByKey("errorlog"))) {
			System.out.println(" Error：" + info);
		}
	}

	/**
	 * 输出执行的Sql
	 * 
	 * @param msg
	 * @param sqlStr
	 */
	public static void logSqlStr(String msg, String sqlStr) {
		if ("open".equals(ConfigReader.getResultByKey("sqllog"))) {
			System.out.println("模块：" + msg + " 执行Sql语句：" + sqlStr);
		}
	}

	/**
	 * 控制台dubug信息
	 * 
	 * @param request
	 * @param info
	 */
	public static void logDebug(HttpServletRequest request, String info) {
		// debug信息
		if ("open".equals(ConfigReader.getResultByKey("outlog"))) {
			System.out.println(HTLogWriter.getLogInfo(request) + "\t Debug："
					+ info);
		}
	}

	/**
	 * 控制台error信息
	 * 
	 * @param request
	 * @param info
	 */
	public static void logError(HttpServletRequest request, String info) {
		if ("open".equals(ConfigReader.getResultByKey("errorlog"))) {
			System.out.println(HTLogWriter.getLogInfo(request) + "\t Debug："
					+ info);
		}
	}

	/**
	 * 登陆日志，文件日志
	 * 
	 * @param request
	 */
	public static void logonLog(HttpServletRequest request) {
		String date = new SimpleDateFormat("yyyy年MM月dd日").format(new Date());
		File file = new File((String) ConfigReader
				.getResultByKey("configLogonPath")
				+ "/" + date + "登陆日志.txt");// 创建日志文件
		PrintWriter pw = null;// pw
		try {
			pw = new PrintWriter(new FileWriter(file, true));
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 写登陆信息
		pw.println(HTLogWriter.getLogInfo(request) + "\t登陆了");
		// 关闭资源
		pw.close();
	}

	/**
	 * 退出日志，文件日志
	 * 
	 * @param request
	 */
	public static void logonOutLog(HttpServletRequest request) {
		String date = new SimpleDateFormat("yyyy年MM月dd日").format(new Date());
		File file = new File((String) ConfigReader
				.getResultByKey("configLogonPath")
				+ "/" + date + "登陆日志.txt");// 创建日志文件
		PrintWriter pw = null;// pw
		try {
			pw = new PrintWriter(new FileWriter(file), true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 写退出信息
		pw.println(HTLogWriter.getLogInfo(request) + "\t退出了");
		// 关闭资源
		pw.close();
	}

	/**
	 * 操作日志 filereader，文件日志
	 * 
	 * @param request
	 * @param info
	 * @param sql
	 */
	public static void operationLog(HttpServletRequest request, String moduel,
			int info, String sql) {
		String date = new SimpleDateFormat("yyyy年MM月dd日").format(new Date());
		File file = new File((String) ConfigReader
				.getResultByKey("configOperPath")
				+ "/" + date + "操作日志.txt");// 创建日志文件

		PrintWriter pw = null;// pw
		try {
			pw = new PrintWriter(new FileWriter(file, true));
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 写操作日志信息
		String baseInfo = HTLogWriter.getLogInfo(request);
		String operInfo = "moduelName：" + moduel + " modify amount：" + info;
		String exeSql = "executeSql：" + sql;

		pw.println(baseInfo + "\n\t" + operInfo + "\n\t" + exeSql + "\n\n");

		// 关闭资源
		pw.close();
	}

	/**
	 * 操作错误日志 filereader，文件日志
	 * 
	 * @param request
	 * @param info
	 * @param sql
	 */
	public static void operationErrorLog(HttpServletRequest request,
			String moduel, int info, String sql) {
		String date = new SimpleDateFormat("yyyy年MM月dd日").format(new Date());
		File file = new File((String) ConfigReader
				.getResultByKey("configOperErrorPath")
				+ "/" + date + "操作错误日志.txt");// 创建日志文件

		PrintWriter pw = null;// pw
		try {
			pw = new PrintWriter(new FileWriter(file, true));
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 写操作日志信息
		String baseInfo = HTLogWriter.getLogInfo(request);
		String operInfo = "moduelName：" + moduel + " modify amount：" + info;
		String exeSql = "executeSql：" + sql;

		pw.println(baseInfo + "\n\t" + operInfo + "\n\t" + exeSql + "\n\n");

		// 关闭资源
		pw.close();
	}

	/**
	 * 提取登陆信息
	 * 
	 * @param request
	 * @return
	 */
	public static String getLogInfo(HttpServletRequest request) {
		// 登陆人
		String logId = (String) request.getSession().getAttribute("czyid");
		// 登陆人ip
		String logIp = request.getRemoteAddr();
		// 登陆人电脑名称
		String logHostName = request.getRemoteHost();
		// 访问的界面
		String visitAddr = request.getRequestURL().toString();

		// 登陆时间
		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		String currDate = dateFormat.format(new Date());

		return "时间：" + currDate + "登陆人id:" + logId + "\t远程电脑ip:" + logIp
				+ "远程主机名称:" + logHostName + "访问地址：" + visitAddr + "\n";
	}

	/**
	 * 拼接sql插入数据的日志
	 * 
	 * @param request
	 * @param model
	 *            模块名称
	 * @param action
	 *            功能名称
	 * @param operContent
	 *            操作内容
	 * @param sql
	 *            操作sql
	 * @return
	 */
	public static String getSqlIntoDB(HttpServletRequest request, String model,
			String action, String operContent, String sql) {
		String sqlStr = "";
		/*
		 * create table sys_logInfo ( id int identity, log_date datetime null,
		 * sys_model varchar(100) null, sys_action varchar(100) null, visturl
		 * varchar(200) null, sqlstr varchar(500) null, oper_content text null,
		 * oper varchar(50) null, oper_ip varchar(100) null, oper_hostname
		 * varchar(100) null, oper_mackadd varchar(200) null, blocked int null,
		 * creator varchar(50) null, create_date datetime null, constraint
		 * PK_SYS_LOGINFO primary key (id) ) go
		 */

		// 登陆人
		String logId = (String) request.getSession().getAttribute("czyid");
		// 登陆人ip
		String oper_ip = request.getRemoteAddr();
		// 登陆人电脑名称
		String oper_hostname = request.getRemoteHost();
		// 操作人的mack地址
		// String oper_mackadd = getMACAddress(oper_ip);
		// 访问的界面
		String visturl = request.getRequestURL().toString();
		// 操作时间
		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		String currDate = dateFormat.format(new Date());
		// sql的单引号处理
		sql = sql.replaceAll("'", "''");
		operContent = operContent.replaceAll("'", "''");

		sqlStr = "insert into sys_logInfo(log_date,sys_model,sys_action,visturl,sqlstr,oper_content,oper,oper_ip,oper_hostname,";
		sqlStr += "blocked,creator,create_date) select ";
		sqlStr += "'" + currDate + "','" + model + "','" + action + "','"
				+ visturl + "','" + sql + "','" + operContent + "','" + logId
				+ "','" + oper_ip + "','" + oper_hostname + "',";
		sqlStr += "'0','" + logId + "',getdate() ";
		return sqlStr;
	}

	/**
	 * 获取指定Ip的mac地址
	 * 
	 * @param ip
	 * @return
	 */
	@SuppressWarnings("unused")
	private static String getMACAddress(String ip) {
		// 功能不是特别好使，还是取消靠谱，挺消耗资源的
		String str = "";
		String macAddress = "";
		try {
			Process p = Runtime.getRuntime().exec("nbtstat -A " + ip);
			InputStreamReader ir = new InputStreamReader(p.getInputStream());
			LineNumberReader input = new LineNumberReader(ir);
			for (int i = 1; i < 100; i++) {
				str = input.readLine();
				if (str != null) {
					if (str.indexOf("MAC Address") > 1) {
						macAddress = str.substring(
								str.indexOf("MAC Address") + 14, str.length());
						break;
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace(System.out);
		}
		return macAddress;
	}
		
	
	/**
	 * 操作日志 filereader
	 * 
	 * @param request
	 * @param info
	 * @param sql
	 */
	public static void operationLog(String info) {
		String date = new SimpleDateFormat("yyyy年MM月dd日").format(new Date());

		File file = new File((String) ConfigReader
				.getResultByKey("invoiceOperPath")
				+ "/" + date + "数据同步日志.txt");// 创建日志文件
		PrintWriter pw = null;// pw
		try {
			pw = new PrintWriter(new FileWriter(file, true));
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 写操作日志信息
		pw.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new Date())
				+ "时间，同步数据Info：" + info);

		// 关闭资源
		pw.close();
	}
}
