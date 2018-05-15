<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-结算保证金管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>

</head>

<% 
	String id = getStr( request.getParameter("id"));
	System.out.println(id+"**");
	String sqlstr;
	sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_mproj_guarantee_info where id="+id;
	//String sqlstr = "select *,proj_info.project_name from contract_guarantee_equip left join contract_info on contract_guarantee_equip.contract_id=contract_info.contract_id left join proj_info on contract_info.proj_id=proj_info.proj_id where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	
String proj_id="";	
String contract_id="";
String sign_date="";
String lineof_credit="";
String credit_fact="";
String credit_remain="";
String guarantee_plan="";
String plan_remain="";
String income_remian="";
String guarantee_income="";
String remark="";

String creator;
String create_date;
String modificator;
String modify_date;




	if(rs.next()){
		creator=getDBStr(rs.getString("creator"));
		create_date=getDBStr(rs.getString("create_date"));
		modificator=getDBStr(rs.getString("modificator"));
		modify_date=getDBStr(rs.getString("modify_date"));
		
	    proj_id=getDBStr(rs.getString("proj_id"));
	    contract_id=getDBStr(rs.getString("contract_id"));
	    sign_date=getDBStr(rs.getString("sign_date"));
	    lineof_credit=getDBStr(rs.getString("lineof_credit"));
		credit_fact=getDBStr(rs.getString("credit_fact"));
	    credit_remain=getDBStr(rs.getString("credit_remain"));
		guarantee_plan=getDBStr(rs.getString("guarantee_plan"));
		plan_remain=getDBStr(rs.getString("plan_remain"));
		income_remian=getDBStr(rs.getString("income_remian"));
	    guarantee_income=getDBStr(rs.getString("guarantee_income"));
	    remark=getDBStr(rs.getString("remark"));
	
	//}
	//rs.close(); 
	//db.close();
%>

<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="jsbzj_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
结算保证金管理&gt;结算保证就明细
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
		<td><a href="jsbzj_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >修改&nbsp;&nbsp;</a></td>
	  	<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/fdmo_37.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
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
<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">

	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
	  <td width="130px">项目编号：</td>
	    <td><%=proj_id %></td>
	    <td width="130px">合同编号：</td>
	    <td><%=contract_id %></td>
	  </tr>
	  <tr>
	    <td width="130px">日期：</td>
	    <td><%=sign_date %></td>
	 
	 <td>授信总额度：</td>
	  
	    <td> <%=formatNumberStr(rs.getString("lineof_credit"),"#,##0.00")%></td>
	  </tr>
	  <tr>
	   <td >授信发生额：</td>

	   <td> <%=formatNumberStr(rs.getString("credit_fact"),"#,##0.00")%></td>
	    
	    <td>授信余额：</td>
	 
	     <td> <%=formatNumberStr(rs.getString("credit_remain"),"#,##0.00")%></td>
	  </tr>
	  <tr>
		<td>应收保证金：</td>
	
	     <td> <%=formatNumberStr(rs.getString("guarantee_plan"),"#,##0.00")%></td>
	    <td>应收保证金余额：</td>
	         <td> <%=formatNumberStr(rs.getString("plan_remain"),"#,##0.00")%></td>
	  </tr>
	   <tr>
		<td>实收保证金余额：</td>
	     <td> <%=formatNumberStr(rs.getString("guarantee_plan"),"#,##0.00")%></td>
	    <td>实收保证金发生额：</td>

	      <td> <%=formatNumberStr(rs.getString("plan_remain"),"#,##0.00")%></td>
	  </tr>
	 
	
	   <tr>
	<td>备注：</td>
	    <td><%=remark%></td>
	    <td></td><td>
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
