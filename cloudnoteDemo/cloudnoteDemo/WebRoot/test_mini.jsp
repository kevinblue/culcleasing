<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.table.util.*"%>
<jsp:useBean id="db" scope="page" class="com.table.util.InvoiceZJKDataSource" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>法人客户信息管理</title>
<%@ taglib prefix="c" uri="/WEB-INF/tlds/c.tld"%>
<c:if test="${sessionScope['login_userlanguage'].language != 'zh'}">
	<c:set var="currentLocale" value="zh_CN"></c:set>
</c:if>
<c:if test="${sessionScope['login_userlanguage'].language != 'en'}">
	<c:set var="currentLocale" value="en_US"></c:set>
</c:if>
<c:set var="currentTimestamp" value="20140109000"></c:set>
<c:set var="currentSkin" value="blue3"></c:set>
<c:set var="urlPrefix" value="${pageContext.request.contextPath}/123/dcf/table/getTableData.action?tracywindyRandom=1&decorate=none&xmlFileName=" scope="request"></c:set>
 <script type="text/javascript">
	var globalTimestamp = "${currentTimestamp}";
	var globalLocale = "${currentLocale}";
	var globalSkin = "${currentSkin}";
	var globalClientWidth = document.documentElement.clientWidth;
	var globalClientHeight = document.documentElement.clientHeight;
	var globalWebRoot = "${pageContext.request.contextPath}";
	var urlPrefix = "${urlPrefix}";
</script>
</head>
<body>
<!-- 高级查询部分 -->
		<%   
   List<String> names = new ArrayList<String>();  
	    names.add("zhangSan1");  
	    names.add("liSi1");  
	    names.add("wangWu1");  
       names.add("zhaoLiu1");  
  	    pageContext.setAttribute("ns1", names);
  	  %>
  	  
  	 	<c:forEach var="item1" items="${ns1 }">  
	    <c:out value="name: ${item1 }"/><br/>  
        </c:forEach> 
  	 
    </div>
    <!-- 按钮部分 -->
   
   
    </script>
</body>
</html>
