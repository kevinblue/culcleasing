package com.test;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class TestClass {

	public static void main(String[] args) throws ClassNotFoundException {
     //Class clazz=Class.forName("java.lang.Object");
		
	Class clazz=Class.forName("java.lang.String");
	  System.out.println("����ֶ�");
	Field fields[] =clazz.getDeclaredFields();
	  for(Field field:fields){
		System.out.println(field.getName()+""+field.getType());
	}
	  
	  System.out.println("===��ķ��� ==");
	  Method methods[]=   clazz.getDeclaredMethods();
	  for(Method method: methods){
		  System.out.println(method.getName());
	  }
	  System.out.println("======��Ĺ��췽��=========");
	Constructor constructors[]=  clazz.getConstructors();
	for(Constructor constructor:constructors){
		System.out.println(constructor);
	}
	
	System.out.println("----------�����ڰ����������ƣ�����-------");
	System.out.println(clazz.getPackage().getName());
	System.out.println(clazz.getName());
	System.out.println(clazz.getSuperclass());
	}

}
