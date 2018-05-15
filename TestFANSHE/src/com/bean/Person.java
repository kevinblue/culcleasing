package com.bean;

import java.io.Serializable;

public class Person implements  Serializable{
  private  String id;
  private  String name;
  private  String sex;
  private  String age;
  private  String phone;
  private  String address;
  private  String createdate;
  private  String modifydate;
  
  
  
  
     public Person(){
	  super();
 
    }
  //瀹氫簬鏈夊弬鐨勬瀯閫犳柟娉�
  public  Person(String id,String name,String sex,String age,String phone,String address){
	  super();
	  //瀹炰緥鍖栨垚鍛樺彉閲� 
	  this.id=id;
	  this.name=name;
	  this.sex=sex;
	  this.age=age;
	  this.phone=phone;
	  this.address=address;
	  
	  //瀹炰緥鍖栧璞�
	  //Person p = new Person(address, address, address, address, address, address);
  }

public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getSex() {
	return sex;
}

public void setSex(String sex) {
	this.sex = sex;
}

public String getAge() {
	return age;
}

public void setAge(String age) {
	this.age = age;
}

public String getPhone() {
	return phone;
}

public void setPhone(String phone) {
	this.phone = phone;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}
public String getCreatedate() {
	return createdate;
}
public void setCreatedate(String createdate) {
	this.createdate = createdate;
}
public String getModifydate() {
	return modifydate;
}
public void setModifydate(String modifydate) {
	this.modifydate = modifydate;
}
@Override
public String toString() {
	return "Person [id=" + id + ", name=" + name + ", sex=" + sex + ", age=" + age + ", phone=" + phone + ", address="
			+ address + ", createdate=" + createdate + ", modifydate=" + modifydate + "]";
}
  	
	
	
}
