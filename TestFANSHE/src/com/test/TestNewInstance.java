package com.test;

import java.lang.reflect.Constructor;

import com.bean.Student;

public class TestNewInstance {
/*
 * 通过反射构造对象;newInstance()
 * 通过无参构造函数构造该类的实例
 * 注意：构建的对象中必须有无参的构造方法
 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		//1创建一个无参的构造方法的对象实例
     Class clazz=  Class.forName("com.bean.Student");
     Student obj=(Student) clazz.newInstance();
     obj.setAge(1);
     System.out.println(obj.getAge());
     
      //2创建一个有参数的构造方法的实例
     Class clazz1=  Class.forName("com.bean.Student");
    Constructor constructor= clazz1.getConstructor(new Class[]{String.class,int.class});
    Student s=(Student)constructor.newInstance(new Object[]{"zzz",23});
    
    System.out.println(s);
    
    //3无参的构造方法对象实例方法二
    Class clazz2=  Class.forName("com.bean.Student");
   Student s2=(Student) clazz2.getConstructor(new Class[]{}).newInstance(new Object[]{});
   System.out.println(s2);

	}
	

}
