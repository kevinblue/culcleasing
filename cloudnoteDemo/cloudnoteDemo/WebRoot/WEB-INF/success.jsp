<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
   success!!!
  
   处理模型方式1.目标方法添加modelandview类型
  session time: ${requestScope.time};
  session name: ${requestScope.name};
  attention： ${requestScope.attention};
  <br><br>
  
   处理模型方式2.目标方法添加map类型（实际上是model或者modelMap）
    在创建requestmapping的时候如果404，第一路径写错，第二，可能是没有映射到重启一下就好了
  <br><br>
  map: ${requestScope.names};
   <br><br>
</body>
</html>