<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-担保物管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>

<% 
	String id = getStr( request.getParameter("id"));
	System.out.println(id+"**");
	String sqlstr = "select *,proj_info.project_name from contract_guarantee_equip left join contract_info on contract_guarantee_equip.contract_id=contract_info.contract_id left join proj_info on contract_info.proj_id=proj_info.proj_id where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	String contract_id="";
String equip_guarantee_type="";
String eqip_name="";
String guarantor="";
String ID_number="";
String equip_num="";
String total_price="";
String equip_place="";
String equip_sn="";
String ownership_document="";
String creator;
String create_date;
String modificator;
String modify_date;
String zheng_hao="";
String registraction_authority="";
String project_name="";

	if(rs.next()){
		creator=getDBStr(rs.getString("creator"));
		create_date=getDBStr(rs.getString("create_date"));
		modificator=getDBStr(rs.getString("modificator"));
		modify_date=getDBStr(rs.getString("modify_date"));
	project_name=getDBStr(rs.getString("project_name"));
	zheng_hao=getDBStr(rs.getString("zheng_hao"));
	registraction_authority=getDBStr(rs.getString("registraction_authority"));
	    equip_place=getDBStr(rs.getString("equip_place"));
		equip_sn=getDBStr(rs.getString("equip_sn"));
	    ownership_document=getDBStr(rs.getString("ownership_document"));
		contract_id=getDBStr(rs.getString("contract_id"));
		equip_guarantee_type=getDBStr(rs.getString("equip_guarantee_type"));
		eqip_name=getDBStr(rs.getString("eqip_name"));
		guarantor=getDBStr(rs.getString("guarantor"));
	    ID_number=getDBStr(rs.getString("ID_number"));
	    equip_num=getDBStr(rs.getString("equip_num"));
	    total_price=getDBStr(rs.getString("total_price"));
	//}
	//rs.close(); 
	//db.close();
%>

<body onLoad="">
<form name="form1" method="post" action="dydw_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
担保物管理&gt;担保物明细
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
		<td><a href="dydw_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >修改&nbsp;&nbsp;</a></td>
	  	<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/btn_close.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
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
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
	  <td width="130px">项目名称</td>
	    <td><%=project_name %></td>
	    <td width="130px">租赁合同号</td>
	    <td><%=contract_id %></td>
	  </tr>
	  <tr>
	    <td width="130px">物品名称</td>
	    <td><%=eqip_name %></td>
	 
	 <td>登记机关</td>
	    <td><%=registraction_authority%></td>
	  </tr>
	  <tr>
	   <td width="130px">金额</td>

	   <td> <%=formatNumberStr(rs.getString("total_price"),"#,##0.00")%></td>
	    
	    <td>证号</td>
	    <td><%=zheng_hao %></td>
	  </tr>
	  <tr>
		<td>期限：</td>
	    <td><%=ownership_document%></td>
	    <td>类型</td>
	    <td><%=equip_guarantee_type %></td>
	  </tr>
	
	  
	</table>
<br>
<div style="text-align:left;width:98%">


</div>
<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。
</div>
<% 

}
rs.close();
db.close();
%>
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
<!-- end cwMain -->
</body>
</html>
