package com.test;

import java.lang.reflect.Method;

import com.bean.Example;


public class TestMethod {
	/**
	 * �÷�����������еķ���
	 * @throws Exception 
	 * 
	 * ����һ������д����õģ�
	 */
	public static void main(String[] args) throws Exception {
	
	    Class clazz=  Class.forName("com.bean.Example");
	    Example obj=(Example) clazz.newInstance();
	 //obj.setAdd(290,212);
	    Method method= clazz.getMethod("add",new Class[]{int.class,int.class});
	  Object object = method.invoke(obj, new Object[]{290,212});
	  System.out.println(object);
	  
	  
	  Method method1= clazz.getMethod("say",new Class[]{String.class});
	  Object object1 = method1.invoke(obj, new Object[]{"welcome you "});
	  System.out.println(object1);
	  
	     
	}

}
