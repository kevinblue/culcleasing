package com.test;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

import com.caucho.hessian.client.HessianProxyFactory;

public class testde {
	public static Object[] ifRepeat(Object[] arr){  
        //������¼ȥ���ظ�֮������鳤�Ⱥ͸���ʱ������Ϊ�±�����  
    int t = 0;  
         //��ʱ����  
         Object[] tempArr = new Object[arr.length];  
        //����ԭ����  
         for(int i = 0; i < arr.length; i++){  
             //����һ����ǣ���ÿ������  
             boolean isTrue = true;  
             //�ڲ�ѭ����ԭ�����Ԫ������Ա�  
             for(int j=i+1;j<arr.length;j++){  
                 //����������ظ�Ԫ�أ��ı���״̬�����������ڲ�ѭ��  
                 if(arr[i]==arr[j]){  
                    isTrue = false;  
                     break;  
                 }  
             }  
         //�жϱ���Ƿ񱻸ı䣬���û���ı����û���ظ�Ԫ��  
             if(isTrue){  
                //û��Ԫ�ؾͽ�ԭ�����Ԫ�ظ�����ʱ����  
                 tempArr[t] = arr[i];  
                 //�ߵ�����֤����ǰԪ��û���ظ�����ô��¼����  
                 t++;  
             }  
        }  
        //������Ҫ���ص����飬�������ȥ�غ������  
        Object[]  newArr = new Object[t];  
         //��arraycopy�������ղ�ȥ�ص����鿽���������鲢����  
         System.arraycopy(tempArr,0,newArr,0,t);  
        return newArr;  
     } 
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
  String a[]={"0","123","44","6","","0","1111","1111","333"};
  Object[] b=ifRepeat(a);
  for(int i=0;i<b.length;i++){
	  System.out.println(b[i]);
  }
 
				
			 
	}

}
