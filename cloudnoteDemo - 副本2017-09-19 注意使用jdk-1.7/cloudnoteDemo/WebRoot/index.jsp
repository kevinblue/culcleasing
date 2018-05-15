<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>



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