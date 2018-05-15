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
 * �ʽ��ո��ƻ� ����ͬ�����������
 * 
 * @author Jaffe
 * 
 * Date:Oct 8, 2011 11:41:55 PM Email:JaffeHe@hotmail.com
 */
public class GlobalInterestInvokeTask extends TimerTask {

	/**
	 * ִ�е��� �ʽ��ո��ƻ� ����ͬ������
	 */
	public void run() {
		// �жϵ�ǰִ�е���Чʱ��
		//7-9��Ϊÿ��18��
		Calendar cale = Calendar.getInstance();
		cale.setTime(new Date());
		int monTh = cale.get(Calendar.DAY_OF_MONTH);
		int hourTh = cale.get(Calendar.HOUR_OF_DAY);
		
		//��������ÿһ�ζ���ȡ���µ������ļ�����ȡ���µ�������
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
					throw new RuntimeException("�ر�FIDConfig����Դ�����쳣", e);
				}
			}
		} 
		System.out.println("&&&&&&startTaskGlobalInterest&&&& :  "+startTaskGlobalInterest);
		// 1.�ж��Ƿ���Чʱ���� - 2��
		if (monTh ==18 && hourTh==2 && "on".equals(startTaskGlobalInterest)) {
			System.out.println("����ִ�е�===");
			// ʹ�ö��̵߳���WebService
			GlobalInterestInvokeThread invokeThread = new GlobalInterestInvokeThread(
					"======[[GlobalInterest Task Thread]]=========");
			invokeThread.setPriority(5);// �����߳����ȼ���
			invokeThread.start();
			System.out.println("����ִ�е�aaaaaaaa");
		} else {
			LogWriter.logDebug("[������Ϣ ����ͬ������]����Чʱ����ִ�д���");
		}
	}
}
