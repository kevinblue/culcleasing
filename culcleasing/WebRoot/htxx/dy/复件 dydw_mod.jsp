<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-担保物管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String czid;
String sqlstr;

ResultSet rs;
czid=getStr(request.getParameter("id"));
	
	sqlstr = "select *,proj_info.project_name from contract_guarantee_equip left join contract_info on contract_guarantee_equip.contract_id=contract_info.contract_id left join proj_info on contract_info.proj_id=proj_info.proj_id where id="+czid;  
 rs = db.executeQuery(sqlstr);
	
	String project_name="";
	String contract_id="";
	String eqip_name="";
	String registraction_authority="";
	String total_price="";
	String ownership_document="";
	String equip_guarantee_type="";
	String zheng_hao="";

	if(rs.next()){
	 project_name=getDBStr(rs.getString("project_name"));
	    contract_id=getDBStr(rs.getString("contract_id"));
	    eqip_name=getDBStr(rs.getString("eqip_name"));
		registraction_authority=getDBStr(rs.getString("registraction_authority"));
		total_price=getDBStr(rs.getString("total_price"));
		ownership_document=getDBStr(rs.getString("ownership_document"));
	    equip_guarantee_type=getDBStr(rs.getString("equip_guarantee_type"));
	      zheng_hao=getDBStr(rs.getString("zheng_hao"));
	        equip_guarantee_type=getDBStr(rs.getString("equip_guarantee_type"));
	  
		
	
%>


<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="dydw_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理&gt; 担保物修改
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
   <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=czid  %>">

<input class="text" type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">


<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td scope="row">项目名称：</td>
    <td><%=getDBStr(rs.getString("project_name"))%></td>
    <td scope="row">租赁合同号：</td>
    <td><%=getDBStr(rs.getString("contract_id"))%></td>
  </tr>
  <tr>
   <td scope="row">物品名称：</td>
    <td>
        <input class="text" type="text" name="eqip_name"  Require="true" value="<%=getDBStr(rs.getString("eqip_name"))%>" maxlength="40" ><span class="biTian">*</span></td>
    <td scope="row">登记机关:</td>
    <td>
        <input class="text" type="text" name="registraction_authority"  Require="true" value="<%=getDBStr(rs.getString("registraction_authority"))%>" maxlength="40">
      <span class="biTian">*</span></td>
 
  </tr>
    <tr>
    <td scope="row">金额：</td>
    <td><input class="text" name="total_price" type="text" size="20" Require="true"   dataType="Money"  value="<%=formatNumberStr(rs.getString("total_price"),"#,##0.00")%>" maxlength="20">元<span class="biTian">*</span></td>
    <td scope="row">证号：</td>
    <td><input class="text" name="zheng_hao" type="text" size="20"   value="<%=getDBStr(rs.getString("zheng_hao"))%>" maxlength="30"></td>
 
  </tr>
    <tr>
    <td scope="row">期限：</td>
    <td><input class="text" name="ownership_document" type="text" size="20" value="<%=getDBStr(rs.getString("ownership_document"))%>" maxlength="50" dataType="Number"></td>
    <td scope="row">类型：</td>
    <td><select name="equip_guarantee_type" id="equip_guarantee_type" class="text">
		
          <option value="抵押物">抵押物</option>
          <option value="质押物">质押物</option>
        </select>
	</td>
  </tr>
</table>
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
</form>
<%
}
	rs.close(); 
	db.close();
 %>
<!-- end cwMain -->
</body>
</html>