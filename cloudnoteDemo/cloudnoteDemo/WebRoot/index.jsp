<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
   
   
   
    <a href="springmvc/testRedirect.do">springmvc/testRedirect.do</a>
    <br><br>
    <a href="springmvc/testView.do">:testView  自定义视图</a>
    <br><br>

   

  <form action="springmvc/testPojo.do" method="post">
  <br>
    user name:<input type="text" name="username"/><br>
    password:<input type="text" name="password"/><br>
    email:<input type="text" name="email"/><br>
    age:<input type="text" name="age"/><br>
    city:<input type="text" name="address.city"/><br>
    province:<input type="text" name="address.province"/><br>
    <input type="submit"  value="Submit"/>
 
  </form>
  
  
   <a href="springmvc/testMap.do">处理数据模型方式2:testMap</a>
    <br><br>
     
      <a href ="springmvc/testModelAndView.do">处理数据模型方式1:testModelAndView</a>    
       <br><br>
        <br><br>
     <form action="springmvc/testRestmodel.do" method="post">
     <input type="submit"  value="TestRest modleandview" />
     </form>
    
   
    <form action="springmvc/testRest.do" method="post">
    <input type="submit"  value="TestRest Post" />
   </form>

   <form action="springmvc/testRest/1.do" method="post">
     <input type="hidden"  name="_method"  value="DELETE"/>
    <input type="submit"  value="TestRest DELETE" />
   </form>
    <br><br>
    <form action="springmvc/testRest/1.do" method="post">
     <input type="hidden"  name="_method"  value="PUT"/>
    <input type="submit"  value="TestRest PUT" />
   </form>
    <br><br>
    
   <form action="springmvc/testRest.do" method="post">
    <input type="submit"  value="TestRest Post" />
   </form>
   
    <br><br>
     <a href="testRestGet/1.do">test Rest Get</a>
    <br><br>
    <br><br>
     <a href="testRestGet/1.do">test Rest Get</a>
    <br><br>

  <a href="testPathVariable/1.do">testPathVariable.do/1</a>
    <br><br>
  <a href="testParamAndHeaders.do?username=zhangsan&age=11">testParamAndHeaders</a>
     
 <br><br>
  <form action="testMethod.do" method="POST"> 
    <input type="submit" value="submit" />
    <button name="submit" text="提交"></button>
  </form>
  <br>
  <a href="testMethod.do">testMethod.do</a>
   <br>
  <a href="testrequestmapping.do">testrequestmapping.do</a>
</body>
</html>