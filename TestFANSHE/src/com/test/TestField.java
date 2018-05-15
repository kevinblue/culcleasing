package com.test;

import java.lang.reflect.Field;

import com.bean.Student;

public class TestField {
/**反射操作对象中的属性方
 * 8种基本数据类型
 * @param args
 * @throws Exception
 */
	public static void main(String[] args) throws Exception {
	    Class clazz=  Class.forName("com.bean.Student");
	     Student obj=(Student) clazz.newInstance();
	     
   //调用getDeclareField("name")取得name属性对应的Field
	   Field f=  clazz.getDeclaredField("name");
   //取消属性的访问权限控制，即使private属性也可以进行访问
	   f.setAccessible(true);
	   //调用get()方法取得对应属性值
	   System.out.println(f.get(obj));//相当于obj.getName();
	   //调用set()方法给对应的属性赋值
	   f.set(obj,"李四");
	   System.out.println(f.get(obj));
	   
	   
	   Field f1=  clazz.getDeclaredField("age");
	   f1.setAccessible(true);
	   
	   //2中写法都可以
	   System.out.println(f1.get(obj));//相当于obj.getAge();
	   System.out.println(f1.getInt(obj));//相当于obj.getAge();
	}

}
