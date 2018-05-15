<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人客户(法人)明细 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<% 
   String dqczy = (String) session.getAttribute("czyid");
   String plan_id=getStr(request.getParameter("plan_id"));
	//String custId = getStr( request.getParameter("custId"));
	//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator),cr_dep=dbo.GETUSERNAME(creator_dept) from vi_cust_info where cust_id='"+custId+"'"; 
	String sqlstr="select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from  proj_invoice_detail where plan_id='"+plan_id+"'";
	ResultSet rs = db.executeQuery(sqlstr);
	String id="";
	String proj_invoice_id="";
	//String plan_id="";
	
	//时间
	String	creator_dept = "";//部门名称
	String	creator = "";//登记人
	String	create_date = "";//登记时间
	String	modificator = "";//修改人
	String	modify_date = "";//修改时间


	if(rs.next()){
		id=getDBStr(rs.getString("id"));
		proj_invoice_id = getDBStr( rs.getString("proj_invoice_id") );
		plan_id=getDBStr( rs.getString("plan_id") );
		creator = getDBStr( rs.getString("dengjiren") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close(); 
	db.close();
%>

<body onLoad="">
<form name="form1" method="post" action="mx_list.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
法人客户信息明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->

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
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
	    <td width="130px">序号：</td>
	    <td><%=id %></td>
	    </tr>
	    <tr>
	    <td>项目id</td>
	    <td><%=proj_invoice_id %></td>
	    </tr>
	    <tr>
	    <td>租金计划id：</td>
	    <td><%=plan_id %></td>
	  </tr>
	   <tr>
	   	<td>创建人：</td>
	    <td><%=creator %></td>
	    </tr>
	    <tr>
	    <td>创建时间：</td>
	    <td><%=create_date %></td>
	    </tr>
	    <tr>
		<td>修改：</td>
	    <td><%=modificator %></td>
	  </tr>
	    <tr>
		<td>修改时间：</td>
	    <td><%=modify_date %></td>
	  </tr>
	  
	  
	
	
	
	
	  
	
	  

	</table>
<br>

<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。
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
