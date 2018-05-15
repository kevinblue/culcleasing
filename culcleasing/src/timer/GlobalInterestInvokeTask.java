/**
 * com.tenwa.datasync.timer
 */
package timer;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.TimerTask;

import com.tenwa.log.LogWriter;

import timer.util.FIDConfigReader;


/**
 * 资金收付计划 数据同步任务调用类
 * 
 * @author Jaffe
 * 
 * Date:Oct 8, 2011 11:41:55 PM Email:JaffeHe@hotmail.com
 */
public class GlobalInterestInvokeTask extends TimerTask {

	/**
	 * 执行调用 资金收付计划 数据同步任务
	 */
	public void run() {
		// 判断当前执行的有效时间
		//7-9改为每月18号
		Calendar cale = Calendar.getInstance();
		cale.setTime(new Date());
		int monTh = cale.get(Calendar.DAY_OF_MONTH);
		int hourTh = cale.get(Calendar.HOUR_OF_DAY);
		
		//调度任务每一次都读取最新的配置文件，获取最新的配置项
		Properties properties = new Properties();
		String realpath = FIDConfigReader.class.getClassLoader().getResource("/FIDConfig.properties").getPath();
		InputStream is = null;
		String startTaskGlobalInterest = "" ;
		try {
			is = new FileInputStream(realpath);
			properties.load(is);
			startTaskGlobalInterest = properties.getProperty("startTaskGlobalInterest");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					throw new RuntimeException("关闭FIDConfig层资源出现异常", e);
				}
			}
		} 
		System.out.println("&&&&&&startTaskGlobalInterest&&&& :  "+startTaskGlobalInterest);
		// 1.判断是否有效时间内 - 2点
		if (monTh ==18 && hourTh==2 && "on".equals(startTaskGlobalInterest)) {
			System.out.println("代码执行到===");
			// 使用多线程调用WebService
			GlobalInterestInvokeThread invokeThread = new GlobalInterestInvokeThread(
					"======[[GlobalInterest Task Thread]]=========");
			invokeThread.setPriority(5);// 设置线程优先级别
			invokeThread.start();
			System.out.println("代码执行到aaaaaaaa");
		} else {
			LogWriter.logDebug("[计提利息 数据同步任务]非有效时间内执行代理");
		}
	}
}
