package com.tenwa.leasing.bean;

import java.util.Hashtable;

import com.tenwa.leasing.util.xml.ParseXMLConfigFactory;

/**
 * 
 * 项目名称：iulcleasing 类名称：ConfigBean 类描述：读取classes指定目录下.xml文件中的配置信息 默认为:config.xml
 * 创建人：史鸿飞 创建时间：2011-1-24 下午03:29:28 修改人：史鸿飞 修改时间：2011-1-24 下午03:29:28 修改备注：
 * 
 * @version
 */
public class ConfigBean {

	private String configFile = "config.xml";// 默认值

	public String getConfigFile() {
		return configFile;
	}

	public void setConfigFile(String configFile) {
		this.configFile = configFile;
	}

	/**
	 * 读取指定文件（默认为config.xml文件）的键值信息,并以HashTable形式保存
	 * 
	 * @Title: getConfigInfo
	 * @Description:
	 * @param
	 * @return
	 * @param
	 * @throws Exception
	 * @return Hashtable
	 * @throws
	 */
	public Hashtable getConfigInfo() throws Exception {
		ParseXMLConfigFactory parse = new ParseXMLConfigFactory();
		Hashtable ht = new Hashtable();
		// 设置所要读取的文件
		parse.setConfigFile(configFile);
		ht = parse.getConfiguration();
		// System.out.println(ht);
		return ht;

	}

	public static void main(String[] args) throws Exception {
		ConfigBean cfb = new ConfigBean();
		cfb.getConfigInfo();
	}

}
