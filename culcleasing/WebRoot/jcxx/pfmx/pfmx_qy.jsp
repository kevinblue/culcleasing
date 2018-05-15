<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基础信息管理 - 评分模型启用状态</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>


<%
	String id = getStr( request.getParameter("czid") );
	
	String evaluation_type = "";
	String evaluation_type_name = "";
	String order_number = "";
	String item = "";
	String weighting = "";
	String his_flag = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	ResultSet rs;
	String sqlstr = "select * from vi_base_evaluation_model where item_id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		evaluation_type = getDBStr( rs.getString("evaluation_type") );
		evaluation_type_name = getDBStr( rs.getString("evaluation_type_name") );
		order_number = getDBStr( rs.getString("order_number") );
		item = getDBStr( rs.getString("item") );
		weighting = getDBStr( rs.getString("weighting") );
		his_flag = getDBStr( rs.getString("his_flag") );
		creator = getDBStr( rs.getString("creator") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close();
	db.close();
 %>
<body onload="setDivHeight('divH',-55);fun_winMax();">


<form name="form1" method="post" action="pfmx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
评分模型启用状态 &gt; 基础信息管理
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
<BUTTON class="btn_2" name="btnSave" value="<%=his_flag.equals("0")?"关闭":"启用"%>"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0"><%=his_flag.equals("0")?"关闭":"启用"%></button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

 
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">启用状态</td>
  
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

<input type="hidden" name="savetype" value="qy">
<input type="hidden" name="czid" value="<%=id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th scope="row">评分项</th>
    <td><%=item%>
	</td>
    <th scope="row">评分类型</th>
    <td><%=evaluation_type_name%></td>
  </tr>
  <tr>
  	<th scope="row">序号</th>
    <td><%=order_number%>
	</td>
	<th  scope="row">权重</th>
	<td><%=weighting%></td>
  </tr>	
   <tr>
  	<th scope="row">状态</th>
    <td><%=his_flag.equals("0")?"启用":"关闭"%><input type="hidden" name="his_flag" value="<%=his_flag.equals("0")?"1":"0"%>">
	</td>
	<th>登记人</th>
    <td ><%=creator%>&nbsp;</td>
  </tr>	
 <tr>
    <th>登记日期</th>
    <td ><%=create_date%>&nbsp;</td>
  
    <th>更新人</th>
    <td ><%=modificator%>&nbsp;</td>
  </tr>
  <tr>
    <th>更新日期</th>
    <td ><%=modify_date%>&nbsp;</td>
    <th></th>
    <td></td>
  </tr>
</table>


</div>
</div>

    </form>

</body>
</html>
