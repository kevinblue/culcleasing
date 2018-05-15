<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改国家信息 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
String base_user_id = getStr( request.getParameter("id") );
LogWriter.logDebug(request,"我需要的:"+base_user_id);
String sqlstring="v.id,v.name,v.dept_name,v.phone,v.code,v.area,v.provice,v.city,b.area as qymc,b.provice as sfmc,b.city as csmc";
sqlstr = "select "+sqlstring+" from vi_base_user_responsible v,base_user_responsible b where v.id='"+base_user_id+"' and b.base_user_id='"+base_user_id+"'";
rs = db.executeQuery(sqlstr); 
String id="";
String name ="";
String dept_name="";
String phone="";
String code="";
String area="";
String provice="";
String city="";
String qymc="";
String sfmc="";
String csmc="";
if ( rs.next() ) {
	id= getDBStr(rs.getString("id"));
	name= getDBStr(rs.getString("name"));
	dept_name= getDBStr(rs.getString("dept_name"));
	phone= getDBStr(rs.getString("phone"));
	code= getDBStr(rs.getString("code"));
	area= getDBStr(rs.getString("area"));
	provice= getDBStr(rs.getString("provice"));
	city= getDBStr(rs.getString("city"));
	qymc=getDBStr(rs.getString("qymc"));
	sfmc=getDBStr(rs.getString("sfmc"));
	csmc=getDBStr(rs.getString("csmc"));
}

rs.close();
db.close();


%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息维护 &gt; 修改区域信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="gjxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->

<input type="hidden" name="savetype" value="mod">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">编号</td>
    <td >
      <input name="id" type="text"  maxlength="3" value="<%= id %>" width="150" class="readonly">
	</td>
  </tr>
  <tr>
    <td scope="row">名称</td>
    <td >
      <input name="name" type="text" maxlength="3" value="<%=name %>" width="150" class="readonly">
	</td>
  </tr>
  <tr>
    <td scope="row">部门</td>
    <td>
      <input name="dept_name" type="text" maxlength="3" value="<%= dept_name %>" width="150"class="readonly">
	</td>
  </tr>
   <tr>
    <td scope="row">电话</td>
    <td >
      <input name="phone" type="text"  maxlength="3" value="<%= phone %>" width="150" class="readonly">
	</td>
  </tr>
  <tr>
    <td scope="row">财务编码</td>
    <td >
      <input name="code" type="text"  maxlength="3" value="<%= code %>" width="150" class="readonly">
	</td>
  </tr>
  <tr>
    <td nowrap class="text">区域：</td>
    <td nowrap class="text"><input class="text" type="text"   name="area" value="<%=area %>" readonly Require="true" width="150"/>
	    <input type="hidden" name="qymc"  value="<%=qymc %>" vonPropertychange="form1.province.value='';form1.sfmc.value='';form1.city.value='';form1.csmc.value='';"/> 
	    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','区域','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.area','form1.qymc');">
		<span class="biTian">*</span>
	</td>
  </tr>
  

  <tr>
   <td>省份：</td>
    <td nowrap class="text"><input class="text" type="text"   name="provice"  value="<%=provice %>" readonly Require="true" width="150"/>
	    <input type="hidden" name="sfmc" value="<%=sfmc %>" onPropertychange="form1.city.value='';form1.csmc.value='';"/> 
	    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
	    onClick="OpenDataWindow('form1.qymc','区域','qyid','string','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.provice','form1.sfmc');">
		<span class="biTian">*</span>
	</td>
  </tr>
  <tr>
 	 <td nowrap class="text">城市：</td>
    <td nowrap class="text"><input class="text" type="text"  name="city" value="<%=city %>" readonly  width="150">
	    <input type="hidden" name="csmc" value="<%=csmc %>"> 
	    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
	    onClick="OpenDataWindow('form1.sfmc','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.city','form1.csmc');">
	
	</td>
  </tr>

</table>

<!-- end cwDataNav -->

<!-- end cwCellContent -->
</div>
<!-- end cwCell -->

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


