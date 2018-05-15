package com.test;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class TestClass {

	public static void main(String[] args) throws ClassNotFoundException {
     //Class clazz=Class.forName("java.lang.Object");
		
	Class clazz=Class.forName("java.lang.String");
	  System.out.println("类的字段");
	Field fields[] =clazz.getDeclaredFields();
	  for(Field field:fields){
		System.out.println(field.getName()+""+field.getType());
	}
	  
	  System.out.println("===类的方法 ==");
	  Method methods[]=   clazz.getDeclaredMethods();
	  for(Method method: methods){
		  System.out.println(method.getName());
	  }
	  System.out.println("======类的构造方法=========");
	Constructor constructors[]=  clazz.getConstructors();
	for(Constructor constructor:constructors){
		System.out.println(constructor);
	}
	
	System.out.println("----------类所在包。完整名称，父类-------");
	System.out.println(clazz.getPackage().getName());
	System.out.println(clazz.getName());
	System.out.println(clazz.getSuperclass());
	}

}
