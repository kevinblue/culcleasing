package com.tenwa.leasing.bean;

import java.io.InputStream;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

/**
 * 
 * 项目名称：iulcleasing 类名称：PropBean 类描述： .properts属性文件读取工具类 创建人：史鸿飞 创建时间：2011-1-24
 * 下午03:57:56 修改人：史鸿飞 修改时间：2011-1-24 下午03:57:56 修改备注：
 * 
 * @version
 */
public class PropBean {

	public String properFile = "/config.properties";// 默认在src下面

	public String getProperFile() {
		return properFile;
	}

	public void setProperFile(String properFile) {
		this.properFile = properFile;
	}

	/**
	 * 读取指定目录下的.properties文件
	 * 
	 * @Title: getProperties
	 * @Description:
	 * @param
	 * @return
	 * @return Hashtable
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getProperties() {

		Properties prop = new Properties();
		InputStream in;
		Hashtable ht_prop = new Hashtable();

		try {
			in = getClass().getResourceAsStream(properFile);

			prop.load(in);
			Set keyValue = prop.keySet();
			for (Iterator it = keyValue.iterator(); it.hasNext();) {
				String key = (String) it.next();
				// System.out.println(key);
				ht_prop.put(key, prop.get(key).toString());
			}
			System.out.println(ht_prop);
		} catch (Exception e) {
			System.out.println("IO读取出错，找不到" + properFile + "!");
		}
		return ht_prop;
	}

	public static void main(String[] args) {
		PropBean pb = new PropBean();
		pb.setProperFile("/test/com/tenwaleasing/a.properties");
		pb.getProperties();

	}

}
