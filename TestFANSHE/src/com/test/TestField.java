package com.test;

import java.lang.reflect.Field;

import com.bean.Student;

public class TestField {
/**������������е����Է�
 * 8�ֻ�����������
 * @param args
 * @throws Exception
 */
	public static void main(String[] args) throws Exception {
	    Class clazz=  Class.forName("com.bean.Student");
	     Student obj=(Student) clazz.newInstance();
	     
   //����getDeclareField("name")ȡ��name���Զ�Ӧ��Field
	   Field f=  clazz.getDeclaredField("name");
   //ȡ�����Եķ���Ȩ�޿��ƣ���ʹprivate����Ҳ���Խ��з���
	   f.setAccessible(true);
	   //����get()����ȡ�ö�Ӧ����ֵ
	   System.out.println(f.get(obj));//�൱��obj.getName();
	   //����set()��������Ӧ�����Ը�ֵ
	   f.set(obj,"����");
	   System.out.println(f.get(obj));
	   
	   
	   Field f1=  clazz.getDeclaredField("age");
	   f1.setAccessible(true);
	   
	   //2��д��������
	   System.out.println(f1.get(obj));//�൱��obj.getAge();
	   System.out.println(f1.getInt(obj));//�൱��obj.getAge();
	}

}
