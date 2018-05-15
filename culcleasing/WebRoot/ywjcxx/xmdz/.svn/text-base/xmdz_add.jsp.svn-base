<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增客户对照表 - 客户对照表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<%

String dqczy=(String) session.getAttribute("czyid");
//if ((dqczy==null) || (dqczy.equals("")))
//{
//  dqczy="无认证";
//  response.sendRedirect("../../noright.jsp");
//}
int canedit=0;
if (right.CheckRight("gszh_add",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息维护 &gt; 新增客户对照</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="xmdz_save.jsp" onSubmit="return Validator.Validate(this,3);">


<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="120" height="30" scope="row">项目名</td>
    <td height="30" >
     <input name="subject_name" type="text" label="项目名"  Require="true" ><span class="biTian">*</span>
	</td>
  </tr>
   <tr>
    <td height="30" scope="row">项目编码</td>
    <td height="30"><input name="subject_number" type="text" label="项目编码"  Require="ture"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td height="30" scope="row">项目编号</td>
    <td height="30"><input name="project_id" type="text" label="项目编号"  Require="ture"><span class="biTian">*</span></td>
  </tr>
  


</table>
</div>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
</div>
<script type="text/javascript">
 function check(id){
 	if(id=='auxiliary_account3'){
 		document.getElementById('auxiliary_account4').checked = false;
 	} else if(id=='auxiliary_account4'){
 		document.getElementById('auxiliary_account3').checked = false;
 	}
 }
</script>
<!-- end cwMain -->
</body>
</html>