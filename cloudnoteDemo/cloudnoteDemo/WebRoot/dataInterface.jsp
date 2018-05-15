<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数据交互方式</title>
<script Language="Javascript" src="scripts/jquery.js"></script>
<script Language="Javascript" src="scripts/ajaxfileupload.js"></script>
<style type="text/css">
.divcss5{

} 
</style>
</head>
<script type="text/javascript">
function updMaterStatus(){


	

	form3.action="<%=request.getContextPath()%>/views/postform.jsp";
	form3.target="_blank"
	form3.submit();
	form3.action="dataInterface.jsp";
	form3.target="_self"
	
}
</script>
<% String clj="超链接成功";%>
 <body> 
 <a href="xiala.html">返回上一页</a>
<br>
 <h3>页面跳转--1超链接的方式（get）</h3>
 <a href='<%=request.getContextPath()%>/views/getform.jsp?id=<%=clj %>' target="_blank">修改申请</a>  
 <h3>页面跳转--2.1form表单get提交方式</h3>
 <form name="form1" action="<%=request.getContextPath()%>/views/getform.jsp" method="get" enctype="multipart/form-data">
    <p>用户名：<input type="text" name="name"/></p>
    <p>密码：<input type="password" name="pwd"/></p>
    <input type="submit" value="upload"/>
 </form>
 <h3>页面跳转--2.2form表单get提交方式</h3>
 <form name="form2" action="<%=request.getContextPath()%>/views/getform.jsp?name=queena&pwd=123456" method="get" enctype="multipart/form-data">
    <input type="hidden" name="controller" value="你好">   
    <input type="hidden" name="method" value="get方式">
    <input type="submit" value="upload"/>
 </form>
 <h3>页面跳转--3.1form表单post提交方式</h3>
 <form name="form3" action="dataInterface.jsp" method="post" >
     <p>用户名：<input type="text" id="name" name="name"/></p>
    <p>密码：<input type="password" name="pwd"/></p>
    <input type="submit" value="upload"/><!--通过submit提交  -->
    <td  width="30%">
			<input class="btn_2" type="button"  value="提交" onclick="return updMaterStatus();">&nbsp;&nbsp;
		</td> <!--通过自定义button提交  -->
 </form>
  <h3>页面跳转--3.2form表单post提交方式</h3>
 <form name="form4" action="<%=request.getContextPath()%>/views/postform.jsp" method="post" >
     <p>用户名：<input type="text" id="name" name="name"/></p>
    <p>密码：<input type="password" name="pwd"/></p>
    <input type="submit" value="upload"/>
   
 </form>
 <br>
 <a href="xiala.html">返回上一页</a>

</body>
</html>