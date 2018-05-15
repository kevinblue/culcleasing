<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>明细 - 项目意见</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
明细 - 项目意见
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">

<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">详细信息</td>
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>

<script language="javascript">
ShowTabN(0);
</script>

<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<%
sqlstr="";
rs = null;
String proj_id = getStr( request.getParameter("proj_id") );

//模拟proj_id
//proj_id = "00002-01-02-2010-00166-00000";

sqlstr = "select * from vi_proj_opinion_state where proj_id='"+proj_id+"'";
String proj_name="";
String opinion_amount="";
 
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 
	proj_name=getDBStr(rs.getString("project_name"));
	opinion_amount=getDBStr(rs.getString("opinion_amount"));
}
rs.close();
%>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td>项目编号:&nbsp;&nbsp;<b style="color:#E46344;"><%=proj_id %></b></td>
    <td>&nbsp;</td>
	<td>意见数量:&nbsp;&nbsp;<b style="color:#E46344;"><%=CurrencyUtil.convertIntAmount(opinion_amount) %></b></td>
  </tr>
</table>
<br><br>

<form action="opinion_detail.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
        <td align="left" width="1%"><!--操作按钮开始-->
        </td>
        <!--操作按钮结束-->
        
        <td align="right" width="95%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%
		countSql = "select count(id) as amount from opinion_execution where proj_id='"+proj_id+"'";
		%>
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>
</form>

<!-- 数据start -->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:80%;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th>提出人</th>
     	<th>提出时间</th>
		<th>预计落实时间</th>
 		<th>意见</th>
		<th>责任落实人</th>
		<th>执行部门</th>
	 	<th>流程</th>
	 	
	 	<th>是否完成</th>
	    <th>执行结果</th>
	    <th>结果意见</th>
	    <th>完成时间</th>
	    <th>登记人</th>
	    <th>登记时间</th>
	</tr>
<tbody id="data">
<%
//sqlstr="select oe.*,cjz=dbo.GETUSERNAME(oe.creator) from opinion_execution oe where proj_id='"+proj_id+"'";
sqlstr = "select top "+ intPageSize +" oe.*,cjz=dbo.GETUSERNAME(oe.creator) from opinion_execution oe where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from opinion_execution where proj_id='"+proj_id+"' order by id ) and proj_id='"+proj_id+"'";
sqlstr += " order by id ";

rs = db.executeQuery(sqlstr); 
while (rs.next()){
%>
	<tr>
		<td align="left"><%=getDBStr(rs.getString("raiser"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("raiser_date")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="left" class="autoNewLine" width="280px"><%=getDBStr(rs.getString("idea")) %></td>
		<td><%=getDBStr(rs.getString("dutier")) %></td>
		<td><%=getDBStr(rs.getString("operation_dept")) %></td>
		<td><%=getDBStr(rs.getString("flow")) %></td>
    				
		<td align="center"><%=rs.getInt("status")==0?"否":"是" %></td>
		
		<td><%=getDBStr(rs.getString("result")) %></td>
		<td><%=getDBStr(rs.getString("remark")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("end_time")) %></td>
		<td><%=getDBStr(rs.getString("cjz")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("create_date")) %></td>
	</tr>
<%
} rs.close(); 
db.close();%>
</tbody>
</table>
</div>
</div>

<div id="TD_tab_1" style="display:none;"> 
	
</div>

</div>

</center>

<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  

</div>
<!--添加结束-->
<!-- end cwMain -->
</body>
</html>
