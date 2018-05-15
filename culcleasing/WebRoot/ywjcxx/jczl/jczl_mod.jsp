<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改基础资料分类</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改基础资料分类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="jczl_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->

<%
String sqlstr;
String czid;
String sort;
String mater_name;
String mater_type;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = " SELECT * FROM base_material where id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
	sort=getDBStr(rs.getString("sort"));
	mater_name=getDBStr(rs.getString("mater_name"));
	mater_type=getDBStr(rs.getString("mater_type"));
	
%>

<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">

  <tr>
    <td scope="row">租赁物分类</td>
    <td width="84%">
	<select name="sort" id="sort"  class="select_css">
			<option value="飞机">飞机</option>
			<option value="船舶">船舶</option>
			<option value="通用设备">通用设备</option>
			<option value="医疗">医疗</option>
	        </select><span class="biTian">*</span>
	<script>
		var objSelect=document.getElementById("sort");

		var isExit = false;
     		for(var i=0;i<objSelect.options.length;i++)
     		{
         		if(objSelect.options[i].value == '<%=sort%>')
         		{
             			isExit = true;
             			break;
        		 }
     		}
		if(isExit)
     		{
         		for(var i=0;i<objSelect.options.length;i++)
         		{

             			if(objSelect.options[i].value == '<%=sort%>')
             			{
                 			objSelect.options[i].selected=true;
            			 }
         		}                 
     		}

	</script>
    </td>
  </tr>

  <tr>
    <td scope="row">资料名称</td>
    <td><input name="mater_name" type="text" value="<%=getDBStr(rs.getString("mater_name"))%>"  label="资料名称" Require="true"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td scope="row">资料类别</td>
    <td><select name="mater_type"  class="select_css">
			<option value="评审文件">评审文件</option>
			<option value="承租人基本文件">承租人基本文件</option>
			<option value="租赁合同及买卖合同">租赁合同及买卖合同</option>
			<option value="供应商合同">供应商合同</option>
			<option value="保证担保人">保证担保人</option>
			<option value="租赁标的物文件">租赁标的物文件</option>
			<option value="质/抵押人">质/抵押人</option>
	        </select><span class="biTian">*</span>
	<script>
		var objSelect=document.getElementById("mater_type");

		var isExit = false;
     		for(var i=0;i<objSelect.options.length;i++)
     		{
         		if(objSelect.options[i].value == '<%=mater_type%>')
         		{
             			isExit = true;
             			break;
        		 }
     		}
		if(isExit)
     		{
         		for(var i=0;i<objSelect.options.length;i++)
         		{

             			if(objSelect.options[i].value == '<%=mater_type%>')
             			{
                 			objSelect.options[i].selected=true;
            			 }
         		}                 
     		}

	</script>
</td>
  </tr>

</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td width=8 width="12">
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>