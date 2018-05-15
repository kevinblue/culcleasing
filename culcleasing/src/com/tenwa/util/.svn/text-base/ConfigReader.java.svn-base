/**
 * cn.tenwa.util.ConfigReader
 * create by JavaJeffe.
 * date Jun 21, 2010
 */
package com.tenwa.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * @author JavaJeffe
 * 
 * date ---- 3:21:11 PM
 */
public final class ConfigReader {
	private static Map<String, Object> configMap = new HashMap<String, Object>(
			0);// Config Map

	public ConfigReader() {
	}

	static {
		// 读取service配置文件
		Properties properties = loadProperties("sysConfig.properties");
		// 将所有数据缓存
		Set<Map.Entry<Object, Object>> entrys = properties.entrySet();
		for (Map.Entry<Object, Object> entry : entrys) {
			String name = (String) entry.getKey();
			String result = (String) entry.getValue();
			// 放入beanMap中
			configMap.put(name, result);
		}
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
			is = ConfigReader.class.getClassLoader().getResourceAsStream(name);
			properties.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					throw new RuntimeException("关闭config层资源出现异常", e);
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

}
