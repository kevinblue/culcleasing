<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基础信息管理 - 删除评分标准</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>


<%
String id = getStr( request.getParameter("czid") );
	
	String item_id = "";
	String item_name = "";
	String order_number = "";
	String standard = "";
	String disp_name = "";
	String value = "";
	String veto_flag = "";
	String his_flag = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	ResultSet rs;
	String sqlstr = "select * from vi_base_evaluation_standard where standard_id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		item_id = getDBStr( rs.getString("item_id") );
		item_name = getDBStr( rs.getString("item_name") );
		order_number = getDBStr( rs.getString("order_number") );
		standard = getDBStr( rs.getString("standard") );
		disp_name = getDBStr( rs.getString("disp_name") );
		value = getDBStr( rs.getString("value") );
		veto_flag = getDBStr( rs.getString("veto_flag") );
		his_flag = getDBStr( rs.getString("his_flag") );
		creator = getDBStr( rs.getString("creator") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close();
	db.close();
%>
<body  onload="setDivHeight('divH',-55);fun_winMax();">


<form name="form1" method="post" action="pfbz_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
删除评分标准 &gt; 基础信息管理
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
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">删 除</td>
  
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

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th scope="row">显示名称</th>
    <td><%=disp_name%>
	</td>
    <th scope="row">模型编号</th>
    <td><%=item_name%></td>
  </tr>
  <tr>
  	<th scope="row">序号</th>
    <td><%=order_number%>
	</td>
	<th  scope="row">评分标准</th>
	<td><%=standard%></td>
  </tr>	
  <tr>
  	<th scope="row">分值</th>
    <td><%=value%>
	</td>
	<th  scope="row">一票否决</th>
	<td><%=veto_flag.equals("-1")?"启用":"关闭"%></td>
  </tr>
   <tr>
  	<th scope="row">状态</th>
    <td><%=his_flag.equals("0")?"启用":"关闭"%>
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
