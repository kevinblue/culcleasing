<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>跨区信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script language="javascript">
function selgroup()
{
		sel.cgroup_id.value=form1.credit_group_id.value;
		sel.cgroup_name.value=form1.credit_group_name.value;
		sel.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
String base_user_id = getStr( request.getParameter("id") );
LogWriter.logDebug(request,"我需要的--:"+base_user_id);
sqlstr = "select * from vi_base_user_respons v where v.id='"+base_user_id+"' ";

rs = db.executeQuery(sqlstr); 
String id="";
String name ="";
String dept_name="";
String phone="";
String code="";
String respon_provice_title="";
String respon_provice_id="";

if ( rs.next() ) {
	id= getDBStr(rs.getString("id"));
	name= getDBStr(rs.getString("name"));
	dept_name= getDBStr(rs.getString("dept_name"));
	phone= getDBStr(rs.getString("phone"));
	code= getDBStr(rs.getString("code"));
	respon_provice_title= getDBStr(rs.getString("respon_provice_title"));
	respon_provice_id= getDBStr(rs.getString("respon_provice_id"));
}

rs.close();
db.close();

%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">区域信息维护 &gt; 修改区域信息</td>
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
    <td nowrap class="text">负责省份：</td>
    <td nowrap class="text">
       <textarea name="credit_group_name" style="width: 300px;" readonly><%=respon_provice_title %></textarea>
       <input type="hidden" name="credit_group_id" value="<%=respon_provice_id %>" size="30">
   	   <input type="button" value="选择" onclick="selgroup();">
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
</form>

<form name="sel" action="provice_sel.jsp" method="post" target="_blank">
<input type="hidden" name="cgroup_id">
<input type="hidden" name="cgroup_name">
</form>

</div>
<!-- end cwToolbar -->
</td></tr></table>
<!-- end cwMain -->
</body>
</html>


