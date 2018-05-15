package com.test;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.bean.Person;

import ServiceImp.PersonServiceImpl;
import service.PersonService;

public class testxiaojian  {

	public static void main(String[] args) {
	   Person p=new Person();
	   UUID uuid = UUID.randomUUID();
	   p.setId(uuid.toString().replace("-", ""));
	   p.setName("zhagsan");
	   p.setAddress("1111");
	   p.setAge("12");
	   p.setSex("ÄÐ");
	   p.setPhone("18726175886");
	   p.setModifydate("2017-10-01");
	   p.setCreatedate("2017-09-01");
	   PersonServiceImpl pp=new PersonServiceImpl();	  
	   try {
		pp.saveEntity(p);
		//pp.removeEntityById(p, "263bc86ecd874dfca69390923a4a2f02");
		//pp.findEntityByID(p, "24df1abbd64148e9ba9588306ab2d9da");
		//pp.removeAll(p);
		Map<String,Object>  map=new HashMap<String,Object>();
		map.put("sex", "Å®");
		//map.put("name", "zhagsan");
		List<Person> alllist=pp.findAllEntity(Person.class,map);
		for (Person person : alllist) {
			//System.out.println(person.getAddress()+"==="+person.getId()+"==="+person.getName());
		}
		
		Method m=null;
		 m = p.getClass().getMethod("getAge",new Class[]{});
		
		System.out.println(m.invoke(p,new Object[]{}));
		
	/*	List<Person> list=pp.findEntityByID(Person.class,p, "bcf75a3fe9b04410bb0f56d68c6fbc41");
  	   System.out.println(list.size());
		for(int i=0;i<list.size();i++){
			
			 System.out.println(list.get(i).toString());
			
		}*/
		
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		

	}

}
