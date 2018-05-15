<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基本信息 - 操作权限认证方式</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript">
function selgroup()
{
	if (form1.credit_type_id.value.length==0)
	{
		alert("请您先选择认证方式!");
	}
	else
	{
		sel.ctype_id.value=form1.credit_type_id.value;
		sel.cgroup_id.value=form1.credit_group_id.value;
		sel.cgroup_name.value=form1.credit_group_name.value;
		sel.submit();
	}
}
</script>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="operatecredit_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
基本信息 &gt; 操作权限认证方式
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
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
	dqczy="无认证";
}
int canmod=0;


	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select base_operate_credit.opcredit_id,base_module.module_id,base_module.module_name,base_operate.operate_id,base_operate.operate_name,base_right_credit_type.credit_type_id,base_right_credit_type.credit_type_name,base_operate_credit.credit_group_id,base_operate_credit.credit_group_name from base_operate_credit left join base_operate on base_operate_credit.operate_id=base_operate.operate_id left join base_module on base_operate.module_id=base_module.module_id left join base_right_credit_type on base_operate_credit.credit_type_id=base_right_credit_type.credit_type_id where base_operate_credit.opcredit_id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	
	
	String	operate_id = "";
	String	operate_name = "";
	String	credit_type_id = "";
	String	credit_type_name = "";
	String	credit_group_id = "";
	String	credit_group_name = "";

	if ( rs.next() ) {
		operate_id = getDBStr( rs.getString("operate_id") );
		operate_name = getDBStr( rs.getString("operate_name") );
		credit_type_id = getDBStr( rs.getString("credit_type_id") );
		credit_type_name = getDBStr( rs.getString("credit_type_name") );
		credit_group_id = getDBStr( rs.getString("credit_group_id") );
		credit_group_name = getDBStr( rs.getString("credit_group_name") );
	}
	rs.close(); 
	db.close();




%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>操作名称</td>
    <td><input name="operate_name" type="text" size="20" maxB="50" Require="true" readonly value="<%= operate_name%>"><input type="hidden" name="operate_id" value="<%= operate_id%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','操作信息','base_operate','operate_name','operate_id','operate_name','operate_name','asc','form1.operate_name','form1.operate_id');">
    <span class="biTian">*</span></td>
    <td>认证方式</td>
    <td><input name="credit_type_name" type="text" size="20" maxB="50" Require="true" readonly value="<%= credit_type_name%>"><input type="hidden" name="credit_type_id" value="<%= credit_type_id%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','认证方式','base_right_credit_type','credit_type_name','credit_type_id','credit_type_name','credit_type_name','asc','form1.credit_type_name','form1.credit_type_id');">
    <span class="biTian">*</span></td>
  </tr>

<tr>
   <td>被授权集合</td>
   <td colspan=3><textarea name="credit_group_name" cols=10,rows=80 readonly><%=credit_group_name%></textarea><input type="button" value="选择" onclick="selgroup();"><input type="hidden" name="credit_group_id" size="30" value="<%=credit_group_id%>"></td>

</tr>  

</table>
	




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
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
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
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>

<form name="sel" action="group_sel.jsp" method="post" target="_blank">
<input type="text" name="ctype_id">
<input type="text" name="cgroup_id">
<input type="text" name="cgroup_name">
</form>






<!-- end cwMain -->
</body>
</html>
