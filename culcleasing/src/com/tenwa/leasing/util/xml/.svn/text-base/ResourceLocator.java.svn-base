package com.tenwa.leasing.util.xml;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;

public class ResourceLocator {

	public static URL getResourceURL(String fileName){
        ClassLoader loader = null;
        URL resource = null;
        try{
            loader = getTCL();
            if(loader != null)
                resource = loader.getResource(fileName);
        }
        catch(IllegalAccessException e){
        }
        catch(InvocationTargetException e){
        }
        return resource;
    }


	private static ClassLoader getTCL()throws IllegalAccessException, InvocationTargetException{
		Method method = null;
		try
		{
		    method = java.lang.Thread.class.getMethod("getContextClassLoader", null);
		}
		catch(NoSuchMethodException e)
		{
		     
		}
		return (ClassLoader)method.invoke(Thread.currentThread(), null);
	}
}
