package com.webService.service;

import java.util.Iterator;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.tenwa.log.LogWriter;

public class XmlAnalysis {
	public  String getMsg(String receiptxml)throws Exception  {
		System.out.println(receiptxml);
		String res = "请求失败！";
			if(!"".equals(receiptxml)&&receiptxml!=null){
				if(receiptxml.indexOf("resultcode")!=-1){
					LogWriter.logError("nc返回信息解析开始~~~~~~~~~~~~~111111");
				    int resultcode=0;
				    String resultdescription = "";
				    //获取回写信息解析报文数据
					Document doc    = DocumentHelper.parseText(receiptxml);
					  Element root = doc.getRootElement();
					  List<Element> elements = root.elements();
					  for (Iterator<Element> it = elements.iterator(); it.hasNext();) {
						   Element element = it.next();
							 resultcode = Integer.parseInt(element.elementTextTrim("resultcode"));//回写状态：大于0请求成功反之请求失败
							 resultdescription = element.elementTextTrim("resultdescription").toString();
							  System.out.println("nc返回成功与失败的code值："+resultcode);
					  }   
					  if(resultcode>=0){//请求成功
						  res="0";//0代表请求成功,
					  }else{
						  return resultdescription;
					  }
				}
			}
		// 本次执行是否成功
	     return res;
	}
}
