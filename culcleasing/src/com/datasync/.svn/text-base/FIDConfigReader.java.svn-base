package com.datasync;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import com.tenwa.log.LogWriter;

public class FIDConfigReader {

	private static Map<String, Object> configMap = new HashMap<String, Object>(
			0);// Config Map

	public FIDConfigReader() {
	}

	static {
		// 读取service配置文件
		Properties properties = loadProperties("FIDConfig.properties");
		// 将所有数据缓存
		Set<Map.Entry<Object, Object>> entrys = properties.entrySet();
		for (Map.Entry<Object, Object> entry : entrys) {
			String name = (String) entry.getKey();
			String result = (String) entry.getValue();
			// 放入beanMap中
			configMap.put(name, result);
		}
		LogWriter.logDebug("装载Host属性文件Key-Val完成");
	}

	/**
	 * 加载config配置文件
	 * 
	 * @param name -
	 *            文件全名称
	 * @return
	 */
	public static Properties loadProperties(String name) {
		Properties properties = new Properties();
		InputStream is = null;
		try {
			is = FIDConfigReader.class.getClassLoader()
					.getResourceAsStream(name);
			properties.load(is);
			LogWriter.logDebug("加载Host属性文件完成");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					throw new RuntimeException("关闭SMSConfig层资源出现异常", e);
				}
			}
		}
		return properties;
	}
	/**
	 * 得到指定key的值
	 * 
	 * @param <T>
	 * @param clazz
	 * @return
	 */
	public static Object getResultByKey(String key) {
		return configMap.get(key);
	}
	/**
	 * 测试 -- 上线后删除
	 * 
	 * @param args
	 */
	/*public static void main(String[] args) {
		Object d = FIDConfigReader.getResultByKey("delayTimeGlobalFundPlan");
		System.out.println("value:" + d);
	}*/
}
