<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改意见 - 其他功能管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
	function make_val(){
	var idea = document.getElementById("idea_list").value;
	var old = document.getElementById("idea").value;
	if(old=="")
	document.getElementById("idea").value=idea;
	else
	document.getElementById("idea").value=old+"\n"+idea;
	}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String item_id = getStr( request.getParameter("item_id") );
sqlstr = "select * from vi_opinion_list where id='" + item_id+"'"; 
rs = db.executeQuery(sqlstr); 

String proj_id = "";
String proj_name = "";
String raiser = ""; 
String dutier="";
String raiser_date = "";
String operation_dept = "";
String flow = "";
String idea = "";

if ( rs.next() ) {
	proj_id = getDBStr( rs.getString("proj_id") );
	proj_name = getDBStr( rs.getString("project_name") );
	raiser = getDBStr( rs.getString("raiser") );
	dutier=getDBStr( rs.getString("dutier") );
	raiser_date = getDBDateStr( rs.getString("raiser_date") );
	operation_dept = getDBStr( rs.getString("operation_dept") );
	flow = getDBStr( rs.getString("flow") );
	idea = getDBStr( rs.getString("idea") );
}

String idea_list="";
sqlstr = "select title from ifelc_conf_dictionary where type='p' and parentid like '%root.projfocus%'";
rs = db.executeQuery(sqlstr);
while(rs.next()){
idea_list+=getDBStr(rs.getString("title"))+"|";
}
rs.close();

//db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">修改项目关注点</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1"  method="post" action="opinion_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="kid" value="<%=item_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
 
 <tr>
    <td scope="row">项目编号</td>
    <td scope="row">
      <input name="proj_id" type="text" value="<%=proj_id %>" readonly="readonly" Require="ture">
	</td>
    <td scope="row">项目名称</td>
    <td scope="row">
     <input name="project_name" type="text" value="<%=proj_name %>" readonly="readonly" Require="ture">
   	</td>
  </tr>

  <tr>
    <td scope="row">提出人</td>
    <td scope="row">
    <input style="width:150px;" name="raiser" id="raiser" type="text" readonly="readonly" value="<%=raiser %>">
  <img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
	onClick="OpenDataWindow('','','','','提出人','base_user','name','id','name','name','asc','form1.raiser','form1.raiser');">  
	<span class="biTian">*</span>
    </td>
    
    <td scope="row">提出时间</td>
    <td scope="row">
     <input id="raiser_date" name="raiser_date" value="<%=raiser_date %>" type="text" readonly Require="ture">
	<img onClick="openCalendar(raiser_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	<span class="biTian">*</span>
    </td>
  </tr>
  
  <tr>
    <td scope="row">执行部门</td>
    <td scope="row">
   <input style="width:150px;" name="operation_dept" id="operation_dept" type="text" readonly="readonly" value="<%=operation_dept %>">
  <img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
	onClick="OpenDataWindow('','','','','执行部门','base_department','dept_name','id','dept_name','dept_name','asc','form1.operation_dept','form1.operation_dept');">  
	<span class="biTian">*</span>
    </td>
    
    <td scope="row">落实阶段</td>
    <td scope="row">
    <select name="flow" style="width:133">
   <%
  		//List list=new ArrayList();
  		String xmlc="";
  		String sqlStr2="SELECT title FROM ifelc_conf_dictionary WHERE parentid='root.flowNameDefi'";
  		rs=db.executeQuery(sqlStr2);
  		while(rs.next()){
  		xmlc=rs.getString("title");
  		//list.add(name);
  		%>
  		<script type="text/javascript">
     	w(mSetOpt('',"<%=xmlc %>","<%=xmlc %>")); 
   		 </script>
  		<%
  		}
  		rs.close();
  		
   %>
   
 	</select><span class="biTian">*</span>
    </td>
  </tr>
  <%-- 
    <tr>
  		<td>意见选择</td>
	  	<td colspan="3">
	  	<select class="text" id="idea_list" name="idea_list" style="width: 547px" onchange="make_val();">
	  	<script>w(mSetOpt('',"<%=idea_list %>"));</script>
	  	</select>
	  	</td>
  	</tr>
  	 --%>
  	 <tr>
  	<td>责任落实人</td>
  	<td colspan="3">
  	<input style="width:150px;" name="dutier" id="dutier" type="text" readonly="readonly" value="<%=dutier %>">
  		<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
				onClick="OpenDataWindow('','','','','责任落实人','base_user','name','id','name','name','asc','form1.dutier','form1.dutier');">  
		<span class="biTian">*</span>
  	
  	</td>
  </tr>
  <tr>
    <td scope="row">意见</td>
    <td colspan="3">
  		<textarea rows="6" cols="4" name="idea" Require="ture"><%=idea %></textarea>
  		<span class="biTian">*</span>
    </td>
  </tr>
  
</table>
<!-- end cwDataNav -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>


<%if(null != db){db.close();}%>