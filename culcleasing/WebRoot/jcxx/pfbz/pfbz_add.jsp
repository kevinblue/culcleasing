<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基础信息管理 - 新增评分标准</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>


<%
String item_name="";
String max_order_number = "";
String item_id = getStr(request.getParameter("item"));
if(item_id!=null&&!item_id.equals("")){
ResultSet rs = null;
String sqlstr = "select item from base_evaluation_model where item_id="+item_id;
rs=db.executeQuery(sqlstr);
if(rs.next()){
	item_name = getDBStr(rs.getString("item"));
}
ResultSet rsOrder =null;
sqlstr = "select count(order_number)+1 as max_order_number from base_evaluation_standard where item_id="+item_id;
rsOrder=db.executeQuery(sqlstr);
if(rsOrder.next()){
	max_order_number = getDBStr(rsOrder.getString("max_order_number"));
}
}
%>
<body onload="setDivHeight('divH',-55);fun_winMax();">


<form name="form1" method="post" action="pfbz_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
新增评分标准 &gt; 基础信息管理
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	-->
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->







<!-- end cwCellTop -->

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th scope="row">显示名称</th>
    <td><input name="disp_name" type="text" value="" size="40" maxlength="100" maxB="100"  Require="true"><span class="biTian">*</span>
	</td>
    <th scope="row">模型编号</th>
    <td><input name="item_name" type="text" value="<%=item_name%>" size="40" maxlength="50" maxB="50"  Require="true"><input type="hidden" name="item_id" value ="<%=item_id%>">
    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
 		onclick="SpecialDataWindow('模型编号','base_evaluation_model','item','item_id','item','stringfld','item_id','form1.item_name','form1.item_id');">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">序号</th>
    <td><input name="order_number" type="text" value="<%=max_order_number%>"  dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">评分标准</th>
	<td><input name="standard" type="text" value=""  size="40" maxlength="250" maxB="250"  Require="true"><span class="biTian">*</span></td>
  </tr>	
  <tr>
  	<th scope="row">分值</th>
    <td><input name="value" type="text" value=""  dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">一票否决</th>
	<td><select name="veto_flag"><script>w(mSetOpt('1',"启用|关闭","-1|1"));</script></select><span class="biTian">*</span></td>
  </tr>
   <tr>
  	<th scope="row">状态</th>
    <td><select name="his_flag"><script>w(mSetOpt('0',"启用|关闭","0|1"));</script></select><span class="biTian">*</span>
	</td>
	<th  scope="row"></th>
	<td></td>
  </tr>	
</table>


</div>
</div>

    </form>

</body>
</html>
<%db.close();%>