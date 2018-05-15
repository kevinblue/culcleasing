<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String id = getStr(request.getParameter("id"));
	System.out.print(id+"14");
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from contract_manuf  where id='" + id + "'"; 
	ResultSet rs = db.executeQuery(sqlstr);
String manuf_name="";
String margin_per="";
String initial_margin="";
String creator="";
String create_date="";
String modificator="";
String modify_date="";
	
	
	if ( rs.next() ) {
		
	    creator=getDBStr(rs.getString("creator"));
		create_date=getDBStr(rs.getString("create_date"));
		modificator=getDBStr(rs.getString("modificator"));
		modify_date=getDBStr(rs.getString("modify_date"));

		manuf_name=getDBStr(rs.getString("manuf_name"));
	    margin_per=getDBStr(rs.getString("margin_per"));
	    initial_margin=getDBStr(rs.getString("initial_margin"));
     
	}

%>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp" onSubmit="return checkdata(this);">	
 <input name="id" id="id" type="hidden" value="<%=id%>">
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
厂商明细
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
		<td><a href="csbzj_mod_tt.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:1000px;overflow:auto;">
<div id="TD_tab_0">
 <input name="id" id="id" type="hidden" value="<%=id%>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
   <tr>
	    <td  width="20%">厂商名字：</td>
	    <td width="20%"><%=manuf_name %></td>
	    <td >保证金比例：</td>
	    <td><%=margin_per %>%</td>
	   <td>保证金初始金额：</td>
	   <td> <%=formatNumberStr(rs.getString("initial_margin"),"#,##0.00")%></td>
	  </tr>
 
  
</table>
<%
	rs.close(); 
	db.close();
%>


<br>
<div style="text-align:left;width:98%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">子合同</td>
  
 </tr>
 </table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0" >
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../csbzj/csbzj_list.jsp?id=<%=id%>" align="center" height="500px"></iframe>
</div>
<div id="TD_s_tab_1" style="display:none;">
<iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" src="#"></iframe>
</div>
</div>
<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>
</center>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>


<script language="javascript">
	ShowTabN(0);
	ShowTabSub(0);
	reinitIframe();
	//外部div高度自适应
	function reinitIframe(){
	var divH = document.getElementById("divH");
	var reinitIframe_resize=function(){
	divH.style.height=window.document.body.clientHeight-100;
	}
	reinitIframe_resize();
	window.onresize=reinitIframe_resize;
	}
	//内部Iframe高度自适应
	function autoResize()
	{
		try
		{
			document.all["UserBody0"].style.height=UserBody0.document.body.scrollHeight
			document.all["UserBody2"].style.height=UserBody2.document.body.scrollHeight
			document.all["UserBody3"].style.height=UserBody3.document.body.scrollHeight
			document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
			document.all["UserBody4"].style.height=UserBody4.document.body.scrollHeight
		    document.all["UserBody5"].style.height=UserBody5.document.body.scrollHeight
		    document.all["UserBody6"].style.height=UserBody6.document.body.scrollHeight
		}
		catch(e)
		{
			//alert('#$%^%#$^$#exception');
		}
	}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
