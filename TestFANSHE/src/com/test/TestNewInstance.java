package com.test;

import java.lang.reflect.Constructor;

import com.bean.Student;

public class TestNewInstance {
/*
 * ͨ�����乹�����;newInstance()
 * ͨ���޲ι��캯����������ʵ��
 * ע�⣺�����Ķ����б������޲εĹ��췽��
 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		//1����һ���޲εĹ��췽���Ķ���ʵ��
     Class clazz=  Class.forName("com.bean.Student");
     Student obj=(Student) clazz.newInstance();
     obj.setAge(1);
     System.out.println(obj.getAge());
     
      //2����һ���в����Ĺ��췽����ʵ��
     Class clazz1=  Class.forName("com.bean.Student");
    Constructor constructor= clazz1.getConstructor(new Class[]{String.class,int.class});
    Student s=(Student)constructor.newInstance(new Object[]{"zzz",23});
    
    System.out.println(s);
    
    //3�޲εĹ��췽������ʵ��������
    Class clazz2=  Class.forName("com.bean.Student");
   Student s2=(Student) clazz2.getConstructor(new Class[]{}).newInstance(new Object[]{});
   System.out.println(s2);

	}
	

}
