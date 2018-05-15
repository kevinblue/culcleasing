<%@ page contentType="text/html; charset=gbk" language="java" %>

<!-- 公共的变量定义 -->
<%
//session Id
String dqczy=(String) session.getAttribute("czyid");
if(dqczy==null || "".equals(dqczy)){
	dqczy = "ADMN-WUSESSION";
}
//sqlstr -- 主要存放查询sql语句
String sqlstr="";
//countSql -- 统计数据总数量的sql语句
String countSql = "";
//rs 查询结果
ResultSet rs = null;
//存放wherestr查询sql
String wherestr = "";
%>


